Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F43745746
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEpo-00058E-7w; Mon, 03 Jul 2023 04:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1qGEpk-00056J-Ad
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1qGEpi-0006fA-EP
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688372572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHSDRPty5xB3LeLguf4HG+y4Xs9Ta8oKJ0eZ2VvQjlw=;
 b=AZJKz5vn/wJetUwZ53/kUTl2E1r7dLvZPKYezVAN5onj+ixF5xY2jWCgaKfNMDNY0UJLXZ
 zAzusGL5O2dI0uetgf1CpvmaWJXFjGzvJn71gipJ2kgUYRXrlR7ci4l7klVfAkr9bNgZFk
 Cyukjp6lftJ9bhVpi5q0QmGcj8YSuvs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Roi5ywcBPuiGadgDwBUjNg-1; Mon, 03 Jul 2023 04:22:51 -0400
X-MC-Unique: Roi5ywcBPuiGadgDwBUjNg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so2275526a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688372570; x=1690964570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHSDRPty5xB3LeLguf4HG+y4Xs9Ta8oKJ0eZ2VvQjlw=;
 b=eezivowCAskuxtTlrWs44xWWFbbfXoXrgM8nBUcXBkyxxyJRSasHwr2E+KybV5Q4mo
 9GpvCgHa0fPeeMQNIKqQIc2vAz/ziQllAZ5ShiKje1zT0F04E9MyaSpJp73gBpSKYLE1
 VfdpptYTvIlZCz/wzI3sKB1B5FNNXzcL/jXfGUHmRYkDdlOi6Zm7UFuUbqK2PhjYTSn4
 905nJs0XvHs5E/vhJaq+sjdq7mT49L3nfqMlNBsEXsNqBkzBUTr7wGgcNPe8mlDsH7TJ
 ocZR1w83fF30ujbtrF3I7jVymHlYdOKG68bihB/41bOzqI2aStS39A1OnIBCD6YX0t6c
 VfcQ==
X-Gm-Message-State: ABy/qLYJUQQglGvMVhC6mWzbJyC/yEBvuCYFKNKpdhT5na4JFQm1Fa3g
 k6+CubuWm5BmTWEVEsqZW1Sp41mfOA8gjhZ9DsQorZPdHNIn5s1ytBbsHm6fPC7Erh1GI7+2Eab
 UGkDVdKLyzmYcd00=
X-Received: by 2002:aa7:da10:0:b0:51e:c61:1cd6 with SMTP id
 r16-20020aa7da10000000b0051e0c611cd6mr2367953eds.35.1688372569977; 
 Mon, 03 Jul 2023 01:22:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRuQNRED/+ERrzqQJmgbt4TgcvYAeLq4USlLlJ24ak5LYEKWmmC/drMQdvW1qqq9R8vEEvKA==
X-Received: by 2002:aa7:da10:0:b0:51e:c61:1cd6 with SMTP id
 r16-20020aa7da10000000b0051e0c611cd6mr2367944eds.35.1688372569735; 
 Mon, 03 Jul 2023 01:22:49 -0700 (PDT)
Received: from ridgehead.home.lan (cst2-15-35.cust.vodafone.cz. [31.30.15.35])
 by smtp.gmail.com with ESMTPSA id
 r26-20020aa7d15a000000b0051df54c6a27sm3736677edo.56.2023.07.03.01.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 01:22:49 -0700 (PDT)
Date: Mon, 3 Jul 2023 10:22:47 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <bcain@quicinc.com>,
 Daniel =?utf-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>
Subject: Re: How do you represent a host gcc and a cross gcc in lcitool?
Message-ID: <ZKKFV2ta438L5oGs@ridgehead.home.lan>
References: <87wn0obuk6.fsf@linaro.org>
 <SN6PR02MB4205D202EFB6D6A256ECB93FB8489@SN6PR02MB4205.namprd02.prod.outlook.com>
 <87jzwoba78.fsf@linaro.org>
 <CAKmqyKOidBkxXzWCm8rxagTbF0bucmitrQk1kW20wDNdjqUkeA@mail.gmail.com>
 <87fs6ifp5e.fsf@linaro.org>
 <CAKmqyKNHvP4MJOPP8i-Lj5Bu3-DNi00SngEe5X+c8_vA0EGLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKmqyKNHvP4MJOPP8i-Lj5Bu3-DNi00SngEe5X+c8_vA0EGLaQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

[...]
> > >> >> RiscV guys,
> > >> >>
> > >> >> It's clear that relying on Debian Sid for the QEMU cross build for RiscV
> > >> >> is pretty flakey. Are you guys aware of any other distros that better
> > >> >> support cross compiling to a riscv64 target or is Debian still the best
> > >> >> bet? Could you be persuaded to build a binary docker image with the
> > >> >> cross compilers and libraries required for a decent cross build as an
> > >> >> alternative?
> > >
> > > It's probably not very helpful, but I find Arch based distros to be
> > > the best bet for this.
> >
> > I've never tried arch under docker, isn't it just as much of a moving
> > target?
> 
> I haven't really tried Arch under Docker. I agree that it is a fast
> moving target. I guess it's up for debate if it's too much churn or
> not
> 
> Would a working Arch image be helpful with lcitool?

Not sure from which angle to look at ^this question, so I just add a NB and if
I missed the point just ignore it - we currently don't support Arch as a target
in lcitool, but if this is kind of a dealbreaker for cross-arch QEMU CI,I don't
see a reason why we shouldn't add it. There'd be quite a few steps involved to
introduce it properly, especially wrt/ VM installation, hence we'd need an
issue to track all subgoals, but FWIW it's not needed to address all of the
problems at once if all that is sufficient for you is a working Dockerfile.

Regards,
Erik


