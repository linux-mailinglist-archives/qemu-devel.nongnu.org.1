Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B317383A6
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwru-0005pS-SK; Wed, 21 Jun 2023 08:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qBwrr-0005ob-Oq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:23:23 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qBwrp-0003uI-RR
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:23:23 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-55b3d77c9deso4141131eaf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687350200; x=1689942200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IOSdOO7jr8gRDoaOezFqkntAdqpBhlnc5jE0elj/aW4=;
 b=IEnI+8tc8Q5KyB90mP82i9DReLu7Tzs3HI9z0ewFS0YWVd0fnREE8LlLZdBWADGVWH
 AohGokL739Gg5aL9YAz5hw24pBNYWIkSJyjbKjZBKRgKPs1VQPYNWy4fR3ET/ePVWr0i
 xB31Y/8dYhFTb5qfvJRMhYDbJYMTPh3ximVpoi06Od7gH8BzfY3aRWQ7T7F8GRt9zruz
 K/N3Kgd1dSCKFKdq4V3j7J6tdaDsqP1KqVTRP7hYxqUrgGSs0J4MSZF2oJMXTGLY4TiM
 S9nrZ6b5KzV+5G8KDtf9VbZ/Fpp5efYFjg2M0vZ51vgC0DCUqxvNONhuIZx4QvIV0F17
 pXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687350200; x=1689942200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IOSdOO7jr8gRDoaOezFqkntAdqpBhlnc5jE0elj/aW4=;
 b=i/UGJczU74mqY5uxGBghIRhHN9RhO5/lGLM8FtjoksoP1dN/k5Ow6GWWDGT4AygMir
 mPtFq4aJcTGV620luLIm+4Bw8qfd03zOOxSh5NQoQI8k5rPeKCkdMtOxeOfu5Hnlr3kw
 sYefUTfqm5CpZMJ8nt5oqLZ3n36mddPriDb33NAnxi90Kf2/iE+0HgLabsjAgCbhkWsB
 /8FxEueNvYnaz93F5C2ftX/L+SdiBAnEZS2bxsZRulCxT5PhbzyJ9+z2uRN0KwvgN6+2
 K0LeYkMs8qGbwExNXR1zpaV62sxEyEa2gog7FYwkb72LWSjNanYaElFTyLs1l7rlv+7f
 uUyw==
X-Gm-Message-State: AC+VfDwsUL8ftR0ovgVYti8E/33qGG6pQ5GlEouNZ7DFn3FntRjKEGBg
 /T1IZXWdNRJRV0v4zH3Do9nHhCYNswxys2KvB5U=
X-Google-Smtp-Source: ACHHUZ7GMBP8kdZSaTrjwl+a0WPOMTfboEXzpO5sAas+FV/gfPiHD6gtOJ/6wMbTKvOFGDsUczsGka7AQA3GDYfAO+A=
X-Received: by 2002:a4a:ea8e:0:b0:558:b7e4:cd13 with SMTP id
 r14-20020a4aea8e000000b00558b7e4cd13mr11475621ooh.4.1687350199944; Wed, 21
 Jun 2023 05:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
 <20230608160817.GK2138915@fedora>
 <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
In-Reply-To: <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 Jun 2023 14:23:07 +0200
Message-ID: <CAJSP0QXt6wyK+_r1uxhxmBhWEgmA6-Y5x2q6Uamkm1ZMwV96cw@mail.gmail.com>
Subject: Re: virtio-blk using a single iothread
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Sagi,
I just got back from a conference and am going to be offline for a
week starting tomorrow. I haven't had time to look through your email
but will reply when I'm back from vacation.

Stefan

On Sun, 11 Jun 2023 at 14:29, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 6/8/23 19:08, Stefan Hajnoczi wrote:
> > On Thu, Jun 08, 2023 at 10:40:57AM +0300, Sagi Grimberg wrote:
> >> Hey Stefan, Paolo,
> >>
> >> I just had a report from a user experiencing lower virtio-blk
> >> performance than he expected. This user is running virtio-blk on top of
> >> nvme-tcp device. The guest is running 12 CPU cores.
> >>
> >> The guest read/write throughput is capped at around 30% of the available
> >> throughput from the host (~800MB/s from the guest vs. 2800MB/s from the
> >> host - 25Gb/s nic). The workload running on the guest is a
> >> multi-threaded fio workload.
> >>
> >> What is observed is the fact that virtio-blk is using a single disk-wide
> >> iothread processing all the vqs. Specifically nvme-tcp (similar to other
> >> tcp based protocols) is negatively impacted by lack of thread
> >> concurrency that can distribute I/O requests to different TCP
> >> connections.
> >>
> >> We also attempted to move the iothread to a dedicated core, however that
> >> did yield any meaningful performance improvements). The reason appears
> >> to be less about CPU utilization on the iothread core, but more around
> >> single TCP connection serialization.
> >>
> >> Moving to io=threads does increase the throughput, however sacrificing
> >> latency significantly.
> >>
> >> So the user find itself with available host cpus and TCP connections
> >> that it could easily use to get maximum throughput, without the ability
> >> to leverage them. True, other guests will use different
> >> threads/contexts, however the goal here is to allow the full performance
> >> from a single device.
> >>
> >> I've seen several discussions and attempts in the past to allow a
> >> virtio-blk device leverage multiple iothreads, but around 2 years ago
> >> the discussions over this paused. So wanted to ask, are there any plans
> >> or anything in the works to address this limitation?
> >>
> >> I've seen that the spdk folks are heading in this direction with their
> >> vhost-blk implementation:
> >> https://review.spdk.io/gerrit/c/spdk/spdk/+/16068
> >
> > Hi Sagi,
> > Yes, there is an ongoing QEMU multi-queue block layer effort to make it
> > possible for multiple IOThreads to process disk I/O for the same
> > --blockdev in parallel.
>
> Great to know.
>
> > Most of my recent QEMU patches have been part of this effort. There is a
> > work-in-progress branch that supports mapping virtio-blk virtqueues to
> > specific IOThreads:
> > https://gitlab.com/stefanha/qemu/-/commits/virtio-blk-iothread-vq-mapping
>
> Thanks for the pointer.
>
> > The syntax is:
> >
> >    --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"iothread0"},{"iothread":"iothread1"}],"drive":"drive0"}'
> >
> > This says "assign virtqueues round-robin to iothread0 and iothread1".
> > Half the virtqueues will be processed by iothread0 and the other half by
> > iothread1. There is also syntax for assigning specific virtqueues to
> > each IOThread, but usually the automatic round-robin assignment is all
> > that's needed.
> >
> > This work is not finished yet. Basic I/O (e.g. fio) works without
> > crashes, but expect to hit issues if you use blockjobs, hotplug, etc.
> >
> > Performance optimization work has just begun, so it won't deliver all
> > the benefits yet. I ran a benchmark yesterday where going from 1 to 2
> > IOThreads increased performance by 25%. That's much less than we're
> > aiming for; attaching two independent virtio-blk devices improves the
> > performance by ~100%. I know we can get there eventually. Some of the
> > bottlenecks are known (e.g. block statistics collection causes lock
> > contention) and others are yet to be investigated.
>
> Hmm, I rebased this branch on top of mainline master and ran a naive
> test, and it seems that performance regressed quite a bit :(
>
> I'm running this test on my laptop (Intel(R) Core(TM) i7-8650U CPU
> @1.90GHz), so this is more qualitative test for BW only.
> I use null_blk as the host device.
>
> With mainline master I get ~9GB/s 64k randread, and with your branch
> I get ~5GB/s, this is regardless of assigning iothreads (one or
> two) or not.
>
> my qemu command:
> taskset -c 0-3 build/qemu-system-x86_64 -cpu host -m 1G -enable-kvm -smp
> 4 -drive
> file=/var/lib/libvirt/images/ubuntu-22/root-disk-clone.qcow2,format=qcow2
> -drive
> if=none,id=drive0,cache=none,aio=native,format=raw,file=/dev/nullb0
> -device virtio-blk-pci,drive=drive0,scsi=off -nographic
>
> my guest fio jobfile:
> --
> [global]
> group_reporting
> runtime=3000
> time_based
> loops=1
> direct=1
> invalidate=1
> randrepeat=0
> norandommap
> exitall
> cpus_allowed=0-3
> cpus_allowed_policy=split
>
> [read]
> filename=/dev/vda
> numjobs=4
> iodepth=32
> bs=64k
> rw=randread
> ioengine=io_uring
> --
>
> Maybe I'm doing something wrong? Didn't expect to find a regression
> against mainline on the default setup.
>

