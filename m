Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62259742306
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:15:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnjU-00086g-JH; Thu, 29 Jun 2023 05:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEnjP-00086Q-H5
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:14:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEnjN-0002Vu-TU
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:14:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313e12db357so591695f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688030064; x=1690622064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1RsHEKD0FMHmmficSNBtEH2hMgEMXNCvY9J4MXFDthE=;
 b=ZD7SOGitxWs2Bd5Pf55b5tXMXRIIXZML3hwV4WXRE8I0PSnwDuErIz59tpO1Go6zUC
 Fdjs2oK1axWTl3mckUDN8vRLQ9a5Aq8QdTTR+sb1T0YE/vv4rj/jHgUWFHnsO9ArLyvQ
 8kpFWe8sxnrG6EFbuf7yOOh97rf+AZoMPpSmp4RdxQb9TgONAWo94BYlU2+atxS/7JOi
 rFXWeRnZaF4ZO9cmtYtmUmNmm2gx5Nw+kfXaR7s1O4ommjafSZTeEP1fMeobyX29MkAu
 3op1Jv0mn013knT6WwfHu6+sT9LayUyZqU+EEPwo1JcUQuTwuac0r/jOGfmFY3CEtpWJ
 DaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688030064; x=1690622064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RsHEKD0FMHmmficSNBtEH2hMgEMXNCvY9J4MXFDthE=;
 b=l5TmUn+OY0zhfL6kXaWGHv5UPvWei26+SnJSGporIE2MdlB8kvqxkGXF2wqp8M7KcQ
 KbLmRbJmuFZmkxfUX75Eqq0scClgfcU/7/k/b0pBBGl9Spe0V3ftCDeXVTwlum8Fd3lw
 OV7oIDh4kmZQbr9o1AVTNZnpZxII93gLDj7xA5ofSljQ9B4h0AqlW1J8k2IrQBAVs6Hw
 5+SQdlC6Kl+/skFndK4N/xABxyCuBjkEt00QZsH4wWljs7rYJrJlQAKGnTD4E/v/3f1x
 kK9Rx+gyroTbawsNaWH+PHIhRKOV5tmVVhtYUMyDmNj+xSHSz5fD6jIj3u1Z0FdJ8Y0Z
 FtnA==
X-Gm-Message-State: AC+VfDzTw8/qYWxgSeQNZGJhDamMb/Uk1k7SaFEsw9yj5pseEaWHqe1r
 XDcRLFzfoA5AJNO4wn6JUA+wPg==
X-Google-Smtp-Source: ACHHUZ5my7dOKDHBU7XnEMk4Jug3nv+vc+HAhwRz0Q9v2n5TzWHTte6fozsd+VIAI0xgrp9hYk8evA==
X-Received: by 2002:a5d:608f:0:b0:313:f157:7d58 with SMTP id
 w15-20020a5d608f000000b00313f1577d58mr12555615wrt.38.1688030064411; 
 Thu, 29 Jun 2023 02:14:24 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 s4-20020adfea84000000b002ca864b807csm15773153wrm.0.2023.06.29.02.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 02:14:23 -0700 (PDT)
Date: Thu, 29 Jun 2023 11:14:23 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org
Subject: Re: [PATCH v6 14/20] target/riscv/kvm.c: add multi-letter extension
 KVM properties
Message-ID: <20230629-d809b1d8514383d0eebc88ca@orel>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
 <20230628213033.170315-15-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628213033.170315-15-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42c.google.com
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

On Wed, Jun 28, 2023 at 06:30:27PM -0300, Daniel Henrique Barboza wrote:
> Let's add KVM user properties for the multi-letter extensions that KVM
> currently supports: zicbom, zicboz, zihintpause, zbb, ssaia, sstc,
> svinval and svpbmt.
> 
> As with MISA extensions, we're using the KVMCPUConfig type to hold
> information about the state of each extension. However, multi-letter
> extensions have more cases to cover than MISA extensions, so we're
> adding an extra 'supported' flag as well. This flag will reflect if a
> given extension is supported by KVM, i.e. KVM knows how to handle it.
> This is determined during KVM extension discovery in
> kvm_riscv_init_multiext_cfg(), where we test for EINVAL errors. Any
> other error different from EINVAL will cause an abort.
> 
> The use of the 'user_set' is similar to what we already do with MISA
> extensions: the flag set only if the user is changing the extension
> state.
> 
> The 'supported' flag will be used later on to make an exception for
> users that are disabling multi-letter extensions that are unknown to
> KVM.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c |   8 +++
>  target/riscv/kvm.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

