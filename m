Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2B75C6E7
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 14:31:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMpFs-00052H-Hx; Fri, 21 Jul 2023 08:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMpFp-00051F-Jb
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 08:29:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMpFf-0001FU-4Q
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 08:29:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso2506031a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689942533; x=1690547333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMGrLA74ax3ZXDdbQTIvZqhbtdK8cEtRGYrB0J/L0kE=;
 b=a85fv4Tz9nVWuNNi+YAo/HFpozLqoOAh1YqMAiq7X6K3vPucvzi61+FHdM4mP5Q1km
 KEKiB1fnydjd8groHB84sFPJE8ATy0EPvt6DapSQKLTbtv/QYMd1K/N24Q9geNbLm6Tm
 zjW3cA+ufAjUgzDh+jwae+bsop1ZWrhFXszOaNWNaVbfbl3AO4ebsh3/iTMRnAG9Ctzq
 TC4AFjBIwN+sz9mqTr/pPyinvD3ZDu9wAOn02vHNkFy5WyaJtnRXlgCdnXB+YwOEP+6X
 gDtCphGeKhs6WamZ4YzvRzcoe+pnhBoUhWGIjziGShZcXuaq9YSJlSrHg9DnThAWS7OO
 AEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689942533; x=1690547333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMGrLA74ax3ZXDdbQTIvZqhbtdK8cEtRGYrB0J/L0kE=;
 b=RS8NUTJKL+F2ffE+dLSt+J+SW/BPf+1q/PALnUGQY45RTHl5humLgZb5ulbVO/hyHq
 hwXTmCwhOOgK7kbCpCP/0z7GBjV6QiLkW8Cfo6QI2Lstn0y04ll2RcjZ7Nty/egdBRyb
 wsfSpAs7YPRsKlEZy9/Zcks3I52pQZvkL1/q0pSFPLXZJU2EDIF1OoY7jSDNWQEyrB/Q
 qfJxeoJc0YYYXjeCzlsaKgWI4BmhXjOrvdL1PRyvuJGVMai9y6KSnjZO6Dhn+Y01qnQF
 1OHT4RZ3zBV2JIRhLEP6kc7F8NoeGUhmfV6FQ9Tk2m/fbnkumLJH98JkBPmjDpsAN8+K
 0l/Q==
X-Gm-Message-State: ABy/qLbH62gqmM6efMRPqgwN0ic1CLeyeFC3IJzXtFiOhNOUq28MSKyF
 4YmZh48fzbyG4RlowSxtfrlE5cPZSsvmAJfJLeHeLA==
X-Google-Smtp-Source: APBJJlE+XvXwl79hgEmKL02wWnHj3G1UNKKxXi6C+x+rSZ6pERXjKFphu9MMtVcCrsZk65JkK3FF1Cxl8VIUeHuAzz4=
X-Received: by 2002:aa7:d50f:0:b0:51d:d615:19af with SMTP id
 y15-20020aa7d50f000000b0051dd61519afmr1465566edq.28.1689942533305; Fri, 21
 Jul 2023 05:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230721062421.12017-1-akihiko.odaki@daynix.com>
 <05d4e5ff-dc5c-b2da-7ae8-ac135d4a73c9@linaro.org>
In-Reply-To: <05d4e5ff-dc5c-b2da-7ae8-ac135d4a73c9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 13:28:42 +0100
Message-ID: <CAFEAcA_xTAnZ+CO8L3yhUMht3fL=rspk94z-hmZKgdABLAgBNA@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: Specify default IPA size for arm64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Jul 2023 at 08:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Akihiko,
>
> On 21/7/23 08:24, Akihiko Odaki wrote:
> > libvirt uses "none" machine type to test KVM availability. Before this
> > change, QEMU used to pass 0 as machine type when calling KVM_CREATE_VM.
> >
> > The kernel documentation says:
> >> On arm64, the physical address size for a VM (IPA Size limit) is
> >> limited to 40bits by default. The limit can be configured if the host
> >> supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> >> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
> >> identifier, where IPA_Bits is the maximum width of any physical
> >> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
> >> machine type identifier.
> >>
> >> e.g, to configure a guest to use 48bit physical address size::
> >>
> >>      vm_fd =3D ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(4=
8));
> >>
> >> The requested size (IPA_Bits) must be:
> >>
> >>   =3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>    0   Implies default size, 40bits (for backward compatibility)
> >>    N   Implies N bits, where N is a positive integer such that,
> >>        32 <=3D N <=3D Host_IPA_Limit
> >>   =3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
> >> and is dependent on the CPU capability and the kernel configuration.
> >> The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
> >> KVM_CHECK_EXTENSION ioctl() at run-time.
> >>
> >> Creation of the VM will fail if the requested IPA size (whether it is
> >> implicit or explicit) is unsupported on the host.
> > https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm
> >
> > So if Host_IPA_Limit < 40, such KVM_CREATE_VM will fail, and libvirt
> > incorrectly thinks KVM is not available. This actually happened on M2
> > MacBook Air.
> >
> > Fix this by specifying 32 for IPA_Bits as any arm64 system should
> > support the value according to the documentation.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > V1 -> V2: Introduced an arch hook
> >
> >   include/sysemu/kvm.h   | 1 +
> >   accel/kvm/kvm-all.c    | 2 +-
> >   target/arm/kvm.c       | 2 ++
> >   target/i386/kvm/kvm.c  | 2 ++
> >   target/mips/kvm.c      | 2 ++
> >   target/ppc/kvm.c       | 2 ++
> >   target/riscv/kvm.c     | 2 ++
> >   target/s390x/kvm/kvm.c | 2 ++
> >   8 files changed, 14 insertions(+), 1 deletion(-)
>
> My understanding of Peter's suggestion would be smth like:
>
> -- >8 --
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 115f0cca79..c0af15eb6c 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -201,10 +201,15 @@ typedef struct KVMCapabilityInfo {
>
>   struct KVMState;
>
> +struct KVMClass {
> +    AccelClass parent_class;
> +
> +    int default_vm_type;

The kernel docs say you need to check for the
KVM_CAP_ARM_VM_IPA_SIZE before you can pass something other
than zero to the KVM_CREATE_VM ioctl, so this needs to be
a method, not just a value. (kvm_arm_get_max_vm_ipa_size()
will do this bit for you.)

If the machine doesn't provide a kvm_type method, we
should default to "largest the host supports", I think.

I was wondering if we could have one per-arch
method for "actually create the VM" that both was
a place for arm to set the default vm type and
also let us get the TARGET_S390X and TARGET_PPC
ifdefs out of this bit of kvm-all.c, but maybe that would
look just a bit too awkward:

     if (kc->create_vm(s, board_sets_kvm_type, board_kvm_type) < 0) {
         goto err;
     }

where board_sets_kvm_type is a bool, true if board_kvm_type
is valid, and board_kvm_type is whatever the board's
mc->kvm_type method told us.

(Default impl of the method: call KVM_CREATE_VM ioctl
with retry-on-eintr, printing the simple error message;
PPC and s390 versions similar but with their arch
specific extra messages; arm version has a different
default type if board_sets_kvm_type is false.)

Not trying to do both of those things with one method
would result in a simpler
   type =3D kc->get_default_kvm_type(s);
API.

thanks
-- PMM

