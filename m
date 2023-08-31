Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DE78EF3C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:06:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiIl-0002lX-LF; Thu, 31 Aug 2023 10:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiIi-0002kx-Un
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:05:36 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiIg-0000Yy-68
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:05:36 -0400
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-991c786369cso100479866b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693490733; x=1694095533; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PELuaiX3vV/mXIndActHRdN0VyKcLY9qfxPbe5lrsho=;
 b=c4ER3TBPCUAICcWNICCdc+0Wzrbj4L8TN2taNuL4i38wDch3jtyVce25rbJNC+btqv
 QEfcMQMVeywqgM+RC0Csk7x6+y7c/MMBkywDG8Lo6E5yN0U4ePkr0d6023VZDeqFeNDt
 2M7/aLbesCLrGCjwKnJMJJwIRKzT4GWRSsk/IgUAN0haTUWW6oeq6m3Q1EBlZWsoB436
 mUYhGChV8eR6i/LlMaVUYpCA1tYLwTu7rUNpNCiqGk+/xWKpsGUiLaitl0kp3gebm/3J
 3mgyu1s0vMtoJ9JsyT2apCbkOoc4ewqCKQuYqAKmig3l1bsQQWuEcemlkaBwD0NIvLO8
 1qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490733; x=1694095533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PELuaiX3vV/mXIndActHRdN0VyKcLY9qfxPbe5lrsho=;
 b=mDykeitk7rcmLg/cXP9FauIGHuieYuiA0r9baqk+cMU+Q6l1JDu424ZsHuhQaB+Dh9
 ATb/HxaA3yyoVlvPmBONCOUNDPTgRhDVUfV4b5AKT1hIwq5YWXFhKoqe7SI4QtsqEdII
 Uie5YynGl2YLeG489H/fZrLbAHEDfjpfNKa3T22Xv6FfTWErNgecmgpUi97i99SgzlVG
 X0cMuVZApPLLzSzd5yP7z2xXOcd3zbjzyDbBm6gfVW+EFBGWtwvMqlQJ7OjBLEc7Oryy
 SZ72upyXVRVRdr5Ge++YKcrK9EqpTT1l/GCjkonia5Dt8u7eknl1mJJZBX+QBLJdPKTi
 7njA==
X-Gm-Message-State: AOJu0YwyoKPFa7GHZjQysUrRa/9FzS1g78ERs4a6MzkujyuqWDXAAGR4
 gJRK7MDv9XWgs6oBfZiwHNiebQ==
X-Google-Smtp-Source: AGHT+IGcAoB+2PCH4z8yhEhEYXWB1DFCW6f8D1NaZSHLpSndCCzFbVlWVs+TI0oKGEhaTQtcqgGzGA==
X-Received: by 2002:a17:907:1dd3:b0:9a1:c221:4661 with SMTP id
 og19-20020a1709071dd300b009a1c2214661mr3555693ejc.0.1693490732728; 
 Thu, 31 Aug 2023 07:05:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 qq7-20020a17090720c700b00992afee724bsm791795ejb.76.2023.08.31.07.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:05:32 -0700 (PDT)
Date: Thu, 31 Aug 2023 16:05:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 00/20] riscv: 'max' CPU, detect user choice in
 TCG
Message-ID: <20230831-adf7386649250fe8c2af87c3@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x644.google.com
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

On Thu, Aug 24, 2023 at 07:14:20PM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> This is a resend of these two patch sets because they no longer apply
> into Alistair's riscv-to-apply.next:
> 
> [PATCH v8 00/12] riscv: add 'max' CPU, deprecate 'any'
> https://lore.kernel.org/qemu-riscv/20230815223741.433763-1-dbarboza@ventanamicro.com/
> 
> [PATCH v3 0/8] riscv: detecting user choice in TCG extensions
> https://lore.kernel.org/qemu-riscv/20230815224733.434682-1-dbarboza@ventanamicro.com/
> 
> 
> They're being sent in a single package for convenience. No other changes
> made from their old versions aside from the rebase.
> 
> Patches missing acks: 4,7,8
> 
> Changes from v7:
> - patch 7:
>   - add riscv_cpu_add_qdev_prop_array() function instead of a macro
> - patch 8:
>   - add riscv_cpu_add_kvm_unavail_prop_array() function instead of a
>     macro
> - v7 link: https://lore.kernel.org/qemu-riscv/20230815201559.398643-1-dbarboza@ventanamicro.com/
>

Tracking whether or not the user enabled/disabled an extension is good. I
see we're still not tracking for the MISA extensions, though. If tracking
isn't necessary for them, then a comment above
riscv_cpu_add_misa_properties()
explaining why not would be good. If tracking may be necessary, then
making them consistent with the multi extensions by using the hash would
be good.

Thanks,
drew

