Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1165777E8A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8m0-0005ii-9S; Thu, 10 Aug 2023 12:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8lx-0005i1-MJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:44:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8lv-0001Ud-Os
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:44:29 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fe7e67cc77so1749191e87.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685866; x=1692290666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1PINb9Y/QoehjsjEFWDVOS1APnWFsBfKDEf7P1YdGI=;
 b=ZIkjvjQZMsaulYr5eEXB53eXMei9wIxoc3CQ6BybMkcN9pD1v920lMLwC85vnqbUfQ
 4U1NH4Gr3cyAvZPLkPJKocVto0pZoFMTjHtNiRssJs42VoflBchfR2Qylvh7QWr2azU3
 snt5THF3y/jbtFgNC/4bRyxmrocDXzQP7/Xnf2lq3xVKJEvwRAGuyrI2bc+wGr0qyZUP
 5cplFlXPsl/1bpJz6+kQgLGbud3roGsb1YLa/hcdDi1jzXTiKl2cCqol9sxC+t8WidEQ
 4NRTUR1LFIM3p+AXQdwnUrDluPiuVMVmKSBLmQjlGPc8pUrc1gPK8f/sw0pU/Xsl1LF6
 eQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685866; x=1692290666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1PINb9Y/QoehjsjEFWDVOS1APnWFsBfKDEf7P1YdGI=;
 b=XIYqWGvo06zB5OpSI4kPYnZgVp5EmbnlPQrBDcNl05CTa0O7dBXJklB9NQISzgg6p5
 dY8yMIHbNGpCzyEovrehAysKYeAUBfcVVzuh9ggUfWIyboR2DxBudDGNUvCGusOFdECZ
 2YLk6B1KOZKAxkc7H1LLQylHSi4lvs7dAA7bijRlqc3xXIqFgfyvsjcxnTEVcEncYXRO
 STZVoW4xmOhKV65yPvFtPodPH/+COtRMcJerqtk7eTYpFuygAdQD/sp4gsMG3yb53Rsn
 sB8QhHxz5vcNagHHFy7JE1D+8wrF8LSID7Wk8kj0OySr3zLzAuPi/kivdJPxbNiqvZmy
 w1yQ==
X-Gm-Message-State: AOJu0YyWK/UL70nNgiysYtcwUMAIMW5oXTDp9ZlBepCtX5z2ixJ+UoC7
 AsuK8S69NOCJ0xwlvjE6F/AIRjZyJb4m1arODDyr6g==
X-Google-Smtp-Source: AGHT+IHi25oISB2TlhH0k5GZsIc+Txmm618oIFNWTuNJLr0ZMRZQLTcqrWjzhcJ425PqL1Y9pNni3gwIRFuYl0tBDEM=
X-Received: by 2002:ac2:5936:0:b0:4fe:a2c:24b0 with SMTP id
 v22-20020ac25936000000b004fe0a2c24b0mr2124681lfi.26.1691685865721; Thu, 10
 Aug 2023 09:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230810161329.7453-1-philmd@linaro.org>
In-Reply-To: <20230810161329.7453-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:44:14 +0100
Message-ID: <CAFEAcA8o_W28cUoAtLekhpFUTTG+xEn_0uEmyWGh_xEM6j9Y=Q@mail.gmail.com>
Subject: Re: [PATCH-for-8.2] target/arm/cpu: Allow logging disabled CPU
 features at UNIMP level
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 10 Aug 2023 at 17:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Some CPU features aren't strictly required to run guest code (such
> debugging features), so we don't model them. To prevent the guest
> to access non-existent system registers, we disable the feature bit
> in the ID registers (see commit 7d8c283e10 "target/arm: Suppress more
> TCG unimplemented features in ID registers").
>
> Since it might be useful to know when a CPU supposed to implement a
> feature has it disabled in QEMU, provide the ability to log disabled
> features at the UNIMP level:
>
>   $ qemu-system-aarch64 -M virt -d unimp -S -cpu neoverse-v1
>   QEMU 8.0.92 monitor - type 'help' for more information
>   CPU#0: Disabling unimplemented feature 'FEAT_SPE (Statistical Profiling=
 Extension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_TRF (Self-hosted Trace Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Trace Macrocell system register=
 access' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Trace Macrocell system register=
 access' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'Memory-mapped Trace' for neover=
se-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_AMU (Activity Monitors Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_AMU (Activity Monitors Ext=
ension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_MPAM (Memory Partitioning =
and Monitoring Extension)' for neoverse-v1
>   CPU#0: Disabling unimplemented feature 'FEAT_NV (Nested Virtualization)=
' for neoverse-v1
>   (qemu) q
>
>   $ qemu-system-aarch64 -M xlnx-zcu102 -trace arm_disable\* -S -d unimp -=
monitor stdio -cpu cortex-a76
>   QEMU 8.0.92 monitor - type 'help' for more information
>   CPU#0: Disabling unimplemented feature 'Memory-mapped Trace' for cortex=
-a53
>   CPU#1: Disabling unimplemented feature 'Memory-mapped Trace' for cortex=
-a53
>   CPU#2: Disabling unimplemented feature 'Memory-mapped Trace' for cortex=
-a53
>   CPU#3: Disabling unimplemented feature 'Memory-mapped Trace' for cortex=
-a53
>   (qemu) q

Generally the 'unimp' logging is "the guest tried to use some
feature we don't implement". Here we log about the fact we
don't implement the feature, even if the guest never tries
to use the feature at all...

thanks
-- PMM

