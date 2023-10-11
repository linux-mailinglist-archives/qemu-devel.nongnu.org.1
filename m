Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C557C5586
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZKT-0006gg-U4; Wed, 11 Oct 2023 09:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1qqYqh-00054A-Ao
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:02:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1qqYqf-00080T-12
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:02:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406532c49dcso17408375e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697029317; x=1697634117;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwgmh6+dGvGXg4dM1TwwbyonY61p5x8aIJa99FUZaaE=;
 b=qWyIX/xb98GkRpkpAh84G+Eko37O2drm8SN+9rwEQAExc6mlk4/YUm/218LUsIF0sG
 g4AhU3mD1beCeZ5rFHaPM8JD59bM8vdHsERymw2+ofZAw6e97gI3JbaqwRN/GcJSVxiy
 7u2EX4Ed2JjUWLw5szuaxAUr+iVoQkHWIiF216aRg1nawltHGF/wTg7ls9mVPffMTSSz
 hvkdA3JemP+u0hLaFzLxVs4fWq21Py8pPn0VOn54k9xHOOZpr+/c2zy5f+oLK/w0gyC9
 ZSPsf6WTZKCeOQgVwsbhHYQp1HlfCv4M3B6n0Vb2I9HOsQ//6dzs3c+dL6wvCzisQz36
 PUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029317; x=1697634117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwgmh6+dGvGXg4dM1TwwbyonY61p5x8aIJa99FUZaaE=;
 b=MzRDSJWq3JKD0Po0umyRawkTDyUaLIA+DtnBjINbGTRTI0LgHTMNq8RNRnpSskMm59
 aydXEH8J7AXtZVRiknD5RMq1OodDHgD3clGUkIEKsEylgZi5vSUzeC481FP0pklICDh4
 bez65Ug15U7HLLPARZa5re0NFmvNEgg2f2osr/A6jqbXTU2ojiAAd06UEAKOpiAXfMpR
 WR98OhAN1f+68liDESMaLIt0fm/kCp4Vj7B1yF+R725dsWcKIkoGOHIKraQeL5M1ALyI
 5xpYKBq7vtia9vlG7reaIbDP5pliHLLtxeIB7DqERD5hwLqW2UpWXoMxKwccYNqMrdBg
 qaKA==
X-Gm-Message-State: AOJu0YzOV+WXNtS1zvnqKI8/sKy0JMripnnyzl7mApWeqrPbYywyqJpy
 oRhjt4Wl8HmLIrNaEjgpzlDqTw==
X-Google-Smtp-Source: AGHT+IEhMkJ2UZs6Oq4f4tUpfy0l0nV4F52Qa2DFBj6+4HKIgbRMYasQqxe3N8vqkwv/ysHcS2lQQg==
X-Received: by 2002:a05:600c:1d03:b0:404:7606:a871 with SMTP id
 l3-20020a05600c1d0300b004047606a871mr18566318wms.2.1697029317191; 
 Wed, 11 Oct 2023 06:01:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9134:b302:d8b:a200?
 ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a05600c21cb00b00405bbfd5d16sm16970192wmj.7.2023.10.11.06.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 06:01:56 -0700 (PDT)
Message-ID: <7d8958a5-01cf-428d-bc40-efc06d1be8fe@rivosinc.com>
Date: Wed, 11 Oct 2023 15:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20231011114721.193732-1-bjorn@kernel.org>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:31:43 -0400
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


Hi Björn,

On 11/10/2023 13:47, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
> 
> Add the missing RISC-V arch-defines.
> 
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:

small typo here: monitor

>   (qemu) dump-guest-memory vmcore
> 
> The vmcore can now be used, e.g., with the "crash" utility.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
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
>  	tristate "QEMU fw_cfg device support in sysfs"
> -	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
> +	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
>  	depends on HAS_IOPORT_MAP
>  	default n
>  	help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>  
>  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
> 
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5

I didn't know that qemu could generate vmcore files. BTW, whenever I
don't have 'crash' at hand, I often use them with gdb and vmlinux-gdb.py
debugging scripts. Anyway, works as expected:

Tested-by: Clément Léger <cleger@rivosinc.com>

Clément

