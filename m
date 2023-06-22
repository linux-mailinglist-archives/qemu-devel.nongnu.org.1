Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D201F73A144
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJnU-0005V6-NX; Thu, 22 Jun 2023 08:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCJnS-0005Ub-FT
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCJnQ-00035N-0o
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687438338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkQwDpmHFh0LbtPRqPGM5CfIxLbyqh6KvOsAGT4gKQ4=;
 b=QKTRKzUrL5kPjVEeIa4gr6JqhJELWrtByexJSlm/3Jb6PwKz4zGEn017V7cwO5E8fbYXFk
 tXUfremoPo/d6IXV0Myif0zCTEafSpo7nFiKWsndBr5os4t4jWiMv0PLNZ6lxu2q+O3qN2
 iSAENdiKgytxqzhABcflw0eo82e5CbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-J3uboT8VMaO6zyVFFKTeXw-1; Thu, 22 Jun 2023 08:52:17 -0400
X-MC-Unique: J3uboT8VMaO6zyVFFKTeXw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f8f9b50f17so39412885e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687438336; x=1690030336;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TkQwDpmHFh0LbtPRqPGM5CfIxLbyqh6KvOsAGT4gKQ4=;
 b=Lf3E4rVjyNGkJTkaL63YqgYb8NVw6QtRHZC8owk89/b/3pf/MH4h/kMkofKvCHR7+z
 NkhPRU9FUXX0AKKd0anmD0ba0US6Hz2XeYLoDwwp5Mm9JmqZFjPuIW1UpXkIPcIfP1D7
 Y31n/I3NpVTZ9c3prtvziTQKTHHdA5CARVhR3QPSc0EqLFGb7I4SUZxR17sRrZzaIy+T
 l73jjqEeeXigHPDyQCXVej+6j/xHdqSC7tOhchTd45F5yus4jgfPomcLg6rVnnQvoktW
 KIebSJy+2Goy0o6+Blg6XQoCda7k1/6Mx/ioHAEIHP0uWsmMQV/rSCTlZ+Rwu7J/EIXZ
 1Ytg==
X-Gm-Message-State: AC+VfDwOfX1/IOzcjrv1OXUBq8SIE65X06Xw0jiQrRib6NFHjMm734gR
 +hPAJ66gvQzdNKh7HIM+XL8tEL8xzBcLz9jN8OsMtuI1RI1Ur/smJO1INbG3TrRT3oGD9y/B0tt
 pATZ1D0LORhZHAaY=
X-Received: by 2002:a05:600c:2501:b0:3f9:baf3:8d05 with SMTP id
 d1-20020a05600c250100b003f9baf38d05mr4836948wma.14.1687438336091; 
 Thu, 22 Jun 2023 05:52:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ712RRA/6efypU/tLUNHHeBLr4/0pDlPBXSan4zC55ehiTnKcNQ6pGESTMy9wcsgqEQlMWu8g==
X-Received: by 2002:a05:600c:2501:b0:3f9:baf3:8d05 with SMTP id
 d1-20020a05600c250100b003f9baf38d05mr4836921wma.14.1687438335562; 
 Thu, 22 Jun 2023 05:52:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d4610000000b003112dbc3257sm7028798wrq.90.2023.06.22.05.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 05:52:15 -0700 (PDT)
Message-ID: <4da58c74-cc42-6159-87df-905d4441537c@redhat.com>
Date: Thu, 22 Jun 2023 14:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <08d68f19-5570-464e-a79e-6d79cb046c40@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.06.23 14:14, Maciej S. Szmigiero wrote:
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
>>>>>>         --enable-kvm \
>>>>>>         -m 4G,maxmem=36G \
>>>>>>         -cpu host,hv-syndbg=on,hv-synic,hv-relaxed,hv-vpindex \
>>>>>>         -smp 16 \
>>>>>>         -nographic \
>>>>>>         -nodefaults \
>>>>>>         -net nic -net user \
>>>>>>         -chardev stdio,nosignal,id=serial \
>>>>>>         -hda Fedora-Cloud-Base-37-1.7.x86_64.qcow2 \
>>>>>>         -cdrom /home/dhildenb/git/cloud-init/cloud-init.iso \
>>>>>>         -device isa-serial,chardev=serial \
>>>>>>         -chardev socket,id=monitor,path=/var/tmp/mon_src,server,nowait \
>>>>>>         -mon chardev=monitor,mode=readline \
>>>>>>         -device vmbus-bridge \
>>>>>>         -object memory-backend-ram,size=2G,id=mem0 \
>>>>>>         -device hv-balloon,id=hv1,memdev=mem0
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
> 			-cpu host,vmx,-mpx,-pmu,check,hv-crash,hv-relaxed,hv-time,hv-vapic,hv-spinlocks=0x1fff,hv-

^ That magic collection of flags seems to make Win10 happy.

Master+your patches

(qemu) balloon 3000
(qemu) info balloon
balloon: actual=3000
(qemu) balloon 8000
(qemu) info balloon
balloon: actual=6144


As the VM has 4G and the memdev 2G, that's expected (although I'd have
expected an error when trying to set above what's possible).


On my prototype:

(qemu) balloon 3000
(qemu) info balloon
balloon: actual=3000
(qemu) balloon 8000
(qemu) info balloon
balloon: actual=6144


Further (some adjustments from me):
(qemu) info memory-devices
Memory device [hv-balloon]: "hv1"
   memaddr: 0x800000000
   max-size: 2147483648
   memdev: /objects/mem0
(qemu) info mtree
...
address-space: device-memory
   0000000180000000-000000097fffffff (prio 0, i/o): device-memory
     0000000800000000-000000087fffffff (prio 0, i/o): hv-balloon
       0000000800000000-000000087fffffff (prio 0, ram): mem0
...
(qemu) info memory_size_summary
base memory: 4294967296
plugged memory: 2147483648


Without a memdev:

(qemu) info memory-devices
Memory device [hv-balloon]: "hv1"
   max-size: 0



I noticed that sometimes balloon requests get essentially ignored.
Even retrying to set a target doesn't change anything. Only after
some time it eventually works.

(qemu) balloon 3000
(qemu) info balloon
balloon: actual=4096
...
(qemu) info balloon
balloon: actual=4096
(qemu) balloon 4000
(qemu) info balloon
balloon: actual=4096
...
(qemu) balloon 3000
(qemu) info balloon
balloon: actual=4096
(qemu) balloon 5000
(qemu) balloon 2000
(qemu) info balloon
balloon: actual=3152
(qemu) info balloon
balloon: actual=2000


Maybe the VM needs some time after start-up to actually
process requests.


Anyhow, the prototype lives at:
	https://github.com/davidhildenbrand/qemu/tree/hv-balloon
Right now it's on top of:
	https://github.com/davidhildenbrand/qemu/tree/virtio-mem-memslots

Patches/commits:

1) memory-device: Support empty memory devices
2) memory-device: Drop size alignment check
-> Two added patches
3) error: define g_autoptr() cleanup function for the Error type
4) Add Hyper-V Dynamic Memory Protocol definitions
5) Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
-> Your unmodified patches
6) ea0e4775ca tmp
-> Me going wild


The alignment thingy is indeed ugly, but unless we want to fail hotadd for devices
with crazy alignment requirements, it's probably best the way it is on that branch.


You should definitely split up patch #3 into self-contained logical chunks
(e.g., split off the whole hotadd part, common code changes, ...). Also,
I'm not sure if the whole dynamic OurRangePlugged allocation thingy is
not really required, looks like that can be optimized.

I have some other cleanups in mind, but that is best kept to later, once the
patches are in an easier-to-review-sized shape.

-- 
Cheers,

David / dhildenb


