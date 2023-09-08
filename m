Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DA7986FA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaYj-0003qM-FC; Fri, 08 Sep 2023 08:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaYg-0003pK-7v
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:25:58 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaYb-0007hY-St
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:25:57 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-501bd6f7d11so3274188e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694175951; x=1694780751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5qABC+6qAZskwSAsfe9urrYr/WGts/zQ3PIA7K4Nzw=;
 b=SsqJDudIH8yvToCGW2LS8XPB7oBmyai3u/2KeYziihQxYk++bjA7lNybgeKrepN8fY
 xK696ub2Ab/opXdGfbW46wLFWClE0AQ1s0W+eB9D8FGDzwubJ+nxkG3jfrLkD8zsaDVq
 DkKDhERUmMRd31tfMpgOXmfRy9L3KdADb3pbaGwEU5oKSVnEFIJ4+nhb05i2ILaj4fgq
 2wsBolVpLATDcRR7YXboNn8q+DqZ7uRZsl1uyghk9ClUA81+n00f+Kkm/w2qNUahSDzs
 3Z2mc1yWEqlzsOQh5ymh8h9HO9tqcoaxXhZDz7P1jQhvx2ERNO1F9NkQohwZ1mHzGySb
 Q45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694175951; x=1694780751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5qABC+6qAZskwSAsfe9urrYr/WGts/zQ3PIA7K4Nzw=;
 b=h9igRi0LTfgMd+TG+z5AUHe4VV9Oz8OQfB6D1T9hAa1aOeyaWX2pTtptGSecl6BOuL
 li9Vypq9lirnGT5LZrOYyzj0ilXO/jMjpkrYF2mkABF+OKiQ0WCibHu07CCDwVGocA8z
 IJwu4FHtsuqOGsq6d4yp92AzwxQOrjKdhwOEK28CmolsSJtbfdZCDKf+l8sx7lVpVLbP
 WP+DFVBQxczP5yXJ45IziLFPOVH5G6yqQktOHWkHIbNGZMCYCumZ+LQLgF/paeLS3Z1s
 9bTfJSyVRlHw1Ge0Iwf53rhGwSziX5HvntYsCknxhsJd9oZfUlHQHzMzMHL92Frx1Z++
 e4fw==
X-Gm-Message-State: AOJu0YyrjhUdTJ2oYLtvNKDFY5n+T6AHAjZ8hmzf4uIiKwSiB4IxBHpF
 CdbBaSiuDjwFIJ8lmXIK7q2pcRaVCndxqWAFnurZ2g==
X-Google-Smtp-Source: AGHT+IH8eRJzeV6Mo5fpToJQmVbnQ/joTiV3kBH/AfT6mj+dDF5xIPcrXX/QY+JBYBcDsQ8XeG6OzfDgpnQJJujcQv4=
X-Received: by 2002:a19:645c:0:b0:500:a00e:1415 with SMTP id
 b28-20020a19645c000000b00500a00e1415mr1299838lfj.35.1694175950514; Fri, 08
 Sep 2023 05:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-3-philmd@linaro.org>
In-Reply-To: <20230904161235.84651-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:25:39 +0100
Message-ID: <CAFEAcA_E7M2-jtaaDsCZbb7MC+N62pNkLCbXqbfMkh3nJrkU2g@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] target/arm/tcg: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 4 Sept 2023 at 17:12, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   target/arm/tcg/translate-m-nocp.c: In function =E2=80=98gen_M_fp_sysreg=
_read=E2=80=99:
>   target/arm/tcg/translate-m-nocp.c:509:18: warning: declaration of =E2=
=80=98tmp=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>     509 |         TCGv_i32 tmp =3D load_cpu_field(v7m.fpdscr[M_REG_NS]);
>         |                  ^~~
>   target/arm/tcg/translate-m-nocp.c:433:14: note: shadowed declaration is=
 here
>     433 |     TCGv_i32 tmp;
>         |              ^~~
>        ---
>
>   target/arm/tcg/mve_helper.c: In function =E2=80=98helper_mve_vqshlsb=E2=
=80=99:
>   target/arm/tcg/mve_helper.c:1259:19: warning: declaration of =E2=80=98r=
=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>    1259 |         typeof(N) r =3D FN(N, (int8_t)(M), sizeof(N) * 8, ROUND=
, &su32);  \
>         |                   ^
>   target/arm/tcg/mve_helper.c:1267:5: note: in expansion of macro =E2=80=
=98WRAP_QRSHL_HELPER=E2=80=99
>    1267 |     WRAP_QRSHL_HELPER(do_sqrshl_bhs, N, M, false, satp)
>         |     ^~~~~~~~~~~~~~~~~
>   target/arm/tcg/mve_helper.c:927:22: note: in expansion of macro =E2=80=
=98DO_SQSHL_OP=E2=80=99
>     927 |             TYPE r =3D FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat)=
;          \
>         |                      ^~
>   target/arm/tcg/mve_helper.c:945:5: note: in expansion of macro =E2=80=
=98DO_2OP_SAT=E2=80=99
>     945 |     DO_2OP_SAT(OP##b, 1, int8_t, FN)            \
>         |     ^~~~~~~~~~
>   target/arm/tcg/mve_helper.c:1277:1: note: in expansion of macro =E2=80=
=98DO_2OP_SAT_S=E2=80=99
>    1277 | DO_2OP_SAT_S(vqshls, DO_SQSHL_OP)
>         | ^~~~~~~~~~~~
>        ---
>
>   target/arm/tcg/mve_helper.c: In function =E2=80=98do_sqrshl48_d=E2=80=
=99:
>   target/arm/tcg/mve_helper.c:2463:17: warning: declaration of =E2=80=98e=
xtval=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>    2463 |         int64_t extval =3D sextract64(src << shift, 0, 48);
>         |                 ^~~~~~
>   target/arm/tcg/mve_helper.c:2443:18: note: shadowed declaration is here
>    2443 |     int64_t val, extval;
>         |                  ^~~~~~
>        ---
>
>   target/arm/tcg/mve_helper.c: In function =E2=80=98do_uqrshl48_d=E2=80=
=99:
>   target/arm/tcg/mve_helper.c:2495:18: warning: declaration of =E2=80=98e=
xtval=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>    2495 |         uint64_t extval =3D extract64(src << shift, 0, 48);
>         |                  ^~~~~~
>   target/arm/tcg/mve_helper.c:2479:19: note: shadowed declaration is here
>    2479 |     uint64_t val, extval;
>         |                   ^~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

