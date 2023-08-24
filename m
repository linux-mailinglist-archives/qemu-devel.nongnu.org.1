Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D909578752A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZD5h-00012m-TF; Thu, 24 Aug 2023 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZD5X-00012U-RC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:21:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZD5U-0004gj-RR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:21:39 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so112220a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692894094; x=1693498894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=56YLcoKtVubEkhTOZ9zO7HDR8oscAkgNJAKY8t4vY10=;
 b=sItRocVuFQFKVYms094iJAyI1+WdceHKiW8z/nRg/D3gFZu9dG7UDVQOqxztoz/Y8h
 U0IR6mofgEwfmas0wV4r2g4GzAwceH3u8ADTDP6sKR5F9eqGXWACdv3dvDmbB4fHIO4m
 gYfamNiqdpkpdsWpc40zg0W53JVPTqq8zOe1sJjW9siTiMBGurkjgC8a9g4V+qZcjSaJ
 GeXQnkLX2P5ULqXcsvwWesIDyEb2Pz+8adjjeDqZHlKRRmrWFVX8sugibVT6lfqlUeAF
 JuP30UQCHd5spUI8xWDKqHrQuM8K09QDXJxgyVgN0qIac8QcNG0NyYF0q2g6GDp1Eb0X
 8Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692894094; x=1693498894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56YLcoKtVubEkhTOZ9zO7HDR8oscAkgNJAKY8t4vY10=;
 b=LyTZmPDLQwn8QBqvV550k3Dleixam9tDVCyxq0w6wUgOBHsvRDSt1LaEwtP5UHZrF4
 wVvcFsU4w2FgOEQyczHzIDfVy06AlPCS6JTUj6Wh8ruK1GC5NrWtYGE/7A2P9jz6RtV0
 /HFKZjDAJL6HU/T7PmsXrmBOIPzZkKV316KwkXuv2bnWviTTs44VvQzQnRj5hh+pdTky
 OpMshLhhztuH10vc+0PtWe2vFZXsF5L8fv+z/E7RjrbhqjDFZWMuG1c+r37jQKm0ua9O
 a+3gn3gMmSi/WyRkJi+22XB0qftDpsKHg+eY6MeQVFOsgVak4Bu85q3wr7QdLwmVYH2B
 n9LQ==
X-Gm-Message-State: AOJu0Yw3oF3mXfVkLHcK/pa2tGdUlo7DnpG9RhgSjz/TQLwvN4mH/xgI
 kBofpsfiVmIKxgCjS44oSIXBHTonyBiVFxmiMl2CPg==
X-Google-Smtp-Source: AGHT+IH2xbx8dQ1wOJmQ1UP4hMaPiaQhhyrR2gpAiPMbj0sOjCVZIG/BetkBGGJPk5O8kiVYs+RckrZUOrhW5rPaNHM=
X-Received: by 2002:a05:6402:339:b0:523:2811:5531 with SMTP id
 q25-20020a056402033900b0052328115531mr13460922edw.4.1692894094399; Thu, 24
 Aug 2023 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823163440.GA851545@fedora>
 <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
 <CAJSP0QXO1QQ=4UyLXg_=iyc9=uy1CdeL0fq8_95ewZiewU6XTw@mail.gmail.com>
 <e0b5f2d5-a489-a1b4-b630-987a2999a2b2@redhat.com>
In-Reply-To: <e0b5f2d5-a489-a1b4-b630-987a2999a2b2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 17:21:23 +0100
Message-ID: <CAFEAcA_JCrN4d9MGqOUbtwA0zG2L0NoTTKrs2hcYTB+JOfNiPg@mail.gmail.com>
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 24 Aug 2023 at 17:10, Thomas Huth <thuth@redhat.com> wrote:
>
> On 24/08/2023 16.51, Stefan Hajnoczi wrote:
> > On Thu, 24 Aug 2023 at 02:53, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> On 23/08/2023 18.34, Stefan Hajnoczi wrote:
> >>> On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
> >>>> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
> >>>>
> >>>>     Open 8.2 development tree (2023-08-22 07:14:07 -0700)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>     https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
> >>>>
> >>>> for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:
> >>>>
> >>>>     tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)
> >>>
> >>> Hi Thomas,
> >>> Please take a look at the following ubuntu-20.04-s390x-all CI failure:
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/4931341536
> >>
> >> It says: "TimeoutError: Timeout waiting for job to pause" ... could you
> >> please check the load on that host? ... I think that s390x runner is known
> >> for being too slow some times, so I assume that problem should go away if
> >> you re-run the job when it is less loaded.
> >
> > I ran it again and it timed out. I've merged the PR and assume the
> > test is just flaky.
>
> I think someone needs to look at the runner to see whether there is still
> old stuff taking CPU time or something similar.

It does not currently seem to be running anything it should
not be. The uptime is less than 2 days so it was rebooted
recently.

thanks
-- PMM

