Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61EB73A0DD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJPJ-0004p3-PE; Thu, 22 Jun 2023 08:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qCJPG-0004kj-4u
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:27:22 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qCJPD-0003ZG-Do
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:27:21 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qCJP3-0000K6-Q1; Thu, 22 Jun 2023 14:27:09 +0200
Message-ID: <2cfad6f4-dbe7-48fd-9369-2c65bc41390d@maciej.szmigiero.name>
Date: Thu, 22 Jun 2023 14:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
 <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
 <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
 <1b107fba-38e0-cced-e19f-b62684072bfd@maciej.szmigiero.name>
 <008fced2-1bcf-7a89-d642-bb724eb63ddf@redhat.com>
 <987af80f-9636-42da-26de-e2d07dc25ce3@maciej.szmigiero.name>
 <acf9402f-3baf-6c07-6662-7e0638f78263@redhat.com>
 <0a7cc359-f308-21a1-6c6d-7bcb51051f7e@maciej.szmigiero.name>
 <aa78a4fc-9c88-b6c1-98f8-d22348927df4@redhat.com>
 <614701f8-b0cf-a856-a374-5b59165ebc9c@maciej.szmigiero.name>
 <ec4d9557-c7af-54a5-2e17-f5d8d2b54534@redhat.com>
 <9da309c5-d39e-8d42-d444-b021d6379c14@maciej.szmigiero.name>
 <10a3981c-4716-e358-4d06-a672d8d7a874@redhat.com>
 <08d68f19-5570-464e-a79e-6d79cb046c40@maciej.szmigiero.name>
In-Reply-To: <08d68f19-5570-464e-a79e-6d79cb046c40@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22.06.2023 14:14, Maciej S. Szmigiero wrote:
> On 22.06.2023 14:06, David Hildenbrand wrote:
>> On 22.06.23 13:17, Maciej S. Szmigiero wrote:
>>> On 22.06.2023 13:15, David Hildenbrand wrote:
>>>> On 22.06.23 13:12, Maciej S. Szmigiero wrote:
>>>>> On 22.06.2023 13:01, David Hildenbrand wrote:
>>>>>> [...]
>>>>>>
>>>>>>>>>> We'd use a memory region container as device memory region (like [1]) and would have to handle the !memdev case (I can help with that). > Into that, you can map the RAM memory region on demand (and eventually even using multiple slots like [1]).
>>>>>>>>>>
>>>>>>>>>> (2) Use a single virtual DIMM and (un)plug that on demand. Let the machine code handle (un)plugging of the device.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> (1) feels cleanest to me, although it will require a bit more work.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I also think approach (1) makes more sense as it avoids memslot metadata
>>>>>>>>> overhead for not-yet-hot-added parts of the memory backing device.
>>>>>>>>>
>>>>>>>>> Not sure what you mean that the !memdev case would be problematic in this
>>>>>>>>> case - it is working in the current driver shape so why would adding
>>>>>>>>> potential memory subregions (used in the memdev case) change that?
>>>>>>>>
>>>>>>>> I'm thinking about the case where you have a hv-balloon device without a memdev.
>>>>>>>>
>>>>>>>> Without -m X,maxmem=y we don't currently expect to have memory devices around
>>>>>>>> (and especially them getting (un)plugged. But why should we "force" to set the
>>>>>>>> "maxmem" option
>>>>>>>
>>>>>>> I guess it's only a small change to QEMU to allow having hv-balloon
>>>>>>> device (without a memdev) even in the case where there's no "maxmem"
>>>>>>> option given on the QEMU command line.
>>>>>>>
>>>>>>>>
>>>>>>>> I hope I'll find some time soonish to prototype what I have in mind, to see
>>>>>>>> if it could be made working.
>>>>>>>>
>>>>>>>
>>>>>>> Okay, so I'll wait for your prototype before commencing further work on
>>>>>>> the next version of this driver.
>>>>>>
>>>>>> About to have something simplistic running -- I think. Want to test with a Linux VM, but I don't seem to get it working (also without my changes).
>>>>>>
>>>>>>
>>>>>> #!/bin/bash
>>>>>>
>>>>>> build/qemu-system-x86_64 \
>>>>>>        --enable-kvm \
>>>>>>        -m 4G,maxmem=36G \
>>>>>>        -cpu host,hv-syndbg=on,hv-synic,hv-relaxed,hv-vpindex \
>>>>>>        -smp 16 \
>>>>>>        -nographic \
>>>>>>        -nodefaults \
>>>>>>        -net nic -net user \
>>>>>>        -chardev stdio,nosignal,id=serial \
>>>>>>        -hda Fedora-Cloud-Base-37-1.7.x86_64.qcow2 \
>>>>>>        -cdrom /home/dhildenb/git/cloud-init/cloud-init.iso \
>>>>>>        -device isa-serial,chardev=serial \
>>>>>>        -chardev socket,id=monitor,path=/var/tmp/mon_src,server,nowait \
>>>>>>        -mon chardev=monitor,mode=readline \
>>>>>>        -device vmbus-bridge \
>>>>>>        -object memory-backend-ram,size=2G,id=mem0 \
>>>>>>        -device hv-balloon,id=hv1,memdev=mem0
>>>>>>
>>>>>>
>>>>>>
>>>>>> [root@vm-0 ~]# uname -r
>>>>>> 6.3.5-100.fc37.x86_64
>>>>>> [root@vm-0 ~]# modprobe hv_balloon
>>>>>> modprobe: ERROR: could not insert 'hv_balloon': No such device
>>>>>>
>>>>>>
>>>>>> Any magic flag I am missing? Or is there something preventing this to work with Linux VMs?
>>>>>>
>>>>>
>>>>> Haven't tested the driver with Linux guests in a long time (as it is
>>>>> targeting Windows), but I think you need to disable KVM PV interface for
>>>>> the Hyper-V one to be detected by Linux.
>>>>>
>>>>> Something like adding "kvm=off" to "-cpu" and seeing in the dmesg whether
>>>>> the detected hypervisor is now Hyper-V.
>>>>>
>>>>> Also, you need to disable S4 in the guest for hot-add capability to work
>>>>> (I'm adding "-global ICH9-LPC.disable_s4=1" with q35 machine for this).
>>>>>
>>>>> Would also suggest adding "--trace 'hv_balloon_*' --trace 'memory_device_*'"
>>>>> to QEMU command line to see what's happening.
>>>>
>>>> VM is not happy:
>>>>
>>>> [    1.908595] BUG: kernel NULL pointer dereference, address: 0000000000000007
>>>> [    1.908837] #PF: supervisor read access in kernel mode
>>>> [    1.908837] #PF: error_code(0x0000) - not-present page
>>>> [    1.908837] PGD 0 P4D 0
>>>> [    1.908837] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [    1.908837] CPU: 13 PID: 492 Comm: (udev-worker) Not tainted 6.3.5-100.fc37.x86_64 #1
>>>> [    1.908837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-p4
>>>> [    1.908837] RIP: 0010:acpi_ns_lookup+0x8f/0x4c0
>>>> [    1.908837] Code: 8b 3d f5 eb 1c 03 83 05 52 ec 1c 03 01 48 85 ff 0f 84 51 03 00 00 44 89 c3 4c 89 cb
>>>> [    1.908837] RSP: 0018:ffff95b680ad7950 EFLAGS: 00010286
>>>> [    1.908837] RAX: ffff95b680ad79e0 RBX: 0000000000000002 RCX: 0000000000000003
>>>> [    1.908837] RDX: 0000000000000000 RSI: ffff8a0283a3c558 RDI: ffffffffa4b376e0
>>>> [    1.908837] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
>>>> [    1.908837] R10: ffff8a02811034ec R11: 0000000000000000 R12: ffffffffffffffff
>>>> [    1.908837] R13: ffff8a02811034e8 R14: ffff8a02811034e8 R15: 0000000000000000
>>>> [    1.908837] FS:  00007f3bb2e7d0c0(0000) GS:ffff8a02bbd40000(0000) knlGS:0000000000000000
>>>> [    1.908837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    1.908837] CR2: 0000000000000007 CR3: 0000000100a58002 CR4: 0000000000770ee0
>>>> [    1.908837] PKRU: 55555554
>>>> [    1.908837] Call Trace:
>>>> [    1.908837]  <TASK>
>>>> [    1.908837]  ? __die+0x23/0x70
>>>> [    1.908837]  ? page_fault_oops+0x171/0x4e0
>>>> [    1.908837]  ? prepare_alloc_pages.constprop.0+0xf6/0x1a0
>>>> [    1.908837]  ? exc_page_fault+0x74/0x170
>>>> [    1.908837]  ? asm_exc_page_fault+0x26/0x30
>>>> [    1.908837]  ? acpi_ns_lookup+0x8f/0x4c0
>>>> [    1.908837]  acpi_ns_get_node_unlocked+0xdd/0x110
>>>> [    1.908837]  ? down_timeout+0x3e/0x60
>>>> [    1.908837]  ? acpi_ns_get_node+0x3e/0x60
>>>> [    1.908837]  acpi_ns_get_node+0x3e/0x60
>>>> [    1.908837]  acpi_ns_evaluate+0x1cb/0x2d0
>>>> [    1.908837]  acpi_ut_evaluate_object+0x68/0x1c0
>>>> [    1.908837]  acpi_rs_get_method_data+0x37/0x80
>>>> [    1.908837]  ? __pfx_vmbus_walk_resources+0x10/0x10 [hv_vmbus]
>>>> [    1.908837]  acpi_walk_resources+0x91/0xe0
>>>> [    1.908837]  vmbus_acpi_add+0x87/0x170 [hv_vmbus]
>>>> [    1.908837]  acpi_device_probe+0x47/0x160
>>>> [    1.908837]  really_probe+0x19f/0x400
>>>> [    1.908837]  ? __pfx___driver_attach+0x10/0x10
>>>> [    1.908837]  __driver_probe_device+0x78/0x160
>>>> [    1.908837]  driver_probe_device+0x1f/0x90
>>>> [    1.908837]  __driver_attach+0xd2/0x1c0
>>>> [    1.908837]  bus_for_each_dev+0x85/0xd0
>>>> [    1.908837]  bus_add_driver+0x116/0x220
>>>> [    1.908837]  driver_register+0x59/0x100
>>>> [    1.908837]  ? __pfx_init_module+0x10/0x10 [hv_vmbus]
>>>> [    1.908837]  hv_acpi_init+0x39/0xff0 [hv_vmbus]
>>>> [    1.908837]  ? __pfx_init_module+0x10/0x10 [hv_vmbus]
>>>> [    1.908837]  do_one_initcall+0x5a/0x240
>>>> [    1.908837]  do_init_module+0x4a/0x210
>>>> [    1.908837]  __do_sys_init_module+0x17f/0x1b0
>>>> [    1.908837]  do_syscall_64+0x5c/0x90
>>>> [    1.908837]  ? handle_mm_fault+0x11e/0x310
>>>> [    1.908837]  ? do_user_addr_fault+0x1e0/0x720
>>>> [    1.908837]  ? exc_page_fault+0x74/0x170
>>>> [    1.908837]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>
>>>
>>> I guess *few* people run Linux with QEMU Hyper-V interfaces
>>> implementation..
>>>> Maybe I'll have to install a Windows guest :/
>>>>
>>> I think that makes more sense, since we're targeting Windows anyway.
>>>
>>
>> Having installed fairly recent Win10 and running with master+your patches, I still can't get it to work.
>>
>> Windows is stuck booting (before the little circle starts turning).
>>
>> Removing the hv-balloon device makes it work again (well, at least the circle spins again my windows installation now seems to be broken and I have to reinstall ... windows).
>>
>> Do you have a working cmdline for Windows I can try?
>>
> 
> Do you get any tracing output from the driver when it is loaded or does its mere presence
> make your Windows installation fail to boot?
> 
> I'm was testing using "qemu-system-x86_64 -machine q35,accel=kvm \
>              -cpu host,vmx,-mpx,-pmu,check,hv-crash,hv-relaxed,hv-time,hv-vapic,hv-spinlocks=0x1fff,hv-vpindex,hv-runtime,hv-synic,hv-stimer
>              -smp sockets=1,cores=4,threads=2 -m 4G,slots=2,maxmem=1T -nodefaults -monitor stdio -d guest_errors \
>              -rtc base=localtime,driftfix=slew -global kvm-pit.lost_tick_policy=discard \
>                -device VGA,id=video0 -vnc :0 -usb -device usb-tablet,id=usb-tablet \
>              -drive format="raw",file="${SYSIMG}",cache=writeback,if=none,id=disk-sys \
>              -device virtio-blk-pci,drive=disk-sys,id=disk-sys-pci,bootindex=1 \
>              -netdev user,id=user-net,restrict=on \
>              -device virtio-net-pci,id=nic,netdev=user-net \
>              -global ICH9-LPC.disable_s4=1 -qmp tcp:localhost:4444,server,nowait" \
>              -snapshot -device vmbus-bridge,id=vmbus-bridge -object memory-backend-ram,id=mem1,size=32G \
>              -device hv-balloon,id=hvb,memdev=mem1,status-report=on --trace 'hv_balloon_*' --trace 'memory_device_*'
> 
> Some of these might not be actually required since I was using that VM for other tests too.
> 

Also - the first time Windows boots with VMBus enabled it has to install the necessary drivers,
so if your VM doesn't boot now even without hv-balloon maybe something bad happened during
that installation.

Thanks,
Maciej


