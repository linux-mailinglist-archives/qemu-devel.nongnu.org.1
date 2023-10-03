Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AA7B6696
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncqT-0001Qm-NZ; Tue, 03 Oct 2023 06:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qncqQ-0001QG-1p
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qncqO-0000sn-GK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696329695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcJVyH2llOLki8X0rx5ksDogK7/87o8Fg/bvWxrwplg=;
 b=Zq8gI3cDroK4Fm+nbiymwnP2Zfxs4fq59T6PUX3tUfDKnB23+P+0CePtpjzW0nLYfvUImP
 5AqoVJqG5pc+LgmjfAfdj8IOYFO6OS+0Ih7oenmmzpWZ+2E+U7fGrmPn9uj19/4JF5ozf+
 BItLkQbqG9CDKHbycSRZB+JVpqL6EMU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-lBaZNq3xPFCr7E8tQEnfCA-1; Tue, 03 Oct 2023 06:41:16 -0400
X-MC-Unique: lBaZNq3xPFCr7E8tQEnfCA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-690f9c65205so709167b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696329676; x=1696934476;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcJVyH2llOLki8X0rx5ksDogK7/87o8Fg/bvWxrwplg=;
 b=GZ+gfmhuS9FtXRtiFcj8XHmHMlEbuGhTA4rKrO3js26NK2wUwVLEWE5wLv7OjIYw41
 n1JgabISuMOJ8Pf3f0Ml+G0RHc/lQiWcXhaxtQDCjVEHPh2Ecllf61KYkhADDMAWq/Np
 Ec8tZKrLa3XAOnYsLswL3Qw5KMaSX5KIDkeK7hv8zUi8Iz2B8lkX7+PIDgo6lR4sBfy0
 N/l7WtqCPT/tYcYEblUqoFmgURa6/6z4/+8ifLTsj9xb4TCZBP5B1ybr7l+WVFM97yPf
 Q3YdHJMwtMr0p9NAJHXjDAFy0ZCbmxAij8lV8SUWP3u47VwpPpF3klI9DiUft6VeV2Ok
 QiRg==
X-Gm-Message-State: AOJu0Yw5KlBz7EjdcLX2IdypmZIJ5ZZvRqLX0P1dVrwzmLFJZ23igFOu
 Ui+oAERDfiAJaF/ExHBKt0yS6kJTEGTHgEn/6Lo6RC/5SDHTDGJppsvq3pw3+XoFuMOgzuVJd45
 cGQj4VdF8tyD8WSo=
X-Received: by 2002:a05:6a00:c85:b0:68a:5449:7436 with SMTP id
 a5-20020a056a000c8500b0068a54497436mr16194914pfv.32.1696329675805; 
 Tue, 03 Oct 2023 03:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqHvvHvZ35guOKSS7OgiRlIG+XCMtavIeQ/iGpG4uP2feMmOnHciINbq2X9V9WfkfMW/GJ9g==
X-Received: by 2002:a05:6a00:c85:b0:68a:5449:7436 with SMTP id
 a5-20020a056a000c8500b0068a54497436mr16194896pfv.32.1696329675438; 
 Tue, 03 Oct 2023 03:41:15 -0700 (PDT)
Received: from smtpclient.apple ([115.96.159.31])
 by smtp.gmail.com with ESMTPSA id
 fm18-20020a056a002f9200b00684ca1b45b9sm1082308pfb.149.2023.10.03.03.41.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Oct 2023 03:41:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/i386/intel_iommu: changes towards enabling
 -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231003103601.6245-1-anisinha@redhat.com>
Date: Tue, 3 Oct 2023 16:11:10 +0530
Cc: =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58B781D9-1825-4ECF-9634-AFF3F80DB33F@redhat.com>
References: <20231003103601.6245-1-anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 03-Oct-2023, at 4:06 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> Code changes that addresses all compiler complaints coming from =
enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
> other local variables or parameters. These makes the code confusing =
and/or adds
> bugs that are difficult to catch.
>=20
> See also
>=20
>   Subject: Help wanted for enabling -Wshadow=3Dlocal
>   Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>   https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Although I sent this for completeness, I see this already got merged

=
https://gitlab.com/qemu-project/qemu/-/commit/a082739eb390d2aad679b5efa9af=
c40cfa2a496d

So we can toss this patch out.

> ---
> hw/i386/intel_iommu.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> See also=20
> Peter's changes from
> https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com.
> This patch is same as above.
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..2c832ab68b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus,
> /* Unmap the whole range in the notifier's scope. */
> static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier =
*n)
> {
> -    hwaddr size, remain;
> +    hwaddr total, remain;
>     hwaddr start =3D n->start;
>     hwaddr end =3D n->end;
>     IntelIOMMUState *s =3D as->iommu_state;
> @@ -3765,7 +3765,7 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>     }
>=20
>     assert(start <=3D end);
> -    size =3D remain =3D end - start + 1;
> +    total =3D remain =3D end - start + 1;
>=20
>     while (remain >=3D VTD_PAGE_SIZE) {
>         IOMMUTLBEvent event;
> @@ -3793,10 +3793,10 @@ static void =
vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                              VTD_PCI_SLOT(as->devfn),
>                              VTD_PCI_FUNC(as->devfn),
> -                             n->start, size);
> +                             n->start, total);
>=20
>     map.iova =3D n->start;
> -    map.size =3D size - 1; /* Inclusive */
> +    map.size =3D total - 1; /* Inclusive */
>     iova_tree_remove(as->iova_tree, map);
> }
>=20
> --=20
> 2.42.0
>=20


