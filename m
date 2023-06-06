Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129272484C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Z0x-0000xG-Lw; Tue, 06 Jun 2023 11:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6Z0u-0000wX-B5
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:54:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6Z0s-0003u0-Ql
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:54:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so54831265e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686066865; x=1688658865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QD0B8F/hFYpCl/CMQBukCAYpFaWSfJME8PtsC3EXHKc=;
 b=M2DmzW8eqladMkHJTWA30eKtkcCxhShcTzAm/1VTW2alL38QpH+tOLBKGtu7I9Qd5h
 4XPkbWSSPRVxWJFjZrMdcYXd6OjeOIXP84bMyDEyQVEqgrIRS6C7aaoUM6oi5FfRAJOG
 zJOdmXMsBONMACbO8qLkaFrZ/jrAmUyEMLH0qEvchfF6jIL905DEK8UTft4lVoyGCrIy
 Sjd3GaBmdFh3qFjEZPxB0ShVBtVMgvb0rFrDeHdrttMUo6GZQ0aKfYc4y+cf0adbN+BH
 gMcC8GRtq5NZmBiYK5NxZguk7+43uNiMOFjH4Ve5dbHiaKCuyrzTzpvGEOZQgc5rb46+
 XXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066865; x=1688658865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QD0B8F/hFYpCl/CMQBukCAYpFaWSfJME8PtsC3EXHKc=;
 b=MXPUZ8rdzFVCggbXtxrVN8Wck1CfGxF3KevKQ9uLju2r2AKNzFrlfyE6uNCd8/Buel
 xUpYKLz5+eOkxj+4K505ZDBqLjyPJyOKnS+1Xh2wmLDiImSWiXpkj+BM5//6XVnYyYKE
 4E3vq48xsbbZN02XXLPvZtECl2t+w3LPd1FcVR8Hzi4BDrSpYULbnhAckUJ1i1eCeIk7
 8NktDL1AI0FZz7iFRVEoPUu5JEyu9cCBJou6ofzR+dccMYW4+kxLz1eiUKG5oz0fCs5x
 U4ZIvJAtTkpHOZ+K9cbKB8z2KR9JBHcj5yArmipMi2dS4zZMAY5d2hHCZLusHDlGL7GX
 E7Sg==
X-Gm-Message-State: AC+VfDx3y3X41dRr+cdSj/0TResUPNCe/1CyBKsFybwiYci0fjJ6Lu5F
 ZueKtOzVg7eSbvUZKsLyGBdOag==
X-Google-Smtp-Source: ACHHUZ6o8J/K5YJvHijru+TJTG8zEwYLKrNNKZQjabJYQ1SGNkMKAO1V4CTRrFvNWvMDbhAenBeIrg==
X-Received: by 2002:a05:600c:220e:b0:3f7:3673:5429 with SMTP id
 z14-20020a05600c220e00b003f736735429mr2310097wml.2.1686066865320; 
 Tue, 06 Jun 2023 08:54:25 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003f182a10106sm14453188wmj.8.2023.06.06.08.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:54:24 -0700 (PDT)
Date: Tue, 6 Jun 2023 17:54:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 10/16] target/riscv/kvm.c: init 'misa_ext_mask' with
 scratch CPU
Message-ID: <20230606-6b0d5ce5cacc7e9190eeb39a@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-11-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-11-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32e.google.com
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

On Tue, May 30, 2023 at 04:46:17PM -0300, Daniel Henrique Barboza wrote:
> At this moment we're retrieving env->misa_ext during
> kvm_arch_init_cpu(), leaving env->misa_ext_mask behind.
> 
> We want to set env->misa_ext_mask, and we want to set it as early as
> possible. The reason is that we're going to use it in the validation
> process of the KVM MISA properties we're going to add next. Setting it
> during arch_init_cpu() is too late for user validation.
> 
> Move the code to a new helper that is going to be called during init()
> time, via kvm_riscv_init_user_properties(), like we're already doing for
> the machine ID properties. Set both misa_ext and misa_ext_mask to the
> same value retrieved by the 'isa' config reg.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

