Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC82AAD288
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 03:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCTM3-0007FM-LV; Tue, 06 May 2025 21:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uCTLx-0007Ex-1j
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:13:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uCTLu-0005fK-1T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:13:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22e661313a3so755755ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746580416; x=1747185216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y9mrtvVZoMnX0hgOqATpravBv8ydphVGhC2o4/rgQl0=;
 b=l1ONVPAwrfMe4x3MvjkoAe5dJYSSdHk9jixKEG+QW8O4rjdLy8Zc+jWRHbt3SVjADl
 /a4w5IbCEyls+yFnCwlIK7MitM3V23B14s57Y/e2aNhYINghtzBjgNj1UMPsTlxf5HUq
 zwGXgAwO1M3Ib5a9aA16oak3jjTXUCeEVRTakXXgy9aoaT9QAxhI9X9bjeK7mvjgvZr3
 5ylY5OrbUXytMe9FBW9eabCzbWb0m+NvP3i/R9TIBSsL3jX7iYyeUgIFATFrhO5VhsL4
 A2KXZzGWeIhXDNj4kbQfVW6kmKBpKHv/fV3bvhsst8L+PjwcFd/WuPLkw7xDW3wudT4z
 T5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746580416; x=1747185216;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9mrtvVZoMnX0hgOqATpravBv8ydphVGhC2o4/rgQl0=;
 b=qbmXNAi6qCASoRv+q0LNRzuvXGn17E9Xu/SA/TuF+qy4r/EJ6vg/T1tLv8MOrJ4MFn
 sPLekbMfjwQUV1SOdTvKfMQHO9F1CnFvgRiZpc+8hMkJzyowmJyI7VTuyo8K3byof2Aw
 LFlW/lB+xU329y4BBUvvKp25MPu9lsDEb0ossqYFHNWK417q+hQqK3CNYDhVYvNium8B
 wce4XAaDewJJxcsO+jQ1vIcrvc7cd3WTRp92jfo+wMKATUrVsvj2n3X9Bl+Giyc1oYEb
 MFStUC3JCc+rrFfwrV6qOv/KBXSniSPEuvlDYkOUdN86dRRiJKIX2u66Du9Jl4dstU3m
 e6tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW20QwkQXmryFcM9sJ4f3JnJUk7l8sC6Luk7dSBu74+Dg5zwsx4InXXNMylFsTYv6WoJpeYJ60viurO@nongnu.org
X-Gm-Message-State: AOJu0YzbfIZ5mHH6/a9dkusTyCVUXtJ5br+sJBL2WpuN2Bm/omCxoSbq
 M5feSqmzI2DOp6kLNkTDzwmx21E4Ye4E2cFnd5VS8OrxrXnRRPHtgg8YBJ26iQU=
X-Gm-Gg: ASbGncuRU++N6z1aVkKutRrypiFvSr8eo+OWKLUBkZUyyQo7aLzzgwFfhFBW3/YRCaK
 tSq/cpOr6DT7F0V+fa0eTb6jMJ+yetNY7biSGU0+g8JR7JZgcFzfS0Mzbk+7a7VCFI77hgzMulU
 ybbz/HzZW1+7IPzPjYhiCTyZv/by26aMww7HztNHvIGoT+FmwVlbR42A6Nlm61CWr4FizH0Fsgt
 CgPrDZhvt86zdGm7Ggw6YJhIP//H17q99tlQiWi4yvLJjHx1ZO3K4LM6FpiU9B4T+hTVJJyNgNL
 cbs59GPdJogg+qhvCJ1BoUaxDmNvCWzqSKdfl4Gan2TTyGP7nd856C5MTpQjtxbmygjnbztYIN8
 vgZk7Buzh51i+mgkx/yM=
X-Google-Smtp-Source: AGHT+IE0RPGXtedMeRT9Mpmu2nWTgMqv/FdKg37YCUr94r5x5Nyp1aIbyEKMe/KV7qm3MdvMWSA0zg==
X-Received: by 2002:a17:902:ecc6:b0:22e:505d:57e5 with SMTP id
 d9443c01a7336-22e5ea27f4bmr20046015ad.11.1746580415771; 
 Tue, 06 May 2025 18:13:35 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:fdbc:e6b2:66ea:1256?
 ([2804:7f0:b400:8604:fdbc:e6b2:66ea:1256])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30aaec170eesm563033a91.31.2025.05.06.18.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 18:13:35 -0700 (PDT)
Message-ID: <9a58f718-a7ad-4838-a5d1-9df8f3d43372@linaro.org>
Date: Tue, 6 May 2025 22:13:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/24] APCI PCI Hotplug support on ARM
From: Gustavo Romero <gustavo.romero@linaro.org>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <6a52f974-3e13-49ba-bfeb-e30e683e4ce5@linaro.org>
 <5e24182d-a8bc-41fa-9741-6caecaa0c12e@redhat.com>
 <b409baa6-8834-4841-a544-ee8055c54051@linaro.org>
Content-Language: en-US
In-Reply-To: <b409baa6-8834-4841-a544-ee8055c54051@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Eric,

On 5/6/25 21:51, Gustavo Romero wrote:
> Hi Eric,
> 
> On 5/6/25 12:58, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 5/5/25 3:26 PM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 4/28/25 07:25, Eric Auger wrote:
>>>> This series enables APCI PCI hotplug/hotunplug on ARM
>>>> and makes it default for 10.1 machine type. This aligns with
>>>> x86 q35 machine. Expected benefits should be similar to
>>>> those listed in [1].
>>>>
>>>> The infrastructure used in x86 is heavily reused and a
>>>> huge part of the series consists in moving code from
>>>> hw/i386/acpi-build.c to a generic place and slightly
>>>> adapting it to make it usable on ARM. The DSDT table is
>>>> augmented to support ACPI PCI hotplug elements.
>>>>
>>>> On ARM we use use a GED event to notify the OS about
>>>> hotplug events.
>>>>
>>>> I have not noticed any tests/qtest/bios-tables-test failures
>>>> neither on x86 nor ARM. x86 DSDT table has not changed.
>>>> ARM DSDT table definitively has but there are no tests
>>>> impacted. ARM misses hotplug tests that do exist on x86. This
>>>> most probably should be considered in the future.
>>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>
>>>> This series can be found at:
>>>> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-rfc
>>>>
>>>> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
>>>> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
>>>
>>> I've just started to review your series and went to a quick smoke test
>>> by hotplugging a net adapter and got the following kernel internal error:
>>>
>>> (qemu) device_add virtio-net-pci,bus=pcie.1,addr=0,id=na
>>> (qemu) [   64.165411] pci 0000:01:00.0: [1af4:1041] type 00 class
>>> 0x020000
>>> [   64.165895] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
>>> [   64.166259] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff
>>> 64bit pref]
>>> [   64.166658] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff
>>> pref]
>>> [   64.167153] pci 0000:01:00.0: enabling Extended Tags
>>> [   64.179972] Internal error: synchronous external abort:
>>> 0000000096000050 [#1] SMP
>>> [   64.180719] Modules linked in: aes_ce_blk aes_ce_cipher polyval_ce
>>> polyval_generic ghash_ce gf128mul sha2_ce binfmt_misc sha256_arm64
>>> sha1_ce nls_ascii nls_cp437 vfat fat evdev cfg80211 rfkill loop fuse
>>> efi_pstore drm dm_mod dax configfs efivarfs qemu_fw_cfg ip_tables
>>> x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic virtio_scsi
>>> virtio_net scsi_mod net_failover failover virtio_blk scsi_common
>>> crct10dif_ce crct10dif_common virtio_pci virtio_pci_legacy_dev
>>> virtio_pci_modern_dev virtio_mmio
>>> [   64.183656] CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted
>>> 6.1.0-30-arm64 #1  Debian 6.1.124-1
>>> [   64.184071] Hardware name: QEMU QEMU Virtual Machine, BIOS
>>> edk2-stable202408-prebuilt.qemu.org 08/13/2024
>>> [   64.184759] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
>>> [   64.185320] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [   64.185737] pc : acpi_ex_system_memory_space_handler+0x290/0x300
>>> [   64.186175] lr : acpi_ev_address_space_dispatch+0x124/0x334
>>> [   64.186490] sp : ffff80000a6bb3b0
>>> [   64.186663] x29: ffff80000a6bb3b0 x28: ffff0003fcbb08b8 x27:
>>> 0000000000000000
>>> [   64.187126] x26: ffff0003fcbb0288 x25: ffff80000a6bb568 x24:
>>> 0000000000000001
>>> [   64.187499] x23: ffff80000a6bb568 x22: 0000000000000004 x21:
>>> ffff0000c206cb00
>>> [   64.187885] x20: 00000000090c0014 x19: 0000000000000020 x18:
>>> 0000000000000000
>>> [   64.188265] x17: 0000000000000000 x16: 0000000000000000 x15:
>>> 0000000000000000
>>> [   64.188640] x14: 0000000000000000 x13: 4d43c3194dea1791 x12:
>>> 4d7a3553e5c937d0
>>> [   64.189003] x11: 0000000000000001 x10: 0000000000000000 x9 :
>>> ffff800008735b34
>>> [   64.189383] x8 : 0000000000000001 x7 : ffff80000873c850 x6 :
>>> 00000000000000f8
>>> [   64.189778] x5 : ffff0000c206cb00 x4 : 0000000000000000 x3 :
>>> 00000000090c0018
>>> [   64.190163] x2 : ffff80000a9af014 x1 : 00000000090c0018 x0 :
>>> 0000000000000001
>>> [   64.190734] Call trace:
>>> [   64.191086]  acpi_ex_system_memory_space_handler+0x290/0x300
>>> [   64.191696]  acpi_ev_address_space_dispatch+0x124/0x334
>>> [   64.192042]  acpi_ex_access_region+0xe4/0x2e0
>>> [   64.192287]  acpi_ex_field_datum_io+0x88/0x200
>>> [   64.192509]  acpi_ex_write_with_update_rule+0xd4/0x120
>>> [   64.192793]  acpi_ex_insert_into_field+0x210/0x2b0
>>> [   64.193048]  acpi_ex_write_data_to_field+0xa0/0x190
>>> [   64.193298]  acpi_ex_store_object_to_node+0x150/0x240
>>> [   64.193527]  acpi_ex_store+0x144/0x300
>>> [   64.193726]  acpi_ex_opcode_1A_1T_1R+0x218/0x580
>>> [   64.193971]  acpi_ds_exec_end_op+0x24c/0x4b0
>>> [   64.194227]  acpi_ps_parse_loop+0x100/0x6a0
>>> [   64.194477]  acpi_ps_parse_aml+0x94/0x3b0
>>> [   64.194674]  acpi_ps_execute_method+0x128/0x25c
>>> [   64.194922]  acpi_ns_evaluate+0x1f0/0x2d0
>>> [   64.195148]  acpi_evaluate_object+0x138/0x2d0
>>> [   64.195380]  acpi_evaluate_dsm+0xb8/0x134
>>> [   64.195613]  acpi_check_dsm+0x34/0xdc
>>> [   64.195822]  smbios_attr_is_visible+0x5c/0xb0
>>> [   64.196089]  internal_create_group+0xd0/0x3d0
>>> [   64.196335]  internal_create_groups+0x58/0xe0
>>> [   64.196584]  sysfs_create_groups+0x20/0x30
>>> [   64.196813]  device_add_groups+0x18/0x2c
>>> [   64.197039]  bus_add_device+0x48/0x160
>>> [   64.197260]  device_add+0x3a4/0x85c
>>> [   64.197463]  pci_device_add+0x308/0x660
>>> [   64.197680]  pci_scan_single_device+0xe4/0x114
>>> [   64.197941]  pci_scan_slot+0x70/0x1fc
>>> [   64.198155]  acpiphp_rescan_slot+0x90/0xa4
>>> [   64.198366]  acpiphp_hotplug_notify+0x2a8/0x300
>>> [   64.198584]  acpi_device_hotplug+0x138/0x4c0
>>> [   64.198819]  acpi_hotplug_work_fn+0x2c/0x4c
>>> [   64.199045]  process_one_work+0x1f4/0x460
>>> [   64.199277]  worker_thread+0x188/0x4e0
>>> [   64.199492]  kthread+0xe0/0xe4
>>> [   64.199671]  ret_from_fork+0x10/0x20
>>> [   64.200114] Code: f90002e0 52800000 17ffff97 f94002e0 (b9000040)
>>> [   64.200820] ---[ end trace 0000000000000000 ]---
>>>
>>> (qemu)
>>>
>>> This is a Debian Bookworm stock kernel 6.1. I built QEMU from your GH
>>> branch.
>>>
>>> The machine was started with:
>>>
>>> ./qemu-system-aarch64 -m 16G -nographic -machine
>>> type=virt,gic-version=max -cpu cortex-a57 -initrd
>>> /mnt/initrd.img-6.1.0-30-arm64 -kernel /mnt/vmlinuz-6.1.0-30-arm64
>>> -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=force" -device
>>> virtio-scsi-pci -device virtio-blk-pci,drive=root -drive
>>> if=none,id=root,file=/mnt/debian-12-nocloud-arm64.qcow2 -device
>>> pcie-root-port,id=pcie.1,chassis=1,slot=1 -bios
>>> ./pc-bios/edk2-aarch64-code.fd
>>>
>>> ./pc-bios/edk2-aarch64-code.fd is the one found under ./build dir, so
>>> nothing special.
>>
>> I have just tested debian-12-nocloud-arm64.qcow2 which features
>> 6.1.0-34-arm64 + edk2-aarch64-code.fd and I am able to
>> hotplug/hot-unplug the virtio-net-pci device. Can you retry without
>>
>> -initrd /mnt/initrd.img-6.1.0-30-arm64 -kernel
>> /mnt/vmlinuz-6.1.0-30-arm64 -append "root=/dev/vda1
>> console=ttyAMA0,115200 acpi=force" ?
> 
> Sure, so I got the same internal error without passing the kernel, the initrd,
> and the append command.
> 
> 
> I also tried with a pristine Debian .qcow2 taken from:
> 
> https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-arm64.qcow2
> 
> I'm building your Github branch:
> 
> gromero@gromero0:/mnt/git/qemu_/build$ git branch -vv | grep eauger
> * arm-acpi-pcihp-rfc        cf92b293ff [eauger/arm-acpi-pcihp-rfc] hw/arm/virt: Use ACPI PCI hotplug by default
> gromero@gromero0:/mnt/git/qemu_/build$ git log --oneline -1
> cf92b293ff (HEAD -> arm-acpi-pcihp-rfc, eauger/arm-acpi-pcihp-rfc) hw/arm/virt: Use ACPI PCI hotplug by default
> 
> I tried in a pristine ./build dir.
> 
> QEMU options:
> 
> gromero@gromero0:/mnt/git/qemu_/build$ ./qemu-system-aarch64 -m 16G -nographic -machine type=virt,gic-version=max -cpu max -drive if=none,file=/mnt/debian/debian-12-nocloud-arm64.qcow2,format=qcow2,id=hd -device virtio-blk-device,drive=hd -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1,addr=0x2.0x0 -bios ./pc-bios/edk2-aarch64-code.fd
> UEFI firmware (version edk2-stable202408-prebuilt.qemu.org built at 16:28:50 on Sep 12 2024)
> 
> gromero@gromero0:/mnt/git/qemu_/build$ md5sum ./pc-bios/edk2-aarch64-code.fd
> 3426cd25efb1593f86352ec0c61d66f5  ./pc-bios/edk2-aarch64-code.fd
> 
> and I get the same error:
> 
> root@localhost:~# QEMU 10.0.50 monitor - type 'help' for more information
> (qemu) device_add virtio-net-pci,bus=pcie.1,addr=0,id=na
> (qemu) [   56.865284] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
> [   56.866620] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [   56.867711] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> [   56.868287] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> [   56.869143] pci 0000:01:00.0: enabling Extended Tags
> [   56.900481] Internal error: synchronous external abort: 0000000096000050 [#1] SMP
> [   56.900911] Modules linked in: aes_ce_blk binfmt_misc aes_ce_cipher polyval_ce polyval_generic ghash_ce gf128mul sha3_ce sha3_generic sha512_ce sha512_arm64 sha2_ce sha256_arm64 sha1_ce nls_ascii nls_cp437 vfat fat evdev cfg80211 rfkill loop fuse drm efi_pstore dm_mod dax configfs efivarfs qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic virtio_net net_failover failover virtio_blk crct10dif_ce crct10dif_common virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_mmio
> [   56.903132] CPU: 0 PID: 10 Comm: kworker/u2:0 Not tainted 6.1.0-34-arm64 #1  Debian 6.1.135-1
> [   56.903753] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202408-prebuilt.qemu.org 08/13/2024
> [   56.904126] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> [   56.904877] pstate: 60402005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   56.905085] pc : acpi_ex_system_memory_space_handler+0x290/0x300
> [   56.905306] lr : acpi_ev_address_space_dispatch+0x124/0x334
> [   56.905471] sp : ffff80000809b3b0
> [   56.905580] x29: ffff80000809b3b0 x28: ffff0003fcb852d0 x27: 0000000000000000
> [   56.905856] x26: ffff0003fcb85558 x25: ffff80000809b568 x24: 0000000000000001
> [   56.906092] x23: ffff80000809b568 x22: 0000000000000004 x21: ffff0000c1644980
> [   56.906333] x20: 00000000090c0014 x19: 0000000000000020 x18: 0000000000000000
> [   56.906557] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   56.906793] x14: 0000000000000000 x13: ffffb8324c78ebb0 x12: 0000000000000001
> [   56.907016] x11: 000000000000002e x10: ffffb8324cab6e20 x9 : ffffb8324b2076b4
> [   56.907236] x8 : 0000000000000001 x7 : ffffb8324b20e3d0 x6 : 00000000000000f8
> [   56.907473] x5 : ffff0000c1644980 x4 : 0000000000000000 x3 : 00000000090c0018
> [   56.907705] x2 : ffff800008837014 x1 : 00000000090c0018 x0 : 0000000000000001
> [   56.908026] Call trace:
> [   56.908226]  acpi_ex_system_memory_space_handler+0x290/0x300
> [   56.908540]  acpi_ev_address_space_dispatch+0x124/0x334
> [   56.908736]  acpi_ex_access_region+0xe4/0x2e0
> [   56.908870]  acpi_ex_field_datum_io+0x88/0x200
> [   56.909003]  acpi_ex_write_with_update_rule+0xd4/0x120
> [   56.909152]  acpi_ex_insert_into_field+0x210/0x2b0
> [   56.909285]  acpi_ex_write_data_to_field+0xa0/0x190
> [   56.909426]  acpi_ex_store_object_to_node+0x150/0x240
> [   56.909569]  acpi_ex_store+0x144/0x300
> [   56.909688]  acpi_ex_opcode_1A_1T_1R+0x218/0x580
> [   56.909824]  acpi_ds_exec_end_op+0x24c/0x4b0
> [   56.909953]  acpi_ps_parse_loop+0x100/0x6a0
> [   56.910074]  acpi_ps_parse_aml+0x94/0x3b0
> [   56.910197]  acpi_ps_execute_method+0x128/0x25c
> [   56.910331]  acpi_ns_evaluate+0x1f0/0x2d0
> [   56.910445]  acpi_evaluate_object+0x138/0x2d0
> [   56.910573]  acpi_evaluate_dsm+0xb8/0x134
> [   56.910696]  acpi_check_dsm+0x34/0xdc
> [   56.910809]  smbios_attr_is_visible+0x5c/0xb0
> [   56.910937]  internal_create_group+0xd0/0x3d0
> [   56.911066]  internal_create_groups+0x58/0xe0
> [   56.911194]  sysfs_create_groups+0x20/0x30
> [   56.911315]  device_add_groups+0x18/0x2c
> [   56.911435]  bus_add_device+0x48/0x160
> [   56.911552]  device_add+0x3a4/0x85c
> [   56.911678]  pci_device_add+0x308/0x660
> [   56.911803]  pci_scan_single_device+0xe4/0x114
> [   56.911937]  pci_scan_slot+0x70/0x1fc
> [   56.912039]  acpiphp_rescan_slot+0x90/0xa4
> [   56.912161]  acpiphp_hotplug_notify+0x2a8/0x300
> [   56.912290]  acpi_device_hotplug+0x138/0x4c0
> [   56.912428]  acpi_hotplug_work_fn+0x2c/0x4c
> [   56.912549]  process_one_work+0x1f4/0x460
> [   56.912679]  worker_thread+0x188/0x4e0
> [   56.912792]  kthread+0xe0/0xe4
> [   56.912892]  ret_from_fork+0x10/0x20
> [   56.913136] Code: f90002e0 52800000 17ffff97 f94002e0 (b9000040)
> [   56.913532] ---[ end trace 0000000000000000 ]---
> 
> 
> I'm wondering if we are using the same  ./pc-bios/edk2-aarch64-code.fd, although
> I can't see how it would cause such error.

hmm actually I'm able to properly hotplug the network device using the exactly
same sw stack as above (your branch, Debian 12, edk2) but running on an arm64 host.

It seems your running on a arm64 host since you're passing --enable-kvm. Do you
mind trying it on a x86_64 or without --enable-kvm on the arm64 host? I'm able to
reproduce it on arm64 host without --enable-kvm but not with --enable-kvm passed to QEMU.


Cheers,
Gustavo

