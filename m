Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6878ED98
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbh6w-00088Q-Oj; Thu, 31 Aug 2023 08:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbh6g-0007zh-Cy
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:49:08 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbh6e-0002VH-3x
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:49:06 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcfd3220d3so13471941fa.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486142; x=1694090942; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5+gTtKRnVEIja1xBtveYgsqQRdKygOna8UIiM8z144k=;
 b=ZHTk0rsdHxYwUl1H47v3PTgVn8DDBWd1/IP+poQ6y5otThK6f1DdYlNktTcWFyyIu1
 7kmRDkEV/f5oa94l2S8WEae3HAbX+tpl8N14HCRYE6+9c8IdJEwE1TqX3qT3A9PigpIJ
 W7QSvBpzDdcl6yrFhpke/Ti98PTRmGqUG4QIgGI8PqnoiK71O912bEHa6boVg11BnSUr
 PgBaDRlg/yXjkBSoszPgbBnWbV+t9dbZ0DDREbkRA4MHaAWY9JkDnLPyk2TVsAqxwZlH
 BuOTRy6Vf3E2FxR1pWHj2GYDITeWUC/upVjnWOecolVkuQgjLwGmAEuT5qR0fAy9y8kr
 ZaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486142; x=1694090942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+gTtKRnVEIja1xBtveYgsqQRdKygOna8UIiM8z144k=;
 b=e9Yxyn1MgZCqPs8+SzYAtYhXJSOMkGlajXHW3SZMLGKHVkhgWW6Nk41yBazT873fr4
 3homBBrllD8zU06Gx67GLoaTp8IEvz6ow1tkkVJ2mgd1iy1pbR5Y2e2ZyUIyIj1K9X9z
 j/ziHSj6mHwaKLO/JwAtQN/8ceGW65O1pLouPrp7GiE2VvMfrJf7hFUGb/gYrQMm9pFO
 MKFVLuhzVLmcRoAW8WB0Fy9dVJJcGk2CrJBCVJO1b5E4R3+btqhOCCbnp6BdoFx1/pJF
 4/6BbUh8f4qZvByFzbObbRrlps+Kvv1M9jORxpNEfl1OnmekUa13kKOmlz7CrdNMY9ce
 5LBQ==
X-Gm-Message-State: AOJu0YyjA5sayCzEF3aaFezCflXZDtHgSeeyQIt0CJdHJbCJtyl2qa/a
 KjzP9TwfxadRJ0Rup0i6kaCNuw==
X-Google-Smtp-Source: AGHT+IHRE4zcCBGfSy6QljO7XRkC8Xw5r26dEk8yZOIRNRgFCoVIDiQKnk0odYUzt79Iddk5qpcWaA==
X-Received: by 2002:a2e:9995:0:b0:2bc:dba0:60f9 with SMTP id
 w21-20020a2e9995000000b002bcdba060f9mr4179326lji.44.1693486141789; 
 Thu, 31 Aug 2023 05:49:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 dk24-20020a170906f0d800b00992d0de8762sm723518ejb.216.2023.08.31.05.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:49:01 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:49:00 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 01/20] target/riscv/cpu.c: split CPU options
 from riscv_cpu_extensions[]
Message-ID: <20230831-1bdbe4d2afbc10dd26f1892f@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 24, 2023 at 07:14:21PM -0300, Daniel Henrique Barboza wrote:
> We'll add a new CPU type that will enable a considerable amount of
> extensions. To make it easier for us we'll do a few cleanups in our
> existing riscv_cpu_extensions[] array.
> 
> Start by splitting all CPU non-boolean options from it. Create a new
> riscv_cpu_options[] array for them. Add all these properties in
> riscv_cpu_add_user_properties() as it is already being done today.
> 
> 'mmu' and 'pmp' aren't really extensions in the usual way we think about
> RISC-V extensions. These are closer to CPU features/options, so move
> both to riscv_cpu_options[] too. In the near future we'll need to match
> all extensions with all entries in isa_edata_arr[], and so it happens
> that both 'mmu' and 'pmp' do not have a riscv,isa string (thus, no priv
> spec version restriction). This further emphasizes the point that these
> are more a CPU option than an extension.
> 
> No functional changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

