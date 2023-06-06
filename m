Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CDE724826
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YtJ-0004J4-TG; Tue, 06 Jun 2023 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YtE-0004Ht-EL
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:46:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YtA-0002F0-PJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:46:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-97454836448so822560166b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686066386; x=1688658386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PMykGFw7YgKpaICUOC8LdD6f5V7SJPXiGqPbwi/MV58=;
 b=cFdXHXHN1Il1tXPy72erVfWWC6HQBEInNyNAXuG0Dk3K8tHfiyWwWycVn1Z7etnotU
 LAJwUGmB2z8i3rG1NIpP7n0OQfasAVHtw8/HKe1x6002XuBkY+zAoof1CS1fLQKA5oPX
 DgnULjhrOxWkc3tue2hwbzj58JP1uVUIRyUq+WW+Eg3HI4vX8ZEkM3U8hGqVxYz8P9MK
 00cLo4PozNCBqvGIVSFQq+IGeG8Cj/ciZFoHC51L0AUdJYVj3KzU8VcV/JjW6FYnjhay
 m89qBQw1YCYH+rxgB640FGRETm55zH1k5Z2D1LzPmtYl5w58kLBIEJGhPUOQlcpxvkta
 qNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066386; x=1688658386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMykGFw7YgKpaICUOC8LdD6f5V7SJPXiGqPbwi/MV58=;
 b=IkaHLZb8KGjYm6307Zc2yv39XM/MwRQ1S5Pow1t/xJ5I8+BXb3btfiWg6mZRGsLRO9
 A/6YilEB35wVXBjLUmx859MH2RwuTSCojHWmNqjWbHOFK1L+MmUz9Q7Q87exvuei7Fyj
 Wh515a9iKBMh1admF9B2b1G0Csz7CIJDTu2K6KY5uHQ24AQEeIAsPZzFaRghebNzOt6k
 YBjTn5YajG2teiu3kYTNz4nQkss087DTb8fpB4lCFgpA27ITYNG1INiyWocF/SUGoO23
 kuXdlFsVsSzzQsDGUtCAQCzGWwVFcLYHhHQ99AlL+LaBsQ5mqnQkJpRY3ccCy5+1nuN9
 SxTA==
X-Gm-Message-State: AC+VfDxrIxUiHhc8DlUiK2ZL0e+jJjCRmbWkn+tr3KDhqTwWlRnf2o1R
 FhsRocFb9tT3UTGpOcJd07Pdwdlh2WDSJN7/QYs=
X-Google-Smtp-Source: ACHHUZ4nxExFuAZqzxPtF85VRaF6nv3xjfrpSzmKgkuqgWa7c4T4ckmZwN7pgHvxxjXQe/zedyFaVw==
X-Received: by 2002:a17:907:1606:b0:94a:7b2c:205e with SMTP id
 hb6-20020a170907160600b0094a7b2c205emr2444986ejc.72.1686066386549; 
 Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 fx12-20020a170906b74c00b0094ebc041e20sm5705316ejb.46.2023.06.06.08.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Date: Tue, 6 Jun 2023 17:46:25 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 06/16] target/riscv: use KVM scratch CPUs to init KVM
 properties
Message-ID: <20230606-87a03bf04af265ce7070f168@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62f.google.com
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

On Tue, May 30, 2023 at 04:46:13PM -0300, Daniel Henrique Barboza wrote:
> Certain validations, such as the validations done for the machine IDs
> (mvendorid/marchid/mimpid), are done before starting the CPU.
> Non-dynamic (named) CPUs tries to match user input with a preset
> default. As it is today we can't prefetch a KVM default for these cases
> because we're only able to read/write KVM regs after the vcpu is
> spinning.
> 
> Our target/arm friends use a concept called "scratch CPU", which
> consists of creating a vcpu for doing queries and validations and so on,
> which is discarded shortly after use [1]. This is a suitable solution
> for what we need so let's implement it in target/riscv as well.
> 
> kvm_riscv_init_machine_ids() will be used to do any pre-launch setup for
> KVM CPUs, via riscv_cpu_add_user_properties(). The function will create
> a KVM scratch CPU, fetch KVM regs that work as default values for user
> properties, and then discard the scratch CPU afterwards.
> 
> We're starting by initializing 'mvendorid'. This concept will be used to
> init other KVM specific properties in the next patches as well.
> 
> [1] target/arm/kvm.c, kvm_arm_create_scratch_host_vcpu()
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c       |  4 ++
>  target/riscv/kvm.c       | 85 ++++++++++++++++++++++++++++++++++++++++
>  target/riscv/kvm_riscv.h |  1 +
>  3 files changed, 90 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

