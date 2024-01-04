Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B678823C23
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 07:16:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLH0X-0008EK-NA; Thu, 04 Jan 2024 01:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLH0V-0008EC-MM
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:15:07 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLH0T-0007Gq-A6
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:15:07 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7cc94f8756aso73371241.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 22:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704348904; x=1704953704; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5LVNrgSNhhUh6wqST3N7LURPEFQksoT3IDpSWDPqZI=;
 b=l7Fnrkv9sJLbAhX4NtXSBNMNLGil/6GsW1TcE1/s2HK16uCK1bM6cc4hAjPkfuBt2M
 cLT6at8/fPVmZ+jqWz+vUefQRStT51kAyQL4LSz1BVY+wnWXWjyPm0HSz2O+zLz/5ajT
 L4eCiPr4G0ljRLsuFL6rT3jYzGSGQv5hcTmI0gsRZ1sfmYAN4n+30AMukf+y9kDtEDeT
 5CovK3NAZ51xfkJQQVyqs1byjDpW38hOPiia9FTp8CY+flUD8XgaN3EKIcvnf0xkUEUG
 EjjWfrwlNWh+lNtmJvq9lKkuwMPmJtHbj07+9IJHANlggNm8N5EdOo/O0uHWlUXW3NMQ
 DT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704348904; x=1704953704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5LVNrgSNhhUh6wqST3N7LURPEFQksoT3IDpSWDPqZI=;
 b=g3xSWjOVgmezoz/gX4gQOQjIRpHqIE18b/uC5ZRSsALbRCvqOwyFnK1a0olicFELDD
 A6VvrczQi6+ImmCxqwQ2hpSgqTUV+Wr+9JIQCepCsp33sWtxUoxJ0T1xf8AfWrfE8Qrf
 mSCKUkC9HejqfoNTmUxgNBblgwNvFZ68N6jMwT7eI+Hbnoo/uTTzuQpqu2rqapvHBp86
 FG14/5ewpt5mCQSFSLtYh0p9rAMmxtsWFCUvs4JMu+He0+iFEgEIOVkWqWlaNnBn5m0Q
 Ibje80ApFIdrYOp52QuPfhbNy1hyCill6TInsE6qQNgH52g6oBOj2cdJnATityCmH2Wq
 NgmQ==
X-Gm-Message-State: AOJu0Yziktl8BCS2//lkBH1kJ3mazyCFOMRQ8Sh7mUeh+nGUb3ofMC6t
 7WavE4UdUtsfK7wLByt71hUseeyjODRRdGDsWXc=
X-Google-Smtp-Source: AGHT+IFv+8cvzPDgjWeymZKhv/MBhFWqTFbXnf7xgrWek+IpJ9ke4uJko9xGZXU1FKplPSgIjeErC9tXdnF/vqXH3g4=
X-Received: by 2002:a05:6102:2c14:b0:467:a7cf:212e with SMTP id
 ie20-20020a0561022c1400b00467a7cf212emr58268vsb.17.1704348903739; Wed, 03 Jan
 2024 22:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Jan 2024 16:14:37 +1000
Message-ID: <CAKmqyKPk3jA5YttbizhNhtLY=2NaNCjvgucAAqO4kJ4Ptg8OPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/system/riscv: document acpi parameter of virt
 machine
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Thu, Dec 21, 2023 at 6:03=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
>
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2:
>         mention that acpi=3Don is the default
> ---
>  docs/system/riscv/virt.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f5fa7b8b29..9a06f95a34 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>    SiFive CLINT. When not specified, this option is assumed to be "off".
>    This option is restricted to the TCG accelerator.
>
> +- acpi=3D[on|off|auto]
> +
> +  When this option is "on" (which is the default), ACPI tables are gener=
ated and
> +  exposed as firmware tables etc/acpi/rsdp and etc/acpi/tables.
> +
>  - aia=3D[none|aplic|aplic-imsic]
>
>    This option allows selecting interrupt controller defined by the AIA
> --
> 2.40.1
>
>

