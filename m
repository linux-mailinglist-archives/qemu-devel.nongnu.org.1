Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE40793F10
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtfu-000873-7K; Wed, 06 Sep 2023 10:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdtfr-00082n-MF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:38:31 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdtfo-0006O8-85
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:38:31 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c26bb27feeso2854478fac.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694011105; x=1694615905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbX0nONM8qgoPZvtAu/UDvzjCKl5Co97jKzyjqjp66Q=;
 b=R2EYM9uaD6149ZPBT5vq85XiIGojpGFRVzMFBlJXcQSj9ROXGjMU8uuBxNTc3o6m0G
 mxa7UP4X/Rqx6042MqPGti2Qnvbfh8uu+JRAmJ0560TFR9jFi8xDVt4vMACOuwFe+wxz
 xM8a0+7+Ftb5+/fKkzTqjhpfZ3k0iy9YiBrbXjkCmDJm859pH5bMaHbPy+BXNrJbpvab
 0sIdqDE18K5IPJWonA39c4bPMRvKJOWosqEPdDJE7jRTHuQxhOSZ6wjhfqy+N4RtdUcJ
 hg5mij8otD57Am+BVNfQRdpMxlAKXQ2kckyHMlzhFrSrO/okWLaCs19wqpj1kxazS6Yo
 sE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011105; x=1694615905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbX0nONM8qgoPZvtAu/UDvzjCKl5Co97jKzyjqjp66Q=;
 b=LyfjaH7CH6ZDkfxeiBJBAuqW7T5JFYnDwOmS7QenpFlRmqhwLmVL1Qk++VtQBVZZ1f
 tQIS54p29Q4A45VFU+lQhgauix7ryp3/uCSnMPdQQkEnMf1C7TiBFmt3JQ6E/78LyKns
 iSUPd2WWC5R7jM0cko7Y2VLTT3KH+Z97CHi7xoSGY5KppwmZro90pWReMD4HATJ0j8pe
 6bsZExwX8cdDwPFo0xdUIVzJ+xKMPcvomA3LzyTumNbWCXomQRPAHzqIwfUrA3A9VL5G
 8TU4DpLpXAY6jRCJ1inqEYt2/LX6QHlk56iierigoSwFUe1LrV+ipxQ+pF8t651JXmdu
 4ufQ==
X-Gm-Message-State: AOJu0Yz2j04OklIKtBcV0vlWuuAslaepPlPRMfB5+SUBRLdhOT56LfOC
 LrFKgDBXZhJxFQh9xMs77nW0dA==
X-Google-Smtp-Source: AGHT+IGrFcSco9bx5oGBD/apPv2xUGGUO3fmFg/X4/cvea40mMi8fnqyH1M84icBV4t2zwvzm7DAcg==
X-Received: by 2002:a05:6870:249d:b0:1b0:57f8:dab4 with SMTP id
 s29-20020a056870249d00b001b057f8dab4mr19183230oaq.24.1694011105369; 
 Wed, 06 Sep 2023 07:38:25 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a056870911400b001d1358a6435sm5858763oae.1.2023.09.06.07.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:38:24 -0700 (PDT)
Message-ID: <dfeec126-304f-c4a4-77fb-7bf0927dbd31@ventanamicro.com>
Date: Wed, 6 Sep 2023 11:38:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/6] target/riscv: Add RISC-V Virtual IRQs and IRQ
 filtering support
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 apatel@ventanamicro.com
References: <20230526162308.22892-1-rkanwal@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230526162308.22892-1-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hey,


What's the latest on this work? It seems that all patches are acked:

https://lore.kernel.org/qemu-riscv/20230526162308.22892-1-rkanwal@rivosinc.com/


It'll probably conflict with current Alistair's riscv-to-apply.next though, so
perhaps Rajnesh could gather the acks and send a rebased version.


Thanks,

Daniel


On 5/26/23 13:23, Rajnesh Kanwal wrote:
> This series adds M and HS-mode virtual interrupt and IRQ filtering support.
> This allows inserting virtual interrupts from M/HS-mode into S/VS-mode
> using mvien/hvien and mvip/hvip csrs. IRQ filtering is a use case of
> this change, i-e M-mode can stop delegating an interrupt to S-mode and
> instead enable it in MIE and receive those interrupts in M-mode and then
> selectively inject the interrupt using mvien and mvip.
>              
> Also, the spec doesn't mandate the interrupt to be actually supported
> in hardware. Which allows M/HS-mode to assert virtual interrupts to
> S/VS-mode that have no connection to any real interrupt events.
>               
> This is defined as part of the AIA specification [0], "5.3 Interrupt
> filtering and virtual interrupts for supervisor level" and "6.3.2 Virtual
> interrupts for VS level".
> 
> Most of the testing is done by hacking around OpenSBI and linux host.
> The changes for those can be found at [1] and [2].
> 
> It's my first touch on RISC-V qemu IRQ subsystem. Any feedback would
> be much appreciated.
> 
> The change can also be found on github [3].
> 
> TODO: This change doesn't support delegating virtual interrupts injected
> by M-mode to VS-mode by the Hypervisor. This is true for bits 13:63 only.
> 
> Thanks
> Rajnesh
> 
> [0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf
> [1]: https://github.com/rajnesh-kanwal/opensbi/tree/dev/rkanwal/irq_filter
> [2]: https://github.com/rajnesh-kanwal/linux/commits/dev/rkanwal/aia_irq_filter
> [3]: https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/riscv_irq_filter
> 
> v2:
>   * Move RISCV_EXCP_SEMIHOST to switch case and remove special handling.
>   * Fix linux-user build.
> 
> Rajnesh Kanwal (6):
>    target/riscv: Without H-mode mask all HS mode inturrupts in mie.
>    target/riscv: Check for async flag in case of RISCV_EXCP_SEMIHOST.
>    target/riscv: Set VS* bits to one in mideleg when H-Ext is enabled
>    target/riscv: Split interrupt logic from riscv_cpu_update_mip.
>    target/riscv: Add M-mode virtual interrupt and IRQ filtering support.
>    target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.
> 
>   target/riscv/cpu.c        |   9 +-
>   target/riscv/cpu.h        |  23 ++
>   target/riscv/cpu_bits.h   |   6 +
>   target/riscv/cpu_helper.c |  99 +++++---
>   target/riscv/csr.c        | 477 ++++++++++++++++++++++++++++++++++----
>   target/riscv/machine.c    |   6 +
>   6 files changed, 546 insertions(+), 74 deletions(-)
> 

