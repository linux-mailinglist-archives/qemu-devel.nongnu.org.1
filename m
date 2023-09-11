Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F279A4F9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbfX-0002Xn-Do; Mon, 11 Sep 2023 03:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbfV-0002WG-Fr
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:49:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbfT-0007sz-0X
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:49:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401b5516104so43792255e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694418549; x=1695023349; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ur27qpYMxGprQKH6X1Uitl4vRydq9C1iObla+Kcao9I=;
 b=WOkymbxEsHB/8UtZkv0a3a4L6LS85vlqLHeHSlaEXZmwDrJ6xLSi0Bwe1qIcbFiV3p
 mQ9zPtNSjLd31H1xh8cJlqf51I6PzGLcel2yAgeQXH0iAfwrXWVk1WHTpmpxnb+bC9TT
 mSyct4dYgp7wmRVUQO1pFJEnbGYkFc4fybZT0yhdVki9mze49zRS9z6u2SO3/NouC13f
 cZGfhShq5O7WYzp4nIRCBXckxJJWYq4ENmfvs6I5SLz1wAsrXB6ABLyDsuZieh57wdYw
 ip1dlNWlCblC3ZRpPJVuVGOdRXIlUFB+SXHpWJAbfF57gSCNaIX4/N7IrhcZSUpYOGNp
 31Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694418549; x=1695023349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ur27qpYMxGprQKH6X1Uitl4vRydq9C1iObla+Kcao9I=;
 b=MAp9zU3wDdJ4ukf/vGw7Ky5K7WyRncZdvkcyQXJn4yTSbSrqllpHw9qu6G8kv7ZQi9
 DvuWfvL9jSAs/8ZBHAugsdZ0H0Vl2efEZRQ6oOS63BdJrIoDeS8wSao2p3r+vEMJTxC0
 xe7PMlBQQbe6pan7c/mUT3WvkKuCsV/qQI6u3pJtn8MjfLLql51FKRG2Dz08W9OIvQNT
 8SQgnW0EUEkfJfACZJ1KkHok54gMC/A2GHg5G47NdUl6TG6AMj8gqPxxyioVxMNgHbsH
 YzMJBFw3LJjrmlChlF3fEYpiLrwkXE4arjEecRzyyeV6+GkFMiYDyASY84FRwuEFGJbK
 kK8A==
X-Gm-Message-State: AOJu0Yy7Ha70hWTjoT4WOrqo8m47VxE3HnrRcmi61tN1+pB86zX6AgqS
 5cnDTHJbVemrsVUB9L8ZGu/Tng==
X-Google-Smtp-Source: AGHT+IHwVWiDI1iV7/6QwA0dILKhDTSKivF2Y0//zNoG5pPwE0ziuTYQwUEahgvp/DCsGAL0h5Hi5Q==
X-Received: by 2002:a05:600c:354d:b0:402:f500:fcee with SMTP id
 i13-20020a05600c354d00b00402f500fceemr7198192wmq.0.1694418547588; 
 Mon, 11 Sep 2023 00:49:07 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a05600c1c8d00b00402ff8d6086sm7043944wms.18.2023.09.11.00.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:49:07 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:49:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 10/19] target/riscv: remove kvm-stub.c
Message-ID: <20230911-0ff170da2e7063d0eb82ded9@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-11-dbarboza@ventanamicro.com>
 <f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
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

On Wed, Sep 06, 2023 at 12:23:19PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/9/23 11:16, Daniel Henrique Barboza wrote:
> > This file is not needed for some time now. All the stubs implemented in
> > it (kvm_riscv_reset_vcpu() and kvm_riscv_set_irq()) are wrapped in 'if
> > kvm_enabled()' blocks that the compiler will rip it out in non-KVM
> > builds.
> > 
> > We'll also add non-KVM stubs for all functions declared in kvm_riscv.h.
> > All stubs are implemented as g_asserted_not_reached(), meaning that we
> > won't support them in non-KVM builds. This is done by other kvm headers
> > like kvm_arm.h and kvm_ppc.h.
> 
> Aren't them also protected by kvm_enabled()? Otherwise shouldn't they?

Yes, I think your earlier suggestion that we always invoke kvm functions
from non-kvm files with a kvm_enabled() guard makes sense.

> 
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >   target/riscv/kvm-stub.c  | 30 ------------------------------
> >   target/riscv/kvm_riscv.h | 31 +++++++++++++++++++++++++++++++
> >   target/riscv/meson.build |  2 +-
> >   3 files changed, 32 insertions(+), 31 deletions(-)
> >   delete mode 100644 target/riscv/kvm-stub.c
> 
> 
> > diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> > index f6501e68e2..c9ecd9a967 100644
> > --- a/target/riscv/kvm_riscv.h
> > +++ b/target/riscv/kvm_riscv.h
> > @@ -19,6 +19,7 @@
> >   #ifndef QEMU_KVM_RISCV_H
> >   #define QEMU_KVM_RISCV_H
> > +#ifdef CONFIG_KVM
> >   void kvm_riscv_cpu_add_kvm_properties(Object *obj);
> 
> At a glance kvm_riscv_cpu_add_kvm_properties() is.
> Keep the prototype declared (before #ifdef CONFIG_KVM) is enough for the
> compiler to elide it.

Yes, when building without CONFIG_KVM enabled it's actually better to not
have the stubs, since the compiler will catch an unguarded kvm function
call (assuming the kvm function is defined in a file which is only built
with CONFIG_KVM).

Unfortunately we don't have anything to protect developers from forgetting
the kvm_enabled() guard when building a QEMU which supports both TCG and
KVM. We could try to remember to put 'assert(kvm_enabled())' at the start
of each of these types of functions. It looks like mips does that for a
couple functions.

Thanks,
drew

