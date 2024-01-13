Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F6682CCCC
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 14:27:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOe1I-0008GO-97; Sat, 13 Jan 2024 08:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe1F-0008Fn-AB
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:25:49 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOe18-0002Ve-PB
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 08:25:47 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-557c188f313so10929998a12.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705152340; x=1705757140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xwb/pG+4+lZ/N8kjn8ZXif7LxvZAq1yC/392vBJEkw=;
 b=qEy0sQX7aak+eSLCGgg2+SJ8Ylhg/Tn2vwnbRUR2TTw03NY+eBRPGFA1/NvZeWg1PX
 AhVGmPZx5JLsqWNnO7G43ZAkkFn4PvlZXkB2muKPzyDaGMUE6YSKgts00lgnFe/6IVov
 xEcic6vfGKys7hjYkTlTAf0Qp4fz11nraQsUIRbtxtq5B3BsrEx3PpNcYlmFtb03TTR6
 oS+0wo2PItqxLgL+QQ3ZLmhSeDtCpmWfRmhLeVmpy9aywoIqpghAFHImLASgEZkirEIX
 H4WGt063gXZleB4C00zm1CBFOLMmkKvOBPoaQ3KLLK/Vkeqs9g0h5ielS4BBA8W3qeGT
 /JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705152340; x=1705757140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xwb/pG+4+lZ/N8kjn8ZXif7LxvZAq1yC/392vBJEkw=;
 b=dJO9CQbZSaxBjr6zP6QhAwUtP8sB4lJ8+REo8IjGW/CW3X6xt7VanodTJTU+0m7KNg
 k+8BFrvg3DCYXvYC9NBQo6ZKV82fXJCA0d0W/HlDpjTqfn0rTRbv2SVvScX8hVvybaoV
 YoKDJpYnfKwEwt3V02eZ8cOnhuJ/bTOXDVXsUZpiA4l5k2XVP+Dqioh5PPgbn5rMyqXR
 xxJSFhZCb9HovX9cdemfORf9BogmxSXp4VnOg+I85Q4oCsNcpOQvmUmkipJBwB7Sux+Y
 OrA6s9Q8IqZ5qnYikmbDe8Gjo2JaARzJxWKqItrpRzANYfUMRS0dUDJnAzBWSWp98N2k
 PGiA==
X-Gm-Message-State: AOJu0Yz4hqzczw+wzJXZZo6I5PDqgvDN0m19eT0FaEh0p9RN2wWDyuGJ
 +xbKs2nFzFTjojxAQQof6t0F/pjsanYL3cZkYb1CLXFw6yL/NQ==
X-Google-Smtp-Source: AGHT+IHsocBF7/cu2JK0SXST7YGi8MhSkKTcSmXdINw2CLet1TnDdHVlR8823CE151CQ3Y15CFO05uzPC+ZdPcnLuR4=
X-Received: by 2002:a05:6402:3cd:b0:559:144:7dc4 with SMTP id
 t13-20020a05640203cd00b0055901447dc4mr581733edw.21.1705152340575; Sat, 13 Jan
 2024 05:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-2-philmd@linaro.org>
In-Reply-To: <20240110195329.3995-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 13:25:07 +0000
Message-ID: <CAFEAcA9Au5TFkmJvEphUXRNH4EvtoBbQ-10MZUJzTn0TPaE3-g@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] hw/arm/armv7m: Introduce cpudev variable in
 armv7m_realize()
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We are going to cast s->cpu as DeviceState multiple times.
> Add a local 'cpudev' variable to simplify code review, having
> a single DEVICE(s->cpu) conversion.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/armv7m.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

