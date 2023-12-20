Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F528198E2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 07:59:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFqWx-0000xS-FI; Wed, 20 Dec 2023 01:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rFqWu-0000uk-F9
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 01:58:08 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rFqWs-0004w7-92
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 01:58:07 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35da160de2bso27266875ab.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 22:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703055484; x=1703660284; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=psqPCC8h54CzisIAHj4NkflMiXSHDKgv1e9aseOcz80=;
 b=J7+bAjJ8S2DDWhRi64txD1rThoS9gUXXcBawkNLuzZ70l2k/B+oWrkYK7IonAWX7OQ
 iQQbyab2hR5uOWAPiga3SeLuO/uypPNX4Zuq5MlKmgClYo52o9CrO3PV85v3/iRtjbVk
 +VHvmePjz6zLdHddc5zhj9vzLVfgF0wTMJstVi72+uN2onmAjVv4USpjox5p1P0IQK8w
 z2emi51tNsYlfLZVmMQj5td6bfOUGGMifhaCs8+BtNqAMa1qCSz+wZg2UeiXo4cUt/Lj
 VtA0r1Vf6NzYOXKqdRYXLpsn7Vh13MQm0dAoyvpz+l+euczlU+RLKjhVD3pX4Kbt1RHj
 FWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703055484; x=1703660284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psqPCC8h54CzisIAHj4NkflMiXSHDKgv1e9aseOcz80=;
 b=fhUnuG7htsFdJuydIB4gOTVM8S6A4hJXuvecTh47AxVd+f0CwfqS+prp020XTEx/RI
 wJ3mVSlAyq4Zmv9Mep/JAuHhbCynIebel08whw5VefchmRAUHAQ/qY3qj/P5CeXRzhpT
 jB9s0vkmHYhWLi0aBh4R3j3bmd7e1IyyPgItUNXv5Ye7KVWPrwA3l+vW/GcHXq+NAu8f
 kK1xYKOMHJ5ZrRY8wRp/PniU5Jqvlsi7t1T/tZdaA54ivfsrYNwjW6JG+jz72RFCOwSv
 MDGN+O7c10c9L5HaROVxmVKkWzhrqN7vF3Nccz8TmgMkjDcHlbBRB8wO21645880UQaW
 TtJg==
X-Gm-Message-State: AOJu0YzSjB+1Fm3XfGozNU7KjjkTrWtcTut2yhXUEwiRqBt7AMBAxHRw
 40f6lyjCHtHUjWhtfCqNkXjmQg==
X-Google-Smtp-Source: AGHT+IGwDPNU9H8hukzO1e2rbaENWYLGjWnu+MJy//vNZhuhkicRzEgbYCoL6uURjt2kG+RjQGvOuA==
X-Received: by 2002:a92:d07:0:b0:35d:59a2:128b with SMTP id
 7-20020a920d07000000b0035d59a2128bmr22051019iln.55.1703055484300; 
 Tue, 19 Dec 2023 22:58:04 -0800 (PST)
Received: from sunil-laptop ([106.51.83.242]) by smtp.gmail.com with ESMTPSA id
 t10-20020a92c90a000000b0035fac895f48sm1984715ilp.29.2023.12.19.22.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 22:58:03 -0800 (PST)
Date: Wed, 20 Dec 2023 12:27:57 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] docs/system/riscv: document acpi parameter of virt
 machine
Message-ID: <ZYKQdb0xYGVezoqS@sunil-laptop>
References: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Dec 19, 2023 at 03:38:29PM +0100, Heinrich Schuchardt wrote:
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
> 
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  docs/system/riscv/virt.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f5fa7b8b29..4e134ff2ac 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>    SiFive CLINT. When not specified, this option is assumed to be "off".
>    This option is restricted to the TCG accelerator.
>  
> +- acpi=[on|off|auto]
> +
> +  When this option is "on", ACPI tables are generated and exposed as firmware
> +  tables etc/acpi/rsdp and etc/acpi/tables.
> +
Hi Heinrich,

Should we add, When not specified or set to auto, this option is assumed
to be "on"?

Thanks,
Sunil

