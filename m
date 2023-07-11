Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69F74E7B9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7Wl-0003AS-TF; Tue, 11 Jul 2023 03:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ7Wj-0003A6-2A
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ7WU-00054k-Dz
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689059455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FURBEUuuFJ8LAbxlIvMoFjq3Tnt6PAemTCUU2iN72pY=;
 b=Ic7V88obFCOuaBRKGOZJjZ031geNrxBpx0C7eB5hBP854r8yp7AH9Fu/F2Fiw+Z7qkiksJ
 bu9OY/+wb6GXXxPFXvvoeahH65zJX4eJstfd38nYhOoNnGDy9X7sbuCIKkSpaDp04JpkXt
 1WW9cA9tA9uX4N9BoHtMjG4zlnTkkfU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Uf4d988wN7aH-l2EMUFOzw-1; Tue, 11 Jul 2023 03:10:54 -0400
X-MC-Unique: Uf4d988wN7aH-l2EMUFOzw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b747da8ab9so4952676a34.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689059453; x=1691651453;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FURBEUuuFJ8LAbxlIvMoFjq3Tnt6PAemTCUU2iN72pY=;
 b=SOcZsg877+EMal0dDhcQifXHXjisBghbb/YyuaiebrhoB/cwS7WPJxiai5ksxYvMtj
 o5b6LAh0KP47TJujuUKWkHRK5O4CUOzeL399uW45e6Fr0vv1+B67JqKTZHGMVXyIrFxg
 Ln2oNIDemUcPF9NjRQaHto/UbrQFOHTImIJH3wa8bar9SvOmLuC9MCitul1Iq9U45I0+
 gfOwbjfSIKXMXlECDz0m37zRMPq8JupyodJ2uWV0VnE+uaRiX1zGhNbUMd2CSg9gGd/A
 zu312Iw+EsUxjs6H4fu+KBe2+rK2POk0EmaW2XuFck/t5XrkKeZJP3rN2LwDbk4gEVWd
 krFQ==
X-Gm-Message-State: ABy/qLYDLhCFceSRWrkRxmkUQWcxZxw5s3NW4rkZxY7VGUpdNvgdIw+2
 4eykDk0fdfuJlID5yq6UXPQujB0ICj2/uU8hSk6ZgfZ35zRwiB7W2doPoKaa4dGA3oiSoNb2pz8
 PTyYf+UJ8zJAPLhI=
X-Received: by 2002:a9d:6ac5:0:b0:6b7:2366:3497 with SMTP id
 m5-20020a9d6ac5000000b006b723663497mr14731199otq.18.1689059453701; 
 Tue, 11 Jul 2023 00:10:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTXx42h1HbH6p69S9K7Xc7hagiq6yBDEgBcdaxx+6nraR+HkepdUgO4rkqhY6M641iopOdUQ==
X-Received: by 2002:a9d:6ac5:0:b0:6b7:2366:3497 with SMTP id
 m5-20020a9d6ac5000000b006b723663497mr14731175otq.18.1689059453335; 
 Tue, 11 Jul 2023 00:10:53 -0700 (PDT)
Received: from smtpclient.apple ([116.73.134.124])
 by smtp.gmail.com with ESMTPSA id
 z92-20020a17090a6d6500b00263ed4efa9bsm1165443pjj.19.2023.07.11.00.10.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jul 2023 00:10:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 4/4] pci: Compare function number and ARI next function
 number
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230701070133.24877-5-akihiko.odaki@daynix.com>
Date: Tue, 11 Jul 2023 12:40:47 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <805445D0-111B-4D7B-A02F-71A4B90FA848@redhat.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-5-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 01-Jul-2023, at 12:31 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> The function number must be lower than the next function number
> advertised with ARI.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> hw/pci/pci.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..568665ee42 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, =
Error **errp)
>     Error *local_err =3D NULL;
>     bool is_default_rom;
>     uint16_t class_id;
> +    uint16_t ari;
> +    uint16_t nextfn;
>=20
>     /*
>      * capped by systemd (see: udev-builtin-net_id.c)
> @@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, =
Error **errp)
>         }
>     }
>=20
> +    if (pci_is_express(pci_dev)) {
> +        ari =3D pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
> +        if (ari) {
> +            nextfn =3D (pci_get_long(pci_dev->config + ari + =
PCI_ARI_CAP) >> 8) & 0xff;
> +            if (nextfn && (pci_dev->devfn & 0xff) >=3D nextfn) {
> +                error_setg(errp, "PCI: function number %u is not =
lower than ARI next function number %u",
> +                           pci_dev->devfn & 0xff, nextfn);
> +                pci_qdev_unrealize(DEVICE(pci_dev));
> +                return;
> +            }
> +        }
> +    }
> +

So I kind of got lost in all the patches. What was the ultimate decision =
regarding checking this?

>     if (pci_dev->failover_pair_id) {
>         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>             error_setg(errp, "failover primary device must be on "
> --=20
> 2.41.0
>=20


