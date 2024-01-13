Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C982CCCF
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 14:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOe3m-00029N-IX; Sat, 13 Jan 2024 08:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe3V-0001zd-SU
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:28:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe3U-0003Wg-7t
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:28:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e6bf323b0so5251135e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705152486; x=1705757286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4K3Wxfo4ZyLhveW7ANrV2lDD2G99tSb4tG0hfk3ZaM=;
 b=QXKnLNyElnps4iO9dPjbss9A/cGIeI9xzV4RGB0RvJoqOjVwMBNk2ky7dalWhijZJS
 EHxREotO+R8B2PVCcN4XWcYQMU6JoFygCLEBhB+LJyaKSki71uUC6NEzjC4C+g8+zyqz
 fsrho0hOVCvvpkvr0R+siyM6kmYt+gBxUcikzUErRJz1wiGzb7jk6Q7LQgvC6JW74KyE
 vLFm2UoknLR+nLy1IVKDCUj48PUrF60jovzJSs9VSvltFezSKpAfwu16OAxaTsyy+P2y
 CmtQm4DdEdGNhiy9s72NrQ9cjol2wOLbzR43d024g+TN8ExkSzoA8mJhnfGnoAnz0GS6
 DbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705152486; x=1705757286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4K3Wxfo4ZyLhveW7ANrV2lDD2G99tSb4tG0hfk3ZaM=;
 b=rFv3BOzXq0Dp+RqscfMQGlBMCyR3BwJqrVgb1Zs0GbzN99O1FYkbjzDWRChiLmtzoX
 HBH0NcwBRr5mQYuKf3NpS4CNTgxEMeLv/MKxx1sMtdISueZ45j5vOtuBekhkROxD9Et9
 p/QMPKdPgRomSrC2GUEnn+odaqkTYxhElfPRrBdV93AS4rgrswbQ0z1Nca7CTcecq7qR
 pZhjJ+Pma27KsYyVtFrxBOFg2oJm4VklzOXflyiWFM5dWtX8ng2/F8mftixO3rDIQgYT
 gh6J0gCdLZcvNZBxW9r6xSuIZOBFhEqTI/Ot5pnbAKaPT+UJ5Am5Ibe2qereUaz0vNvo
 sDwA==
X-Gm-Message-State: AOJu0Yzgxjpg8tuqtVQ9VXB9+Z0LdVu/MP7LiCHVFbviSHQ/ku2NT1Xt
 hOAYXtGhgRzRgDOXGA33A46vvGRSqIGy/FyU8BHC9nbsdLwxXw==
X-Google-Smtp-Source: AGHT+IGXxTvL35WmMTNzUEMuG99M1syyv7xFN0LuUEEggaWsIfLCCeKzw1TLSg9w362CnqRs5DDHBLTM2hBlZXeTTh8=
X-Received: by 2002:a05:600c:1d85:b0:40e:4c1a:2663 with SMTP id
 p5-20020a05600c1d8500b0040e4c1a2663mr1406433wms.3.1705152486520; Sat, 13 Jan
 2024 05:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-5-philmd@linaro.org>
In-Reply-To: <20240110195329.3995-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 13:27:33 +0000
Message-ID: <CAFEAcA_OarQg2Aw8bTQD3Q4X80uTzzfgvG9pXcRvz48_aa=vFw@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] hw/arm/armv7m: Always set 'init-nsvtor' property
 for Cortex-M CPUs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

On Wed, 10 Jan 2024 at 19:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> All CPUs implementing ARM_FEATURE_M have the 'init-nsvtor' property.
> Since setting the property can not fail, replace
>
>    object_property_set_uint(..., "init-nsvtor", ..., &error_abort);
>
> by:
>    qdev_prop_set_uint32(..., "init-nsvtor", ...).
>
> which is a one-to-one replacement.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

