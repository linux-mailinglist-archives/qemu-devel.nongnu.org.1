Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A53AC0164
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 02:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHtlh-00048l-F2; Wed, 21 May 2025 20:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHtld-00048L-Gx; Wed, 21 May 2025 20:26:38 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHtla-0003B3-M5; Wed, 21 May 2025 20:26:37 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-52b2290e28eso1653460e0c.3; 
 Wed, 21 May 2025 17:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747873593; x=1748478393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrmXOBTslxcZRmTkjNe4Evnmc3J9pDjRcXQqN9L5Tis=;
 b=RLqOaa6tk+HFnGM7jtE5ekGoonlRbOvFLnjoILxckugrmIzPEuU69hpta/kWEJ3l+z
 XAQAAaQlLgiTNXkKOE+drkjUilrAHprZ7QCvhogtiVvqDSNvYLVkzPVsdX/aojzw92nt
 hw+5h42/PXjiGvwE/HpKOSdmfx/90rzkE1PGMivnmFpzBXUrU4VhTlbwgYLdc/0Bj23t
 X9xxdF/QRoJBpNScA31R6oh+ZWg7nQP1Il9VUYrAaRb7KQnqXs/zB81+iybyKOUS42hx
 NlesZsFVzcLgYfmZQUzOuc9KpIJNmP4UYoodIsrCIMnxHzbU9A8sMSgDFY98I99S+RS9
 E9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747873593; x=1748478393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrmXOBTslxcZRmTkjNe4Evnmc3J9pDjRcXQqN9L5Tis=;
 b=CTYRwFwgNoNvjKgfEWRY5Y3XZxTBPaQy9Fn3+p5OQAmGvn1W39XP4jlZhBzHxmozA1
 MNWvYQH9g8pQBzOwizA0JC9ZJycbV7MdXMGIN3UDdOVQXUnHwEuFEIpq+nBHvztXezM2
 ktXcs5gK6Gq2/r26D+2sv0nGxTGUeDEVFJA4jH214Q8NqM0DzwP2aA434ikF92O3lC7k
 uHFfNuDH+7DAKwG1NXreysvkOWGNlfrGlw8azMW/letCSjiDPDXgWVDoEwy3+19DvcbU
 phUTxCIOanhvFWeYMVpiL8+zKAufDqhdcEbsPxDmbZ111LK/KfoE/UpGq52zvuNSWNe7
 nlqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIQSwQUNaBGxiSBoLCr0q2eoUFw0HsO2kQyzHiV4BrY1//ga487DqkkOda9JgaKJUIH441qVhUBu4T@nongnu.org
X-Gm-Message-State: AOJu0Yzd61jvd1gMx6aiPTjORg4yceAiPwZfOpBgGhTwHI+OGIGIl7XB
 a1hlM9FSBuc577QJAiKrdHag0xWOxF4rFf0Olz0Y7ujXuubAZiUrRADmuZoJ4rNjkscXk9TnTWC
 RBhnUABg7LO1CTswRCiuyka1t5Joc/sc=
X-Gm-Gg: ASbGncucsP8zpmrJMkuyzP4HAUZimesSTKK95nydv6WQZMs0+cyZKZuYerhx9ZyiMoH
 BzO4rljtAK2G2rb+5u0JFrUQfGFrXXm6PJ+znAkrbERzPryjjgtqNLYtGWXYjxi7owU8vVMo63q
 pPFDHLQaEtgjIA1RVfxpWyUqvM7ejdCNlDnLEW45gyh92YRLz0x0v5uismMOGBXNM=
X-Google-Smtp-Source: AGHT+IFdbAuPaPWrE8CTpLm2xAOo9/cVAr/p4G8tG8NybZEptfrcJjhg2msZVewAOdxcBk5gZOOp1jtXQ1At4T8XlN4=
X-Received: by 2002:a05:6122:885:b0:526:42c2:8453 with SMTP id
 71dfb90a1353d-52dba9649b2mr20741833e0c.7.1747873592776; Wed, 21 May 2025
 17:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250425094452.17013-1-jay.chang@sifive.com>
 <20250425094452.17013-3-jay.chang@sifive.com>
In-Reply-To: <20250425094452.17013-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 10:26:06 +1000
X-Gm-Features: AX0GCFuLsJzGUPyKXGV4-fklb007oD4msni9v4DJmjLsMd8wMXIWvIEol5BlZvs
Message-ID: <CAKmqyKOu-78RKfS9RrJ=6oGd_YquPjhSiOFJ4FaBwseuF+Y3aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Make PMP region count configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Fri, Apr 25, 2025 at 7:46=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> Previously, the number of PMP regions was hardcoded to 16 in QEMU.
> This patch replaces the fixed value with a new `pmp_regions` field,
> allowing platforms to configure the number of PMP regions.
>
> If no specific value is provided, the default number of PMP regions
> remains 16 to preserve the existing behavior.
>
> A new CPU parameter num-pmp-regions has been introduced to the QEMU
> command line. For example:
>
>         -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, num-pmp-regions=3D8
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>  target/riscv/cpu.c                | 54 +++++++++++++++++++++++++++++--
>  target/riscv/cpu.h                |  2 +-
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/csr.c                |  5 ++-
>  target/riscv/machine.c            |  3 +-
>  target/riscv/pmp.c                | 28 ++++++++++------
>  6 files changed, 79 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ee20bd7ca2..9cab08f9df 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize =3D 64;
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
> +    cpu->cfg.pmp_regions =3D 16;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> @@ -1574,6 +1575,46 @@ static const PropertyInfo prop_pmp =3D {
>      .set =3D prop_pmp_set,
>  };
>
> +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint16_t value;
> +
> +    visit_type_uint16(v, name, &value, errp);
> +
> +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        return;
> +    }
> +
> +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > 16) {

This 16 should be a macro

> +        error_setg(errp, "Number of PMP regions exceeds maximum availabl=
e");
> +        return;
> +    } else if (value > 64) {

Same here

> +        error_setg(errp, "Number of PMP regions exceeds maximum availabl=
e");
> +        return;
> +    }
> +
> +    cpu_option_add_user_setting(name, value);
> +    cpu->cfg.pmp_regions =3D value;
> +}
> +
> +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint16_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
> +
> +    visit_type_uint16(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_num_pmp_regions =3D {
> +    .type =3D "uint16",

uint8?

> +    .description =3D "num-pmp-regions",
> +    .get =3D prop_num_pmp_regions_get,
> +    .set =3D prop_num_pmp_regions_set,
> +};
> +
>  static int priv_spec_from_str(const char *priv_spec_str)
>  {
>      int priv_version =3D -1;
> @@ -2573,6 +2614,7 @@ static const Property riscv_cpu_properties[] =3D {
>
>      {.name =3D "mmu", .info =3D &prop_mmu},
>      {.name =3D "pmp", .info =3D &prop_pmp},
> +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
>
>      {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>      {.name =3D "vext_spec", .info =3D &prop_vext_spec},
> @@ -2895,6 +2937,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
>          .cfg.mmu =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>          .priv_spec =3D PRIV_VERSION_LATEST,
>      ),
>
> @@ -2941,7 +2984,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_MBARE,
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
> -        .cfg.pmp =3D true
> +        .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8
>      ),
>
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR=
_CPU,
> @@ -2952,7 +2996,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.mmu =3D true,
> -        .cfg.pmp =3D true
> +        .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8
>      ),
>
>  #if defined(TARGET_RISCV32) || \
> @@ -2970,6 +3015,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>          .cfg.ext_smepmp =3D true,
>
>          .cfg.ext_zba =3D true,
> @@ -3044,6 +3090,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_xtheadmempair =3D true,
>          .cfg.ext_xtheadsync =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>
>          .cfg.mvendorid =3D THEAD_VENDOR_ID,
>
> @@ -3067,6 +3114,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.rvv_ta_all_1s =3D true,
>          .cfg.misa_w =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>          .cfg.cbom_blocksize =3D 64,
>          .cfg.cbop_blocksize =3D 64,
>          .cfg.cboz_blocksize =3D 64,
> @@ -3123,6 +3171,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_zifencei =3D true,
>          .cfg.ext_zicsr =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>          .cfg.ext_zicbom =3D true,
>          .cfg.cbom_blocksize =3D 64,
>          .cfg.cboz_blocksize =3D 64,
> @@ -3167,6 +3216,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>
>          .cfg.mmu =3D true,
>          .cfg.pmp =3D true,
> +        .cfg.pmp_regions =3D 8,
>
>          .cfg.max_satp_mode =3D VM_1_10_SV39,
>      ),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 679f417336..de4517c4f8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>
>  #define MMU_USER_IDX 3
>
> -#define MAX_RISCV_PMPS (16)
> +#define MAX_RISCV_PMPS (64)
>
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 59f134a419..d80eb1eb7b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
>  TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>  TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>  TYPED_FIELD(uint16_t, cboz_blocksize, 0)
> +TYPED_FIELD(uint16_t, pmp_regions, 0)
>
>  TYPED_FIELD(int8_t, max_satp_mode, -1)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 41cf469615..daaef8c438 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -736,7 +736,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *en=
v, int csrno)
>  static RISCVException pmp(CPURISCVState *env, int csrno)
>  {
>      if (riscv_cpu_cfg(env)->pmp) {
> -        if (csrno <=3D CSR_PMPCFG3) {
> +        uint16_t MAX_PMPCFG =3D (env->priv_ver >=3D PRIV_VERSION_1_12_0)=
 ?
> ++                              CSR_PMPCFG15 : CSR_PMPCFG3;

MAX_PMPCFG isn't a macro it shouldn't be all caps

Alistair

> +
> +        if (csrno <=3D MAX_PMPCFG) {
>              uint32_t reg_index =3D csrno - CSR_PMPCFG0;
>
>              /* TODO: RV128 restriction check */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index df2d5bad8d..e9a179ae55 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          pmp_update_rule_addr(env, i);
>      }
>      pmp_update_rule_nums(env);
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c685f7f2c5..3439295d41 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -121,7 +121,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
>   */
>  static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_inde=
x)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          return env->pmp_state.pmp[pmp_index].cfg_reg;
>      }
>
> @@ -135,7 +137,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env=
, uint32_t pmp_index)
>   */
>  static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_=
t val)
>  {
> -    if (pmp_index < MAX_RISCV_PMPS) {
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
> +
> +    if (pmp_index < pmp_regions) {
>          if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
>              /* no change */
>              return false;
> @@ -235,9 +239,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32=
_t pmp_index)
>  void pmp_update_rule_nums(CPURISCVState *env)
>  {
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      env->pmp_state.num_rules =3D 0;
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          const uint8_t a_field =3D
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>          if (PMP_AMATCH_OFF !=3D a_field) {
> @@ -331,6 +336,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>      int pmp_size =3D 0;
>      hwaddr s =3D 0;
>      hwaddr e =3D 0;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /* Short cut if no rules */
>      if (0 =3D=3D pmp_get_num_rules(env)) {
> @@ -355,7 +361,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>       * 1.10 draft priv spec states there is an implicit order
>       * from low to high
>       */
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          s =3D pmp_is_in_range(env, i, addr);
>          e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
>
> @@ -526,8 +532,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  {
>      trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
>      bool is_next_cfg_tor =3D false;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
>              /* no change */
>              return;
> @@ -537,7 +544,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>           * In TOR mode, need to check the lock bit of the next pmp
>           * (if there is a next).
>           */
> -        if (addr_index + 1 < MAX_RISCV_PMPS) {
> +        if (addr_index + 1 < pmp_regions) {
>              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].cfg_r=
eg;
>              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pm=
p_cfg);
>
> @@ -572,8 +579,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>  {
>      target_ulong val =3D 0;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
> -    if (addr_index < MAX_RISCV_PMPS) {
> +    if (addr_index < pmp_regions) {
>          val =3D env->pmp_state.pmp[addr_index].addr_reg;
>          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>      } else {
> @@ -591,6 +599,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>  {
>      int i;
>      uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>      /* Update PMM field only if the value is valid according to Zjpm v1.=
0 */
>      if (riscv_cpu_cfg(env)->ext_smmpm &&
>          riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
> @@ -602,7 +611,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulo=
ng val)
>
>      /* RLB cannot be enabled if it's already 0 and if any regions are lo=
cked */
>      if (!MSECCFG_RLB_ISSET(env)) {
> -        for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +        for (i =3D 0; i < pmp_regions; i++) {
>              if (pmp_is_locked(env, i)) {
>                  val &=3D ~MSECCFG_RLB;
>                  break;
> @@ -658,6 +667,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
ddr addr)
>      hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
>      hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
>      int i;
> +    uint16_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>
>      /*
>       * If PMP is not supported or there are no PMP rules, the TLB page w=
ill not
> @@ -668,7 +678,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwa=
ddr addr)
>          return TARGET_PAGE_SIZE;
>      }
>
> -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
> +    for (i =3D 0; i < pmp_regions; i++) {
>          if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) =3D=3D PMP_AM=
ATCH_OFF) {
>              continue;
>          }
> --
> 2.48.1
>
>

