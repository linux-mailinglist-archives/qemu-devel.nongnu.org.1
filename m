Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3A78D66E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLz4-00061e-Md; Wed, 30 Aug 2023 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLz3-000617-2r
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:15:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLz0-0008QB-TE
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:15:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf7423ef3eso34938675ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693404945; x=1694009745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nmgPBm+n8NTcNdco4ZK1DFuejCH+ncgpQ440jge4l/8=;
 b=vX4QS9d0tH0BApt8MDeffWgOzE5TS5GffcC6/cHCBQMQJ8FfeRzkRPvafNwimgAH63
 Xx8XodQeT5BU4OdcoqnN7NfpR9T0E+pEj22N8TrGWXoLAHSN51h37dQ/2iHd0WR7VIq/
 DNGMdJexSMtB73o6kUkKxKZlpy7DSLL/9JWuPVSRqHpZVfTM4COE9mlyMMtUgkfOVvsD
 /FdeshtsP4Rwp0mrvLmi4GIYrtsqd1Jy6ZOy3uVUnKB+MUoeRozCaqPBthDh3ZoFkijn
 IeUIJSieBgjvpnfIAcFBGnIzxCDQHBKnxGKBwSmyIB6X5cDyxHn59O7bRxe2s+8LR3qV
 vhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693404945; x=1694009745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nmgPBm+n8NTcNdco4ZK1DFuejCH+ncgpQ440jge4l/8=;
 b=j0SBEjl57cq0mSfn0EyBzL0zQV31EVSgpTUH/EN5xpIfapcLnBulUtuWAu0v9mJOIT
 wc3Js3EnyD85hLsVVlu4ZloeugjNgapDWPKaCOoJ1qzkudgzEBOxlz3JmpydV4g+ITLE
 t/Oe298hHX+SRwmdVDqhek6WYVwRxek2K+AoMUFXk/J1hoKFcMSbOfLz28yUL/yc2ljo
 b0iszhrY8S5mlGXFmcbhc9pZjOm0Wy5FvCNGf83aSdBcd/iMDLGPCn1F1znTJQmrUbWx
 i3BoAKjrRwTNRykKMg9cBijVP6k6YF0ksslo6ftdekis019Ghvzob6bv5CYxzTVEKilQ
 ZHHg==
X-Gm-Message-State: AOJu0YxA9fR8VMuo3tNaQ9yOuKdzH1JEcTf/VFYMZpfwRkvXMq6nANYo
 UQgR2NP2nzvdv/KKh9qExuyy9w==
X-Google-Smtp-Source: AGHT+IFXYbL2J5qOiYFaVmwUVjc+0gfMVvYVKzeSm7IXQfDUN5JbaJQ+CBTEHTZlDSqUQFq/1n/FyQ==
X-Received: by 2002:a17:903:41d1:b0:1af:aafb:64c8 with SMTP id
 u17-20020a17090341d100b001afaafb64c8mr2534195ple.21.1693404945316; 
 Wed, 30 Aug 2023 07:15:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001ba066c589dsm6686414pld.137.2023.08.30.07.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:15:44 -0700 (PDT)
Message-ID: <03884391-7990-6105-fb59-c66566b05c9e@linaro.org>
Date: Wed, 30 Aug 2023 07:15:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-2-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830133503.711138-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 06:35, Daniel Henrique Barboza wrote:
> A build with --enable-debug and without KVM will fail as follows:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
> ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
> 
> This happens because the code block with "if virt_use_kvm_aia(s)" isn't
> being ignored by the debug build, resulting in an undefined reference to
> a KVM only function.
> 
> Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
> make the compiler crop the kvm_riscv_aia_create() call entirely from a
> non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
> virt_use_kvm_aia() won't fix the build because this function would need
> to be inlined multiple times to make the compiler zero out the entire
> block.
> 
> While we're at it, use kvm_enabled() in all instances where
> virt_use_kvm_aia() is checked to allow the compiler to elide these other
> kvm-only instances as well.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

