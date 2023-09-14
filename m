Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654A7A079C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnYu-00035r-3r; Thu, 14 Sep 2023 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnYr-000355-M1
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:43:17 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnYq-00016i-2x
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:43:17 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so1866219e87.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694702593; x=1695307393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxaY4CcZ9l95kr6sXtBF4WnDKq063r4MZG5I7MgmObA=;
 b=qZe8lT9pkYH9sa+/hBR91OU+fvckIwR0BG7/81ZV28BV14THPy0R6tlZDkBaZvHpkw
 kzFYikIoa/a+ga6yFxFieoAvrlMAZA7pVx5sVyfYNY8xblWW1LhB7ZUDmtaJH2QQ2Z/W
 RGKV8WVZjsYvW7D5PtypB2YnvjAQZG9ZR5bG/RfIx64TMmE40DDp1zq9ubtiwN+N7IqW
 lK0bdm2iLHafYx2LHjyYGw7Bz9joWGyyOEDtDNyRADK2C5PBylRhMsBqfiXvH37ZabjD
 OE9W/IJpbB2PK8asWvTDPpN9oSUyVwzbaYVLnez3pqUUvQnXT5lMooLYdQ+ok/Rb/Re0
 BIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694702593; x=1695307393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxaY4CcZ9l95kr6sXtBF4WnDKq063r4MZG5I7MgmObA=;
 b=LDqfm+zKYZp319+vzuFl/e2SI39+cVz5UEJOnEzT0gozbPz95TYtXOcD3I4LAd7MSZ
 qu0AkbvfGjVGP8vW7KHRX1yigfmvvj0jwbeLHyXufkVMADMShpvLMP73/+XOG/Uu9vvO
 Da4UV1yk/iRUPS1FYAx59n1uyCz1B8M6IUSEBRgrBpKq69yF3rey1w0/lWBmMjCIXTkH
 GEVy83MMRy6bqCwJbH2TQP3/RfSr+fWNVpir9WX1vZ4BFcE/N5mb+s8UjK1vgyAdlR7w
 x8B/Mnc1+Nf0CojZqcZxD348VrMVufJL/M8XssmYPEiQstBcQ6ynf1qCvQOAjJvmnnOC
 kO2g==
X-Gm-Message-State: AOJu0YzawyEzXrkAo3rLnw4zm3Ud7dSPaU838zvzUwqA2bMub2lF/cjz
 EF9BGlnugPKZLOzmaCBI8XnUl3FOL6pVxWle7fWj3A==
X-Google-Smtp-Source: AGHT+IGawwQqv8Vf07k34lNJthmWITTz6/F6+GqKm5mmEv62N31ZTgNY6Lfy4W3yn1Aw2eX4ZN+nJRNZOVWHqvh5lwA=
X-Received: by 2002:a05:6512:e81:b0:4fb:889c:c53d with SMTP id
 bi1-20020a0565120e8100b004fb889cc53dmr6427041lfb.10.1694702592918; Thu, 14
 Sep 2023 07:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230913055639.174032-1-clg@kaod.org>
In-Reply-To: <20230913055639.174032-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 15:42:53 +0100
Message-ID: <CAFEAcA-u-nhK9YQU8wr5+YnXie5-uhXCPjTDwmkpPHGBSA77uA@mail.gmail.com>
Subject: Re: [PATCH] ppc/xive: Fix uint32_t overflow
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Wed, 13 Sept 2023 at 06:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> As reported by Coverity, "idx << xive->pc_shift" is evaluated using
> 32-bit arithmetic, and then used in a context expecting a "uint64_t".
> Add a uint64_t cast.
>
> Fixes: Coverity CID 1519049
> Fixes: b68147b7a5bf ("ppc/xive: Add support for the PC MMIOs")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 9b10e905195a..a36b3bf08c92 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -210,7 +210,7 @@ static uint64_t pnv_xive_vst_addr_remote(PnvXive *xiv=
e, uint32_t type,
>          return 0;
>      }
>
> -    remote_addr |=3D idx << xive->pc_shift;
> +    remote_addr |=3D ((uint64_t) idx) << xive->pc_shift;

Nit: our coding style doesn't want a space after the '(uint64_t)'.

thanks
-- PMM

