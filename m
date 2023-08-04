Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9047770746
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRylV-0005z5-47; Fri, 04 Aug 2023 13:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRylS-0005yP-Sw
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:39:02 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRylR-0007f5-7P
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:39:02 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so5084275a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170739; x=1691775539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WJQF/s3rT1P+39oLCYPi5xllhzTzH9j+4r0ow7Ta0v4=;
 b=CJyUx8loeqVC+QoYGq4TsRo62LRMV5E4n6sHc9xUlC4rAUfYoqIHQQUopItKs2LyHn
 AZYLzFv3BHx1qyuT2nbvENd9nLtP5X91MUYD2+xZ5FW8SQXdjY/vNqG+fxhDRlZR7SIo
 33wTmnpBWHyQOb/6Ob2cb9ji1PH7VlZGWU2e1oapNct252S3fe2bZk8PnBOM9oA/KSu2
 Q0U50hFvPtOp53u4jfzDpv8LrErrHVNlULcSs5e/bfIH4dv3j51g2DCw6wg08+Y7jDgM
 x8PH8e8bXcynYWWGdW9t3MGr/N1y/ALAf6ULJPPyAH5GqyFH+QfZJTCjOhHf6n/EM0Xd
 +PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170739; x=1691775539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJQF/s3rT1P+39oLCYPi5xllhzTzH9j+4r0ow7Ta0v4=;
 b=IkaWnRJLlkWvoRzpK+MaPwpVfvu3hvdG2mv6CuGP56UNtWcFX58xOpi2FJWHOeJJKJ
 S48nYlViXSnbxiaRG/BywQu5zlYblp0Xt5Mo9HM/ssdbK5kfj7lc2ErKAKWU7xDvoZPg
 1LRev0jCQU0WRY0T/s0EHEZrCWVBq4XmevATSFcGbqJMuOnNukfs8aFqdFzBhJgeu/5P
 Pk9q1wFU8JdqErpAQtFLXCQcvoit/02wHcqIJWeqLkiE83pS+KO0aG2yAWGGi5AE4BaB
 Loz71ROXtLnv2kSGFqXEDIlSG1lRDO+QuClig89EGeQ6R/3sMqoiTOJXkMTozQs9jWEJ
 L2ng==
X-Gm-Message-State: AOJu0YyET9QSMccQ8yC4DEuRg+BQbGriSzt8yuzO/u93Sn3cpfAI6Iuu
 4JjdbXsZg7X5QkU/7uG4HIYi3bWSSjUwWAXE3VFMQg==
X-Google-Smtp-Source: AGHT+IEQ930XjvM88a1W5rHGmhKOQbNzc1l2YidYQyIxFZ7q31M35uM2Sd24s6HPKS85BtZBsilBwRx6p6IPs/VUmlw=
X-Received: by 2002:a05:6402:2141:b0:522:582c:f427 with SMTP id
 bq1-20020a056402214100b00522582cf427mr434413edb.14.1691170739265; Fri, 04 Aug
 2023 10:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-2-akihiko.odaki@daynix.com>
 <CAFEAcA_26e2G_qLA8DEcv74MADgquhiVkWEZkh_wL0+JxAf91Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_26e2G_qLA8DEcv74MADgquhiVkWEZkh_wL0+JxAf91Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:38:48 +0100
Message-ID: <CAFEAcA9gkKy=GBXNw0rRLeN80ekFY5JQB1Jn2b+F70oC1C5uxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] kvm: Introduce kvm_arch_get_default_type hook
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 4 Aug 2023 at 18:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > kvm_arch_get_default_type() returns the default KVM type. This hook is
> > particularly useful to derive a KVM type that is valid for "none"
> > machine model, which is used by libvirt to probe the availability of
> > KVM.
> >
> > For MIPS, the existing mips_kvm_type() is reused. This function ensures
> > the availability of VZ which is mandatory to use KVM on the current
> > QEMU.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  include/sysemu/kvm.h     | 2 ++
> >  target/mips/kvm_mips.h   | 9 ---------
> >  accel/kvm/kvm-all.c      | 4 +++-
> >  hw/mips/loongson3_virt.c | 2 --
> >  target/arm/kvm.c         | 5 +++++
> >  target/i386/kvm/kvm.c    | 5 +++++
> >  target/mips/kvm.c        | 2 +-
> >  target/ppc/kvm.c         | 5 +++++
> >  target/riscv/kvm.c       | 5 +++++
> >  target/s390x/kvm/kvm.c   | 5 +++++
> >  10 files changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 115f0cca79..ccaf55caf7 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -369,6 +369,8 @@ int kvm_arch_get_registers(CPUState *cpu);
> >
> >  int kvm_arch_put_registers(CPUState *cpu, int level);
> >
> > +int kvm_arch_get_default_type(MachineState *ms);
> > +
>
> New global functions should have a doc comment that explains
> what they do, what their API is, etc. For instance, is
> this allowed to return an error, and if so, how ?

Looks like this was the only issue with this patchset. So
I propose to take this into my target-arm queue for 8.2,
with the following doc comment added:

/**
 * kvm_arch_get_default_type: Return default KVM type
 * @ms: MachineState of the VM being created
 *
 * Return the default type argument to use in the
 * KVM_CREATE_VM ioctl when creating the VM. This will
 * only be used when the machine model did not specify a
 * type to use via the MachineClass::kvm_type method.
 *
 * Returns: type to use, or a negative value on error.
 */

unless anybody wants more time for review or for this
series to go into the tree some other way.

thanks
-- PMM

