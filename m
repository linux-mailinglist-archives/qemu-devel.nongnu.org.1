Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40482AF4F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuua-0007QW-TF; Thu, 11 Jan 2024 08:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNuuH-0007Bn-LK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:15:39 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNuuC-0002E4-MX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:15:35 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so6270251a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 05:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704978930; x=1705583730; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h0K06ZXbOyxiBDKfO2g5T4zjXYvc65UdXgQLYDUK9F8=;
 b=ej+g4SDEUjpk2Gdu4z5QuxBci/IBth9LUQ1pI+sGqL12ZLjCPpqU9g9eds/QxBiSZF
 7Q7N4ccIRrj+gT4EIEJO0iMTbraBoz2LspYWGfmdzELKeQUstQR+WBvP4E7Gg8mabj9u
 ChV6G2gRDZDWzJPRnQx0k/LQ8h99mbBVMS7Ryg8PYKy7tVeJpjWi+O2fxy0Vq4ZrI9DF
 +Jc8nevDRRV+rmdJvkxMv4gEeW5Vwj7IlY0cvPAwImkqdkvpNv/w8fKQ83q8I9W5kvIr
 7njeGCjaQF/mbmb063F98KMw3BFwcHa6Fjj4TQucpNBL7cxHXB5wpzPGqEX3nXW7n6N4
 7Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978930; x=1705583730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0K06ZXbOyxiBDKfO2g5T4zjXYvc65UdXgQLYDUK9F8=;
 b=B1MkNsDuOodakpcHwe8JxTLHUbkj9gRmIXdepeR90AC4AA15T/C7l3iHx+On3bPC3t
 86WbUx+1Dfq/8eKiAFn/XjZcU/7YOrvUGncojIgEdZis8zQBIYJS6pmAPkSIjU68jDCD
 NnLyz9fgj6OM3gBtYx/eQzC+E2TIntQPKufAZF6gDxJxGTsrVYG7CHbjf0lOPIfZc/G+
 dyBrzT8mcqGn/uyc6k6qaa5XzC4SgezUuShcrGGhfbw2UtytntsaK6Jmb9oKoxHEOwrZ
 CYUKDPK0VZ5U/eO6YEWCTmL2oaZhciKyav7uGdbtT/JDiTweU6su1fgwIPMvVyw4tags
 2siw==
X-Gm-Message-State: AOJu0YxIo/W12q7YjzWhcjDwu2wQ4RQlvEquUt8h2C5C0vowyTzW5yy4
 NB53X14G6KEPB6HR0jN7qGWrk0m2fm767Q==
X-Google-Smtp-Source: AGHT+IEvXoVR73cDVQfBxH4DXEBKyDPLgeJbvL8kMos6RaZC+z3AycHUPExwh9kC9H3g1T8iBdXwOg==
X-Received: by 2002:a17:906:b088:b0:a26:90a0:695f with SMTP id
 x8-20020a170906b08800b00a2690a0695fmr391475ejy.83.1704978929817; 
 Thu, 11 Jan 2024 05:15:29 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a1709066dd900b00a26af4d96c6sm568831ejt.4.2024.01.11.05.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 05:15:29 -0800 (PST)
Date: Thu, 11 Jan 2024 14:15:28 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 1/3] target/riscv: Add infrastructure for 'B' MISA
 extension
Message-ID: <20240111-44114ecff921e28798180fd9@orel>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-2-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109171848.32237-2-rbradford@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x531.google.com
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

On Tue, Jan 09, 2024 at 05:07:35PM +0000, Rob Bradford wrote:
> Add the infrastructure for the 'B' extension which is the union of the
> Zba, Zbb and Zbs instructions.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>  target/riscv/cpu.c         | 5 +++--
>  target/riscv/cpu.h         | 1 +
>  target/riscv/tcg/tcg-cpu.c | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b07a76ef6b..22f8e527ff 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,9 +38,9 @@
>  #include "tcg/tcg.h"
>  
>  /* RISC-V CPU definitions */
> -static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
> +static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>  const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVJ, RVG, 0};
> +                              RVC, RVS, RVU, RVH, RVJ, RVG, RVB, 0};
>  
>  /*
>   * From vector_helper.c
> @@ -1251,6 +1251,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>      MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> +    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
>  };
>  
>  static int riscv_validate_misa_info_idx(uint32_t bit)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2725528bb5..756a345513 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
>  #define RVH RV('H')
>  #define RVJ RV('J')
>  #define RVG RV('G')
> +#define RVB RV('B')
>  
>  extern const uint32_t misa_bits[];
>  const char *riscv_get_misa_ext_name(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8a35683a34..fda54671d5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -791,6 +791,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>      MISA_CFG(RVJ, false),
>      MISA_CFG(RVV, false),
>      MISA_CFG(RVG, false),
> +    MISA_CFG(RVB, false)
>  };
>  
>  /*
> -- 
> 2.43.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

