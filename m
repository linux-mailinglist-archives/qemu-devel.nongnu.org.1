Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6879A68E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfcqK-0002R9-Fd; Mon, 11 Sep 2023 05:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfcqG-0002Qo-Mm
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:04:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfcqE-0005Rq-Ak
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:04:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so48687205e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694423059; x=1695027859; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AdHBJPi6PKEA5yC99M0E0h+RXGmc4sklzolg6FGJ4Gs=;
 b=YWeYR089u/krji2rPMUeMFh4GzF7es7sLkD7QBOiTJaHhkCMxUQ28hZAryhIYVPlpe
 d0CkJXrTt/W1fKwY4aiExuQDHfUjwDb5jL2/B+qbMaWvotwnO4GXA+Ywyeqqp9+PV1gZ
 szUjcLHq64OzRdg+y0X6+y7d6PoLwDYXxbTqXgN7HE8lDTVRCmhhc3sOZy/dvXl1SJLT
 Yc73kGxB0k2QxPD9IpaeUoli7TmqqIn/QaxXao9oTkXnz/n8mq1dyVF0hvT40Vmq0qjw
 bB+0bUMMXM94RfFwOIyI4/hhXddHXa4odNe2VU+HNXnpH1hu3WkJ/WWmkp3kiBA6mu7L
 EjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694423059; x=1695027859;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AdHBJPi6PKEA5yC99M0E0h+RXGmc4sklzolg6FGJ4Gs=;
 b=vPY/0QonEWMIxb4MKYEn5gZUBzX4j3JhQ8ENzrI0DgVs04Ysra4Zz3ERS/VXwmkPmX
 2ZUbyDjaqsECEKmcddHS4OZFNfsztkddNG9t+8drbb2hHExlELYwuoQKm2t3xPxHeRW9
 oP112pl/3VHcquwQY/4vkbqTKuLT18kBbbpCLdByEaeeTRJ/455PS4XRPaeGzGp5CuO4
 VN/+87r37TVmgBxh1fklYsPDZyKnqwKj51L6uDZCveWuH+W1qAJAo8jN1gHcEK3YK5j6
 r8oGW83rq6Gr5WBn3L2tyUYiwzOmi9KdGkKuIat8QjOP5j3DVw73o/OEsfmRLthXFZs0
 PKqQ==
X-Gm-Message-State: AOJu0YwK53npKTa4ebThjKwsqcp8Z4Ml6ommt4KGLTlJ1zsHy7/aflLZ
 4xhUjoY9GBoOUDD6aT2ETFRMXw==
X-Google-Smtp-Source: AGHT+IGuZsz3ARmLfU4R2t9qpKsKfI53wHXuXVSVoQ5qdeSISnUfrDPgvJ746+PkWK9BEcYuz9nOLA==
X-Received: by 2002:a05:600c:214d:b0:401:cbf6:e5cc with SMTP id
 v13-20020a05600c214d00b00401cbf6e5ccmr7929720wml.22.1694423059503; 
 Mon, 11 Sep 2023 02:04:19 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc7c6000000b003fa96fe2bd9sm12603492wmk.22.2023.09.11.02.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 02:04:19 -0700 (PDT)
Date: Mon, 11 Sep 2023 11:04:18 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 10/19] target/riscv: remove kvm-stub.c
Message-ID: <20230911-df4609b7aca0b1fe00fb2e17@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-11-dbarboza@ventanamicro.com>
 <f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org>
 <20230911-0ff170da2e7063d0eb82ded9@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911-0ff170da2e7063d0eb82ded9@orel>
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

On Mon, Sep 11, 2023 at 09:49:06AM +0200, Andrew Jones wrote:
> On Wed, Sep 06, 2023 at 12:23:19PM +0200, Philippe Mathieu-Daudé wrote:
> > On 6/9/23 11:16, Daniel Henrique Barboza wrote:
> > > This file is not needed for some time now. All the stubs implemented in
> > > it (kvm_riscv_reset_vcpu() and kvm_riscv_set_irq()) are wrapped in 'if
> > > kvm_enabled()' blocks that the compiler will rip it out in non-KVM
> > > builds.
> > > 
> > > We'll also add non-KVM stubs for all functions declared in kvm_riscv.h.
> > > All stubs are implemented as g_asserted_not_reached(), meaning that we
> > > won't support them in non-KVM builds. This is done by other kvm headers
> > > like kvm_arm.h and kvm_ppc.h.
> > 
> > Aren't them also protected by kvm_enabled()? Otherwise shouldn't they?
> 
> Yes, I think your earlier suggestion that we always invoke kvm functions
> from non-kvm files with a kvm_enabled() guard makes sense.
> 
> > 
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   target/riscv/kvm-stub.c  | 30 ------------------------------
> > >   target/riscv/kvm_riscv.h | 31 +++++++++++++++++++++++++++++++
> > >   target/riscv/meson.build |  2 +-
> > >   3 files changed, 32 insertions(+), 31 deletions(-)
> > >   delete mode 100644 target/riscv/kvm-stub.c
> > 
> > 
> > > diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> > > index f6501e68e2..c9ecd9a967 100644
> > > --- a/target/riscv/kvm_riscv.h
> > > +++ b/target/riscv/kvm_riscv.h
> > > @@ -19,6 +19,7 @@
> > >   #ifndef QEMU_KVM_RISCV_H
> > >   #define QEMU_KVM_RISCV_H
> > > +#ifdef CONFIG_KVM
> > >   void kvm_riscv_cpu_add_kvm_properties(Object *obj);
> > 
> > At a glance kvm_riscv_cpu_add_kvm_properties() is.
> > Keep the prototype declared (before #ifdef CONFIG_KVM) is enough for the
> > compiler to elide it.
> 
> Yes, when building without CONFIG_KVM enabled it's actually better to not
> have the stubs, since the compiler will catch an unguarded kvm function
> call (assuming the kvm function is defined in a file which is only built
> with CONFIG_KVM).
> 
> Unfortunately we don't have anything to protect developers from forgetting
> the kvm_enabled() guard when building a QEMU which supports both TCG and
> KVM. We could try to remember to put 'assert(kvm_enabled())' at the start
> of each of these types of functions. It looks like mips does that for a
> couple functions.

Eh, ignore this suggestion. We don't need asserts, because we have CI. As
long as our CI does a CONFIG_KVM=n build and all KVM functions are in kvm-
only files, then we'll always catch calls of KVM functions which are
missing their kvm_enabled() guards.

Thanks,
drew

