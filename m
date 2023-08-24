Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD91786B9E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6YN-0000E3-AC; Thu, 24 Aug 2023 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6YK-0000AS-Gi
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:22:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6YI-0002Uw-72
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:22:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-523bf06f7f8so8031849a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692868972; x=1693473772;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9SkdToUdpopeJ3B2GtXRCXJWn3s+OrfRM/JZXJ8zkUU=;
 b=rQ/CB2L/k3xDdA0p9z4KoeDHJf2A0IrR2RfL2EwBtws71dJKPtFSZr7Cx3FaDXNelY
 YvsHWqOVaCl4FzoAyu1rANtFaPpC1/4ECQpOIkiMk8+pTwJ3/TllFI/LaUgTDzJa/d4G
 70V3AxeNP1PqnWZZRsL4D0CJqoMPl6dc0Q1hhqXMu7tfnTV7kFvYfgv1aC85LOFKoCk0
 Uow6ErgCv8/E1jIMgfPbVKBFqBTlW42Rxvu9vZaN7Ul6ClyvWGAw6YiyVHrs8np0cRl/
 mpIz9qpB/kC0NB/LJ8dJ7IbCY6P67cjXn+Z3apxbiByFwEVNqISDjhfdy8OyGiJgtP3O
 lBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692868972; x=1693473772;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9SkdToUdpopeJ3B2GtXRCXJWn3s+OrfRM/JZXJ8zkUU=;
 b=KdYNmgit2K7mdq8il1OkxvPPW/TsXtBtqKPtR5531OC19cN7ojKRYyrV4eDna//rft
 5TIs8ndFVARo7IRUzAu2JEKqyOSwiC6qtgqsz9KsxP4Ga9XtSQFwqT7i4bq/6NTvJRYs
 FllCnunDeAc0kjtEggkosR7NpXpREILYcVlN96UaWmlAbn7+98Xxnj/381ZPCUTd2mbJ
 5j2nBOGJburicOv2QBEetbY7EJSK/yJmfPbSI5k1J214iU0X8DTjalnGfQjDMlo7LpTR
 CUNy1wo43/vw+GzeBu67PPP9PXp+TzOJzUgkBb01XKEpZF5i4VdFo5JAzEbU43jaY2mX
 OGmw==
X-Gm-Message-State: AOJu0Yxhb9fLyaC0dz3kbj05MuOhy/utm+ZZjPhlJFZhfVQ6upQvyQs1
 vKL8TjBlIAAsLo1h/zXa3agQPa518xEIzgZkzRYVPw==
X-Google-Smtp-Source: AGHT+IGZk9ilEsliEQ00/bzKgmyBUfRZOEmd7RHcrKUQsnOl7YBBQXR/af+Y+exrgljmdy00v1ADMZ2mqQ9E6e16BoU=
X-Received: by 2002:aa7:d952:0:b0:523:33eb:1103 with SMTP id
 l18-20020aa7d952000000b0052333eb1103mr12377509eds.14.1692868972038; Thu, 24
 Aug 2023 02:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230823112259.GA820132@fedora>
In-Reply-To: <20230823112259.GA820132@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 10:22:41 +0100
Message-ID: <CAFEAcA-pd3G4q+C50JAmi5j1S8xHLNrqHTqhKtXbE4asXdrsVQ@mail.gmail.com>
Subject: Re: Starting the QEMU 8.2 release cycle
To: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 23 Aug 2023 at 12:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Hi,
> The QEMU 8.2 release cycle has begun. I am merging qemu.git pull
> requests for this release. You do not need to CC me on pull requests
> because I am monitoring qemu-devel.
>
> The proposed schedule is as follows:
>
> 2023-08-22      Beginning of development phase
> 2023-11-14      Soft feature freeze. Only bug fixes after this point. All feature changes must be already in a sub maintainer tree and all pull requests from submaintainers must have been sent to the list by this date.
> 2023-11-21      Hard feature freeze. Tag rc0
> 2023-11-28      Tag rc1
> 2023-12-05      Tag rc2
> 2023-12-12      Tag rc3
> 2023-12-19      Release; or tag rc4 if needed
> 2023-12-26      Release if we needed an rc4
>
> Please let me know if these dates are inconvenient. I may adjust the
> last date depending on my availability at the end of 2023.

Up to you, but my personal preference when doing the end-of-year
releases was to move the cycle a week or so earlier, because
it's pretty common that we need the rc4 and it's better not
to be trying to do the final release in the middle of the
holiday season (especially bearing in mind that releases
require not just your availability but also Mike Roth's).

-- PMM

