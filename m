Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5EA725679
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nze-0001jQ-6y; Wed, 07 Jun 2023 03:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6nza-0001iW-Pn; Wed, 07 Jun 2023 03:54:06 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6nzY-0004ag-8e; Wed, 07 Jun 2023 03:54:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-977c72b116fso646017566b.3; 
 Wed, 07 Jun 2023 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686124442; x=1688716442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfuzmuAuP3RR4ZsC7WG9jVcLx4gB5TI2PD98uD8BcDw=;
 b=FIDvUgi1mFm8aS7FEPicb6QopwKMD++7sWM4pY0s1g61xYVNkdCly29J6dTBJwpedp
 nxhTqkAXZBV7o5ncjXRMIfoo3xk1vnUcl1SXRCXUuiGCjy+hY7oX1PCgKfdbTfSgb7vi
 6aAjAzmdYI1Ms1WEYQSYCRl1UDvcliO0HP0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686124442; x=1688716442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfuzmuAuP3RR4ZsC7WG9jVcLx4gB5TI2PD98uD8BcDw=;
 b=D4u+8+GEvPo3GpOui1GY3+K4ncpRgdxGV1jbdV/iwSbyfYY/xrGuGH2AnqyIZhj/Tx
 kQBYLUqCDpEz30PXzrSnop580OnGgD0qdTrYbCw0yPPFAVus0FG0HC3u8H3u9tz2YVQg
 9zVzc5ME1EE0htO/G/Nb0VFmBNEFK9M3HFwR71wuY1ol1Cylf60JrO1nH1xQCQxa0LLe
 5+T3VytUcQtyyPjbUaJ6ViR+kB0b19laa+znE90D7fKNMkyLwo0pEWF1xiJ71cKEGi8/
 AZdHcSWZOOoBW+gYXJg0+c4dq4Iv+n28QW89yIrzZL8GxLRMd+GT+Pm6GmYG7/8CLZX9
 r57A==
X-Gm-Message-State: AC+VfDwjV+QhlzLojVrpXber8Tff0zFsQcOecEB8xEkp+leBJPOlvBwQ
 kcJcLNC55jsA+qmUkLEUsvItHHqo48loEJdTzdY=
X-Google-Smtp-Source: ACHHUZ6nUNVqLVceMfZ/lYyekJkMD6qN0MS5V9qOi02P3LJ5Q9qgTtx6NqyybKhGTl5PWdC0+tFYb5fy3j/wfIfvQkU=
X-Received: by 2002:a17:907:7f93:b0:96f:bd84:b89c with SMTP id
 qk19-20020a1709077f9300b0096fbd84b89cmr5692744ejc.70.1686124441590; Wed, 07
 Jun 2023 00:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-2-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 07:53:49 +0000
Message-ID: <CACPK8Xe1GcR8d0=_aYQbKtVxGMnA_jeJc9fd7BBD6g+kWwxyKw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] aspeed/hace: Initialize g_autofree pointer
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, qemu-stable@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 7 Jun 2023 at 04:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> As mentioned in docs/devel/style.rst "Automatic memory deallocation":
>
> * Variables declared with g_auto* MUST always be initialized,
>   otherwise the cleanup function will use uninitialized stack memory
>
> This avoids QEMU to coredump when running the "hash test" command
> under Zephyr.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Was never a fan of using this magic :)

>
> Cc: Steven Lee <steven_lee@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-stable@nongnu.org
> Fixes: c5475b3f9a ("hw: Model ASPEED's Hash and Crypto Engine")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Message-Id: <20230421131547.2177449-1-clg@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/misc/aspeed_hace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index 12a761f1f55d..b07506ec04ef 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -189,7 +189,7 @@ static void do_hash_operation(AspeedHACEState *s, int=
 algo, bool sg_mode,
>                                bool acc_mode)
>  {
>      struct iovec iov[ASPEED_HACE_MAX_SG];
> -    g_autofree uint8_t *digest_buf;
> +    g_autofree uint8_t *digest_buf =3D NULL;
>      size_t digest_len =3D 0;
>      int niov =3D 0;
>      int i;
> --
> 2.40.1
>

