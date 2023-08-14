Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3477B659
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 12:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVUbh-00072u-NC; Mon, 14 Aug 2023 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUbf-00072K-2F
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:15:27 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUbc-0000M0-6p
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:15:26 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9bf52cd08so60492781fa.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692008120; x=1692612920;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVGogzY/o/9UdnkKhBMGvut2D0IzlbB7Wzxry2/CNXE=;
 b=x7asZwrRR7cZWGIbY64ZPSed8a6g1Ayut8YvsPsywgn7c1MdqddnSynjy180QKL3dj
 kVs7icwB+UvYK2rSnkB/3ulViFnW9QTi7v81i0MBB6XAetxbIDS1KiSwTHWrYKJtGvfD
 JtJuMIg18cZN58yMyfHnmp4f5PaH40YANcY9o33iv7CAceptQgLED+z/3452NEgTA6EV
 Jp1MxgHm9fChmrhUKVyCDuuurmU5+oV98VDac5mFOxfzQ41KYvot3+zFmV00VLvBVe8I
 qbwq7gtaS7NyDM2qZ+F8jRz97mBu/0MwnGyM+2et/4Ez+hL/ZtwRFcM3A4J43s3vPj5M
 vWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692008120; x=1692612920;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bVGogzY/o/9UdnkKhBMGvut2D0IzlbB7Wzxry2/CNXE=;
 b=fCEtbesg5av2lWD0sNZvJMezRTyE6ptlARFwuDY9bL/4afSIYtsJVR4odC3ukCXEVJ
 +9cwozFll/UXzYQ9kiRh6NyA8g2fJWFUyr+SpsqZhAiz9+w5tg0LKlWYE8tHd8oXRg4Y
 cKR05csqiVC+gmgUStFRKaNHU8oXPGAeobDU7MEVOgNtcQ2qR1NoUu8eE3/I/dlyJKGI
 mm52zvcOAHmbIThiGTJHqRQv9PTjZh/2AScwDIIPp3St8vGaKsVsj+lFmevP42B9PQBh
 pY4z1vAQ7N8S9t6+uueYgTgC4mAeZKFtKbYGyWK8jbHNzqjrXw2NZXwwHZEQqz5zTfMN
 RLTQ==
X-Gm-Message-State: AOJu0YyZFBN+/qS891opHhyWzv/XX3qZQT15WkKhdHkGu/Im6m3mIxVp
 UHyErLIzVEYnITQMqs7YwBEDQg==
X-Google-Smtp-Source: AGHT+IEXADlArYXe1GEWcKPcxsRg+Xz5kPlq20tNryLH75oonT11Z5ibC7XihCLls3I+UQQpWKieuQ==
X-Received: by 2002:a2e:9184:0:b0:2b9:4c17:7939 with SMTP id
 f4-20020a2e9184000000b002b94c177939mr7050480ljg.12.1692008119798; 
 Mon, 14 Aug 2023 03:15:19 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a1c7310000000b003fbe791a0e8sm13879004wmb.0.2023.08.14.03.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 03:15:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC4831FFBB;
 Mon, 14 Aug 2023 11:15:18 +0100 (BST)
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
 <20230808115713.2613-3-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>, linuxarm@huawei.com, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, zhao1.liu@linux.intel.com, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: Re: [RFC PATCH 2/5] HACK: target/arm/tcg: Add some more caches to
 cpu=max
Date: Mon, 14 Aug 2023 11:13:58 +0100
In-reply-to: <20230808115713.2613-3-Jonathan.Cameron@huawei.com>
Message-ID: <87y1ierkuh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Used to drive the MPAM cache intialization and to exercise more
> of the PPTT cache entry generation code. Perhaps a default
> L3 cache is acceptable for max?
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  target/arm/tcg/cpu64.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 8019f00bc3..2af67739f6 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -711,6 +711,17 @@ void aarch64_max_tcg_initfn(Object *obj)
>      uint64_t t;
>      uint32_t u;
>=20=20
> +    /*
> +     * Expanded cache set
> +     */
> +    cpu->clidr =3D 0x8204923; /* 4 4 4 4 3 in 3 bit fields */
> +    cpu->ccsidr[0] =3D 0x000000ff0000001aull; /* 64KB L1 dcache */
> +    cpu->ccsidr[1] =3D 0x000000ff0000001aull; /* 64KB L1 icache */
> +    cpu->ccsidr[2] =3D 0x000007ff0000003aull; /* 1MB L2 unified cache */
> +    cpu->ccsidr[4] =3D 0x000007ff0000007cull; /* 2MB L3 cache 128B line =
*/
> +    cpu->ccsidr[6] =3D 0x00007fff0000007cull; /* 16MB L4 cache 128B line=
 */
> +    cpu->ccsidr[8] =3D 0x0007ffff0000007cull; /* 2048MB L5 cache 128B li=
ne */
> +

I think Peter in another thread wondered if we should have a generic
function for expanding the cache idr registers based on a abstract lane
definition.=20

>      /*
>       * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a =
real
>       * one and try to apply errata workarounds or use impdef features we
> @@ -828,6 +839,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t =3D FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level=
 2 */
>      t =3D FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
>      t =3D FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
> +    t =3D FIELD_DP64(t, ID_AA64MMFR2, CCIDX, 1);      /* FEAT_TTCNP */
>      cpu->isar.id_aa64mmfr2 =3D t;
>=20=20
>      t =3D cpu->isar.id_aa64zfr0;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

