Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E184E73B790
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCg2b-00041W-E9; Fri, 23 Jun 2023 08:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCg2L-0003sZ-D9
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qCg2I-0003vY-Lg
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687523829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovy0ble02iA06wr+XWgTN7I6XmF6rmrkIcnDvs291EU=;
 b=HZh9MdEsxc7FbGD4u10K+O5zqs/pFSwMTkhB6s5dWzm5YI2JLGtAdhifW0/LQ4ZEyTsakf
 ftLRs0Qg8qOgSKhck7gAfDpMuZOXsDbCM3+qjmwbd8mIhK6R5RyilxnmWnCpRRUH1Rfwb3
 W3nAunxHYE4RW4Bdc898p5/P5Cb8PAQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-DYRx2syAMH6GdbMNg_MkQA-1; Fri, 23 Jun 2023 08:37:08 -0400
X-MC-Unique: DYRx2syAMH6GdbMNg_MkQA-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-78cf00ee733so103489241.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523827; x=1690115827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ovy0ble02iA06wr+XWgTN7I6XmF6rmrkIcnDvs291EU=;
 b=EaWCN0dNETlif5wPuEmsciL0QBRA63RcIj1Kse+pMJ+i2zUuY5czeGK3weNWlh+RfY
 MW+xQ2xHyHXtGAo/3IYxcvhuYM5Gfhjc85ZuwkH8ZcTyRnYDxnSsk/8GqpzwB4+aSXzK
 lKo9b8hl4rTKg6Xm98q057IHfuC0/mwvV0lAUC+dPOXk01NI4qXmQ6Ar6W2cT+bf7DT6
 edVOBUbwXnRNSXv3FSGs7PoavCw8hS9fXC30GybkrjG2mHzqNzrDp7GUL9X7UN9r3nsR
 myIzqRlR0vPWYiafpnTUVXKefdCVxdHvs4CsLaQAZSAO1iDt46kGJ86fTdFu5MWCVQXK
 D6iw==
X-Gm-Message-State: AC+VfDzQqZd+e0skCBKw4zuaw3SGAuXbic0yKGIFJrdea2tct4RMllWg
 iaoKX4U8AQKf5Yojq01gp3uLwGO7XGlbyEreBMavuEhiQCFGd9J7HK0CZHQdQ6QceUhUw5LWrOz
 qgl86T+SS62JISJU=
X-Received: by 2002:a67:ce84:0:b0:440:b0eb:4fd7 with SMTP id
 c4-20020a67ce84000000b00440b0eb4fd7mr11026865vse.23.1687523827347; 
 Fri, 23 Jun 2023 05:37:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5W/W9RmP9GqG4fKXWPek+xopZsonBJdSp4diJrx5vsS87vN6GddPJZvYLWPJ66XDQa2+oOaA==
X-Received: by 2002:a67:ce84:0:b0:440:b0eb:4fd7 with SMTP id
 c4-20020a67ce84000000b00440b0eb4fd7mr11026843vse.23.1687523827057; 
 Fri, 23 Jun 2023 05:37:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a0cb34e000000b0063017dc17fcsm4972104qvf.126.2023.06.23.05.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 05:37:06 -0700 (PDT)
Message-ID: <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
Date: Fri, 23 Jun 2023 14:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
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

On 6/23/23 11:10, Peter Maydell wrote:
> On Fri, 23 Jun 2023 at 09:21, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> ppc has always silently ignored access to real (physical) addresses
>> with nothing behind it, which can make debugging difficult at times.
>>
>> It looks like the way to handle this is implement the transaction
>> failed call, which most target architectures do. Notably not x86
>> though, I wonder why?
> 
> Much of this is historical legacy. QEMU originally had no
> concept of "the system outside the CPU returns some kind
> of bus error and the CPU raises an exception for it".
> This is turn is (I think) because the x86 PC doesn't do
> that: you always get back some kind of response, I think
> -1 on reads and writes ignored. We added the do_transaction_failed
> hook largely because we wanted it to give more accurate
> emulation of this kind of thing on Arm, but as usual with new
> facilities we left the other architectures to do it themselves
> if they wanted -- by default the behaviour remained the same.
> Some architectures have picked it up; some haven't.
> 
> The main reason it's a bit of a pain to turn the correct
> handling on is because often boards don't actually implement
> all the devices they're supposed to. For a pile of legacy Arm
> boards, especially where we didn't have good test images,
> we use the machine flag ignore_memory_transaction_failures to
> retain the legacy behaviour. (This isn't great because it's
> pretty much going to mean we have that flag set on those
> boards forever because nobody is going to care enough to
> investigate and test.)
> 
>> Other question is, sometimes I guess it's nice to avoid crashing in
>> order to try to quickly get past some unimplemented MMIO. Maybe a
>> command line option or something could turn it off? It should
>> probably be a QEMU-wide option if so, so that shouldn't hold this
>> series up, I can propose a option for that if anybody is worried
>> about it.
> 
> I would not recommend going any further than maybe setting the
> ignore_memory_transaction_failures flag for boards you don't
> care about. (But in an ideal world, don't set it and deal with
> any bug reports by implementing stub versions of missing devices.
> Depends how confident you are in your test coverage.)

It seems it broke the "mac99" and  powernv10 machines, using the
qemu-ppc-boot images which are mostly buildroot. See below for logs.

Adding Mark for further testing on Mac OS.

Thanks,

C.


Saving 256 bits of non-creditable seed for next boot
Starting network: [    3.876834] Disabling lock debugging due to kernel taint
[    3.877351] Oops: Machine check, sig: 7 [#1]
[    3.877697] BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=4 PowerMac
[    3.878019] Modules linked in:
[    3.878233] CPU: 0 PID: 93 Comm: ip Tainted: G   M               6.1.14 #1
[    3.878403] Hardware name: PowerMac3,1 PPC970 0x390202 PowerMac
[    3.878554] NIP:  c0000000007f1c28 LR: c0000000007f18d0 CTR: 0000000000000000
[    3.878721] REGS: c00000000ffefd60 TRAP: 0200   Tainted: G   M                (6.1.14)
[    3.878922] MSR:  8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 44002884  XER: 00000000
[    3.879149] DAR: c0003e0080103010 DSISR: 42000000 IRQMASK: 0
[    3.879149] GPR00: c0000000007f10fc c0000000037f35e0 c000000000d4bc00 0000000000000024
[    3.879149] GPR04: c0003f00000cbdc8 0000000000000000 0000000000000000 c0000000037f35a6
[    3.879149] GPR08: 0000000000000000 c0003e0080103010 0000000000000000 c000000001513c58
[    3.879149] GPR12: 0000000084002884 c0000000015fa000 000000010d8b0460 000000011a042f13
[    3.879149] GPR16: 000000011a042f7f 000000011a042f87 000000011a04052c 000000011a042f0e
[    3.879149] GPR20: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
[    3.879149] GPR24: c0000000036f8e00 0000000000000000 c00000000319af08 c00000000319af10
[    3.879149] GPR28: c000000003797000 c000000003798000 c00000000319a880 c000000003924c00
[    3.880889] NIP [c0000000007f1c28] .gem_reinit_chip+0xc28/0xc70
[    3.881045] LR [c0000000007f18d0] .gem_reinit_chip+0x8d0/0xc70
[    3.881209] Call Trace:
[    3.881274] [c0000000037f35e0] [c0000000007f10fc] .gem_reinit_chip+0xfc/0xc70 (unreliable)
[    3.881484] [c0000000037f3680] [c0000000007f2df4] .gem_do_start+0x34/0x430
[    3.881658] [c0000000037f3730] [c0000000009396d0] .__dev_open+0x150/0x240
[    3.881835] [c0000000037f37e0] [c000000000939d1c] .__dev_change_flags+0x20c/0x2c0
[    3.882015] [c0000000037f38b0] [c000000000939dfc] .dev_change_flags+0x2c/0x90
[    3.882185] [c0000000037f3940] [c000000000a1dc88] .devinet_ioctl+0x2e8/0x9b0
[    3.882361] [c0000000037f3a20] [c000000000a20854] .inet_ioctl+0x184/0x2c0
[    3.882527] [c0000000037f3b30] [c0000000008fa5d8] .sock_do_ioctl+0x58/0x130
[    3.882693] [c0000000037f3c00] [c0000000008fb77c] .sock_ioctl+0x1cc/0x830
[    3.882876] [c0000000037f3ce0] [c0000000002c6bcc] .__se_sys_ioctl+0x10c/0x130
[    3.883066] [c0000000037f3d80] [c0000000000252e8] .system_call_exception+0x158/0x2d0
[    3.883255] [c0000000037f3e10] [c00000000000b2d4] system_call_common+0xf4/0x258
[    3.883436] --- interrupt: c00 at 0x3fff825da858
[    3.883553] NIP:  00003fff825da858 LR: 0000000119f7b3a0 CTR: 0000000000000000
[    3.883721] REGS: c0000000037f3e80 TRAP: 0c00   Tainted: G   M                (6.1.14)
[    3.883910] MSR:  800000000200f032 <SF,VEC,EE,PR,FP,ME,IR,DR,RI>  CR: 28002884  XER: 00000000
[    3.884149] IRQMASK: 0
[    3.884149] GPR00: 0000000000000036 00003fffc530af10 00003fff826b7400 0000000000000003
[    3.884149] GPR04: 0000000000008914 00003fffc530b0a0 000000011a040518 0000000000000000
[    3.884149] GPR08: 00000000803c7414 0000000000000000 0000000000000000 0000000000000000
[    3.884149] GPR12: 0000000000000000 00003fff827377e0 000000010d8b0460 000000011a042f13
[    3.884149] GPR16: 000000011a042f7f 000000011a042f87 000000011a04052c 000000011a042f0e
[    3.884149] GPR20: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
[    3.884149] GPR24: ffffffffffffffff ffffffffffffffff ffffffffffffffff 00003fffc530bf51
[    3.884149] GPR28: 00003fffc530b0a0 0000000000000001 0000000000000001 000000011a040518
[    3.885775] NIP [00003fff825da858] 0x3fff825da858
[    3.885902] LR [0000000119f7b3a0] 0x119f7b3a0
[    3.886006] --- interrupt: c00
[    3.886109] Instruction dump:
[    3.886296] 39290044 55290032 1d09fffe 7d485214 7d295050 915e01b8 913e01bc 4bfff628
[    3.886537] e93e0000 39400000 39293010 7c0004ac <7d404d2c> a14d02f8 5548043e 2c080000
[    3.886968] ---[ end trace 0000000000000000 ]---
[    3.887112]

and

[   34.443113577,5] XIVE: [ IC 00  ] Resetting one xive...
[   34.446516646,5] RESET: Fast reboot disabled: Kernel re-entered OPAL
[   34.447320802,3] OPAL exiting with locks held, pir=0000 token=80 retval=1
[   34.447483518,3]   hw/xive2.c:3955
[   34.447578862,5] CPU ATTEMPT TO RE-ENTER FIRMWARE! PIR=0000 cpu @0x31c10000 -> pir=0000 token=158
[   34.447781018,5] CPU ATTEMPT TO RE-ENTER FIRMWARE! PIR=0000 cpu @0x31c10000 -> pir=0000 token=158
[    0.000000][    C0] Disabling lock debugging due to kernel taint
[    0.000000][    C0] MCE: CPU0: machine check (Severe)  Real address Load (bad) DAR: 0006030201000038 [Not recovered]
[    0.000000][    C0] MCE: CPU0: NIP: [0000000030093290] 0x30093290
[    0.000000][    C0] MCE: CPU0: Initiator CPU
[    0.000000][    C0] MCE: CPU0: Hardware error
[    0.000000][    C0] opal: Hardware platform error: Unrecoverable Machine Check exception
[    0.000000][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G   M               6.1.14 #1
[    0.000000][    C0] Hardware name: IBM PowerNV (emulated by qemu) POWER10 0x801200 opal:v7.0 PowerNV
[    0.000000][    C0] NIP:  0000000030093290 LR: 0000000030093284 CTR: 0000000030100f20
[    0.000000][    C0] REGS: c00000003df8fd60 TRAP: 0200   Tainted: G   M                (6.1.14)
[    0.000000][    C0] MSR:  9000000002201002 <SF,HV,VEC,ME,RI>  CR: 84022424  XER: 20040000
[    0.000000][    C0] CFAR: 0000000030112dd8 DAR: 0006030201000038 DSISR: 00000040 IRQMASK: 3
[    0.000000][    C0] GPR00: 0000000030093284 0000000031c13bd0 0000000030192600 8000000000000000
[    0.000000][    C0] GPR04: 0000000000030000 0000000000000300 0000000030144f46 0000000030144f38
[    0.000000][    C0] GPR08: 0000000000000010 0006030201000038 0000000000000000 0000000000000001
[    0.000000][    C0] GPR12: 0000000024022424 c000000002580000 0000000000000000 0000000000000000
[    0.000000][    C0] GPR16: 0000000031c10000 0000000000000001 0000000000000008 0000000000800000
[    0.000000][    C0] GPR20: ffffffffffffff80 0000000030608ea8 0000000030145427 00000000301453e8
[    0.000000][    C0] GPR24: 0000000030145312 000000003014548f 00000000301454bd 0000000030608118
[    0.000000][    C0] GPR28: 0000000000000038 0006030201000000 0000000000000003 0000000030608e08
[    0.000000][    C0] NIP [0000000030093290] 0x30093290
[    0.000000][    C0] LR [0000000030093284] 0x30093284
[    0.000000][    C0] Call Trace:
[    0.000000][    C0] Instruction dump:
[    0.000000][    C0] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    0.000000][    C0] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[   34.458079299,0] OPAL: Reboot requested due to Platform error.
[   34.458349474,3] OPAL: Reboot requested due to Platform error.[   34.458589592,5] Unable to log error
[   34.458756741,2] NVRAM: Failed to load
[    0.000000][    C0] opal: Reboot type 1 not supported for Unrecoverable Machine Check exception
[    0.000000][    C0] Kernel panic legoater@virtlab1024:~/qemu/qemu-ppc-boot.git$



