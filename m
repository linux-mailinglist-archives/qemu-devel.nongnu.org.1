Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFE8C713A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 06:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7T8K-0007YR-Hg; Thu, 16 May 2024 00:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7T8I-0007Xz-CH; Thu, 16 May 2024 00:54:22 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7T8G-0008M0-Hz; Thu, 16 May 2024 00:54:22 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-47f39711c94so2064495137.1; 
 Wed, 15 May 2024 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715835259; x=1716440059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnTrxIAX4KMsTZTbMjsYJgBUC+Rk9NfYJot1ZZjej7M=;
 b=PR91dHkHYfbERcYGBs+nVlsCi+AAci+K4ljbYhE4/tQZY2PJzmMr7W2eRgrN3PbWWv
 xFZ+k/4ku2hQ2/JThv1dkXJZiqbbJEOcRJyaH+uMBUIW8We3g7zWq5k7Bfi/rOizbZz/
 IK2R93F6TZtGRhXG7NciWBfysHcRkTXJtVA2mN+9497vgUBtm3+E/rZ/ZhoqRoKXQcQ3
 vsBEBp6P/ULSA54Q9NxBEf9lknPyZ5Rt2yHapP3dWh6rLbEMogmoavdkK8KjL6pAq5gq
 IelMwRwUIrE/tVkoJoKesB+c3QeZ+OLDmZbbZKdkYZuilNIcILvJ0mp+hLLB2KYIH+wx
 YzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715835259; x=1716440059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnTrxIAX4KMsTZTbMjsYJgBUC+Rk9NfYJot1ZZjej7M=;
 b=NR02IrcbIKw75XtRPF/TsS/ixkgVbojF26cY5rzcudy1s1NyzOH2wHv0vYl9ErWVec
 7tTsrUavwprubRUiic5KLUBcpYd5Mco690sfRA+RB3Bj1Oy3WfIS6siMLAexzgX3EOEH
 tE4ZMtKMNt0kgbO7xkzE90bUhuYGvuI30HDxRVw/y+wq3D1IRQBibbhslZOSuz9Et1EP
 GyDod+kgvFxFNXT3yiZyN8BkcLhQYcgftU0oN5Bs8AGc6pbvW3IaVi7zCu3akOmXFr9u
 PVxJcm3MMgoOm06u4L1hqdIeiW8AyvBlpk6faUBKzKTMkTltl89CT6NlPpKchqCqBox3
 aQuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaXNsd2RUFCf+Af+S9+yLurIbjwEhETL2f8yvj73hDFQ7jOTR7j89FrNTMO0wFnWw+Cn5HW+e8E21A367kJ/Ism7kPpu4=
X-Gm-Message-State: AOJu0Yy/yQqHwQlMgesTy6aWWP6x8NaNK34H8cN0NHn1EYK7tbF3aM9I
 5lyAhfhzoRGnN1dUZWS6JnlJPZWylhgddXBRQ8Kq5ZkRUUIo9shlKkvmE9vNBPPcXiH7/KT+B+b
 WCh/e50Wfkujo9Oy+D5YIFX4isUc=
X-Google-Smtp-Source: AGHT+IGeJFwljkFSXC9e3cM+vKBdcToX6OcUU+g47maSv40ikPyTyv+cyMbcDNOCLQkBYvDBMsJXDxBpZfWzB+Dvjr4=
X-Received: by 2002:a05:6102:3e86:b0:47b:ce9f:93f3 with SMTP id
 ada2fe7eead31-480789e1648mr15046456137.20.1715835258573; Wed, 15 May 2024
 21:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240514110217.22516-1-rbradford@rivosinc.com>
In-Reply-To: <20240514110217.22516-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 May 2024 14:53:52 +1000
Message-ID: <CAKmqyKMx-Di2aHhjFa1=hsggMEf9cd9_n8xLs1+PTugyxRpQqQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Remove experimental prefix from "B"
 extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Tue, May 14, 2024 at 9:04=E2=80=AFPM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> This extension has now been ratified:
> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> removed.
>
> Since this is now a ratified extension add it to the list of extensions
> included in the "max" CPU variant.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c         | 2 +-
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..861d9f4350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] =3D {
>      MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>  };
>
>  static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..164a13ad0f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1281,7 +1281,7 @@ static void riscv_init_max_cpu_extensions(Object *o=
bj)
>      const RISCVCPUMultiExtConfig *prop;
>
>      /* Enable RVG, RVJ and RVV that are disabled by default */
> -    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
> +    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
>
>      for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
>          isa_ext_update_enabled(cpu, prop->offset, true);
> --
> 2.44.0
>
>

