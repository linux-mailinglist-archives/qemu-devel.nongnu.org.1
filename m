Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20E7F7A11
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:06:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZdO-0007xX-A0; Fri, 24 Nov 2023 12:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6ZdC-0007rB-51
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:06:20 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6Zd8-0005Zj-Hd
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:06:17 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso3162460e87.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700845573; x=1701450373; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+7y4IDBz0r+Olrxu5NQjmtEohRwOIe+uD1D4vewoVg=;
 b=Me40vJ4qaE0wx3k4ZyAWuaCNG410oo8bEIg84pqlo6N56QYtzCQWunr3mCyb5i26O9
 Gun8ER/0mMm7OAgtIVLhBAb1q1oKT9gOVCIKHcogCjwXm7NUQq6ajCBBLvCXzUK9rX0Y
 zzmNY70lowVMRuDylUk0CFNUgdeka5iyR+1uVWPGBESbG1xqj89mVmlqQWH+S+YS3vM6
 eNIHAdJJ3AbIqvm9cNI2WcQAxPz1kncFbL3SdO94oqLzOil7GNYef5PA5xwPbNWM1arY
 9EppzFok9b35z342ZKTH01C/z3KJfEaxg7zvEKbTW1L18tUss+ZYmU2ShvVlLHMT75OC
 HGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845573; x=1701450373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+7y4IDBz0r+Olrxu5NQjmtEohRwOIe+uD1D4vewoVg=;
 b=D0EDDsMuhG2AY4GxZ71BLFuPSB+N7o9CwC9IMk9Kr4cc2RWUfTvOwN38/noee6FCTf
 pVZq07QTSG9Iil/MV7zil3P1IvPrzh6cJO35KUD8I9OonhEfPMI0TJgahVtbfJH7POxo
 rm4fWgT/H1xXUuJt0DPGiFTva6BhSvBfo4YfdkqP46aBcfnBNxbjBfQ2cnlMsnuV2JlB
 96SGQnTj9qjjYGxtbfI0sWsiFHnSjGJlaGlTgJwNMBZb4zQtmyFt2TeoZoA0knXUS7Bq
 My1XIo+ecEeVto0NisKN3LogTKbqzwfnLPaYtN8RKbMnKguNpI9RYq/cPHUB1STvag8/
 u9KA==
X-Gm-Message-State: AOJu0YwCGCPkARPyMQTl8QRnquN3Z/hQidR7V5W8Wj8/a0ylaz12LMAo
 z8sCE8+FE9F0awkO5WTjb31UTA==
X-Google-Smtp-Source: AGHT+IHMralGHUtS66A86HROdKnpS5ylbKtCZR4ceViuDQlbreqr578vEgBLa+sFIlBddugAXkoX9g==
X-Received: by 2002:a19:6552:0:b0:504:3c1f:cbd1 with SMTP id
 c18-20020a196552000000b005043c1fcbd1mr2546060lfj.12.1700845572220; 
 Fri, 24 Nov 2023 09:06:12 -0800 (PST)
Received: from localhost ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 v11-20020a1709067d8b00b009dddec5a96fsm2299393ejo.170.2023.11.24.09.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:06:11 -0800 (PST)
Date: Fri, 24 Nov 2023 18:06:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 3/7] target/riscv/cpu.c: finalize satp_mode earlier
Message-ID: <20231124-6876ebf40a2db8336480b23f@orel>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
 <20231123191532.1101644-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123191532.1101644-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x132.google.com
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

On Thu, Nov 23, 2023 at 04:15:28PM -0300, Daniel Henrique Barboza wrote:
> Profiles will need to validate satp_mode during their own finalize
> methods. This will occur inside riscv_tcg_cpu_finalize_features() for
> TCG. Given that satp_mode does not have any pre-req from the accelerator
> finalize() method, it's safe to finalize it ealier.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 29a9f77702..a395c77bda 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1056,6 +1056,14 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      Error *local_err = NULL;
>  
> +#ifndef CONFIG_USER_ONLY
> +    riscv_cpu_satp_mode_finalize(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +#endif
> +
>      /*
>       * KVM accel does not have a specialized finalize()
>       * callback because its extensions are validated
> @@ -1068,14 +1076,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>              return;
>          }
>      }
> -
> -#ifndef CONFIG_USER_ONLY
> -    riscv_cpu_satp_mode_finalize(cpu, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -#endif

Assuming we'll be getting KVM's supported mode with
KVM_REG_RISCV_CONFIG_REG(satp_mode) prior to calling
riscv_cpu_finalize_features(), then this looks good to me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

