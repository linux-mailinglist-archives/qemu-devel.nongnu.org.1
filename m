Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B2727BB5
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CBJ-0002jR-Bt; Thu, 08 Jun 2023 05:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q7CBG-0002iN-Kz
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:43:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q7CBE-0003QQ-Kt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:43:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so416562f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686217422; x=1688809422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MijNI4hAhZ4cu4jN5sF6esq4LAL6ym5TlUGtpT8RyC0=;
 b=VQQd+mgbdaWnIl3WHt3JP258Bh88lKlJaS8sakFYNQkmvN1ILsByBOPxS/g/5Xn00V
 0gqIOZ20lxrwHRII5Ct69NsP+fJ/bxt10uPN7Lgo/ZxUeAvfHQTcVWbRmISPFPywNDD9
 tWlk5u7gwiR6HN+QadOMXg2KGqZ0/cKNtRDkq+BKtCoU1wvpI16yMUyUJssT9PyWijvx
 DrjidbqeR5GyBwg3EOwo54ku4121sHzDgUYYms2HlQdGrdvurua0rX7m73meTtRexP/B
 6XNeLjIM4513ijymt1ijUWuQVghROhup+Ha1WYN4EC2l9qabp/BcnC1ls9KiiHXxXvjo
 RLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686217422; x=1688809422;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MijNI4hAhZ4cu4jN5sF6esq4LAL6ym5TlUGtpT8RyC0=;
 b=CJpYqXB5fTbcntbozDWuIgULgzVr1X+xGvNlMQ+Xxo11We+CyPM/iADtbGNzWFws4f
 7ID+mVMqF9WPCzYzdSzyBW2Z775SXyQcfJYnwj5bCtRc7q2FQ1Poh94jyOSetGXpjueP
 QNPn5aeQuXq3AdQl2zTiR/SC7RHQWkr2URO0vo9djwOTUNOQszIasKSn5UHf5r96bDRI
 K4Q0eoZAAPAAY4tsK92GP5wUVcIXcWTLwj5XBXcE6PzBY/Zao9cvt5Z1E+EqxVJnx71T
 3AN0NiEFQrz5F00JjA3KAJrLmvf5Smzaq/X2fnjirH52gbk5sdhiUcPbp50d24UMlbZP
 eCiA==
X-Gm-Message-State: AC+VfDyflXPj2tiJKQZ8aq3ziofBzrwqp5h6rcvxqnHy8LbIUwsZfZCW
 48u5lfe5W0aX6WrlW/5XJ7lnKA==
X-Google-Smtp-Source: ACHHUZ55pJlAsWQAgxRsQysryuVBUp+mS9znJneEJVMrPzLoXnH8/Pv974bbzcnxZJtMDdMjfjyZlQ==
X-Received: by 2002:adf:e58a:0:b0:30e:4266:14a4 with SMTP id
 l10-20020adfe58a000000b0030e426614a4mr6850937wrm.37.1686217421946; 
 Thu, 08 Jun 2023 02:43:41 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 m12-20020adfe0cc000000b003078681a1e8sm1056052wri.54.2023.06.08.02.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:43:41 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:43:34 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 richard.henderson@linaro.org
Subject: Re: [PATCH v4 0/4] target/riscv: Add Smrnmi support.
Message-ID: <20230608-01a21738d16a20808eceb795@orel>
References: <20230608072314.3561109-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608072314.3561109-1-tommy.wu@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42e.google.com
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

On Thu, Jun 08, 2023 at 12:23:10AM -0700, Tommy Wu wrote:
> This patchset added support for Smrnmi Extension in RISC-V.
> 
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
> 
> =============================================================
>   * mnscratch (0x740)
>   * mnepc     (0x741)
>   * mncause   (0x742)
>   * mnstatus  (0x744)
> =============================================================
>   * mnret: To return from RNMI interrupt/exception handler.
> =============================================================
> 
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
> 
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
> 
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.

Is there an M-mode software PoC for this with implemented handlers?

Thanks,
drew

> 
> Changelog:
> 
> v4 
> * Fix some coding style issues.
> ( Thank Daniel for the suggestions. )
> 
> v3
> * Update to the newest version of Smrnmi extension specification.
> 
> v2
>   * split up the series into more commits for convenience of review.
>   * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
> 
> Tommy Wu (4):
>   target/riscv: Add Smrnmi cpu extension.
>   target/riscv: Add Smrnmi CSRs.
>   target/riscv: Handle Smrnmi interrupt and exception.
>   target/riscv: Add Smrnmi mnret instruction.
> 
>  hw/riscv/riscv_hart.c                         | 21 +++++
>  include/hw/riscv/riscv_hart.h                 |  4 +
>  target/riscv/cpu.c                            | 18 ++++
>  target/riscv/cpu.h                            | 11 +++
>  target/riscv/cpu_bits.h                       | 23 ++++++
>  target/riscv/cpu_helper.c                     | 81 ++++++++++++++++--
>  target/riscv/csr.c                            | 82 +++++++++++++++++++
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 +
>  .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
>  target/riscv/op_helper.c                      | 49 +++++++++++
>  11 files changed, 300 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.1
> 
> 

