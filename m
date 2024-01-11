Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A138482AB24
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrbH-0001El-2n; Thu, 11 Jan 2024 04:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNrbE-00019X-8k
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNrbC-0006Vn-6j
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704966221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EyMGiYAfi1QFIbFYE9pzrBVHq3ikN04i1kzPdHqm0qk=;
 b=iydb6hLvVo/8oNtMoUR6maQ6BTE6FBKn81Oo91Z1VeGYYJY4j9mIu8+80mECsr8EK0s5cH
 iHJr+N4p48xlTxME7VItPMjy48drrPgDcN7scFeBpnvXbpCF1q5s/uOCHI64uUT5npglG/
 bSeG2HxR71AdQJJkcUsXmRoKMNW+TUY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-BaTmhe5KO4etcFPeguqBVg-1; Thu, 11 Jan 2024 04:43:40 -0500
X-MC-Unique: BaTmhe5KO4etcFPeguqBVg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6800714a149so101502366d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 01:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704966219; x=1705571019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EyMGiYAfi1QFIbFYE9pzrBVHq3ikN04i1kzPdHqm0qk=;
 b=DQCe17Ioe/omzuWhdeQJyNKQj3ReDt/CIyqFfOWTVUKrejMiyPiKDK84qFQOYk+F98
 5lsK2Zn6xRssLA5XooWlCXhDPRoGOVSh4MBfSEi0yB26NhyP/deDCm6UgiZh8R8k1Boq
 VebVt7coIT9ru2x+llqRpzbDCpgskdCB79iOkoJ8UQw4wNlZQM683S7mQcSUADfjw56/
 MzIFP8bw7LYkt9fvOE+qvHRC3q4h2NQkVjGkcs+agpHOS+UUdYul6YqKaa9avNs/d4zY
 q8x3HlRy2gbpae9EF8dqygmSh3SSiwsfGGpbXRKhJE93RVbyhF8cY6naDpdySaEboEAh
 Uatg==
X-Gm-Message-State: AOJu0YzuE4qquuFtY7qTZdLzNAwy7yfHNmS+imxgZvCas9vT2JuJjHRE
 hotwRcTBQQMIYVzADyjob5HnzGgyNuXMCPlOl8rFO9nT8a5bYMSWiwSK3KRnUJkEhNGrtFDjdQ8
 OZFYNZ7LGbL8t16xToBEEr4s=
X-Received: by 2002:a05:6214:29ce:b0:681:9ea:b99f with SMTP id
 gh14-20020a05621429ce00b0068109eab99fmr961887qvb.57.1704966219353; 
 Thu, 11 Jan 2024 01:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4USE/NfCRja/b195+ehlUwhno3v9JpGs+7MSeNR/fIev1vME3l5k6TTV+yXxg92lXMpsikg==
X-Received: by 2002:a05:6214:29ce:b0:681:9ea:b99f with SMTP id
 gh14-20020a05621429ce00b0068109eab99fmr961881qvb.57.1704966219031; 
 Thu, 11 Jan 2024 01:43:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a0ce80a000000b00680b34d52f8sm191806qvn.13.2024.01.11.01.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 01:43:38 -0800 (PST)
Message-ID: <e22ebb27-26d0-4e1d-86ab-ab9feb44d645@redhat.com>
Date: Thu, 11 Jan 2024 10:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
 <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
 <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/10/24 21:28, Matthew Rosato wrote:
> On 1/10/24 1:30 PM, Cédric Le Goater wrote:
>> On 9/12/23 13:41, Thomas Huth wrote:
>>> From: Janosch Frank <frankja@linux.ibm.com>
>>>
>>> Bound APQNs have to be reset before tearing down the secure config via
>>> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
>>> code.
>>>
>>> So let's do a subsystem_reset() which includes a AP reset before the
>>> unprotect call. We'll do a full device_reset() afterwards which will
>>> reset some devices twice. That's ok since we can't move the
>>> device_reset() before the unprotect as it includes a CPU clear reset
>>> which the Ultravisor does not expect at that point in time.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Message-ID: <20230901114851.154357-1-frankja@linux.ibm.com>
>>> Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
>>> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 3dd0b2372d..2d75f2131f 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
>>>        switch (reset_type) {
>>>        case S390_RESET_EXTERNAL:
>>>        case S390_RESET_REIPL:
>>> +        /*
>>> +         * Reset the subsystem which includes a AP reset. If a PV
>>> +         * guest had APQNs attached the AP reset is a prerequisite to
>>> +         * unprotecting since the UV checks if all APQNs are reset.
>>> +         */
>>> +        subsystem_reset();
>>
>>
>> This commit introduced a regression with pass-though ISM devices.
>>
>> After startup, a reboot will generate extra device resets (vfio-pci in
>> this case) which break the pass-though ISM device in a subtle way,
> 
> Hi Cedric, thanks for reporting this...  I was able to reproduce just now, and it looks like ISM firmware is unhappy specifically with this susbystem_reset call added by ef1535901a0, not necessarily the multiple attempts at reset -- I verified that reverting ef1535901a0 resolves the ISM issue, but if I instead try reverting the older 03451953c79e while leaving ef1535901a0 in place then ISM devices still break on guest reboot.
> 
> 
>> probably related to IOMMU mapping according to 03451953c79e
>> ("s390x/pci: reset ISM passthrough devices on shutdown and system
>> reset"). After poweroff, the device is left in a sort-of-a-use state
>> on the host and the LPAR has to be rebooted to clear the invalid state
>> of the device. To be noted, that standard PCI devices are immune to
>> this change.
> 
> As a bit of background, ISM firmware is very sensitive re: the contents of the (host) IOMMU and attempts at manipulation that it deems to be out-of-order; the point of 03451953c79e was to ensure that the device gets a reset before we attempt at unmapping anything that wasn't cleaned up in an orderly fashion by the (guest) ism driver at the time of shutdown/reset (e.g. underlying firmware may view guest SBAs in the IOMMU as still registered for use and will throw an error condition at attempts to remove their entries in the IOMMU without first going through an unregistration process).
> 
> The unmap that would make ISM upset would generally be coming out of vfio_listener_region_del where we just do one big vfio_dma_unmap -- a quick trace shows that the subsystem_reset call added by ef1535901a0 is causing the vfio_listener_region_del to once again trigger before the pci reset of the ISM device, effectively re-introducing the condition that 03451953c79e was trying to resolve.

Yes. I saw the vfio_listener_region_del trace coming first and came to
the conclusion it was related to IOMMU mappings.

>> The extra resets should avoided in some ways, (a shutdown notifier and
>> a reset callback are already registered for ISM devices by 03451953c79e)
> 
> So as mentioned above, it's not the extra resets that are the issue, it's the order of operations.  Basically, we need to drive pci_device_reset for any ISM device associated with the guest before we destroy the vfio memory listener (now triggered in this case via subsystem_reset).  So if we must drive this subsystem_reset before we trigger the device reset callbacks then it might require a s390 pci bus routine that is called before or during subystem_reset just to reset the ISM devices associated with this guest first; I'm not sure yet.
> 
> As an aside:  I wonder why we are always doing the subsystem_reset here unconditionally rather than only when s390_is_pv() since that seems to be the only case that requires it.

That would be a start to workaround the issue.
  
>> and, most important, once the VM terminates, the device resources
>> should be cleared in the host kernel. So there seem to be two issues
>> to address in mainline QEMU and in Linux AFAICT.
> 
> Because of the condition detected by ISM firmware as described above, the host device was placed in an error state and remains in that state. 

OK. this condition is considered serious enough to be reported to a
management level. This seems a bit excessive since the recovery can be
handled by software, but manually. Are there any plans to address this
problem ?


> After shutting down the guest, you should be able to use zpcictl --reset on the affected host device(s) to clear the error condition and re-enable it for use.

ok. That's better than reboot.


On a side note, I am also seeing :

[   73.989688] ------------[ cut here ]------------
[   73.989696] unexpected non zero alert.mask 0x20
[   73.989748] WARNING: CPU: 9 PID: 4503 at arch/s390/kvm/interrupt.c:3214 kvm_s390_gisa_destroy+0xd4/0xe8 [kvm]
[   73.989791] Modules linked in: vfio_pci vfio_pci_core irqbypass vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink 8021q garp mrp rfkill sunrpc ext4 mbcache jbd2 vfio_ap zcrypt_cex4 vfio_ccw mdev vfio_iommu_type1 vfio drm fuse i2c_core drm_panel_orientation_quirks xfs libcrc32c dm_service_time mlx5_core sd_mod t10_pi ghash_s390 sg prng des_s390 libdes sha3_512_s390 sha3_256_s390 mlxfw tls scm_block psample eadm_sch qeth_l2 bridge stp llc dasd_eckd_mod zfcp qeth dasd_mod scsi_transport_fc ccwgroup qdio dm_multipath dm_mirror dm_region_hash dm_log dm_mod pkey zcrypt kvm aes_s390
[   73.989825] CPU: 9 PID: 4503 Comm: worker Kdump: loaded Not tainted 6.7.0-clg-dirty #52
[   73.989827] Hardware name: IBM 3931 LA1 400 (LPAR)
[   73.989829] Krnl PSW : 0704c00180000000 000003ff7fcd2198 (kvm_s390_gisa_destroy+0xd8/0xe8 [kvm])
[   73.989845]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[   73.989847] Krnl GPRS: c0000000fffeffff 0000000700000027 0000000000000023 00000007df4249c8
[   73.989849]            000003800649b858 000003800649b850 00000007fcb9db00 0000000000000000
[   73.989851]            000000008ebae8c8 0000000083a8c4f0 0000000000b69900 000000008ebac000
[   73.989853]            000003ff903aef68 000003800649bd98 000003ff7fcd2194 000003800649b9f8
[   73.989859] Krnl Code: 000003ff7fcd2188: c02000024f88	larl	%r2,000003ff7fd1c098
                           000003ff7fcd218e: c0e5fffea360	brasl	%r14,000003ff7fca684e
                          #000003ff7fcd2194: af000000		mc	0,0
                          >000003ff7fcd2198: e310b7680204	lg	%r1,10088(%r11)
                           000003ff7fcd219e: a7f4ffae		brc	15,000003ff7fcd20fa
                           000003ff7fcd21a2: 0707		bcr	0,%r7
                           000003ff7fcd21a4: 0707		bcr	0,%r7
                           000003ff7fcd21a6: 0707		bcr	0,%r7
[   73.989929] Call Trace:
[   73.989931]  [<000003ff7fcd2198>] kvm_s390_gisa_destroy+0xd8/0xe8 [kvm]
[   73.989946] ([<000003ff7fcd2194>] kvm_s390_gisa_destroy+0xd4/0xe8 [kvm])
[   73.989960]  [<000003ff7fcc1578>] kvm_arch_destroy_vm+0x50/0x118 [kvm]
[   73.989974]  [<000003ff7fcb00a2>] kvm_destroy_vm+0x15a/0x260 [kvm]
[   73.989985]  [<000003ff7fcb021e>] kvm_vm_release+0x36/0x48 [kvm]
[   73.989996]  [<00000007de4f830c>] __fput+0x94/0x2d0
[   73.990009]  [<00000007de20d838>] task_work_run+0x88/0xe8
[   73.990013]  [<00000007de1e75e0>] do_exit+0x2e0/0x4e0
[   73.990016]  [<00000007de1e79c0>] do_group_exit+0x40/0xb8
[   73.990017]  [<00000007de1f96e8>] send_sig_info+0x0/0xa8
[   73.990021]  [<00000007de194b26>] arch_do_signal_or_restart+0x56/0x318
[   73.990025]  [<00000007de28bf12>] exit_to_user_mode_prepare+0x10a/0x1a0
[   73.990028]  [<00000007deb607d2>] __do_syscall+0x152/0x1f8
[   73.990032]  [<00000007deb70ac8>] system_call+0x70/0x98
[   73.990036] Last Breaking-Event-Address:
[   73.990037]  [<00000007de1e0c58>] __warn_printk+0x78/0xe8


Thanks,

C.


