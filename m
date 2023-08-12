Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D19779C38
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 03:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUdEp-00044C-MN; Fri, 11 Aug 2023 21:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUdEm-00043a-Hh
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 21:16:17 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUdEk-0007AI-PT
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 21:16:16 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a741f46fadso2259613b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691802973; x=1692407773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+8ZH8lQhU3zfjGHhWBbs/r0tIRN06isJ4o6TaLHN06s=;
 b=p2ATs3GW0NuuB18KWxQ5Fh0DPUwvfnpYpuUB9w8ZSBoSKq/rCPZrU90nBd1HPiPjSl
 v6w/5M3kGmDnDCrQ3l0lLPlS+dIB/R0hM0ZOwiLbpc1VzuRadYmXNCS3gu7t4XByd4Zl
 f6dtd3nyVlWzgg74li2z3ZfGqx7jBWIfEkcO9TVlv3R6d21+d2F3GGztcFKVSKU8Vf57
 bxbUFNGyQmzDzkn0deNgBKG4upPmJ7PeBKluXY2IzjQsLKO4sxHJJY3DlWpMttOsNbMG
 cWCdPQU6SFMPoCFoIZOLN5zC2NX5rFEQcYMZ9ZIxedNxtjeEF68hlCHp4y3Eg+24KH+J
 hDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691802973; x=1692407773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+8ZH8lQhU3zfjGHhWBbs/r0tIRN06isJ4o6TaLHN06s=;
 b=U2ZMjNuB648Q4vZPQJzhLrZt7YdoGmOxLSpy1Tg9ZIySwuLMZDiNhzZAdkUJFyrNn0
 NachUImWGUZa6eH1BJFcIo3gt+9G9v+wVqBRGLK3GqSu1gC9+QjN1XXbzfcYUVaFnlM8
 PT5ySOVAMO+2Zim8/lNhigLOb4/JD2P0iWGLQtVj7GPnZbulaluG4dOoDcmbwT78qFe9
 JuHyo4UfzjuphOThqriK6ms2ajgOYHVWK4Il+fh9txaFqFe1jfskDVJemmz0sbNARQO8
 GfoVyNMC4hse8Jdfq1t34bDlHEAmGA78HuOTgC7VKueRnH/h7VsIXppE5CPgn/x8r9v4
 kycw==
X-Gm-Message-State: AOJu0Yz5+h6uwrtT+va4Q9bjMbWzmncQuc84lom/+G2Py+OI08lsXo4X
 2qZMoJyah/3AGDjyK/C/2ZVV8g==
X-Google-Smtp-Source: AGHT+IEnp6HZ8Ls2n5I3DhX3A7PEEFtYmW8yzzxh4giMqvOMMad03nUUYEjxyAtf2aKl/DTtXKRBSg==
X-Received: by 2002:aca:674c:0:b0:3a7:b5ea:f5e8 with SMTP id
 b12-20020aca674c000000b003a7b5eaf5e8mr4029283oiy.27.1691802972826; 
 Fri, 11 Aug 2023 18:16:12 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a62e30c000000b006870814361bsm3913387pfh.114.2023.08.11.18.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 18:16:12 -0700 (PDT)
Message-ID: <94d64ad4-9358-0351-9780-e01680b4bd8f@linaro.org>
Date: Fri, 11 Aug 2023 18:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] riscv-to-apply queue
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20230811182445.1185140-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811182445.1185140-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 11:24, Alistair Francis wrote:
> The following changes since commit 3944e93af06f06eb07316e0bef46b007573e0309:
> 
>    Update version for v8.1.0-rc3 release (2023-08-10 12:49:56 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git  tags/pull-riscv-to-apply-20230811-3
> 
> for you to fetch changes up to b274c2388e9fcde75d60c6e7c7d8f888874b61b7:
> 
>    hw/riscv/virt.c: change 'aclint' TCG check (2023-08-11 14:16:26 -0400)
> 
> ----------------------------------------------------------------
> Sixth RISC-V PR for 8.1
> 
> This is a last minute PR for RISC-V.
> 
> The main goal is to fix
> https://gitlab.com/qemu-project/qemu/-/issues/1823
> which is a regression that means the aclint option
> cannot be enabled.
> 
> While we are here we also fixup KVM issue.
> 
>   * KVM: fix mvendorid size
>   * Fixup aclint check

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


