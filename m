Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6097102F1
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 04:35:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q20nH-0008OA-Di; Wed, 24 May 2023 22:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q20nE-0008LQ-SB; Wed, 24 May 2023 22:33:32 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q20nB-0003pz-8X; Wed, 24 May 2023 22:33:31 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-78412128326so331287241.1; 
 Wed, 24 May 2023 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684982007; x=1687574007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mzAknRKRQiPjt4CRzylfJ5l4RSCzNByVtF6PZOovdg=;
 b=jJOBHIoaUytGG4aIpRM6XZCgVGb4jX1roel9ff76GznEf4FwoQWIZ7zCwu55P39qLm
 +g6WKLCFMB/et3l7x+wuwtxANYCzrEZDsjBwgc6zP5f2elYYgMI3HRP11OtL4gQU8v31
 JtNZHCT21x46rOt1ITmjhs93ppAlUkSk67ZKPttDHawiiPXbnLoGE7J8SminXnX8yM9C
 YBQ3I43oMFFIdQW6ZdS9JKQPm8iWeK01+pu/2tyw5SPu3183ggxLOgMUyoDnQ9hGD9lw
 vWI7S77hp/DnzIiUXfIEQMUoO0i1R3pHf0XRXc9kPFSzGiYxYekjdu9Xdy8M6HLCO+ZE
 k0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684982007; x=1687574007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mzAknRKRQiPjt4CRzylfJ5l4RSCzNByVtF6PZOovdg=;
 b=KiOCbTVFq7zmCAy8xcrbUNlR+/hOM69W5MPJvUQxfzHheSM+caPioE3BDJEirfkgpZ
 +a4V7E5N3A0pTElszQCAkAdAtHJhJ+CMzT3oc2FJE9lAjRYlgX5Ixlgc+/I1mjuQPHtQ
 AVGstzAEkpxgDkqH4yZAEpS+huaKg8VDG72g2M+rJpTgfpAMLojnhnTlxTLs9kUWI0Ub
 Qo2OipvKgorKtsi3WZJlQ6qg254rIo8Hgs4G2kQ6kZ76U5p4bvo7KMew4H2kGQjbJy/S
 nd3Tp2kIvo9mUwZFBdTLn7hkbhzfx54+TqkllKDYTN5tNnJ/ecsviX2e6Ua3MCmXSHbV
 MxFw==
X-Gm-Message-State: AC+VfDxIM4T1XnIgYf3PO/H6TReJ1W3ZrN+5uZldHAyn+NsxW/isHd5k
 vhgkhHIMh7cr0wSLwWyRw17xjNTxEl99Hhe8gb0=
X-Google-Smtp-Source: ACHHUZ7wEP685yRk0itnbn/MipmWWpdzF71SWSyLwtVyTtw0i7n7iD+Eh+XoCIVG2vglrSm3AA3QBurjYVLb6jxQ2t8=
X-Received: by 2002:a05:6102:3179:b0:439:49f1:bb4d with SMTP id
 l25-20020a056102317900b0043949f1bb4dmr4233794vsm.7.1684982007403; Wed, 24 May
 2023 19:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230523114454.717708-1-tommy.wu@sifive.com>
 <20230523114454.717708-2-tommy.wu@sifive.com>
In-Reply-To: <20230523114454.717708-2-tommy.wu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 May 2023 12:33:01 +1000
Message-ID: <CAKmqyKOfkhN=3+asF-u3r7y83GiZjv34mv42Yp0Ye0NzUEnezQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Add a function to refresh the dynamic
 CSRs xml.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 alistair.francis@wdc.com, apatel@ventanamicro.com, palmer@rivosinc.com, 
 dbarboza@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Tue, May 23, 2023 at 9:46=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrot=
e:
>
> When we change the cpu extension state after the cpu is
> realized, we cannot print the value of some CSRs in the remote
> gdb debugger. The root cause is that the dynamic CSR xml is
> generated when the cpu is realized.
>
> This patch add a function to refresh the dynamic CSR xml after
> the cpu is realized.
>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.h     |  2 ++
>  target/riscv/gdbstub.c | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de7e43126a..dc8e592275 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -494,6 +494,7 @@ struct ArchCPU {
>      CPUNegativeOffsetState neg;
>      CPURISCVState env;
>
> +    int dyn_csr_base_reg;
>      char *dyn_csr_xml;
>      char *dyn_vreg_xml;
>
> @@ -781,6 +782,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operation=
s *ops);
>  void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> +void riscv_refresh_dynamic_csr_xml(CPUState *cs);
>
>  uint8_t satp_mode_max_from_map(uint32_t map);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 524bede865..9e97ee2c35 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -230,6 +230,8 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, in=
t base_reg)
>          bitsize =3D 64;
>      }
>
> +    cpu->dyn_csr_base_reg =3D base_reg;
> +
>      g_string_printf(s, "<?xml version=3D\"1.0\"?>");
>      g_string_append_printf(s, "<!DOCTYPE feature SYSTEM \"gdb-target.dtd=
\">");
>      g_string_append_printf(s, "<feature name=3D\"org.gnu.gdb.riscv.csr\"=
>");
> @@ -349,3 +351,13 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSta=
te *cs)
>                                   "riscv-csr.xml", 0);
>      }
>  }
> +
> +void riscv_refresh_dynamic_csr_xml(CPUState *cs)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    if (!cpu->dyn_csr_xml) {
> +        g_assert_not_reached();
> +    }
> +    g_free(cpu->dyn_csr_xml);
> +    riscv_gen_dynamic_csr_xml(cs, cpu->dyn_csr_base_reg);

I don't really understand why we need dyn_csr_base_reg, could we just
use cs->gdb_num_regs directly here?

Alistair

> +}
> --
> 2.38.1
>
>

