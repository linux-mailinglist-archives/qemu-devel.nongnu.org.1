Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60BE777F94
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:50:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9mx-00029k-Mf; Thu, 10 Aug 2023 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qU9mr-00029J-TV; Thu, 10 Aug 2023 13:49:29 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qU9mp-00063M-Ub; Thu, 10 Aug 2023 13:49:29 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7996fe1c31bso404301241.3; 
 Thu, 10 Aug 2023 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691689766; x=1692294566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yusdXC+6hqlTTOMmZMPPWmhKHD5s8VRm8gA3gaoLCk8=;
 b=NVa3qqcjfRzl/6WwiWzRXGhDMWjvR/O6+hrskh22VZMBOchPf0bW2aPnSstWXxfkcS
 xwa4FjZGmzhjTSbYJ6efTyPjUX7yLXFlIXHgNkg7IC1e6gWoHfalsgX5GVHjPOqNgUBB
 16k1suVz/9dt2s1FgS6/QBOXB0LcB/8Tb88s3kfE7c0RZn5QG29Um8l+afgbCgffO8W9
 +hWZ0LAybpiZbJNnYbFxEiyZKX0EzDi2YkHqhqXPsE+sSGpSLOQ55yKh+7gZea7PpinO
 0y3HVv7hs2MEGo5hX0Z8Gzzo2OCm6ZmLSkmL1jilp+cP8zSCpQq9g6W167q85vTyP4fp
 N9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691689766; x=1692294566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yusdXC+6hqlTTOMmZMPPWmhKHD5s8VRm8gA3gaoLCk8=;
 b=fPPAXL50WO5Mr2ajt7ayn0ZRYPXl5lmSvJrfptKfiL5k4v1UjXAEhDYVujfpfdZFE4
 qgNp1P9vs+iXg16GzX8R0Bt81d62/+TnDXjb0zaamDSzuzMpylEcxVs2BtnkbuJf1DGJ
 PIAVjVHzwLu8EsvXcyi6ym28JY7PK+7GlvWLR9g/yE878A7C/byD5HojuLw67TFlEzqu
 7gbrU0tMbjRvLnPxPtJPk8zon4JjtYaLD5/JmRaiPuC9WYLODPVgcRts6cBsg3M97JFa
 qjr+w+OPErX2fXG+SqunPfLWTJUhZZZGGX59HoU+P19t+Zn3gszfhJZeFnKjnetLaSqg
 aLjQ==
X-Gm-Message-State: AOJu0YzNAE50uvqaTiCuvEfShaJYfLpnWAak9VYITCyxWDuk4JUywj6r
 yAnOyeP39rGBW/Wne+h5uSZ/fOid9cDpHFR75YI=
X-Google-Smtp-Source: AGHT+IGpw3RzrATXYMIcTLWhbQvJil4Wj9vRJ4jXbawmMWgVJUEdNAzNfOlvrPVf6M0uY4p2hRx3F63pI2IESHSfERI=
X-Received: by 2002:a67:fe85:0:b0:444:6b9f:5229 with SMTP id
 b5-20020a67fe85000000b004446b9f5229mr2416898vsr.29.1691689766518; Thu, 10 Aug
 2023 10:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
 <20230727220927.62950-5-dbarboza@ventanamicro.com>
In-Reply-To: <20230727220927.62950-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Aug 2023 13:49:00 -0400
Message-ID: <CAKmqyKMkWbg5iFOOqgiaT_J6+FCUr9gpQS9HV90kZeGwPeioPg@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] target/riscv/cpu.c: del DEFINE_PROP_END_OF_LIST()
 from riscv_cpu_extensions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jul 27, 2023 at 6:20=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This last blank element is used by the 'for' loop to check if a property
> has a valid name.
>
> Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is already
> using. All future arrays will also do the same and we'll able to
> encapsulate more repetitions in macros later on.

Is this the right approach? This seem different to the rest of QEMU

Alistair

>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> ---
>  target/riscv/cpu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f1a292d967..33a2e9328c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1842,8 +1842,6 @@ static Property riscv_cpu_extensions[] =3D {
>      DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
>      DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
>      DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
> -
> -    DEFINE_PROP_END_OF_LIST(),
>  };
>
>  static Property riscv_cpu_options[] =3D {
> @@ -1901,14 +1899,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object=
 *obj, const char *prop_name)
>
>  static void riscv_cpu_add_kvm_properties(Object *obj)
>  {
> -    Property *prop;
>      DeviceState *dev =3D DEVICE(obj);
>
>      kvm_riscv_init_user_properties(obj);
>      riscv_cpu_add_misa_properties(obj);
>
> -    for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> +    for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
> +        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name=
);
>      }
>
>      for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> @@ -1929,7 +1926,6 @@ static void riscv_cpu_add_kvm_properties(Object *ob=
j)
>   */
>  static void riscv_cpu_add_user_properties(Object *obj)
>  {
> -    Property *prop;
>      DeviceState *dev =3D DEVICE(obj);
>
>  #ifndef CONFIG_USER_ONLY
> @@ -1943,8 +1939,8 @@ static void riscv_cpu_add_user_properties(Object *o=
bj)
>
>      riscv_cpu_add_misa_properties(obj);
>
> -    for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
> -        qdev_property_add_static(dev, prop);
> +    for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
> +        qdev_property_add_static(dev, &riscv_cpu_extensions[i]);
>      }
>
>      for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> --
> 2.41.0
>
>

