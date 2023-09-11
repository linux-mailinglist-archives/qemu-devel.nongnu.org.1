Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC81079A42D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfb3Q-0001nS-LQ; Mon, 11 Sep 2023 03:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfb3O-0001nG-1C
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:09:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfb3L-0000dx-NY
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:09:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso3287679f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694416186; x=1695020986; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FIMRAzskmcY/dj44756p4wCzcX5TDjJfDqa4jLVpCdo=;
 b=hLN3J5ccuWw3FErGpANvAphJ01M7aOIpCf5MsC8jeuKdG+EXIhqzgIr+8AFV5AZACg
 CvxooIsrIULRnqWxz/LQwu7dtuD7OVitvu2jSvtEwc4Bm+X0aLItz9sQmDhO93HpXI5n
 ctelv+DLuh8emmZBYASeKzQUNq0E7ODKmW+dTEtdOjh4K3gGl7c//mlWNeEuHhGVjEF7
 e7d4sjX6nqvMIhaCyIPZMCKLynVCbnglSzaJFLXj0yGHZsNHlaC0LYsI0I8zBKDhUJrd
 OJUaySLvuutU51DvaW9qxePB5M7dtSBbn1Whlht1p3vmXAPvDiYl6FBhqDciu8YY6h15
 2Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694416186; x=1695020986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIMRAzskmcY/dj44756p4wCzcX5TDjJfDqa4jLVpCdo=;
 b=jch+1astE+ylIw0XgQu4mOQErnpMhB8tWIeNATgPszq2OGYngAlj3OkwTDPVJkIogp
 7MhAFWfvuBa36pr0ImPwfHtc7TxZdkoXVfjU3hblvGfVQjXS4Z92EdiWzieq/mRUciNi
 7MjLW9YkD4jy7QgJh2WBRt374IEcZhmf3aybc9c7955H1SA/1sgQS75YaatOMSohyCuD
 +Xa0/aOZRt+6Sds3uM0RhjL2XgCqQV4IlooYqnOCIxSNrG7ZHq36DHvOllZKTs1WMWTA
 V31KBHbJZ1ZIGYr6HVKWSogOZc36taNJLGVwHPd0JrL7Ut/twxlxII4vDERpUSlmOiID
 mltg==
X-Gm-Message-State: AOJu0YxCQYYw/tUjiQ3oSfcUMlln9uB+nqBzWs1BSaUc1fohbjGMNEqW
 nUlRN21b9jZN6zDNYn9sTfN1Pg==
X-Google-Smtp-Source: AGHT+IGROfHJHIxNyOcOaR4fF5gonuPrWfaTWajQ20mqpWMG9P+nLyWf1iSMhk/ZUDzsG0CjWh7dDA==
X-Received: by 2002:a5d:5885:0:b0:31f:8bea:3676 with SMTP id
 n5-20020a5d5885000000b0031f8bea3676mr4451364wrf.26.1694416185784; 
 Mon, 11 Sep 2023 00:09:45 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a05600003c400b0030fd03e3d25sm2200099wrg.75.2023.09.11.00.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:09:45 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:09:44 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org
Subject: Re: [PATCH v2 09/19] target/riscv: make
 riscv_add_satp_mode_properties() public
Message-ID: <20230911-da5a16e76fb2dc4fb8df685e@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-10-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906091647.1667171-10-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 06, 2023 at 06:16:36AM -0300, Daniel Henrique Barboza wrote:
> This function is used for both accelerators. Make it public, and call it
> from kvm_riscv_cpu_add_kvm_properties(). This will make it easier to
> split KVM specific code for the KVM accelerator class in the next patch.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 5 ++---
>  target/riscv/cpu.h | 1 +
>  target/riscv/kvm.c | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0dc9b3201d..50be127f36 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1115,7 +1115,7 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
>      satp_map->init |= 1 << satp;
>  }
>  
> -static void riscv_add_satp_mode_properties(Object *obj)
> +void riscv_add_satp_mode_properties(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
>  
> @@ -1589,12 +1589,11 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
>  static void riscv_cpu_add_user_properties(Object *obj)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    riscv_add_satp_mode_properties(obj);
> -
>      if (kvm_enabled()) {
>          kvm_riscv_cpu_add_kvm_properties(obj);
>          return;
>      }
> +    riscv_add_satp_mode_properties(obj);
>  #endif
>  
>      riscv_cpu_add_misa_properties(obj);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b9c4bea3f7..950c2301f2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -726,6 +726,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
>  extern Property riscv_cpu_options[];
>  
>  void riscv_cpu_add_misa_properties(Object *cpu_obj);
> +void riscv_add_satp_mode_properties(Object *obj);
>  
>  /* CSR function table */
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 7dac01374f..ef6b2cfffe 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -1279,6 +1279,7 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
>      DeviceState *dev = DEVICE(obj);
>  
>      riscv_init_user_properties(obj);
> +    riscv_add_satp_mode_properties(obj);
>      riscv_cpu_add_misa_properties(obj);
>  
>      riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

