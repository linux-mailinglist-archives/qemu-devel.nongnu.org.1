Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D796C7C6183
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 02:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqjGZ-0007xr-BS; Wed, 11 Oct 2023 20:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqjGX-0007xb-FP
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:09:25 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqjGV-0001a4-SH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:09:25 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-45765b55fb1so179434137.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697069362; x=1697674162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E6Rb76QtykLEtpxRTYbPOUD3PEgLNbGFAb6+VKc0g0=;
 b=DTsZtY9YbhWKQ6QNf1hCV8e2wk8gF9RRQsx2QCz9Ddwc7f1/qE71l4uZ/2SJaQKMBI
 yBq/7PBPNl8vRgeyMGp9SJfVKU8irk8iYV9Iygy7cbBcGr00vO1I0tu9+hMtvlWlhHQI
 1PY/t22dute/vjnHhVSOa81/mh048xIGlzw2msyGHk5oP6AR57hReuaNMotwhvsFEQ4q
 oaorenxuPC2nN25ANC1UZWx85EWgVT/bJLUGngt7B72sWhly5SJrq0Npzgi7z1VEw0Qh
 b4Wq2tygoWQAVdT48m536y7YwAj+7Rl1T87j5swM6R+eX+c4QnxvWyXGz6itDnRC28dI
 p1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697069362; x=1697674162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E6Rb76QtykLEtpxRTYbPOUD3PEgLNbGFAb6+VKc0g0=;
 b=bVvDdk6HPN3qLOFfhGrJ1cjSJiK81hE5quQi6pRkwk3U6tTrMh+MCXNrFi0jP9pVb/
 ohy8gjVRgfm3gU3aSC5TggLA02wq4dj8J1n9ZtSJQbBd58k/MftVlHMlp8nvHPBdzZUF
 WrpXRD1A1TpSvuuKXd+KWKT+iZfaxtz8fDVFbTrGhoJ0APHDeXjfD8877ErIa/u80VNg
 /bdSLUjHGdejNQ5hFL10zOBp4Hd65KBlq1gX7YhTn63KXRElutJqHff6/RaTHOWpd40i
 u0+naCUO9fWgd/k0X0QyD++D8TzdBKoqQZRApZN8aJCAsCA7fgixi6Srt0mR/2oeUsGT
 ue4g==
X-Gm-Message-State: AOJu0YxDEzv7kHQtmOOA17U1l0SPeac1YufN4oD3cdff/cwrhq1E3CO+
 Bkf++7CWEVsZYcpmNuzkHfMl9gq52ioKqs4bvBU=
X-Google-Smtp-Source: AGHT+IE+jtGj0bpjr4ph2nFS2WUEiMP1Bl7FyBQFitIVf0PO5COhrul84X3ZhwP6TxoKBxvnZ7R7AtyFrDQXdrhBJCI=
X-Received: by 2002:a67:e40d:0:b0:452:8953:729e with SMTP id
 d13-20020a67e40d000000b004528953729emr22925899vsf.13.1697069361033; Wed, 11
 Oct 2023 17:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231011114721.193732-1-bjorn@kernel.org>
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Oct 2023 10:08:54 +1000
Message-ID: <CAKmqyKMtD7cvNjvs=_=frbaUVpPunj4sX0Q+jgLqDSYKNAwWxg@mail.gmail.com>
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Wed, Oct 11, 2023 at 11:34=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
>
> Add the missing RISC-V arch-defines.
>
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:
>   (qemu) dump-guest-memory vmcore
>
> The vmcore can now be used, e.g., with the "crash" utility.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..f05ff56629b3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
>
>  config FW_CFG_SYSFS
>         tristate "QEMU fw_cfg device support in sysfs"
> -       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC =
|| X86)
> +       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV =
|| SPARC || X86)
>         depends on HAS_IOPORT_MAP
>         default n
>         help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>
>  /* arch-specific ctrl & data register offsets are not available in ACPI,=
 DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RIS=
CV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
>
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
> --
> 2.39.2
>
>

