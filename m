Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F382AF32
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:09:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNumg-0001Tt-Aj; Thu, 11 Jan 2024 08:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNuma-0001Sw-Uf
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:07:41 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNumY-0006MZ-JY
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:07:40 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2bdc3a3c84so184525866b.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704978456; x=1705583256; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OK9rIy48rVdf6fVvU0J04ZQWy+LTTuIH+kUnIDOqdBE=;
 b=C2TOpOJd7HBzlTGNr4wik08xu4OSenBmCVIgNZVc+gLXmOpyBUUpETPpHRXYByFRoX
 V0t+5bSSnt+tbTplpkB/QnEO9j58R6q1oAGh8d1PhS3a1e0F4Bbqa42k9+11b5dlvMjV
 3E5nm5zTzKfssFwxzJoKgOFW9aPhKKln4h/bhSRuWGq4wK8I1GMzYpOqbcu3PETS6Lru
 fjdeepHmy3NEHcvlJcJ9pGlJYTZUqSb/rNcTZppqiiX9ARikk5vYxNstmbCgrEwXtLNJ
 KC5t3OD3NcRHRYxWshqvB2zN/aTs2+eAnzh9bBlwumXwJ4AnW80wyRw3S4S6sRGy7/uC
 l0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978456; x=1705583256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK9rIy48rVdf6fVvU0J04ZQWy+LTTuIH+kUnIDOqdBE=;
 b=TAZIkPZTDSJ5ONrTAYFytjA2iSRFv3pQFcZ/r62GpXZeM7v4+OvfR8S1JKFJWMH4QI
 js7ByaV3ceSG/WkVOuSx2C7XAdqDJp8u8sdUWAWm6rCo9QGY621N5fUsefb2xQd6Vmri
 n3BU6C8DcmlrDlvwUrfYfXKl4kFe7u26NrBRveErLZ1kJsTkXYFcgW2AsXlAHZkmZpk/
 nOoSlvxiYPWKQL+tuXXJZfJFf2fWFSAnbSoonJM9mxWIX8bVCHx/QNuPKE32JUk2sO9q
 vE8zqCUs2nKatMzzR545xk7Dv+2eCv66+XaS3D16YZ2ihgNwA9E/dj2qFUPRS0cFe7AS
 fbPg==
X-Gm-Message-State: AOJu0YwguTQ2N+EEYiCIzHYDod2wyjVvc5/z/kf7TjOM4GP/DLTbdJZw
 UDOPhh8k5b5OYveiJ3Ao06T2oJtxF3v86A==
X-Google-Smtp-Source: AGHT+IHtX2WLhoKtfeAlU7OWfNX2n2PKaV51mOajuQY0Ix1Q8OqiWi6GatFL+2DUEd2KsoLekhkIFA==
X-Received: by 2002:a17:906:269b:b0:a27:b489:b5d8 with SMTP id
 t27-20020a170906269b00b00a27b489b5d8mr628474ejc.72.1704978456066; 
 Thu, 11 Jan 2024 05:07:36 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a1709065a8d00b00a298c766585sm559682ejq.57.2024.01.11.05.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 05:07:35 -0800 (PST)
Date: Thu, 11 Jan 2024 14:07:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 1/3] target/riscv: Add infrastructure for 'B' MISA
 extension
Message-ID: <20240111-585fe1291fcaa1e0432674e3@orel>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-2-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109171848.32237-2-rbradford@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Is there a corresponding proposed change to table 29.1 of the nonpriv spec
which states B comes after C and before P? If so, can you provide a link
to it? Otherwise, how do we know that?

Thanks,
drew

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

