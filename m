Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C9786F41
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 14:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ9ax-0001sU-3k; Thu, 24 Aug 2023 08:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZ9av-0001rV-1a
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:37:49 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qZ9as-0002Hk-OF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:37:48 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-572a7141434so450657eaf.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692880664; x=1693485464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nyda80D22eOZQOBfuh3Q0HndectihBENGkCmCpK6Glc=;
 b=SF13piBeaFM4rGy67eGQmQulWBPpqngEvRjYJU3arOGno8CpXqiW6ftAqHCu3Yd8KV
 nwRSlWREkgP9q/ogc3vaaQtDHXtvU8pruhOA6Px5UIly/a1FCPm/uQpijeA6JV2NsBLM
 Epa4+7vrine/XEjzZE/tHsZFdsfZU2BY+KiX82xjrtGZjV2Zk0CnMFBIH2r3Fn1joxRE
 xAGAL1YSmqVTyDi4MGxbc+0vKsWvNprQa9oXZ+XU8GBhWncbh6xncAUnjK9xSmjTDvLB
 0x3BIBo14DD4vhfNwmDVUS7GHCbsx55av6JRo78R1M6rtaPvjHlk1dzDOznH8icOJ8E2
 f/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692880664; x=1693485464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nyda80D22eOZQOBfuh3Q0HndectihBENGkCmCpK6Glc=;
 b=lrlZ6sDnrqOK4RBzF2wEA+WQ+nGBCooMHOfIt4r3KrpljqlPUHhYVPM9GNtfYTahaX
 v8Warfi0V+s0M6YBkwnbnsytEUAuO1s6/kbscUY5p1FJT8UGuH/1m4NCh2PhnWX2qw+E
 wuznF92HBzzAha5PFwyaibEWMstyNXBy6BNxyCSspSdeEya0G1kY7IWzc+yVs7qvXMeD
 WtWhSEHuiRthMMupR2l372+VDh/6JV5u1wzxYWAOpUZoO6Pq0NiZ+xuQOiptXb/v5ory
 l1Gj96uLH94Xx096qStqYIMW3sK7ozz4o3G/MxT6lOhRyMtPv8Bu3bY2Bfq/Ka9Woakd
 Bi/g==
X-Gm-Message-State: AOJu0Yzd02hQ9fNa3ZB5cCsrBVEaN+cBqEEgQc/MZ3yB1BE5/oj74spA
 eJqBzMipDNDTtmQZ/pRp9s7iGD9RJPu9YvfJDTg=
X-Google-Smtp-Source: AGHT+IFIaEZKX0IuO/CDXqVoke7Lcpl0ZQ1n3I6+sfJDwR4jOFTSAR+oeRw9g1NwPMiuR6djIVMLjMsth8BvbUP7dpw=
X-Received: by 2002:a4a:dfc9:0:b0:56c:820e:7f02 with SMTP id
 p9-20020a4adfc9000000b0056c820e7f02mr2140517ood.0.1692880664568; Thu, 24 Aug
 2023 05:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230823112259.GA820132@fedora>
 <CAFEAcA-pd3G4q+C50JAmi5j1S8xHLNrqHTqhKtXbE4asXdrsVQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-pd3G4q+C50JAmi5j1S8xHLNrqHTqhKtXbE4asXdrsVQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 24 Aug 2023 08:37:32 -0400
Message-ID: <CAJSP0QWUne2y1nv8vsw7Nhw_z20_-k-VnJuU4mHF81J+=Ux9Xw@mail.gmail.com>
Subject: Re: Starting the QEMU 8.2 release cycle
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 24 Aug 2023 at 05:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 23 Aug 2023 at 12:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > Hi,
> > The QEMU 8.2 release cycle has begun. I am merging qemu.git pull
> > requests for this release. You do not need to CC me on pull requests
> > because I am monitoring qemu-devel.
> >
> > The proposed schedule is as follows:
> >
> > 2023-08-22      Beginning of development phase
> > 2023-11-14      Soft feature freeze. Only bug fixes after this point. All feature changes must be already in a sub maintainer tree and all pull requests from submaintainers must have been sent to the list by this date.
> > 2023-11-21      Hard feature freeze. Tag rc0
> > 2023-11-28      Tag rc1
> > 2023-12-05      Tag rc2
> > 2023-12-12      Tag rc3
> > 2023-12-19      Release; or tag rc4 if needed
> > 2023-12-26      Release if we needed an rc4
> >
> > Please let me know if these dates are inconvenient. I may adjust the
> > last date depending on my availability at the end of 2023.
>
> Up to you, but my personal preference when doing the end-of-year
> releases was to move the cycle a week or so earlier, because
> it's pretty common that we need the rc4 and it's better not
> to be trying to do the final release in the middle of the
> holiday season (especially bearing in mind that releases
> require not just your availability but also Mike Roth's).

That sounds good. I will bring the dates forward by one week.

Stefan

