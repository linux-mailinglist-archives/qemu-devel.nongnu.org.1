Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F9813879
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 18:26:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDpT7-0001l5-9i; Thu, 14 Dec 2023 12:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDpT5-0001km-7D
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:25:51 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDpT3-000502-Jh
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:25:50 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7e88feso9383387a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702574747; x=1703179547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6xcYxyGpGh0UMclg4CLI/erDIk3zf90VHoo3HjoFRM=;
 b=ORU64NgRuxmS1usc+qHkJ8UaDbLquIrCPce5B6b+zYvYf0vFTfXYqJa9dFsAoicinm
 +OwlFnzYSnwvHx6k96V00Kk9+RvgMNvYboHCWlAodLEfSY/7tBiamHc9kyQ2SoXl42gI
 JiPB3vf78uKKVQrQm0yiljW52mwSiRQuiYVIePwyNja5XdGRyF3svGjPG5jyHqxPtLx1
 Qt1COWGAeY/uFAf6I8XEcUeM7TVD1czHpiOQFAJ7GB8kMSctDzF+Q3WYZJvVxMqdEuA7
 uFGy8+VfRGmBuFZg89tThn8metgNcNifsKsNLWVxuNo9weKFF3d4K+u1LxyM3apOArsq
 rZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702574747; x=1703179547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6xcYxyGpGh0UMclg4CLI/erDIk3zf90VHoo3HjoFRM=;
 b=Su8TNpGwF+UxB21IjcJSewPLh4yolEJrq/ylfsglwCcVxsQyLcvAADHFK3cNpTo0Z2
 NlwQKHsQY9x3GGQYWWE+buRLsQ7Lz7Cjc8g3ezZ+a1ifIsJzBJdQIpD0MS6SIO9liE9U
 035K9x6CThDU7o6URnsIyE2vJjN6ybCTwunmgkGIX4hbwdu2ZrM/fhrF+Tt9DlBOu+Wu
 9ZYuQ0nJ/6b5aHr/vBfKyM5LO6v5pz2w6PzwezQHAa8tsp1RUDQdP1m+lgWzHBzD+lP1
 jQs3LAlawxYnkOLNeY3yU0iQ6uL6u/hnU2NRE+CfCr/MnjFIRoE70tOFofXcooRWG2Ll
 GVUQ==
X-Gm-Message-State: AOJu0Yzb/5XeQz9oUiHbGsWsQ+P7C9MTmrDtJrueIB5mAitYUFL5C8Oc
 xXIZBEDsW9dc4UTpIAlW9WQ0Xmj3nO5PNtbEVUiNnA==
X-Google-Smtp-Source: AGHT+IFHsQ3NpezhHG0l7weiSCOe76IlSSTIMrAVAoZydlTZk6I9gfG9PDZzZd5eHGXEici9Ku4jIeLrsjRCM97ML0k=
X-Received: by 2002:a50:871b:0:b0:552:7482:ea27 with SMTP id
 i27-20020a50871b000000b005527482ea27mr1025029edb.34.1702574747100; Thu, 14
 Dec 2023 09:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20231214171447.44025-1-philmd@linaro.org>
In-Reply-To: <20231214171447.44025-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 17:25:36 +0000
Message-ID: <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QOM properties are added on the ARM vCPU object when a
> feature is present. Rather than checking the property
> is present, check the feature.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: If there is no objection on this patch, I can split
>      as a per-feature series if necessary.
>
> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>   "hw: Simplify accesses to CPUState::'start-powered-off' property"

I'm not a super-fan of board-level code looking inside
the QOM object with direct use of arm_feature() when
it doesn't have to. What's wrong with asking whether
the property exists before trying to set it?

thanks
-- PMM

