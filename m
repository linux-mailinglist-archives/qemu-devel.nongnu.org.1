Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44037E1D41
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:29:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzvv9-0001SB-KM; Mon, 06 Nov 2023 04:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qzvv6-0001S3-TG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:29:20 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qzvv4-0003Mz-Cr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:29:20 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4ac0719457bso1548220e0c.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699262957; x=1699867757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCS6XzZFUwKguRBoFgPCvH8UzoMgVTU54cNYXKhxp9I=;
 b=IZXIabIO5+kZtbITzYjsS4wVPouiTexMpbhOxirWCoQq1Q+G0tnETO50rMpNudm48E
 mAaEuqvKZfY3hcE9TkDAophnk+muwkX083CDwYR+bkGMu1JaiJ9qDUIm41x0RyXr4Ywz
 Q1ff7iryHyDb9nLjeV5U/F2MlaOLIiXRS10eWq0YBw1hz6vNJy5WiwyN2cBcFGiwxNjK
 pD9hccsZVJohvS4j9ZxX0qUtqbHl07hqK6CF13Y0ieWLpgbjSzHyFreiwRqcx7vRvXjN
 R1VNMbANtxN3iMNYMmGQlHnDpW12CaG3YWfHkx6mg+UsELdUXHvrZ6nou8CYXB7ALDY6
 pc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699262957; x=1699867757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCS6XzZFUwKguRBoFgPCvH8UzoMgVTU54cNYXKhxp9I=;
 b=nzWIbPDey4Eb6/ZR/2TBwmuaqVPpIbJmydTeX1gnZlQnczV5hpencY+X3kZGIb6J6+
 j8dzSMuUyLsi40USBOvI9+aIAvO41/G24N40X1X4/43dfXBkApdO5oxKxpDPEdA7B3Ws
 E4v0YNv9jBHConI8KEGDNFgL/jx1XXekRz4J5pNgq7ufS/qdj8dokHGokPU/4drqlYwH
 SaLWHqzblo7EHjz4osqJK1G769V7Ql1hh+eXmErCzuJRWw95fOLwQhPxeycK2W9Hpc12
 WK8jMmprEAZob/Y9gwnBkJienTLn9aKLbZ25XIguQo4l5sj6IpYuj2RAra6iI0vPsnMv
 JSXg==
X-Gm-Message-State: AOJu0YwprwtM+JEbmM8rJ6qXhiEtCtJAbT4dLXPu7VHTsKpMZ72yjInB
 nue+NAElNBHT//Q0sH2HwF77c9DoAr/dqFWnuU0=
X-Google-Smtp-Source: AGHT+IFDF3y12vi3v+CRiFUES3QGRHSmnPT99aN4bZKPDiK+kDI9rhtII7I/4XpUH9RgC4u2T61n0pcawNcCP5uAnpg=
X-Received: by 2002:ac5:ce03:0:b0:496:80b6:2fd1 with SMTP id
 j3-20020ac5ce03000000b0049680b62fd1mr3983188vki.5.1699262957174; Mon, 06 Nov
 2023 01:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-16-richard.henderson@linaro.org>
In-Reply-To: <20231106065827.543129-16-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Nov 2023 19:28:50 +1000
Message-ID: <CAKmqyKPLUdQqsFxTfiWOFz1xmmPD4YEOswA8JVSsfyhsncTxHQ@mail.gmail.com>
Subject: Re: [PATCH 15/71] target/riscv: Constify VMState in machine.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 farosas@suse.de, leobras@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Nov 6, 2023 at 6:16=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index c7c862cdd3..7d857f479b 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -49,7 +49,7 @@ static const VMStateDescription vmstate_pmp_entry =3D {
>      .name =3D "cpu/pmp/entry",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(addr_reg, pmp_entry_t),
>          VMSTATE_UINT8(cfg_reg, pmp_entry_t),
>          VMSTATE_END_OF_LIST()
> @@ -62,7 +62,7 @@ static const VMStateDescription vmstate_pmp =3D {
>      .minimum_version_id =3D 1,
>      .needed =3D pmp_needed,
>      .post_load =3D pmp_post_load,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_STRUCT_ARRAY(env.pmp_state.pmp, RISCVCPU, MAX_RISCV_PMPS=
,
>                               0, vmstate_pmp_entry, pmp_entry_t),
>          VMSTATE_END_OF_LIST()
> @@ -82,7 +82,7 @@ static const VMStateDescription vmstate_hyper =3D {
>      .version_id =3D 2,
>      .minimum_version_id =3D 2,
>      .needed =3D hyper_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.hstatus, RISCVCPU),
>          VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
>          VMSTATE_UINT64(env.hideleg, RISCVCPU),
> @@ -135,7 +135,7 @@ static const VMStateDescription vmstate_vector =3D {
>      .version_id =3D 2,
>      .minimum_version_id =3D 2,
>      .needed =3D vector_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
>          VMSTATE_UINTTL(env.vxrm, RISCVCPU),
>          VMSTATE_UINTTL(env.vxsat, RISCVCPU),
> @@ -160,7 +160,7 @@ static const VMStateDescription vmstate_pointermaskin=
g =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D pointermasking_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.mmte, RISCVCPU),
>          VMSTATE_UINTTL(env.mpmmask, RISCVCPU),
>          VMSTATE_UINTTL(env.mpmbase, RISCVCPU),
> @@ -186,7 +186,7 @@ static const VMStateDescription vmstate_rv128 =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D rv128_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
>          VMSTATE_UINT64(env.mscratchh, RISCVCPU),
>          VMSTATE_UINT64(env.sscratchh, RISCVCPU),
> @@ -215,7 +215,7 @@ static const VMStateDescription vmstate_kvmtimer =3D =
{
>      .minimum_version_id =3D 1,
>      .needed =3D kvmtimer_needed,
>      .post_load =3D cpu_kvmtimer_post_load,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64(env.kvm_timer_time, RISCVCPU),
>          VMSTATE_UINT64(env.kvm_timer_compare, RISCVCPU),
>          VMSTATE_UINT64(env.kvm_timer_state, RISCVCPU),
> @@ -249,7 +249,7 @@ static const VMStateDescription vmstate_debug =3D {
>      .minimum_version_id =3D 2,
>      .needed =3D debug_needed,
>      .post_load =3D debug_post_load,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>          VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>          VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> @@ -280,7 +280,7 @@ static const VMStateDescription vmstate_smstateen =3D=
 {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D smstateen_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64_ARRAY(env.mstateen, RISCVCPU, 4),
>          VMSTATE_UINT64_ARRAY(env.hstateen, RISCVCPU, 4),
>          VMSTATE_UINT64_ARRAY(env.sstateen, RISCVCPU, 4),
> @@ -301,7 +301,7 @@ static const VMStateDescription vmstate_envcfg =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D envcfg_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64(env.menvcfg, RISCVCPU),
>          VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
>          VMSTATE_UINT64(env.henvcfg, RISCVCPU),
> @@ -321,7 +321,7 @@ static const VMStateDescription vmstate_pmu_ctr_state=
 =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D pmu_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
>          VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
>          VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
> @@ -343,7 +343,7 @@ static const VMStateDescription vmstate_jvt =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .needed =3D jvt_needed,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.jvt, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -354,7 +354,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>      .version_id =3D 8,
>      .minimum_version_id =3D 8,
>      .post_load =3D riscv_cpu_post_load,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>          VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
>          VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
> @@ -405,7 +405,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>
>          VMSTATE_END_OF_LIST()
>      },
> -    .subsections =3D (const VMStateDescription * []) {
> +    .subsections =3D (const VMStateDescription * const []) {
>          &vmstate_pmp,
>          &vmstate_hyper,
>          &vmstate_vector,
> --
> 2.34.1
>
>

