Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D780710B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 14:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAs9n-0000ws-2S; Wed, 06 Dec 2023 08:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAs9j-0000wf-Vm
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 08:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAs9i-0003N0-0t
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 08:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701870090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GZjGNK8/DC3s6qdUCadE3q9dujctUbyOyDNt2HX170=;
 b=ReMES8Tzm/Bs2CMslSEm2vAAVhSr+pXDDjS5znonKx50kAYTfnqxP317B5y/9MR3WCTqYY
 jPkgxp7MKukBlnLPskUf9T7avLO0H4InGixtzDwwoEpMK9PtVqxFQ2J9Sq8OXpEPlSQT/I
 hZjQheTG/3DfX9v57k0P2w1SzmSkVVM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-oIsFhB9ZMHud5NzCrvu7_w-1; Wed, 06 Dec 2023 08:41:27 -0500
X-MC-Unique: oIsFhB9ZMHud5NzCrvu7_w-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7c5599372bcso1472524241.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 05:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701870086; x=1702474886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GZjGNK8/DC3s6qdUCadE3q9dujctUbyOyDNt2HX170=;
 b=S91U05ShL+cz4p5btJRCs7Zy+7SCxOFZUhNWwf8tOo3JoKuSI+ZjiOi1k4gSgrBRYY
 UposcFWGJqcPKeNZr49P1IVJCY2FGSQX2cz/MN1jVZ/o1SMXJtI3RpqZp+ESxj+Da38/
 8tpvwTc70XSOEoezIRSZjDWIQwyJtCIxjf0wI0RONJbVxplKf/OJinFChw9boJI2gl12
 vzktd3QqISyxaOQXZB5I3VLr0kX2rfVdWeX8dqGowdg+RzSDZzOzOizvfd8IFKtORbB/
 mgZw1Ee+nLoR2qPGfexEnB+NCnd3pOnGNhjFCECT/W+wCxkQdmSDchY7R786/evTUBnJ
 9yjQ==
X-Gm-Message-State: AOJu0YzkWsor2X0QMwHAWZYGyNyUbtaYMwTgO8SwfiSIYyOk1mM8200+
 4F/DxBMcLoWnwzMQRvXbC5PgSpKPIiMdwO37+ARK3fmoelRAV4mTejyQK4Ct9jyDN0tN69RZIxB
 tJvQmL698AhAxtLLOJ+3Neo5m0KOh7k4=
X-Received: by 2002:a05:6122:2001:b0:4b2:8e2a:4c2 with SMTP id
 l1-20020a056122200100b004b28e2a04c2mr951307vkd.3.1701870086653; 
 Wed, 06 Dec 2023 05:41:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMIdluJ65K5e+nf0OBCTBEj1801D04ARu3sY9ieE5OU9sLovvMyZGzWqcks9pKUkwpoQQx8b9elR3/fAOcZlI=
X-Received: by 2002:a05:6122:2001:b0:4b2:8e2a:4c2 with SMTP id
 l1-20020a056122200100b004b28e2a04c2mr951298vkd.3.1701870086456; Wed, 06 Dec
 2023 05:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20231205222816.1152720-1-michael.roth@amd.com>
In-Reply-To: <20231205222816.1152720-1-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Dec 2023 14:41:13 +0100
Message-ID: <CABgObfb0YmHuw6v9AGK6FpsYA1F3eV2=4RKaxkmVrp97QCDM3A@mail.gmail.com>
Subject: Re: [PATCH v2 for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Dec 5, 2023 at 11:28=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> @@ -3637,12 +3638,18 @@ static int kvm_get_sregs(X86CPU *cpu)
>      env->gdt.limit =3D sregs.gdt.limit;
>      env->gdt.base =3D sregs.gdt.base;
>
> +    cr0_old =3D env->cr[0];
>      env->cr[0] =3D sregs.cr0;
>      env->cr[2] =3D sregs.cr2;
>      env->cr[3] =3D sregs.cr3;
>      env->cr[4] =3D sregs.cr4;
>
>      env->efer =3D sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME) {
> +        if (!(cr0_old & CR0_PG_MASK) && env->cr[0] & CR0_PG_MASK) {
> +            env->efer |=3D MSR_EFER_LMA;
> +        }
> +    }

There is no need to check cr0_old or sev_es_enabled(); EFER.LMA is
simply EFER.LME && CR0.PG.

Alternatively, sev_es_enabled() could be an assertion, that is:

    if ((env->efer & MSR_EFER_LME) && (env->cr[0] & CR0_PG_MASK) &&
       !(env->efer & MSR_EFER_LMA)) {
        /* Workaround for... */
        assert(sev_es_enabled());
        env->efer |=3D MSR_EFER_LMA;
    }

What do you think?

Thanks,

Paolo

>      /* changes to apic base and cr8/tpr are read back via kvm_arch_post_=
run */
>      x86_update_hflags(env);
> @@ -3654,6 +3661,7 @@ static int kvm_get_sregs2(X86CPU *cpu)
>  {
>      CPUX86State *env =3D &cpu->env;
>      struct kvm_sregs2 sregs;
> +    target_ulong cr0_old;
>      int i, ret;
>
>      ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS2, &sregs);
> @@ -3676,12 +3684,18 @@ static int kvm_get_sregs2(X86CPU *cpu)
>      env->gdt.limit =3D sregs.gdt.limit;
>      env->gdt.base =3D sregs.gdt.base;
>
> +    cr0_old =3D env->cr[0];
>      env->cr[0] =3D sregs.cr0;
>      env->cr[2] =3D sregs.cr2;
>      env->cr[3] =3D sregs.cr3;
>      env->cr[4] =3D sregs.cr4;
>
>      env->efer =3D sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME) {
> +        if (!(cr0_old & CR0_PG_MASK) && env->cr[0] & CR0_PG_MASK) {
> +            env->efer |=3D MSR_EFER_LMA;
> +        }
> +    }
>
>      env->pdptrs_valid =3D sregs.flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
>
> --
> 2.25.1
>


