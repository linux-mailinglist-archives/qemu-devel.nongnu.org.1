Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29DD72965E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Z3X-0006BW-1q; Fri, 09 Jun 2023 06:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q7Z3V-0006Az-Cb
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:09:17 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q7Z3T-0006Tv-HE
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:09:17 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39bcba263efso429986b6e.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1686305353; x=1688897353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzSK7hABA28xCfv4pKGg0lBnF68yq9uktgRx5iEmiaI=;
 b=SnjQiblhpKdUrkFmokq90JQhRukoXq5b8J65xXVJT9EIrcP/WR3hM6uzBoAdAPmaR+
 3fQp23XvUy7d9X/SQQuG2rTO/QvUD1wJXI7KDWJ2VKJDeQLf+6fi8iH4QVW+bIU077fU
 IGcDNeMIM5dt1wtSEHAEi6nL3rDKqVcHE2Rhnok+EDQfNuL2kAEF43y1yU/7Gx5y24cv
 gwk8IsL+MKxcaEQIvlvHk2aGIrhi9BmaaLoDVjD+hU9fnTLkykF6r0TUD9n8Ftk/ReM1
 vX2baJvN2ZfSLdEv40zycMQoM9odk9M7DrKLraUWbA40Xnwi/iaSU5qSjWDqJ3FyLQBc
 Dopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686305353; x=1688897353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzSK7hABA28xCfv4pKGg0lBnF68yq9uktgRx5iEmiaI=;
 b=UrP1UP8EqimZQVjcowRbpvcmMYS6/x/7p76RyBalVWbrvt5g2m8kscH9D/rcsqL/Dk
 FwXaXBMCM9Ztyu7KyZ0qRAMZ5pJ8invY4skDat3fhJ6XjeYbI10ykbVi+eCSM8uEwpQI
 XojXKOWkJz4gKiMXCoObszGqSch1PGtzblNXim7UgWufcjL/kOccS10HS7qjLchJWJCZ
 EBT4F9Kk50p+HmHX95XloaniOMIJ3DkYvWlgixvBhBP2KEl+Vohgm5wIKPUGtA3D/O9v
 v2VzhxqyEfBDQ6F+HxHVp2ULVvdCbXOyVpay1awGFzRvhCQEta9PLSzKVi2lOUMTDy6B
 UF6g==
X-Gm-Message-State: AC+VfDwcV28AbFe+UjeNij90jWLYw9tcJW13ON0aiFEoWMxvKAQHqzct
 Sg6th58CHpyip60x41TA50n7Kl1+eFIzttV2gJ4Qvg==
X-Google-Smtp-Source: ACHHUZ6ewDIbcR4/py85q2j6sKSdum5U5/Vdc7cWMVzwmXLvBSTRSLiaS7LXPrZs5BLOaL/cUyMRgLfEvjshvfKWg50=
X-Received: by 2002:aca:db83:0:b0:39a:7233:3340 with SMTP id
 s125-20020acadb83000000b0039a72333340mr2527082oig.23.1686305353377; Fri, 09
 Jun 2023 03:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
 <20230526062509.31682-5-yongxuan.wang@sifive.com>
 <a715b6d1-d28a-1e04-34c5-5d6c1fb2696e@ventanamicro.com>
In-Reply-To: <a715b6d1-d28a-1e04-34c5-5d6c1fb2696e@ventanamicro.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 9 Jun 2023 18:09:03 +0800
Message-ID: <CAMWQL2hQkzCxMdvHXw8Yy8HSceEkHaMga5i1Z-79c-Eq6QGftg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/riscv: Create an KVM AIA irqchip
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, rkanwal@rivosinc.com, 
 anup@brainfault.org, atishp@atishpatra.org, vincent.chen@sifive.com, 
 greentime.hu@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oi1-x22c.google.com
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

Hi  Daniel,

Thanks for your suggestions! I'll fix it in patch v4.

Regards,
Yong-Xuan

On Tue, Jun 6, 2023 at 9:45=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 5/26/23 03:25, Yong-Xuan Wang wrote:
> > implement a function to create an KVM AIA chip
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   target/riscv/kvm.c       | 83 +++++++++++++++++++++++++++++++++++++++=
+
> >   target/riscv/kvm_riscv.h |  3 ++
> >   2 files changed, 86 insertions(+)
> >
> > diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> > index eb469e8ca5..ead121154f 100644
> > --- a/target/riscv/kvm.c
> > +++ b/target/riscv/kvm.c
> > @@ -34,6 +34,7 @@
> >   #include "exec/address-spaces.h"
> >   #include "hw/boards.h"
> >   #include "hw/irq.h"
> > +#include "hw/intc/riscv_imsic.h"
> >   #include "qemu/log.h"
> >   #include "hw/loader.h"
> >   #include "kvm_riscv.h"
> > @@ -548,3 +549,85 @@ bool kvm_arch_cpu_check_are_resettable(void)
> >   void kvm_arch_accel_class_init(ObjectClass *oc)
> >   {
> >   }
> > +
> > +void kvm_riscv_aia_create(DeviceState *aplic_s, bool msimode, int sock=
et,
> > +                          uint64_t aia_irq_num, uint64_t hart_count,
> > +                          uint64_t aplic_base, uint64_t imsic_base)
> > +{
> > +    int ret;
> > +    int aia_fd =3D -1;
> > +    uint64_t aia_mode;
> > +    uint64_t aia_nr_ids;
> > +    uint64_t aia_hart_bits =3D find_last_bit(&hart_count, BITS_PER_LON=
G) + 1;
> > +
> > +    if (!msimode) {
> > +        error_report("Currently KVM AIA only supports aplic_imsic mode=
");
> > +        exit(1);
> > +    }
> > +
> > +    aia_fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, fa=
lse);
> > +
> > +    if (aia_fd < 0) {
> > +        error_report("Unable to create in-kernel irqchip");
> > +        exit(1);
> > +    }
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> > +                            KVM_DEV_RISCV_AIA_CONFIG_MODE,
> > +                            &aia_mode, false, NULL);
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> > +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
> > +                            &aia_nr_ids, false, NULL);
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> > +                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
> > +                            &aia_irq_num, true, NULL);
> > +    if (ret < 0) {
> > +        error_report("KVM AIA: fail to set number input irq lines");
> > +        exit(1);
> > +    }
>
> I see that you didn't check 'ret' for the first 2 calls of kvm_device_acc=
ess().
> Is it intentional?
>
> Since you're setting customized error messages for every step I think it'=
s worth
> also handling the case where we fail to set aia_mode and aia_nr_ids.
>
>
> Thanks,
>
>
> Daniel
>
>
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> > +                            KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
> > +                            &aia_hart_bits, true, NULL);
> > +    if (ret < 0) {
> > +        error_report("KVM AIA: fail to set number of harts");
> > +        exit(1);
> > +    }
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
> > +                            KVM_DEV_RISCV_AIA_ADDR_APLIC,
> > +                            &aplic_base, true, NULL);
> > +    if (ret < 0) {
> > +        error_report("KVM AIA: fail to set the base address of APLIC")=
;
> > +        exit(1);
> > +    }
> > +
> > +    for (int i =3D 0; i < hart_count; i++) {
> > +        uint64_t imsic_addr =3D imsic_base + i * IMSIC_HART_SIZE(0);
> > +        ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
> > +                                KVM_DEV_RISCV_AIA_ADDR_IMSIC(i),
> > +                                &imsic_addr, true, NULL);
> > +        if (ret < 0) {
> > +            error_report("KVM AIA: fail to set the base address of IMS=
ICs");
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    if (kvm_has_gsi_routing()) {
> > +        for (uint64_t idx =3D 0; idx < aia_irq_num + 1; ++idx) {
> > +            kvm_irqchip_add_irq_route(kvm_state, idx, socket, idx);
> > +        }
> > +        kvm_gsi_routing_allowed =3D true;
> > +        kvm_irqchip_commit_routes(kvm_state);
> > +    }
> > +
> > +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CTRL,
> > +                            KVM_DEV_RISCV_AIA_CTRL_INIT,
> > +                            NULL, true, NULL);
> > +    if (ret < 0) {
> > +        error_report("KVM AIA: initialized fail");
> > +        exit(1);
> > +    }
> > +}
> > diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> > index 606968a4b7..6067adff51 100644
> > --- a/target/riscv/kvm_riscv.h
> > +++ b/target/riscv/kvm_riscv.h
> > @@ -21,6 +21,9 @@
> >
> >   void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
> >   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> > +void kvm_riscv_aia_create(DeviceState *aplic_s, bool msimode, int sock=
et,
> > +                          uint64_t aia_irq_num, uint64_t hart_count,
> > +                          uint64_t aplic_base, uint64_t imsic_base);
> >
> >   #define KVM_DEV_RISCV_AIA_GRP_CONFIG            0
> >   #define KVM_DEV_RISCV_AIA_CONFIG_MODE           0

