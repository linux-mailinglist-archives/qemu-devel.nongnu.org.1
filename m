Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C96AE7BD1D0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 03:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpfFR-0005WH-S5; Sun, 08 Oct 2023 21:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qpfFQ-0005W2-M0; Sun, 08 Oct 2023 21:39:52 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qpfFO-0004Mx-Oa; Sun, 08 Oct 2023 21:39:52 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77575531382so270140085a.3; 
 Sun, 08 Oct 2023 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696815589; x=1697420389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyhIJkKCb7EsyfYjONgyotPSaldftdRr5LCLWDlHU+s=;
 b=mgCHIkE5y2C+ntQf+jIr89xQV0I4Bb7VmO6EqUowJnTt2J15nJdN+dgWIxhRfMWGyP
 XXE6cej2qhYeiNLE/2M+niOgeXDjHKKhqgIkbB0rttnqge00xxjT0Hf/L+WyzSJ5HRPL
 Fg+LDTSUttdk6o/SbjG/hqgEQMhbr5brbyqmVH8Cv6twCtp2+djDPrz7kDlFnt0CQXFD
 Uu2wovMg6lxv52NAE41hBKjZnUKcFndJH9mNTY0xMbfPVM4y76jEuPXgRPy2onri9uuh
 2CzScnjw5e8PeVNkwSXlI+ha0xDOZcqN7iop532w1aQWwvxeqhbZLfJvWAO7f/YMjgnu
 JEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696815589; x=1697420389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyhIJkKCb7EsyfYjONgyotPSaldftdRr5LCLWDlHU+s=;
 b=hN60cijsnn7JuSjL7Ap1y4/0MHz2qLQ09rFEn2pQUqOlo6KGL9W2ni4/3ABZsUoEEd
 J1ozpcS8rBaMnQ7B8ELM8vxG1BjJQ6sl/2u4B7d2iSQIAU9rjtFSG64wvaf+VnIpm8c5
 OSFbj0JYOKganiRaKLytLTRcOY7EDJXTYRzrP125Cs77Q2D5oJm/t+KSR7ryvb4kjeDk
 Ugqk3CY1wO73Nsq0kQqVf5EIE2jKli1DxEH00bF5mUYdhRa6uCSYhfIAucLOL81UESR9
 E4CV9RfkR09kT47jZMCSiDccqVPETUIhV+zK7H7gIf2NlaN7HKKlTsHGkwRJVWWLP5pb
 OsnQ==
X-Gm-Message-State: AOJu0YzjLpJosfIKz5/pjrF587B5NzwKR2AXJRnS9aVYdU+4tUwhZWNx
 sGLbdESskFq67HOLiZ6l17nh0ardS39E9f7YjfU=
X-Google-Smtp-Source: AGHT+IG33s5CF1LPHGRPqZXdC5aNnqL1IekkY+O4qUOPORsv/TiuX1/WlD4yONwRxKfidnjW6p5Fqjs/LcSznt4GMsM=
X-Received: by 2002:a05:620a:458e:b0:774:244c:8b2c with SMTP id
 bp14-20020a05620a458e00b00774244c8b2cmr18591588qkb.14.1696815589035; Sun, 08
 Oct 2023 18:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231007171427.1210117-1-dbarboza@ventanamicro.com>
In-Reply-To: <20231007171427.1210117-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Oct 2023 11:39:22 +1000
Message-ID: <CAKmqyKOZCb_-=KDJX3p63M1Muv0pVpUpnyborJBEXuTA1h8=_w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: deprecate capital 'Z' CPU properties
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x730.google.com
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

On Sun, Oct 8, 2023 at 3:15=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> At this moment there are eleven CPU extension properties that starts
> with capital 'Z': Zifencei, Zicsr, Zihintntl, Zihintpause, Zawrs, Zfa,
> Zfh, Zfhmin, Zve32f, Zve64f and Zve64d. All other extensions are named
> with lower-case letters.
>
> We want all properties to be named with lower-case letters since it's
> consistent with the riscv-isa string that we create in the FDT. Having
> these 11 properties to be exceptions can be confusing.
>
> Deprecate all of them. Create their lower-case counterpart to be used as
> maintained CPU properties. When trying to use any deprecated property a
> warning message will be displayed, recommending users to switch to the
> lower-case variant:
>
> ./build/qemu-system-riscv64 -M virt -cpu rv64,Zifencei=3Dtrue --nographic
> qemu-system-riscv64: warning: CPU property 'Zifencei' is deprecated. Plea=
se use 'zifencei' instead
>
> This will give users some time to change their scripts before we remove
> the capital 'Z' properties entirely.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  docs/about/deprecated.rst  | 23 ++++++++++++++++++++++
>  target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++-----------
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++-
>  4 files changed, 82 insertions(+), 12 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 694b878f36..331f10f930 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -378,6 +378,29 @@ of generic CPUs: rv32 and rv64 as default CPUs and '=
max' as a feature complete
>  CPU for both 32 and 64 bit builds. Users are then discouraged to use the=
 'any'
>  CPU type starting in 8.2.
>
> +RISC-V CPU properties which start with with capital 'Z' (since 8.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +All RISC-V CPU properties which start with capital 'Z' are being depreca=
ted
> +starting in 8.2. The reason is that they were wrongly added with capital=
 'Z'
> +in the past. CPU properties were later added with lower-case names, whic=
h
> +is the format we want to use from now on.
> +
> +Users which try to use these deprecated properties will receive a warnin=
g
> +recommending to switch to their stable counterparts:
> +
> +- "Zifencei" should be replaced with "zifencei"
> +- "Zicsr" should be replaced with "zicsr"
> +- "Zihintntl" should be replaced with "zihintntl"
> +- "Zihintpause" should be replaced with "zihintpause"
> +- "Zawrs" should be replaced with "zawrs"
> +- "Zfa" should be replaced with "zfa"
> +- "Zfh" should be replaced with "zfh"
> +- "Zfhmin" should be replaced with "zfhmin"
> +- "Zve32f" should be replaced with "zve32f"
> +- "Zve64f" should be replaced with "zve64f"
> +- "Zve64d" should be replaced with "zve64d"
> +
>  Block device options
>  ''''''''''''''''''''
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 521bb88538..1cdc3d2609 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1246,17 +1246,17 @@ const char *riscv_get_misa_ext_description(uint32=
_t bit)
>  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> -    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
> -    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
> -    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> -    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> -    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> -    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> -    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> -    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> +    MULTI_EXT_CFG_BOOL("zifencei", ext_ifencei, true),
> +    MULTI_EXT_CFG_BOOL("zicsr", ext_icsr, true),
> +    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> +    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> +    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
> +    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
> +    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
> +    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
> +    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> @@ -1349,6 +1349,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +/* Deprecated entries marked for future removal */
> +const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
> +    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
> +    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> +    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> +    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> +    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> +    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> +    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> +    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> +
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  Property riscv_cpu_options[] =3D {
>      DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3f11e69223..e98f5de32e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -722,6 +722,7 @@ typedef struct RISCVCPUMultiExtConfig {
>  extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
> +extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
>  extern Property riscv_cpu_options[];
>
>  typedef struct isa_ext_data {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 08b806dc07..00676593f7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -732,6 +732,25 @@ static void riscv_cpu_add_misa_properties(Object *cp=
u_obj)
>      }
>  }
>
> +static bool cpu_ext_is_deprecated(const char *ext_name)
> +{
> +    return isupper(ext_name[0]);
> +}
> +
> +/*
> + * String will be allocated in the heap. Caller is responsible
> + * for freeing it.
> + */
> +static char *cpu_ext_to_lower(const char *ext_name)
> +{
> +    char *ret =3D g_malloc0(strlen(ext_name) + 1);
> +
> +    strcpy(ret, ext_name);
> +    ret[0] =3D tolower(ret[0]);
> +
> +    return ret;
> +}
> +
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
>  {
> @@ -744,6 +763,13 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visit=
or *v, const char *name,
>          return;
>      }
>
> +    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
> +        g_autofree char *lower =3D cpu_ext_to_lower(multi_ext_cfg->name)=
;
> +
> +        warn_report("CPU property '%s' is deprecated. Please use '%s' in=
stead",
> +                    multi_ext_cfg->name, lower);
> +    }
> +
>      g_hash_table_insert(multi_ext_user_opts,
>                          GUINT_TO_POINTER(multi_ext_cfg->offset),
>                          (gpointer)value);
> @@ -777,13 +803,14 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
>                                     const RISCVCPUMultiExtConfig *multi_c=
fg)
>  {
>      bool generic_cpu =3D riscv_cpu_is_generic(cpu_obj);
> +    bool deprecated_ext =3D cpu_ext_is_deprecated(multi_cfg->name);
>
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
>                          NULL, (void *)multi_cfg);
>
> -    if (!generic_cpu) {
> +    if (!generic_cpu || deprecated_ext) {
>          return;
>      }
>
> @@ -826,6 +853,8 @@ static void riscv_cpu_add_user_properties(Object *obj=
)
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
>
> +    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
> +
>      for (Property *prop =3D riscv_cpu_options; prop && prop->name; prop+=
+) {
>          qdev_property_add_static(DEVICE(obj), prop);
>      }
> --
> 2.41.0
>
>

