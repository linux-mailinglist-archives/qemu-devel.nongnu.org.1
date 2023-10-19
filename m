Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBD7CFFBE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 18:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtW21-0007Le-61; Thu, 19 Oct 2023 12:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtW1y-0007L9-Js
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:37:54 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtW1w-0001lI-V4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:37:54 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso4502033eaf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697733471; x=1698338271; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BK/7ZKNYyGuZVOHuVRvwN/uhLoGLu0FIBBKzWuuVk5s=;
 b=Y5iC0Cor8FjTT5MNgAuFheN0zI9UUgCdixKMp3Dqsdj9V7meNeWd6NL2/Y5r2bH4oN
 TsR17IEqytG5p5LLIP5sfC19VHqvedkne9tm/g7py1Pwzey7yCckdRRTdrB1N9NiaFh+
 3PTazf/HRxzHByXlWiosa/bcF47uYZFTUncx7fCCE9zcac8GfD/nbN5exPlRAAr0aAwp
 XUlUBH/epoDODg5APHCzXVE+5jnIEy/Us3c0FN/wYk8caydcxPR/KF1t9Q/tKXP1n+1A
 3ENo+Rhyiaez7Dq/7/aIbCX1GkZ+UtDxaxFFIK1xFiSIlBjUdgQbZn5nvA4s/YF55MBp
 RkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697733471; x=1698338271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BK/7ZKNYyGuZVOHuVRvwN/uhLoGLu0FIBBKzWuuVk5s=;
 b=UznXRnOuLccusl1xjIY4jvIgQbxjr3URPtLt8VrwZsbZLuTHnnU0KWKltJ74jwAWoQ
 tIy1RUQ/XJq4+uzYMrqSxFMqJ9YSH7breWqs684OkeGbQjYvzFYtmi6Sxx24wh2dqjhC
 Lsp8JBUEDj1/SF/Qz4HDN0s7pwPO5hrQobx1QPz+4HAjqADSFJmTFkOfm2u8RpkKDwLx
 MY/3EZk2ehYz7R58wl91gDWSrR65upgipssylgruHaFXcWO2bZ9DzVk+IYuZle15i+9k
 qQ2eWhqL/j6cipuKWToU5oJyNqNevgO/p+vjhNnAny8JuYWQXQeRkGm5CNXhkGpADclo
 wQwA==
X-Gm-Message-State: AOJu0YzufgLAw8itDayG214JR/bNKJu20MJxW4/vuNGvEzkB9N40+BCd
 RNtKQni0vGllb5eBm/opP70f/wk7W4qsR7ZjkWWQIPZ20Fno7w==
X-Google-Smtp-Source: AGHT+IH6HOidpVlIBV2bOMjrWMqbfurSrFLuzA32wffg09Y0McftzVMf7cZqfqx+nIVBY3LS89QVohnhmB9PevbESwI=
X-Received: by 2002:a05:6820:828:b0:581:f6d8:5ca2 with SMTP id
 bg40-20020a056820082800b00581f6d85ca2mr3463354oob.6.1697733471428; Thu, 19
 Oct 2023 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
 <20231018222557.1562065-16-richard.henderson@linaro.org>
In-Reply-To: <20231018222557.1562065-16-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 09:37:39 -0700
Message-ID: <CAJSP0QW1wL4T5mAYREyfTtF9vRmoEZ7VvATMkywiHvJQPkap8g@mail.gmail.com>
Subject: Re: [PULL 15/29] tcg: Provide guest_base fallback for system mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 18 Oct 2023 at 15:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a define to allow !tcg_use_softmmu code paths to
> compile in system mode, but require elimination.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d3a4a17ef2..35158a0846 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -178,6 +178,10 @@ static bool tcg_target_const_match(int64_t val, TCGT=
ype type, int ct, int vece);
>  static int tcg_out_ldst_finalize(TCGContext *s);
>  #endif
>
> +#ifndef CONFIG_USER_ONLY
> +#define guest_base  ({ qemu_build_not_reached(); (uintptr_t)0; })
> +#endif

Please take a look at this CI failure:

cc -m64 -mcx16 -Itcg/libtcg_system.fa.p -Itcg -I../tcg -I. -Iqapi
-Itrace -Iui -Iui/shader -I/usr/local/include/glib-2.0
-I/usr/local/lib/glib-2.0/include -I/usr/local/include
-fcolor-diagnostics -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g
-fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes
-Wstrict-prototypes -Wredundant-decls -Wold-style-definition
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
-Wexpansion-to-defined -Wmissing-format-attribute
-Wno-initializer-overrides -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-string-plus-int
-Wno-typedef-redefinition -Wno-tautological-type-limit-compare
-Wno-psabi -Wno-gnu-variable-sized-type-not-at-end -Wthread-safety
-iquote . -iquote /tmp/cirrus-ci-build -iquote
/tmp/cirrus-ci-build/include -iquote
/tmp/cirrus-ci-build/host/include/x86_64 -iquote
/tmp/cirrus-ci-build/host/include/generic -iquote
/tmp/cirrus-ci-build/tcg/i386 -pthread -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -DCONFIG_SOFTMMU -MD -MQ
tcg/libtcg_system.fa.p/tcg.c.o -MF tcg/libtcg_system.fa.p/tcg.c.o.d -o
tcg/libtcg_system.fa.p/tcg.c.o -c ../tcg/tcg.c
In file included from ../tcg/tcg.c:744:
/tmp/cirrus-ci-build/tcg/i386/tcg-target.c.inc:1953:35: error: cannot
take the address of an rvalue of type 'uintptr_t' (aka 'unsigned
long')
if (sysarch(AMD64_SET_GSBASE, &guest_base) =3D=3D 0) {
^~~~~~~~~~~
1 error generated.

https://gitlab.com/qemu-project/qemu/-/jobs/5329820109

> +
>  typedef struct TCGLdstHelperParam {
>      TCGReg (*ra_gen)(TCGContext *s, const TCGLabelQemuLdst *l, int arg_r=
eg);
>      unsigned ntmp;
> --
> 2.34.1
>
>

