Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAF072482D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:48:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YuS-0005VX-6X; Tue, 06 Jun 2023 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YuI-0005LB-Az
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:47:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YuB-0002SL-Pl
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:47:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-977c8423dccso679247366b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686066450; x=1688658450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=52SJSOIhXRtWR+atuqChnDE9wIvyPkmBrD1xHodIqcc=;
 b=IPitqhOUhn9CjHaQk3J/Lwr2lJiWSBPB3hVUqW2kOScb8uSk4n0Ynt/AOom1Ik+IQl
 tnh5xrS7m4jihRVZcbEeextXgj0pBaJItGPwStgceizCakQO/Agm6P5FK81JOSgn1Wno
 HuXgg+lQM+NKbcKDDVztrAjuXBWIfdxI/6LYIfbRRFfcLtcMJ4PgCoj69GAUyX56s/eo
 tFwRaRkhdRGRtddneECRn+FvUbL9aBVbnyqY2pa6PsOIQfOAckUK+biVP7MZQ7WT8qiQ
 VGmsAPgUQXDN4UyAoS58h0Fwxun43gDvE9OZQv3mDneRSKdP5rX3mrtuxfABnvWCIhBl
 a0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066450; x=1688658450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52SJSOIhXRtWR+atuqChnDE9wIvyPkmBrD1xHodIqcc=;
 b=HO4o+jwqRP167bkL/ivlIhgrHm6GpuLgmtyVNQo+nJPZeQqFnPhwuvpvgz/RNUH4bX
 Basl54kpBDbTp+Z94QJ1laJwXcnfvpxKQRX6QjH1RIW9cEQ4O13PcS1pNDunHFHFatLW
 MTTnbhttGepgJaGFWurIC6iZRxxSZM9aUHOiqv7Ud+Kzzul7hLWM6AskH1vAxtXvIUzc
 fd1vKEyuj0Ycg+7cqat7j+/xj+9bn2BWK2XUafaI5WCyqMjz7lGJFtup/KuvQcpsNRih
 BbgR5rj/WzCCFi9auaQeF4oe2FF6oO3KcKRS3fg93RQItwSnLESktQR/pAr7qOoBkECD
 gwFQ==
X-Gm-Message-State: AC+VfDwfxP7qZ3s1yPB0R//Yi3PCA+SP7UDcqVEZUT/CRilU8EGKMZlF
 WpB/zWDQPTHg1RAs/ro5JiMJrg==
X-Google-Smtp-Source: ACHHUZ6jwmU0GK2AUq0kVfRZLi6iG2VsJpyItV5hbAEbkW9C46a45q0B2G6OXyrBdAEYTB2vZgx3Pg==
X-Received: by 2002:a17:907:70a:b0:94e:bf3e:638 with SMTP id
 xb10-20020a170907070a00b0094ebf3e0638mr2684631ejb.11.1686066450215; 
 Tue, 06 Jun 2023 08:47:30 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a170906a28f00b00968242f8c37sm5664736ejz.50.2023.06.06.08.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:47:29 -0700 (PDT)
Date: Tue, 6 Jun 2023 17:47:29 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 07/16] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Message-ID: <20230606-a61eb46771466f46ca54e62d@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-8-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-8-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
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

On Tue, May 30, 2023 at 04:46:14PM -0300, Daniel Henrique Barboza wrote:
> Allow 'marchid' and 'mimpid' to also be initialized in
> kvm_riscv_init_machine_ids().
> 
> After this change, the handling of mvendorid/marchid/mimpid for the
> 'host' CPU type will be equal to what we already have for TCG named
> CPUs, i.e. the user is not able to set these values to a different val
> than the one that is already preset.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 37f0f70794..cd2974c663 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -378,6 +378,22 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>      if (ret != 0) {
>          error_report("Unable to retrieve mvendorid from host, error %d", ret);
>      }
> +
> +    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                              KVM_REG_RISCV_CONFIG_REG(marchid));
> +    reg.addr = (uint64_t)&cpu->cfg.marchid;
> +    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret != 0) {
> +        error_report("Unable to retrieve marchid from host, error %d", ret);
> +    }
> +
> +    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                              KVM_REG_RISCV_CONFIG_REG(mimpid));
> +    reg.addr = (uint64_t)&cpu->cfg.mimpid;
> +    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret != 0) {
> +        error_report("Unable to retrieve mimpid from host, error %d", ret);
> +    }
>  }
>  
>  void kvm_riscv_init_user_properties(Object *cpu_obj)
> -- 
> 2.40.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

