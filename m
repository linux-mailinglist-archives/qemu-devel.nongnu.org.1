Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9BD82993F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWuD-0001kr-PV; Wed, 10 Jan 2024 06:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNWtn-0001fZ-DZ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:37:32 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNWtl-0000PF-FD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:37:31 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ccabf5a4beso45485431fa.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 03:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704886644; x=1705491444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUB7mjlvBIbJbHnL3fj2sF87HU4S4WQhheWul9j1M7w=;
 b=sTyc4XXNUhTWS2LjjdjL06l1ImVtQPD6FSkwyibvYn91AodQo54DnBRdzXHY/mZIX0
 PUtNXc8SKQIeAhdU3YQVn7E2u9ilAItfsCFTPO7qN0CRagn9FjQjWGr3aTGU06DmQ0t2
 RLL3EPhXDlrbHlyVEjbKPJL3+whX7A0U0v0LK+TtZRj+uCLiYhgpCKB5zsyzmB8CpSIC
 s8lPIPzW7VvDWtsWTQ7MUXrxPo+08uEvdMmN+pC7VJWwj/o6mVfd142vyAPFmbOFnrQy
 C+PMQOkbxksY+UAmQbBd8JDeTjWEtxUZfosd6DkS/NdWN3xFBRqXMurhcIsCBQNWb9JG
 /02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704886644; x=1705491444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUB7mjlvBIbJbHnL3fj2sF87HU4S4WQhheWul9j1M7w=;
 b=REmVDrRG/kbAxNFQh6BjNKnZsNvcA02OpIYG+NCKrDwZVY6/NWFnEN4Jl6V6OskVG4
 sUUTBlJj/3dm0tXHQyyjSLZbl+PS48WYUvXyKFv/PO/W9XT2OYGtDbNvUsCR8Ad/gjBc
 X77mpZGRvhdHohMgg9vzp3z4xmRzcEcGvqOG0reU7W8dXviCjE23DaOtenyJjPy++1UH
 fKVQFHzQSkAi1odL/7sUy4q/BeJLlyhOl/6tJBDvilEOpesElP6wDzAhG1fO7MmcMCTD
 9hOBUZ9WGyMIj2PS6iVrouDI4ji2QBe2N/7DkpB2MgDOzn3eIdEZuJt9EhVQ1hByq5Vw
 tEDQ==
X-Gm-Message-State: AOJu0Yx/9xggrzRbJRxstjO1PFJC0EbVdQPGBTCFlAcC69h8Cu3gZsVR
 W0wKblX6savu0Q7Aenye85zoJgg2rnX36D9sVAsO8NS9ET4uwA==
X-Google-Smtp-Source: AGHT+IEjHmxpiN3NPnIhYbRa6TqW9QCUyJE0OSvQJlOsnFvDu0u37Aoy+MPiVjc7TjSm27maBCRI6iqMbUc6kkdhBAQ=
X-Received: by 2002:a2e:b0d8:0:b0:2cc:e386:3773 with SMTP id
 g24-20020a2eb0d8000000b002cce3863773mr245325ljl.58.1704886644105; Wed, 10 Jan
 2024 03:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20240109180930.90793-1-philmd@linaro.org>
 <20240109180930.90793-2-philmd@linaro.org>
 <6c877f5e-e0f2-4ef1-920a-df850484c358@linaro.org>
In-Reply-To: <6c877f5e-e0f2-4ef1-920a-df850484c358@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2024 11:36:50 +0000
Message-ID: <CAFEAcA-Gmv3MFngNp+B5PxVBx+kZ941xGgF1AvXrXq+Xn8DWLg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] target/arm/cpu: Simplify checking A64_MTE bit in
 FEATURE_ID register
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Rob Herring <robh@kernel.org>, Alistair Francis <alistair@alistair23.me>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 10 Jan 2024 at 06:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/10/24 05:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > cpu_isar_feature(aa64_mte, cpu) is testing a AArch64-only ID
> > register. The ARM_FEATURE_AARCH64 check is redundant.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/arm/cpu.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 1c8b787482..c828b333c9 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1690,8 +1690,7 @@ void arm_cpu_post_init(Object *obj)
> >       }
> >
> >   #ifndef CONFIG_USER_ONLY
> > -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
> > -        cpu_isar_feature(aa64_mte, cpu)) {
> > +    if (cpu_isar_feature(aa64_mte, cpu)) {
> >           object_property_add_link(obj, "tag-memory",
> >                                    TYPE_MEMORY_REGION,
> >                                    (Object **)&cpu->tag_memory,
>
> It is not redundant.
>
> If !AARCH64, then the isar registers tested by aa64_mte are invalid.

Ah, I think I steered Philippe wrongly on IRC on this one
because I forgot how our feature checking handled this,
but yes, you're right.

-- PMM

