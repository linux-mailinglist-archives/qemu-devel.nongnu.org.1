Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7D72626B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tro-0007sg-1h; Wed, 07 Jun 2023 10:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6tre-0007q8-Jg
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6tra-0001vU-KZ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686147010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjonzrbQ4rxCHySE4tIpUzN9UUf2lE2Fjkc2G4hvisU=;
 b=Pz/GZfPWxm0mhX/A0wrRoyZhZsRa16wFWhGYW8TNWA7RIQ/Arg4Iq7+RdidmZjAXWnUro9
 SW5tVqs+ZoRx6B0SQO0dIFjdsl/mOQOic6GKbHZEweo3198LMGHde2TnroBYUfap55meKB
 mgL6pbV3gWV6yHvt21AoKs7xPPohiRY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Sz19K__FMkiNPe4KUbIiCw-1; Wed, 07 Jun 2023 09:51:30 -0400
X-MC-Unique: Sz19K__FMkiNPe4KUbIiCw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51566dc6066so957429a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686145889; x=1688737889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjonzrbQ4rxCHySE4tIpUzN9UUf2lE2Fjkc2G4hvisU=;
 b=VmUpMUdXoEwT3wCP0JpbzqPbK8/s1rH5oH/giBDUswkaGuBWRFmnPX7KzU8ZKw7Uky
 n8mlO4s4CRhSMhnRblBr5ry8R0xSiPHm3K3tkuMrHKL5d2lLlkxsxZhiItE5U90Yxsha
 OohQ9hweccQuce15Mix1UxfxRT7xAsowC45NqP1m7V3ZjDVqfY6Ndjgm7QIpXc6WuByi
 QCTCiDomu4mWX49Sx57U/JGorPfX0pSDYXGdT6Zv+fIsj36gGV3693e9FGjglHxUpS2M
 HaVhSKBy0b+6FJovXiqDKNXuxNmGfpRW2D0ceAljMjLKaMPh7iDGXUY9NSz1qlWiKhE5
 8MAw==
X-Gm-Message-State: AC+VfDxb/t3xXvSpidcAyOFHs6bPmhb7ZqUylfbDMhHR7k0upc8RT+hB
 s7dl0giRLtQHjsApaHk7GAv1nbfB6MhU0q4lhEHywK7Df5b7bgIdnwmgeSUzjV22jlCG5ef6L04
 A0G32u5J313gKWtY=
X-Received: by 2002:a05:6402:785:b0:50b:d76a:7904 with SMTP id
 d5-20020a056402078500b0050bd76a7904mr4190097edy.28.1686145889770; 
 Wed, 07 Jun 2023 06:51:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4trzQ129aD58fXnuqA/yLbdcHuyTjcTtAmdPuU0fdxvkgr3dx5JS7N4b3/+i4YHHML5Hbltw==
X-Received: by 2002:a05:6402:785:b0:50b:d76a:7904 with SMTP id
 d5-20020a056402078500b0050bd76a7904mr4190073edy.28.1686145889396; 
 Wed, 07 Jun 2023 06:51:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 g16-20020a056402181000b005149cb5ee2dsm6193611edy.82.2023.06.07.06.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:51:28 -0700 (PDT)
Date: Wed, 7 Jun 2023 15:51:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
Subject: Re: [PATCH v5 3/3] pc: q35: Bump max_cpus to 1024
Message-ID: <20230607155127.4adde6e3@imammedo.users.ipa.redhat.com>
In-Reply-To: <81b16f60-87d6-3043-3f1c-d77f1bf8a1c4@linaro.org>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
 <81b16f60-87d6-3043-3f1c-d77f1bf8a1c4@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 7 Jun 2023 10:26:59 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 7/6/23 04:49, Suravee Suthikulpanit wrote:
> > Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> > arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> >=20
> > In case KVM could not support the specified number of vcpus, QEMU would
> > return the following error message:
> >=20
> >    qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invali=
d argument =20
>=20
> Odd, we already check the upper limit with KVM_CAP_NR_VCPUS.
> See in kvm_init():
>=20
>      /* check the vcpu limits */
>      soft_vcpus_limit =3D kvm_recommended_vcpus(s);
>      hard_vcpus_limit =3D kvm_max_vcpus(s);
>=20
> When testing your series I get:
>=20
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested=20
> (1024) exceeds the recommended cpus supported by KVM (710)

Also do not forget about TCG where KVM accel is not even in the picture.

> $ uname -srvp
> Linux 5.15.0-71-generic #78-Ubuntu SMP Tue Apr 18 09:00:29 UTC 2023 x86_64
>=20
> > Also, keep max_cpus at 288 for machine version 8.0 and older.
> >=20
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Julia Suvorova <jusual@redhat.com>
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> >   hw/i386/pc_q35.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-) =20
>=20


