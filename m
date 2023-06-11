Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22A72B1D4
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 14:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8KAv-0004nj-5c; Sun, 11 Jun 2023 08:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sagigrim@gmail.com>)
 id 1q8KAs-0004n5-Nn
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 08:28:02 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sagigrim@gmail.com>)
 id 1q8KAq-000680-T4
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 08:28:02 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-3f7e7a5aaacso6739245e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 05:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686486479; x=1689078479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+F2YCPuCvNucfU27hbM0z+XpuVFvj66Ick2ebriOypA=;
 b=Lqd22K4ZY+0wH5/2wOh3qsSExuyewU8CBzYrDFBBKxFLmJ3N1J1kNQ4d4s5KgQkV1A
 /Nx3uWHLYMs2smMEiRlvXKcqbhR3Ozl5Alo9id98jElVPWK9RcOaBDxCla7feV4yD0EO
 kbB+2Gmb+XanocHnesyAATK8Yf2KqbpJNI6bnqtfxRjpGEHw73GaBbjOon0G7sxgk7rD
 EN97Ij55fJYeRkP0KRMCunj5KXZDHf8K1uAG54KwypMfn9we+SbNaWWzeEK8r7dsfHNl
 wSDUNpv+17hQCLDrPm+g490CdAV5stOifhAa5MW5lwFbMRHweX5d0zUCRPlnO2p+Bwlo
 zwbg==
X-Gm-Message-State: AC+VfDycSYpybRalZY6phwYtHeygDaV6lsemF8pxCGiOeitMIhH05wqr
 hDoH2RH51dltB3la2ICCsam34dKrpq8=
X-Google-Smtp-Source: ACHHUZ4m8pq4txsHvcj8ukwSuRRy79vTijg6ghstlv+RRoXTPZLoCBU2i1OgPnPoRXkq7ODfUZUqnA==
X-Received: by 2002:a05:600c:4746:b0:3f8:651:e25e with SMTP id
 w6-20020a05600c474600b003f80651e25emr5314025wmo.4.1686486478539; 
 Sun, 11 Jun 2023 05:27:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b003f810be0231sm4517721wmh.32.2023.06.11.05.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jun 2023 05:27:58 -0700 (PDT)
Message-ID: <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
Date: Sun, 11 Jun 2023 15:27:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: virtio-blk using a single iothread
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
References: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
 <20230608160817.GK2138915@fedora>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230608160817.GK2138915@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.52; envelope-from=sagigrim@gmail.com;
 helo=mail-wm1-f52.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 6/8/23 19:08, Stefan Hajnoczi wrote:
> On Thu, Jun 08, 2023 at 10:40:57AM +0300, Sagi Grimberg wrote:
>> Hey Stefan, Paolo,
>>
>> I just had a report from a user experiencing lower virtio-blk
>> performance than he expected. This user is running virtio-blk on top of
>> nvme-tcp device. The guest is running 12 CPU cores.
>>
>> The guest read/write throughput is capped at around 30% of the available
>> throughput from the host (~800MB/s from the guest vs. 2800MB/s from the
>> host - 25Gb/s nic). The workload running on the guest is a
>> multi-threaded fio workload.
>>
>> What is observed is the fact that virtio-blk is using a single disk-wide
>> iothread processing all the vqs. Specifically nvme-tcp (similar to other
>> tcp based protocols) is negatively impacted by lack of thread
>> concurrency that can distribute I/O requests to different TCP
>> connections.
>>
>> We also attempted to move the iothread to a dedicated core, however that
>> did yield any meaningful performance improvements). The reason appears
>> to be less about CPU utilization on the iothread core, but more around
>> single TCP connection serialization.
>>
>> Moving to io=threads does increase the throughput, however sacrificing
>> latency significantly.
>>
>> So the user find itself with available host cpus and TCP connections
>> that it could easily use to get maximum throughput, without the ability
>> to leverage them. True, other guests will use different
>> threads/contexts, however the goal here is to allow the full performance
>> from a single device.
>>
>> I've seen several discussions and attempts in the past to allow a
>> virtio-blk device leverage multiple iothreads, but around 2 years ago
>> the discussions over this paused. So wanted to ask, are there any plans
>> or anything in the works to address this limitation?
>>
>> I've seen that the spdk folks are heading in this direction with their
>> vhost-blk implementation:
>> https://review.spdk.io/gerrit/c/spdk/spdk/+/16068
> 
> Hi Sagi,
> Yes, there is an ongoing QEMU multi-queue block layer effort to make it
> possible for multiple IOThreads to process disk I/O for the same
> --blockdev in parallel.

Great to know.

> Most of my recent QEMU patches have been part of this effort. There is a
> work-in-progress branch that supports mapping virtio-blk virtqueues to
> specific IOThreads:
> https://gitlab.com/stefanha/qemu/-/commits/virtio-blk-iothread-vq-mapping

Thanks for the pointer.

> The syntax is:
> 
>    --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"}],"drive":"drive0"}'
> 
> This says "assign virtqueues round-robin to iothread0 and iothread1".
> Half the virtqueues will be processed by iothread0 and the other half by
> iothread1. There is also syntax for assigning specific virtqueues to
> each IOThread, but usually the automatic round-robin assignment is all
> that's needed.
> 
> This work is not finished yet. Basic I/O (e.g. fio) works without
> crashes, but expect to hit issues if you use blockjobs, hotplug, etc.
> 
> Performance optimization work has just begun, so it won't deliver all
> the benefits yet. I ran a benchmark yesterday where going from 1 to 2
> IOThreads increased performance by 25%. That's much less than we're
> aiming for; attaching two independent virtio-blk devices improves the
> performance by ~100%. I know we can get there eventually. Some of the
> bottlenecks are known (e.g. block statistics collection causes lock
> contention) and others are yet to be investigated.

Hmm, I rebased this branch on top of mainline master and ran a naive
test, and it seems that performance regressed quite a bit :(

I'm running this test on my laptop (Intel(R) Core(TM) i7-8650U CPU
@1.90GHz), so this is more qualitative test for BW only.
I use null_blk as the host device.

With mainline master I get ~9GB/s 64k randread, and with your branch
I get ~5GB/s, this is regardless of assigning iothreads (one or
two) or not.

my qemu command:
taskset -c 0-3 build/qemu-system-x86_64 -cpu host -m 1G -enable-kvm -smp 
4 -drive 
file=/var/lib/libvirt/images/ubuntu-22/root-disk-clone.qcow2,format=qcow2 
-drive 
if=none,id=drive0,cache=none,aio=native,format=raw,file=/dev/nullb0 
-device virtio-blk-pci,drive=drive0,scsi=off -nographic

my guest fio jobfile:
--
[global]
group_reporting
runtime=3000
time_based
loops=1
direct=1
invalidate=1
randrepeat=0
norandommap
exitall
cpus_allowed=0-3
cpus_allowed_policy=split

[read]
filename=/dev/vda
numjobs=4
iodepth=32
bs=64k
rw=randread
ioengine=io_uring
--

Maybe I'm doing something wrong? Didn't expect to find a regression
against mainline on the default setup.

