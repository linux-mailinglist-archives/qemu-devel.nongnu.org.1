Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F8745DCC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:52:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJwj-0007Fg-VH; Mon, 03 Jul 2023 09:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJwU-00071e-HX
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:50:17 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJwN-0006zH-6a
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:50:11 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fa16c6a85cso6924448e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392204; x=1690984204;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScrKWezOjG7+TxPbVOgFLvR/j+ZlXSKsx7mPkXBy68I=;
 b=FHBgXQq4FmAFu3+8P2zoNkorlDTgXgHRFaeC/ruMceqM+MwzmX4p0FBCIs2DtlnjLn
 fCNaJhLaAWwHP1SKQyV6SfOcR204sGevZDZmgZiCXf3/R7EqjyBCIAN/iI0u/qo4OBht
 vesNY4/FTP5i29k9OPYlnQfy1DlJkHPtBMmfM+shXXFQ7f8RVxgoZd4tmg3j+9Ive2S9
 apL+0FCqVOOiKHpzvr+4PR7SE2oEF50YGffOePmy3qeReImYa4bywouzhxogycD9JYNb
 LiSPhHXuDTEoXEZuYMoajZYiEJnNO16w/KSH7rqgo2bzC5AYlgYSvff/gZBaUZDnTS+a
 +UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392204; x=1690984204;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ScrKWezOjG7+TxPbVOgFLvR/j+ZlXSKsx7mPkXBy68I=;
 b=CtSmEP97fKaZhZ783y/JPRFl8nYiaOfOl+FpU9qq22MNAU5RDEaWp4gvRDtO+Pi0CF
 7Wb1Mixad48H/7/sAG1kL9GprptFYW+M0QARcRuPmcS9BPH7roXIQJoQqI/N7YqOB+PG
 ZChCeVS1isrEw3bCfkM+0OCt8pmDUg6+X5RzsEqz19hmPHOaLVfmfXnhD0nzZjkhnJs8
 hpyjK4i93scA+r7ATNeN1h6f91JWa6fShM/GSYuQOSumjDMw3mJAEh/Ome6QLFmSUSxW
 RzmrpQjlZU6MCLm+H9U/a8N4MiE3AJwL1lhOPQFPzYfVX9KtZKbVdq/r6o+ZYf7UxfRo
 pJtw==
X-Gm-Message-State: ABy/qLY4JsjhOihGXpuPhNArHR9sH0r6da4WFwNGCvomPNNkpGu7xSsm
 ZEJtaFdGPc+CgRvkcx8+mijmgA==
X-Google-Smtp-Source: APBJJlE+vkhR6HO91DRWQy0FD2kOyE1WRJk1wDVMHvvU2CI37vy/zxXO9hZPDVoplvoez/As2vF14w==
X-Received: by 2002:a05:6512:3710:b0:4f7:6966:36fb with SMTP id
 z16-20020a056512371000b004f7696636fbmr6095284lfr.12.1688392204281; 
 Mon, 03 Jul 2023 06:50:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm15798249wml.0.2023.07.03.06.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:50:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86E061FFBC;
 Mon,  3 Jul 2023 14:50:03 +0100 (BST)
References: <20230703124746.2456684-1-clg@kaod.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] aspeed: Introduce helper for 32-bit hosts limitation
Date: Mon, 03 Jul 2023 14:47:17 +0100
In-reply-to: <20230703124746.2456684-1-clg@kaod.org>
Message-ID: <878rbxhzp0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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


C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the
> default ram size of machines (AST2600 SoC) that can have 2 GB.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6880998484cd..9fca644d920e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -47,6 +47,13 @@ struct AspeedMachineState {
>      char *spi_model;
>  };
>=20=20
> +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> +#if HOST_LONG_BITS =3D=3D 32
> +#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
> +#else
> +#define ASPEED_RAM_SIZE(sz) (sz)
> +#endif
> +

On the one hand this seems a bit hacky to change the guest definition
based on the host architecture - to revive an ongoing argument about
64-on-32 configurations this seems an even more obvious subset of the
problem because regardless of the hoop jumping we do in code generation
we are limited in how much ram we can allocate.

On the other hand at least this moves the hackiness to one place:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

