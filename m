Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F173DE86
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDl3e-0001pt-00; Mon, 26 Jun 2023 08:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDl3U-0001pO-95
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDl3R-00079R-Gh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687781448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iaVLnvWfAoBEKD546jMkx/3QayLgO/z6ZeWR9u6V7Y=;
 b=bU7Ew+taguxVWirK889ZlhLh5Ro+CbhJ3WvNZ39iqGfm0O9US8khwmjThDW1OXKTToRFWh
 TSKhVLPeQ7PV9PHGNKNfLCT6PoBoC3E3V+UFwwSTzNVsk0iCVD1nVi5hrUWPq1skJSJlkC
 WuRCu0uHgoCgnu7CKlaxuJX9Tb4Ft8Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-VxnoiyQjPH2mdCIs5CqoGA-1; Mon, 26 Jun 2023 08:10:46 -0400
X-MC-Unique: VxnoiyQjPH2mdCIs5CqoGA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6a10a0a76so7743081fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687781445; x=1690373445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iaVLnvWfAoBEKD546jMkx/3QayLgO/z6ZeWR9u6V7Y=;
 b=UCmXCjd+J/EDkS3ETXuGfbb16ITaNirGRFeGMixfz97JR/T41rmM/gUhaqATmbz8hN
 kQ6IET5nWOemJ3RF2CBjW99KwU1bbklKQc2MCwLyRt5gBsElfgMdPPR2YrFW7f4oZipU
 ChOX+2Yjgsrxj38jlJQUEILnD0GEwen7KiOQBBLoEf7RMPtjKL2LzzIPDAzRAASUet8E
 TYn+Tz6wWRHK/QmzNtdG4PQK9LSfCIbahksLsrZo9PiYqTeA5pwvxsJArdptTKcelUHK
 dOsXdOZBsncBcmFqZuPBAZb2AyXw/hiCXD5mCAdxdd424SUHlrZ09KS9APs7j6nGkqWB
 Z66Q==
X-Gm-Message-State: AC+VfDx7PIg3cXrAbTzlMJ2kM1ayhIhX6SU0Jv+Mmn0n3f9Fj0v7dMPy
 Ps9RpzIhXseBuuwc9SCwZa5dcl1K8TY4Mij1FrhNUb+E55gO1bAWTNQbozv7kODVqlmFDYj6V5R
 fGOWXtDkxmEIKsp4=
X-Received: by 2002:a2e:9106:0:b0:2b4:6e04:7f2a with SMTP id
 m6-20020a2e9106000000b002b46e047f2amr14101112ljg.47.1687781445146; 
 Mon, 26 Jun 2023 05:10:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43E8fUzANkwskzOceK2AFTIXjy7BqnZkcP6GMWk53NPbZVG6ARNhTvgNPKI8QEa2bITh6YwA==
X-Received: by 2002:a2e:9106:0:b0:2b4:6e04:7f2a with SMTP id
 m6-20020a2e9106000000b002b46e047f2amr14101096ljg.47.1687781444777; 
 Mon, 26 Jun 2023 05:10:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 p23-20020a05640210d700b0051a4c1dc813sm2772959edu.82.2023.06.26.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:10:44 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:10:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Michael Labiuk <michael.labiuk@virtuozzo.com>
Subject: Re: [PATCH v2 4/5] tests/qtest/hd-geo-test: fix test by removing
 unnecessary pcie-root-port
Message-ID: <20230626141043.098c3034@imammedo.users.ipa.redhat.com>
In-Reply-To: <5B33FFEC-B67A-47EF-8867-FE84CEB93412@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
 <20230622103255.267289-5-anisinha@redhat.com>
 <20230626131547.010ccdd8@imammedo.users.ipa.redhat.com>
 <5B33FFEC-B67A-47EF-8867-FE84CEB93412@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 26 Jun 2023 17:01:29 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 26-Jun-2023, at 4:45 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> >=20
> > On Thu, 22 Jun 2023 16:02:54 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >  =20
> >> A SCSI controller can be attached to a pcie-to-pci bridge which in tur=
n can be
> >> attached directly to the root bus (peie.0). There is no need to attach=
 a
> >> pcie-root-port on the root bus in order to attach the pcie-ro-pci brid=
ge.
> >> Fix it. =20
> >=20
> > bridge can be both on pcie.0 or on root-port and both are valid configs.
> > So what exactly and why we are fixing here? =20
>=20
> If you look at the functions carefully, =E2=80=9Cbr=E2=80=9D is a pcie-ro=
ot-port and =E2=80=9Cpcie.0=E2=80=9D is a pcie-to-pci bridge.
> The bug here is that both the SCSI controller and the pcie-to-pci bridge =
(pcie.0) were getting attached to the same pcie-root-port. I think the inte=
ntion of the author was to attach the SCSI controller to pcie-to-pci bridge.
> In any case, I do not see the reason to attach a pcie-root-port here. We =
can attach the pcie-to-pci bridge on the RC and then attach the SCSI contro=
llers on the bridge.

Description of what's wrong should be in commit message
then you can follow up with a reasoning why you don't think it's worth fixi=
ng
and what you do to remedy situation.

>=20
> >  =20
> >>=20
> >> CC: mst@redhat.com
> >> CC: imammedo@redhat.com
> >> CC: Michael Labiuk <michael.labiuk@virtuozzo.com>
> >>=20
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> tests/qtest/hd-geo-test.c | 18 ++++++++----------
> >> 1 file changed, 8 insertions(+), 10 deletions(-)
> >>=20
> >> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> >> index 5aa258a2b3..d08bffad91 100644
> >> --- a/tests/qtest/hd-geo-test.c
> >> +++ b/tests/qtest/hd-geo-test.c
> >> @@ -784,14 +784,12 @@ static void test_override_scsi(void)
> >>     test_override(args, "pc", expected);
> >> }
> >>=20
> >> -static void setup_pci_bridge(TestArgs *args, const char *id, const ch=
ar *rootid)
> >> +static void setup_pci_bridge(TestArgs *args, const char *id)
> >> {
> >>=20
> >> -    char *root, *br;
> >> -    root =3D g_strdup_printf("-device pcie-root-port,id=3D%s", rootid=
);
> >> -    br =3D g_strdup_printf("-device pcie-pci-bridge,bus=3D%s,id=3D%s"=
, rootid, id);
> >> +    char *br;
> >> +    br =3D g_strdup_printf("-device pcie-pci-bridge,bus=3Dpcie.0,id=
=3D%s", id);
> >>=20
> >> -    args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, root=
);
> >>     args->argc =3D append_arg(args->argc, args->argv, ARGV_SIZE, br);
> >> }
> >>=20
> >> @@ -811,8 +809,8 @@ static void test_override_scsi_q35(void)
> >>     add_drive_with_mbr(args, empty_mbr, 1);
> >>     add_drive_with_mbr(args, empty_mbr, 1);
> >>     add_drive_with_mbr(args, empty_mbr, 1);
> >> -    setup_pci_bridge(args, "pcie.0", "br");
> >> -    add_scsi_controller(args, "lsi53c895a", "br", 3);
> >> +    setup_pci_bridge(args, "pcie-pci-br");
> >> +    add_scsi_controller(args, "lsi53c895a", "pcie-pci-br", 3);
> >>     add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> >>     add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
> >>     add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
> >> @@ -868,9 +866,9 @@ static void test_override_virtio_blk_q35(void)
> >>     };
> >>     add_drive_with_mbr(args, empty_mbr, 1);
> >>     add_drive_with_mbr(args, empty_mbr, 1);
> >> -    setup_pci_bridge(args, "pcie.0", "br");
> >> -    add_virtio_disk(args, 0, "br", 3, 10000, 120, 30);
> >> -    add_virtio_disk(args, 1, "br", 4, 9000, 120, 30);
> >> +    setup_pci_bridge(args, "pcie-pci-br");
> >> +    add_virtio_disk(args, 0, "pcie-pci-br", 3, 10000, 120, 30);
> >> +    add_virtio_disk(args, 1, "pcie-pci-br", 4, 9000, 120, 30);
> >>     test_override(args, "q35", expected);
> >> }
> >>  =20
> >  =20
>=20


