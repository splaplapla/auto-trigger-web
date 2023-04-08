ProconBypassManHost.find_or_create_by!(name: 'ras1.local', port: 9000)
ProconBypassManCommand.find_or_create_by!(name: '射撃ボタンを連打', first_buttons: 'zr', second_buttons: 'unzr', repeat_count: 3)
