Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6B77072B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRyfY-0003I9-4C; Fri, 04 Aug 2023 13:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyfP-0003FJ-Gg
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:32:48 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyfN-00069z-2X
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:32:47 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so4118058e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170363; x=1691775163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ouLmlWO0nxLEXXwAGQ0fQVcTHPFq6MPNEjQuiQXiic4=;
 b=zfL5hYuy6XBwrVeD2HBxIdGLvh9mzH+53gxKBMybtnern7YY3syIqlsMMDxAv3TII3
 I/bKlgK0D0lIILWWRgSjGwD04V2gaAF1bwT3XXCXUZryQ0qToKc1bRp1xJoSgczgnTGN
 mp1cLOsDKHEqXf9jJJwTzolyAyp5LZrhh65uhruYd8gRmGvBizGNpS8y3TuSPjvkKwfH
 8Z5Ui67ARGzIVzSV01duJ0ZhYso3exEewfsO9xd4MSf8pbgXipM7V59fGSM3Fgt9KlLU
 mWCIbEUntrcxPE3MZFKaqTpEj4wVkh/wKfcihubmj/qx5kPZfKIcPNQSVkuDDB8RxUiv
 jafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170363; x=1691775163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ouLmlWO0nxLEXXwAGQ0fQVcTHPFq6MPNEjQuiQXiic4=;
 b=eSVhH5/OYKJFEi3vhFottmSsJDjV+W9GhVpGdUdY5UtCRXFUDMAiccIkujUhncHcKS
 xIF8zKWN1ICb6mr4PNET6eB2Dcu6iyxHEkZzOzqTIYW2d7tYfnx+0OCWckvS5dfQQv3J
 aQdY/IQJnsLk1Qe3omrnIV+vUl2cnZJPviH4H1AT90/hYlDXdRWuKXs83cq6EbDkBKwz
 LHjaozYREYrxt5M/oElKZw8B3MGY7nrehzxoCrKi/tTGE1RiVA3hwmOKALV8dMrLsx0w
 Zdx//5/PoN5ggBpg229PIZtCpcnmOBFZEmwV1Eh9UsiRh4RI5nMtvtKLEQUFzjxyMC60
 o1Yw==
X-Gm-Message-State: AOJu0Ywly8FIf6lLzKkk9i9/hDYzHSUQMyy5C+lhlW+pK4F0W802ro4Y
 5rf3KOWirQGcDrPdXA2e+pQaYdtDtyGouyeW3xOV7A==
X-Google-Smtp-Source: AGHT+IHhH8CdEy6bQxI7AJmgKo7Hw9rWebMYZs/xLBIDZ+SJzi3SI14e31ZKoTFZ8ngFL01WKFV0PO3ff+zAc1uhv2A=
X-Received: by 2002:a05:6512:472:b0:4fd:fadc:f1e with SMTP id
 x18-20020a056512047200b004fdfadc0f1emr1617634lfd.44.1691170363295; Fri, 04
 Aug 2023 10:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-3-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-3-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:32:32 +0100
Message-ID: <CAFEAcA90ujx5=r6eFwkYZniSCgKNwGaEjtcU8RQL43-ZtPPktA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] accel/kvm: Specify default IPA size for arm64
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Before this change, the default KVM type, which is used for non-virt
> machine models, was 0.
>
> The kernel documentation says:
> > On arm64, the physical address size for a VM (IPA Size limit) is
> > limited to 40bits by default. The limit can be configured if the host
> > supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> > KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
> > identifier, where IPA_Bits is the maximum width of any physical
> > address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
> > machine type identifier.
> >
> > e.g, to configure a guest to use 48bit physical address size::
> >
> >     vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
> >
> > The requested size (IPA_Bits) must be:
> >
> >  ==   =========================================================
> >   0   Implies default size, 40bits (for backward compatibility)
> >   N   Implies N bits, where N is a positive integer such that,
> >       32 <= N <= Host_IPA_Limit
> >  ==   =========================================================
>
> > Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
> > and is dependent on the CPU capability and the kernel configuration.
> > The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
> > KVM_CHECK_EXTENSION ioctl() at run-time.
> >
> > Creation of the VM will fail if the requested IPA size (whether it is
> > implicit or explicit) is unsupported on the host.
> https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm
>
> So if Host_IPA_Limit < 40, specifying 0 as the type will fail. This
> actually confused libvirt, which uses "none" machine model to probe the
> KVM availability, on M2 MacBook Air.
>
> Fix this by using Host_IPA_Limit as the default type when
> KVM_CAP_ARM_VM_IPA_SIZE is available.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

