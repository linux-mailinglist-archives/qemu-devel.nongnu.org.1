Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856857A22F6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:53:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhB88-0000ut-9n; Fri, 15 Sep 2023 11:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qhB86-0000qJ-MZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qhB85-0002Qg-4L
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694793192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1RLaDyInCF09Gr5sPUWUBrVgmC2bXuPT7JM9TDMQsk=;
 b=P+RHMt4bU6DHPOqxj7fVkbrWea+E3NuctumM2O/ER+m7kVUAwFrb5qJJaslWDT5glisB6U
 5xEG5hvBNNCOEHtndsCVVYnWy6QI+a8a7bYMAt1D/qVLdpSWv6UUR97cRFsyQHULjC24V7
 7z1tppVuY8VWGeA01Us+VVwoLhX5Rmg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-6h_h_rlQPEmfQpycGB7hBw-1; Fri, 15 Sep 2023 11:53:09 -0400
X-MC-Unique: 6h_h_rlQPEmfQpycGB7hBw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso28655241fa.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793187; x=1695397987;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1RLaDyInCF09Gr5sPUWUBrVgmC2bXuPT7JM9TDMQsk=;
 b=MvbGnwBB9KS6qgniITfuTTEXh0I/KqqOPMXxgVjPhgkqPcmaqPEovdI94U5a5d3RdC
 G8/UE/TXzHMm03aKpafHTvHkOVe8t4UoOSUuq+mhw0pkmdZnOEI41byeXGIQeLzxR6lH
 h/Pz02a6Xhoo2XYMx4w2rqpL0+mRG+PUnE7wI8PkX47q2sEW598A3FkYzTcTEEi9xiHi
 SD2jf18hphZ5rVFnbv0MxuLOn/80UFIqraOvT2U8EE4g87wxjo3L6doDq1nz8z1IlYuc
 u1hweARnyZdj+2O89w4UNHTqlWWafrEb4uf8dsyY88A3GHRSkoLgs7xdPtSkSOGLZYSL
 6TLQ==
X-Gm-Message-State: AOJu0YzySSSo0VaupRlC4IZhJXxdDi6FPmsDafyniUvUDZDV1YUot54U
 NNDlA3pckpnkI9HC4yAzsdIpIABPTF6EbjWYQuu4/YV3j0sFwoyIAVXb7gkTTHgB+S02GS9HRX3
 +l+MmdWQWijOmCMA=
X-Received: by 2002:a05:651c:149:b0:2bd:169e:3819 with SMTP id
 c9-20020a05651c014900b002bd169e3819mr1977944ljd.17.1694793187738; 
 Fri, 15 Sep 2023 08:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPcDQtwaKIVoees5dcADucHbA6Xf00OvJpa1QyeK28bMv6is/g08afc5kAMoXkNglupA6dNw==
X-Received: by 2002:a05:651c:149:b0:2bd:169e:3819 with SMTP id
 c9-20020a05651c014900b002bd169e3819mr1977929ljd.17.1694793187409; 
 Fri, 15 Sep 2023 08:53:07 -0700 (PDT)
Received: from [192.168.178.136] (port-92-192-229-70.dynamic.as20676.net.
 [92.192.229.70]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1709064f1900b009ad8084e08asm2580503eju.0.2023.09.15.08.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:53:06 -0700 (PDT)
Message-ID: <0c66fd2ada7a317deb2a0e2cf561f626b6f766b6.camel@redhat.com>
Subject: Re: [PATCH v2 03/10] target/i386: Fix duplicated feature name in
 FEAT_KVM
From: Tim Wiederhake <twiederh@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Date: Fri, 15 Sep 2023 17:53:05 +0200
In-Reply-To: <20230908162109.0878826d@imammedo.users.ipa.redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-4-twiederh@redhat.com>
 <20230908162109.0878826d@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2023-09-08 at 16:21 +0200, Igor Mammedov wrote:
> On Fri,=C2=A0 8 Sep 2023 14:45:27 +0200
> Tim Wiederhake <twiederh@redhat.com> wrote:
>=20
> > The mistake became apparent as there were two features with the
> > same name
> > in this cpuid leaf. The names are now in line with the
> > documentation from
> > https://kernel.org/doc/html/latest/virt/kvm/x86/cpuid.html
>=20
> I'd describe what duplication breaks and it's effects.
>=20
> and also why it's considered that it's safe to change names here.
>=20
This is my first contribution to qemu. I do not know whether it is safe
to change the names, nor how to find out I'm afraid. I ran `make test`,
if that is what you mean.

Please let me know what you need me to do here.

In the meantime, I will separate the patches that rename / fix feature
names from the remaining patch set, and split the changes up as
requested.

Regards,
Tim

> > Fixes: 642258c6c7 ("kvm: add kvmclock to its second bit")
> > Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> > ---
> > =C2=A0target/i386/cpu.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f10d343935..f0fedf4b88 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -852,7 +852,7 @@ FeatureWordInfo
> > feature_word_info[FEATURE_WORDS] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0 [FEAT_KVM] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D CPUID_FEATUR=
E_WORD,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .feat_names =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kv=
mclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kv=
mclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-
> > pv-unhalt",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "kvm-poll-control", "kvm-pv-sched-yield", "kvm-
> > asyncpf-int", "kvm-msi-ext-dest-id",
>=20


