Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927207E6D04
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16hx-0000ii-Vv; Thu, 09 Nov 2023 10:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16hm-0000h9-Sm
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:12:27 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16hl-0007SO-8W
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:12:26 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso1542800a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542742; x=1700147542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BeA1OFZuU8Z+NBhkZJgXIZhb+kVnpN4xIzQlmJqZrnc=;
 b=Q1R+a/cg3Qx9KeeH894bPSWqYIsMBJJBaF4VTofIhAK8GHJKqmVhnA1B8R3gc+8QmX
 VRH6aH+omQq9FoZHSNz94BW9+uC6x7ZjLVClB+46+GsxpA4/6nzKYe8mBOz5AF0HJKgW
 OeU0C4zHFX/9QWBrHnajBCB5ULUYQalS/KIMMkR6vMOF2wGMuKzXW0aZ5xsrXa2/Zgtv
 VDIEBojCretR4qz/XDkkbodL2ucSAOVWnGIJ13lDOOulmn8tgByBNjqJ61fnWfwZq1Wo
 qBe3mSDVgfpVOXXf3ksGi26HcNI0+dhZQciM8w+wuwsa+lYDhe8GCsLJcnU8Fqh6FOf2
 0xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542742; x=1700147542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BeA1OFZuU8Z+NBhkZJgXIZhb+kVnpN4xIzQlmJqZrnc=;
 b=Cq6J/jnQ1oAePcC6kIjLSeGU4IXt15f7X18kkodnJAptrYkfddWx2ApL9v2xu60wC0
 YgKbXab8ORMqJbg7dWy/cUvb4FvifxJauiZIE6aBBuiIfg2GveJatymcxrx2Av3ubwsF
 QnDcx7vdL6ed1QyTh0WrvMU2NJa5d8MLuXYmlK5GbX0peXg1YV2xsUxsjZ4OUYYebhDf
 lhiIR46+USE1RcS5HpSNxrqWDfv+YRNgD01y3Ov5VTyHqnJcKIHvZlwY4EsjxVTQwPpn
 KbWmmHtPZQgV5ez9x+dEaoGNUnsxxuU1B8TGiQ9gMxMUAvFcWjNsAWBzriXepwFWpy8F
 O54Q==
X-Gm-Message-State: AOJu0Yw/KGpcXiCzppCpE1THj8Sj99kJ+YlaohHol939rqlhydwKo8uC
 juEl4Gc8XkzX51fY8l5lVpd9s/WxmmqNT/cWczIuqQ==
X-Google-Smtp-Source: AGHT+IEV4yRRd9p6Eb+zm7cZnzMZTmElLp5KzbrQ/yPdksl132XAgXkAoyiukSMdXxb7Qc/cP/n3saV/YYGavN8VGkA=
X-Received: by 2002:a50:9b5d:0:b0:53d:fe06:3bb2 with SMTP id
 a29-20020a509b5d000000b0053dfe063bb2mr5063332edj.8.1699542742232; Thu, 09 Nov
 2023 07:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107030407.8979-1-richard.henderson@linaro.org>
 <20231107030407.8979-76-richard.henderson@linaro.org>
In-Reply-To: <20231107030407.8979-76-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 15:12:10 +0000
Message-ID: <CAFEAcA8W8k8oPfwjG7ANf6iK6peYtbP4L-i+GGSQ7A1eTBpW9A@mail.gmail.com>
Subject: Re: [PULL 75/85] target/hppa: Add pa2.0 cpu local tlb flushes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 7 Nov 2023 at 03:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The previous decoding misnamed the bit it called "local".
> Other than the name, the implementation was correct for pa1.x.
> Rename this field to "tlbe".
>
> PA2.0 adds (a real) local bit to PxTLB, and also adds a range
> of pages to flush in GR[b].
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi; Coverity points out a potential overflow in this code:



> -/* Purge (Insn/Data) TLB.  This is explicitly page-based, and is
> -   synchronous across all processors.  */
> +/* Purge (Insn/Data) TLB. */
>  static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
>  {
>      CPUHPPAState *env = cpu_env(cpu);
> -    target_ulong addr = (target_ulong) data.target_ptr;
> +    vaddr start = data.target_ptr;
> +    vaddr end;
>
> -    hppa_flush_tlb_range(env, addr, addr);
> +    /*
> +     * PA2.0 allows a range of pages encoded into GR[b], which we have
> +     * copied into the bottom bits of the otherwise page-aligned address.
> +     * PA1.x will always provide zero here, for a single page flush.
> +     */
> +    end = start & 0xf;
> +    start &= TARGET_PAGE_MASK;
> +    end = TARGET_PAGE_SIZE << (2 * end);

Here 2 * end can be 30, but TARGET_PAGE_SIZE is only a 32-bit
type, so the shift might overflow. Cast TARGET_PAGE_SIZE to vaddr
before doing the shift? (CID 1523902)

> +    end = start + end - 1;
> +
> +    hppa_flush_tlb_range(env, start, end);
>  }

thanks
-- PMM

