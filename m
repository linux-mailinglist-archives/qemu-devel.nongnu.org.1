Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D481CD4A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 17:54:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGilI-0001Be-CW; Fri, 22 Dec 2023 11:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGil7-0001Af-8r
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGiky-0006Vj-As
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703263935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrPR79FS8miLQ7NzUXWtPzjj01GgLXWlDO3Ci2zxUek=;
 b=Y6erRIRDwdhTIHfL3swvbY2kT4GAVJYcwdKRIQWM+DbTDoYXJWQEB+zUm1aKZZZsl+yF5r
 dw6v4ti7PGHHPDhvBHjMweV3jF4e02TrbKepTCxT77hUMrVXi4g7AOAy+aux7HwyEqrOYd
 p5tTFgBrEp7RWqjC4VTkFSEMcoBnKqk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-KKQVeECUMtWaqUm5AcPR1w-1; Fri, 22 Dec 2023 11:52:13 -0500
X-MC-Unique: KKQVeECUMtWaqUm5AcPR1w-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7cb93f1864aso493477241.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 08:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703263933; x=1703868733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrPR79FS8miLQ7NzUXWtPzjj01GgLXWlDO3Ci2zxUek=;
 b=BSirkYLzGO1xIl8kzJ/zXrOjUArKPb4HfiMnaoKVlHZQ7qTotKTuhnDhZKa2vSbsRp
 AyOVHJAQhg6+IGIxj/VNiKUr8sdbIlaL6woSzKTZWohgUW8scpzHReYDKRFkC6iVZjWK
 PQyCj+bgf8dv6bjwv10C6Ep/BH8SUItSQv/zV0ME8Wpq22+gynsZjitXkeVRsgkfcEZA
 EjPUInbjPbr3RcBWnY0lnqCeZ6yZzJzd+YvcPr/CbV9e5ymTQ6HUvunop+QMxpn9wBtt
 b5BDMnohY3pRekpqUTXf1N6Kgd+uOYyeGFeAcaQiufdxqys3RlkQaLIdqy3+l3kQR4e5
 UkDw==
X-Gm-Message-State: AOJu0Yy9y+mS119X11GRkdq815L9S4cIdYkMAyv9+oayppGNA8VcN2pl
 ms/fIZ5gEyUKLwtqbyYaFtJHqbD+9+sFKJUkE2mGnVfzx9fKt1ikCNSq/cvHw6MBF1s9T7cbR1i
 x3iYvjvsvO5CZRgR9c2xZbRr5k4LyyLjV5eKw4M8=
X-Received: by 2002:a05:6102:3f0a:b0:466:a641:e2ca with SMTP id
 k10-20020a0561023f0a00b00466a641e2camr1169282vsv.11.1703263932962; 
 Fri, 22 Dec 2023 08:52:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQmHI2Fwwg5oFToypQcMgsFnXm0bRyikNUpuj4ROXtBBaWa9Ygt/nDZLvLJt6v/vGJVNJCH0CVmqIraNd+j0=
X-Received: by 2002:a05:6102:3f0a:b0:466:a641:e2ca with SMTP id
 k10-20020a0561023f0a00b00466a641e2camr1169274vsv.11.1703263932732; Fri, 22
 Dec 2023 08:52:12 -0800 (PST)
MIME-Version: 1.0
References: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
 <1082dfde-644b-4887-bd0f-35b8cea6be26@linaro.org>
 <CABgObfY=Rd5fih1=2y17ACoeqsPOKUynwOnpL+ygvk5Xis5pNw@mail.gmail.com>
 <CABgObfaJyMd-gqZYVdNkjFXhdxX81REMA324vwBiqTEswMAvwg@mail.gmail.com>
In-Reply-To: <CABgObfaJyMd-gqZYVdNkjFXhdxX81REMA324vwBiqTEswMAvwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Dec 2023 17:52:00 +0100
Message-ID: <CABgObfZUXbLLa1vxUe0Kn+BXg5Y6iQA43gmp=-sqjCk=JOSRFQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Fix physical address truncation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Dec 22, 2023 at 5:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 10:04=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > > If the extension is not needed, then the a20 mask isn't either.
> >
> > I think it is. The extension is not needed because the masking is
> > applied by either TCG (e.g. in gen_lea_v_seg_dest or gen_add_A0_im) or
> > mmu_translate(); but the a20 mask is never applied elsewhere for
> > either non-paging mode or page table walks.
>
> Hmm, except helpers do not apply the masking. :/
>
> So Michael's patch would for example break something as silly as a
> BOUND, FSAVE or XSAVE operation invoked around the 4GB boundary.
>
> The easiest way to proceed is to introduce a new MMU index
> MMU_PTW_IDX, which is the same as MMU_PHYS_IDX except it does not mask
> 32-bit addresses. Any objections?

Nevermind, I wasn't thinking straight.

Helpers will not use MMU_PHYS_IDX. So those are fine, we just need to
keep the masking before the "break".

The only user of MMU_PHYS_IDX is VMRUN/VMLOAD/VMSAVE. We need to add
checks that the VMCB is aligned there, and same for writing to
MSR_HSAVE_PA.

Paolo


