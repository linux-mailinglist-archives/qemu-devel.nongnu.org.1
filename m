Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF28148D7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 14:15:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE81M-00082e-O1; Fri, 15 Dec 2023 08:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rE81H-00081r-VU
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:14:24 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rE81F-0002Zv-5B
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:14:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3365705d38eso260495f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702646059; x=1703250859; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3xM8gi7Q1tfzcmJoPgts1To6fIyuOXnBtgbiPgpx17A=;
 b=Pz+R8F+9XYzZDCTl540Y6Vps9Kof1hdcQopw26tomedbDuY1OgStDgW29X1B5Q6Y8f
 1jCuB8ZqHW9deKoGN8+tu0C9n0eAbopUUgjZZ1vbXCb0m2rgHKu5GgjzTsG0xJxuQJ+r
 HFod5oWtvR5k2nKqBs3ZOhtGIoPxrYdoO1Xw4KsyClIQ3F6WLq70Ksog0ePjNtWfYnPY
 3onlYl4zwa/bCk5VnnV+dIsSeyNLQK6kCZYsrRIO79q4bRiY/tzMF7iPeNJnb03BXdNA
 HjeG79ice/RxFp88UAoLEPSphPhENmdU/iSYNRP1xe1JP+iZBR6+apDd9qRDkr8sn07G
 8Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702646059; x=1703250859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xM8gi7Q1tfzcmJoPgts1To6fIyuOXnBtgbiPgpx17A=;
 b=oKUPgQCHAV92uKz8iU5vRVCiawbPhUvMU9YRbab6vBcCWkCI4jORVr+I4DiKO5/rZr
 L3dbJ/MC2SirD14bQNiEv936QvFAMU+wr++Nl2VtE/Zj2jO0SwakY+/Ien+0MNpcYBT0
 pvbXhjmx/XsLR2HIUZfp9tR3Z/Ja3dwJ+7RHXu+Aymz9CL1y4L8izhDhPA3USdKFazaW
 PeNCJzkrizJJeXBYGdbbu0JVXkzBaE7fBvQurfODeeAk8zNfx1IEjmoJ5DEIZfxYEQsD
 cZN4PI2Rca/lKBvU7IyIuqX+yBkEQtRnC3DDOICyFS72IvJ8hBBQptXpqu6lMtorRrDG
 mtVQ==
X-Gm-Message-State: AOJu0Yxc9KFUzk2gx2GC8QncaigNB5Brmz7iEKXYeGYPM1Fzxwqqm+EL
 ASbH5koHP1YtHYOILZn7cMr5ZA==
X-Google-Smtp-Source: AGHT+IGXRowltAyWulANpxVxEDn2sY5XCSxnkfOYIm+f3lQClC2NpX6uQ+qGafHc3Oxlr9v5jTZ+HA==
X-Received: by 2002:a05:6000:4e8:b0:332:fe7e:2a36 with SMTP id
 cr8-20020a05600004e800b00332fe7e2a36mr4017094wrb.30.1702646059544; 
 Fri, 15 Dec 2023 05:14:19 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 f10-20020adff8ca000000b003365951cef9sm487520wrq.55.2023.12.15.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:14:19 -0800 (PST)
Date: Fri, 15 Dec 2023 14:14:17 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 3/5] target/riscv/kvm: change timer regs size to
 u64
Message-ID: <20231215-3b911ad3431253fb4182b349@orel>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
 <20231208183835.2411523-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208183835.2411523-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x436.google.com
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

On Fri, Dec 08, 2023 at 03:38:33PM -0300, Daniel Henrique Barboza wrote:
> KVM_REG_RISCV_TIMER regs are always u64 according to the KVM API, but at
> this moment we'll return u32 regs if we're running a RISCV32 target.
> 
> Use the kvm_riscv_reg_id_u64() helper in RISCV_TIMER_REG() to fix it.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 34ed82ebe5..476e5d4b3d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -88,7 +88,7 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
>  #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
>                   KVM_REG_RISCV_CSR_REG(name))
>  
> -#define RISCV_TIMER_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_TIMER, \
> +#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
>                   KVM_REG_RISCV_TIMER_REG(name))
>  
>  #define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
> @@ -111,17 +111,17 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
>          } \
>      } while (0)
>  
> -#define KVM_RISCV_GET_TIMER(cs, env, name, reg) \
> +#define KVM_RISCV_GET_TIMER(cs, name, reg) \
>      do { \
> -        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
> +        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
>          if (ret) { \
>              abort(); \
>          } \
>      } while (0)
>  
> -#define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
> +#define KVM_RISCV_SET_TIMER(cs, name, reg) \
>      do { \
> -        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
> +        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
>          if (ret) { \
>              abort(); \
>          } \
> @@ -649,10 +649,10 @@ static void kvm_riscv_get_regs_timer(CPUState *cs)
>          return;
>      }
>  
> -    KVM_RISCV_GET_TIMER(cs, env, time, env->kvm_timer_time);
> -    KVM_RISCV_GET_TIMER(cs, env, compare, env->kvm_timer_compare);
> -    KVM_RISCV_GET_TIMER(cs, env, state, env->kvm_timer_state);
> -    KVM_RISCV_GET_TIMER(cs, env, frequency, env->kvm_timer_frequency);
> +    KVM_RISCV_GET_TIMER(cs, time, env->kvm_timer_time);
> +    KVM_RISCV_GET_TIMER(cs, compare, env->kvm_timer_compare);
> +    KVM_RISCV_GET_TIMER(cs, state, env->kvm_timer_state);
> +    KVM_RISCV_GET_TIMER(cs, frequency, env->kvm_timer_frequency);
>  
>      env->kvm_timer_dirty = true;
>  }
> @@ -666,8 +666,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>          return;
>      }
>  
> -    KVM_RISCV_SET_TIMER(cs, env, time, env->kvm_timer_time);
> -    KVM_RISCV_SET_TIMER(cs, env, compare, env->kvm_timer_compare);
> +    KVM_RISCV_SET_TIMER(cs, time, env->kvm_timer_time);
> +    KVM_RISCV_SET_TIMER(cs, compare, env->kvm_timer_compare);
>  
>      /*
>       * To set register of RISCV_TIMER_REG(state) will occur a error from KVM
> @@ -676,7 +676,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>       * TODO If KVM changes, adapt here.
>       */
>      if (env->kvm_timer_state) {
> -        KVM_RISCV_SET_TIMER(cs, env, state, env->kvm_timer_state);
> +        KVM_RISCV_SET_TIMER(cs, state, env->kvm_timer_state);
>      }
>  
>      /*
> @@ -685,7 +685,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>       * during the migration.
>       */
>      if (migration_is_running(migrate_get_current()->state)) {
> -        KVM_RISCV_GET_TIMER(cs, env, frequency, reg);
> +        KVM_RISCV_GET_TIMER(cs, frequency, reg);
>          if (reg != env->kvm_timer_frequency) {
>              error_report("Dst Hosts timer frequency != Src Hosts");
>          }
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

