Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2D78E9CE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbeMO-00033J-Ar; Thu, 31 Aug 2023 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbeML-000337-OO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:53:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbeMJ-0001JB-5m
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:53:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso6063045e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693475581; x=1694080381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KQEJpUTSLCIJkZRuR1n6Y0QrKahsCjCpNkHfDrCi9A=;
 b=QsvmzzSu38caCRiolhLw1cDVYxsYBs/yVubuvUqXgqVjrcJ1TYspUuZt84u6rO7hwp
 5XSegVlCqSbg/CATo3okL+1gk4j7vTddrTQiCWY5EzVbURSheh3DhiMjijbBOaducg5/
 vAsDfExSONOJ8dGap7aqwzLAo0blXq4K37k0RDB45AGs3hKpAOK8jvJMosI7ra40fUOG
 Kyz0ZjmP22cL25aSiUengc4nrCEVQX9uDb6hQ8uA0pdNnjswbxs6sP4FIMYK2LQInKO8
 DFWGzDMI8Ftp0YoXYNNiKjq/VpZjGGUwgDZ4BA44omWo4pEdn425+LflBDoyq7d8buST
 GB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693475581; x=1694080381;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1KQEJpUTSLCIJkZRuR1n6Y0QrKahsCjCpNkHfDrCi9A=;
 b=PRad66mMb83jYWEfMdo5LWMBDGRFBCt0qf1QA/NnuFpEeRE7sHrWqFnhhTKV9d2mtL
 uUjes9Lcus7KFuARMyjRVEHB8jq+UmOU7Wm6PfogQpZXncWy08YRwj4RVHrtZyfyZ98K
 SuSXWSdHGk8+lu1SLp2SGWV2a3MvOebA52ziuKTSfNFjl4vC94fq64dkSVgOT65nBemk
 NEjD82PeKM+NCZT+7+o1xTFIs4cQ+5dNislwOOFFtU1alD6mLtN+fMY3q2mP6kNa0e4y
 hy16Sr60kppaAkLiOMwfh1knErsoxs2XzcjlIk2BvpnAXyF7bQk4vcipRgKWHNSdVf0Z
 oMUw==
X-Gm-Message-State: AOJu0Yzw3C6jDem09TstaF3Bow5ckQ7YOgW4TdJXlRFcm89S055g8EZr
 prNUHODeeNdnRulFwHUrALbe2A==
X-Google-Smtp-Source: AGHT+IH07XYi9G/V7ZKDKpvNx67oTeZV0bcaqcY1+01w/ToDCzJQPEXO+uS/9PRFrQigGwORJtC3rQ==
X-Received: by 2002:a05:600c:2159:b0:400:c0e8:18c6 with SMTP id
 v25-20020a05600c215900b00400c0e818c6mr3980512wml.18.1693475581348; 
 Thu, 31 Aug 2023 02:53:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c22d900b003fe2b6d64c8sm4636032wmg.21.2023.08.31.02.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 02:53:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 904EA1FFBB;
 Thu, 31 Aug 2023 10:53:00 +0100 (BST)
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Xen-devel
 <xen-devel@lists.xenproject.org>, Stewart Hildebrand
 <stewart.hildebrand@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Sergiy Kibrik
 <Sergiy_Kibrik@epam.com>, QEMU Developers <qemu-devel@nongnu.org>, Vikram
 Garhwal <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
Subject: Re: QEMU features useful for Xen development?
Date: Thu, 31 Aug 2023 10:37:45 +0100
In-reply-to: <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
Message-ID: <87cyz3pmgz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.org>=
 wrote:
>> As Xen is gaining R52 and R82 support, it would be great to be able to
>> use QEMU for development and testing there as well, but I don't think
>> QEMU can emulate EL2 properly for the Cortex-R architecture. We would
>> need EL2 support in the GIC/timer for R52/R82 as well.
>
> We do actually have a Cortex-R52 model which at least in theory
> should include EL2 support, though as usual with newer QEMU
> stuff it quite likely has lurking bugs; I'm not sure how much
> testing it's had. Also there is currently no board model which
> will work with the Cortex-R52 so it's a bit tricky to use in practice.
> (What sort of board model would Xen want to use it with?)

We already model a bunch of the mps2/mps3 images so I'm assuming adding
the mps3-an536 would be a fairly simple step to do (mps2tz.c is mostly
tweaking config values). The question is would it be a useful target for
Xen?

  https://developer.arm.com/documentation/dai0536/latest/

> The Cortex-R82 would be more work, because (unlike the R52) it's
> AArch64, and we don't have Armv8-R AArch64 support yet, only the AArch32.
>
> I haven't looked at whether GIC on R-profile requires any changes
> from the A-profile GIC; on A-profile obviously we emulate the
> virtualization support already.
>
>> On Cortex-As, in addition to a PCI root complex and an arbitrary PCI
>> device, SMMUv3 emulation (both stages) and GICv3 ITS are needed to be
>> able to test PCI Passthrough.

We have ITS emulation support and it was recently plumbed into the
"sbsa-ref" board as it is needed for higher level SBSA compliance.

>> However, if I recall correctly SMMUv3
>> emulation in QEMU might not be complete enough to enable us to use it.
>
> Yeah, at the moment the SMMU emulation supports stage 1 and stage 2,
> but not both at the same time. This is good enough for PCI passthrough
> with a Linux guest using KVM to pass a device through to a nested
> Linux guest.

Is this a missing feature for SMMUv3 or something introduced in the
later revisions?

We have sketched out the tasks for SMMUv3.2
(https://linaro.atlassian.net/browse/QEMU-558) with a view to whats
needed for RME guests to access hardware. However I think there is a lot
of other stuff needed specifically for RME including what we do about
modelling things like TDISP. Realistically it will be awhile before we
get to completing all of that.


>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

