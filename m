Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BCF705680
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyztu-0008Q3-RS; Tue, 16 May 2023 14:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pyztq-0008PT-JH
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pyzto-0000Hv-Px
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMY70gq7ikZUe1VhIxubI33hb8EUfP+xJg5C6PFl+rQ=;
 b=Ga88Q8I5uwMaQWCsODgvFrMWsslZLf+Qq2w4+dw3BYRUI2yKVIr2akJCTefywgjtHKlXM5
 a6BGO/1VQVQyQAcY5TMw2Z9a81G+b6FTKcGWZqXqEARMNAsWYyzPrlYBRWUgdlMk2Vam4W
 9vTP5siylrpj+IBZu9XrHZxtk8bOJyg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-5dpQgq-CPCKnvWzmDzKJnQ-1; Tue, 16 May 2023 14:59:49 -0400
X-MC-Unique: 5dpQgq-CPCKnvWzmDzKJnQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3313d6bcc76so94884435ab.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 11:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684263588; x=1686855588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMY70gq7ikZUe1VhIxubI33hb8EUfP+xJg5C6PFl+rQ=;
 b=YZ9MNGSHv/rKr2ZQRXKXJfnzqvHG86t7uqecNXQjzIRLoU39FohIUtQTNPDCb7r/rI
 GYMDoWBYxw68UtgvzSPIyeQZr+lkEf8O10PMtWpoahZfcq9fOBwm+hPSQtdDF5ew25UR
 2r58jTVaTBGIl4c9Q5pepTPvlcYQBaIAPorgmhtyHf4zBw0XMPCdTT5u83pR4/NMcXuU
 cZX9XhvtIlO1elU3iVnLjpwu+CZVVjD4KEUivX7xb+/MiFEBNvf04K/3FDAajs5P5Mjk
 EwIgJ0f+rULMK7TG4ZNAhDfBc0LHSq42FndmFL8CY+F8vgWoFZ6XvBscYGkN3o+8rp5o
 666Q==
X-Gm-Message-State: AC+VfDwmCGDptHuS9yRqKFb3n5N7aCAveNSqOeMONc2td8CPY0u0SFbh
 2eAJQJPv51Zr4Op8qr0VNJ9bLPsM9RFM0ueOM3MQF1xcFRaI7Z/RVb/BvRJAQO+OI67a6KzLtfO
 /+qA9AIVIxiYQm0I=
X-Received: by 2002:a92:dc42:0:b0:334:f662:6406 with SMTP id
 x2-20020a92dc42000000b00334f6626406mr121152ilq.25.1684263588685; 
 Tue, 16 May 2023 11:59:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XdlwrLbPvcH8d93R+yjckNxIHJcdbsIu9e/YMuT0yNid7vASTg9K3Jp7c1ZQyuh7NvcxjAg==
X-Received: by 2002:a92:dc42:0:b0:334:f662:6406 with SMTP id
 x2-20020a92dc42000000b00334f6626406mr121142ilq.25.1684263588360; 
 Tue, 16 May 2023 11:59:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 c22-20020a02a416000000b0040fa241e068sm7806150jal.52.2023.05.16.11.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 11:59:47 -0700 (PDT)
Date: Tue, 16 May 2023 12:59:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH] vfio/pci: Fix a use-after-free issue
Message-ID: <20230516125945.266c35e4.alex.williamson@redhat.com>
In-Reply-To: <SJ0PR11MB6744418C6BCC9BF373898AEF92799@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230516034357.61276-1-zhenzhong.duan@intel.com>
 <a704c7bf-3e04-e919-03e2-149f82c04a2b@redhat.com>
 <SJ0PR11MB6744418C6BCC9BF373898AEF92799@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Tue, 16 May 2023 10:02:24 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> >-----Original Message-----
> >From: C=C3=A9dric Le Goater <clg@redhat.com>
> >Sent: Tuesday, May 16, 2023 4:58 PM
> >To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-
> >devel@nongnu.org
> >Cc: minwoo.im@samsung.com; alex.williamson@redhat.com; Peng, Chao P
> ><chao.p.peng@intel.com>
> >Subject: Re: [PATCH] vfio/pci: Fix a use-after-free issue
> >
> >On 5/16/23 05:43, Zhenzhong Duan wrote: =20
> >> We should free the duplicated variant of vbasedev->name plus uuid
> >> rather than vbasedev->name itself.
> >>
> >> Fixes: 2dca1b37a7 ("vfio/pci: add support for VF toke") =20
> >
> >"toke" -> "token" =20
> Will fix, thanks
>=20
> > =20
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >> ---
> >>   hw/vfio/pci.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> >> bf27a3990564..d2593681e000 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -2998,7 +2998,9 @@ static void vfio_realize(PCIDevice *pdev, Error =
=20
> >**errp) =20
> >>       }
> >>
> >>       ret =3D vfio_get_device(group, name, vbasedev, errp);
> >> -    g_free(name);
> >> +    if (name !=3D vbasedev->name) { =20
> >
> >
> >yes. I wonder if we shouldn't use the same test with which 'name' was
> >allocated instead :
> >
> >     if (!qemu_uuid_is_null(&vdev->vf_token)) { =20
>=20
> I think they are same effect and " if (name !=3D vbasedev->name) {" is a =
bit
> more optimal. If you prefer " if (!qemu_uuid_is_null(&vdev->vf_token)) {",
> let me know and I'll update in v2.

My preference would be that both paths allocate name so that we don't
need to conditionalize the free.  For example:

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a3990564..73874a94de12 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **err=
p)
         qemu_uuid_unparse(&vdev->vf_token, uuid);
         name =3D g_strdup_printf("%s vf_token=3D%s", vbasedev->name, uuid);
     } else {
-        name =3D vbasedev->name;
+        name =3D g_strdup(vbasedev->name);
     }
=20
     ret =3D vfio_get_device(group, name, vbasedev, errp);

Thanks,
Alex


