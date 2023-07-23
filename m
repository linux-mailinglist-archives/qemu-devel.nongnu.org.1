Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C585D75E5AE
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 00:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNi19-0005tb-VO; Sun, 23 Jul 2023 18:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNi18-0005su-0K; Sun, 23 Jul 2023 18:57:34 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNi16-0000SF-EX; Sun, 23 Jul 2023 18:57:33 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-79a00f74a92so638460241.3; 
 Sun, 23 Jul 2023 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690153051; x=1690757851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKOI1yKEvu/NP9imrng9cMF5giBATuNDJ3AJl4Yf6n8=;
 b=cPHMTXtprIVscUHNMfhlDzCJUSASIW3DrClLfpF75k6GG8TUeNZxecBFRwy57esfKJ
 7BryAbBwftLB8PIRksNG4siEwlu98hEjdcbXobqIGpYxj0EySjR2QRpJZD79VoKoQMU0
 xzMILOKw/y2uPA0aZHYGkNI9eMs30FH+yZ8CIWHncui6O/24vTKPI2SLxM/tsTPwECKT
 yCZ8NC0Tte+F8gYN/p3OSXl+bXmeeUQ4YZQDrhcurxI2Tug5zMPIbUWuo5asVt4a1vZh
 3SVZ841PgWjv/msQp7jXToga4Vy4w9ACoaFmoyHxZoQd+f15liTIOSmTT8p1dp84W1IK
 RYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690153051; x=1690757851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKOI1yKEvu/NP9imrng9cMF5giBATuNDJ3AJl4Yf6n8=;
 b=kyxk0J8fnFrAG48sSBTgjL2+pPutTtbgQ2ZJcUVvjbVuoGXb9pfe9QgR/kTK3PPx6a
 XdvCXdDTLNEMcs4BsGsYF+VEeXSwkH4Pqgn6fd7wpX2z7y7a06FqV3QGPtg2NBkteA5Q
 3uiIj0r5YkYd5T0n+8uAlVvVON1xtvo2zgemCQRvmQxP69kDdiI8v7FdcDuwxnPCh5QC
 g9V4MsasdC6mQLAIHn4T9Bd+U4dNxok6nTL/r6S6TxG5POMtz4VN8DA1hC2ySpH31Xg7
 o6jmMwRShtcH2VjDlKczlMFCCwvsLUcuAI9Iqz0AjHqQeKZ0XTYETBS4Kh48JExsCpBg
 9EBw==
X-Gm-Message-State: ABy/qLYmC9Yo9C/vYUvH3nbuJTFcOYlW3FjVU04TTXzDErXYEhq7gZ51
 Q/julLcYN07BCdktgX4nWJnAy9daC98fyx5sLWWRLg6A+doK7g==
X-Google-Smtp-Source: APBJJlG4UkMKKggDL5j+qf9FQwjx6Tro8huhkiknxNGK3RyzvSlmVM0XCiC51KLwOS067k+vwkG9vQW9jqALlteUsnA=
X-Received: by 2002:a67:ce91:0:b0:443:6180:778f with SMTP id
 c17-20020a67ce91000000b004436180778fmr2242457vse.33.1690153051197; Sun, 23
 Jul 2023 15:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230721133411.474105-1-dbarboza@ventanamicro.com>
In-Reply-To: <20230721133411.474105-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jul 2023 08:57:05 +1000
Message-ID: <CAKmqyKOkQvhpPZGWFX7czUj5GaJXbcrHhJT7FGUxeX-95=t_mQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/cpu.c: do not run 'host' CPU with TCG
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Fri, Jul 21, 2023 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The 'host' CPU is available in a CONFIG_KVM build and it's currently
> available for all accels, but is a KVM only CPU. This means that in a
> RISC-V KVM capable host we can do things like this:
>
> $ ./build/qemu-system-riscv64 -M virt,accel=3Dtcg -cpu host --nographic
> qemu-system-riscv64: H extension requires priv spec 1.12.0
>
> This CPU does not have a priv spec because we don't filter its extensions
> via priv spec. We shouldn't be reaching riscv_cpu_realize_tcg() at all
> with the 'host' CPU.
>
> We don't have a way to filter the 'host' CPU out of the available CPU
> options (-cpu help) if the build includes both KVM and TCG. What we can
> do is to error out during riscv_cpu_realize_tcg() if the user chooses
> the 'host' CPU with accel=3Dtcg:
>
> $ ./build/qemu-system-riscv64 -M virt,accel=3Dtcg -cpu host --nographic
> qemu-system-riscv64: 'host' CPU is not compatible with TCG acceleration
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b93b04453..08db3d613f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1395,6 +1395,11 @@ static void riscv_cpu_realize_tcg(DeviceState *dev=
, Error **errp)
>      CPURISCVState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
>
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
> +        error_setg(errp, "'host' CPU is not compatible with TCG accelera=
tion");
> +        return;
> +    }
> +
>      riscv_cpu_validate_misa_mxl(cpu, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);
> --
> 2.41.0
>
>

