Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7357A8DCB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3oy-0004G5-Pg; Wed, 20 Sep 2023 16:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj3os-0004Fm-Vl
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj3on-00005F-9v
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695241744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfJgIoNqufQ7DRY7V6eBW9TRt2BXMlV1LG4lCZg+OS4=;
 b=WBgHrfJjjvpjM7xGluDKo/2BuxNXQF0QMHhh/kMzqp0uGg5OphwJHAqXxCmbIN/3FJlMMN
 g0bxhRowvemwLM62BAYgIicoZfhD1JJ6Q9WBvr2Yyj6UUNV1tbWUTx1J2AIVfmm+pkGZUm
 2We7qUHjrD5gefsx3g14epSNMK1xN/Q=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-I9V91MjGO0iCPvHKvXAlag-1; Wed, 20 Sep 2023 16:29:03 -0400
X-MC-Unique: I9V91MjGO0iCPvHKvXAlag-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-350f5ce6b8dso1226845ab.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 13:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695241742; x=1695846542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfJgIoNqufQ7DRY7V6eBW9TRt2BXMlV1LG4lCZg+OS4=;
 b=VNMc6QPZwoYpu8gkHYVBO4ghliT37VeGxnVB8W0BZhkA/5IxP+CFqkvZj5C0qDMqlf
 4cJVbGTqrZV/Tuwb5Cwq01dvv+NUZb3AfYtXn1ZtBz0OVDvvjdwSaAr3lAa9fp5Qhxm3
 YXF2ARmk4+HVxwYXxMFZnYqXEtOGCv7TFZwYlt8CUhxM8irG2M9uDNeinoIccSU3aHJs
 WcfO6+wjaL1CpcN/wI7Ylzaq3h+fkhj/6FV+gDbF5D6H1xvpQruQq3JDpOWNxWQ6VqdB
 eDED8qwTsvOBZf04GIl3CLLIIKQ6BsBRgI7VkoqVtStl413wwYFak5zb4SE4DXAiJ4Le
 tRPA==
X-Gm-Message-State: AOJu0YykoouC+a6UA+csP9VvpKQPxVfsoWXZhWYNpp0WhITUhVZTwwN/
 PUgdpsKHNqIZW2Lv4oVPmBqe6qaW7Z2sKX3yMn6Nd6QwHrCHzIDwci0Q2xo9L0ry8eqohNPC4+b
 bquYzTErj4e7qIX0=
X-Received: by 2002:a05:6e02:1d83:b0:349:3020:d103 with SMTP id
 h3-20020a056e021d8300b003493020d103mr4538404ila.25.1695241742231; 
 Wed, 20 Sep 2023 13:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPQDm46fcQF94Am32mF8lhyTyiJ3RmugD1owpCZB86pQCZzVSPT/nYe0XNErcFtbmsl6zQUw==
X-Received: by 2002:a05:6e02:1d83:b0:349:3020:d103 with SMTP id
 h3-20020a056e021d8300b003493020d103mr4538384ila.25.1695241741917; 
 Wed, 20 Sep 2023 13:29:01 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 gw23-20020a0566381ef700b00439e20a2c59sm2049692jab.144.2023.09.20.13.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 13:29:01 -0700 (PDT)
Date: Wed, 20 Sep 2023 14:29:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, =?UTF-8?B?Q8OpZHJpYw==?=
 Le Goater <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Laine Stump
 <laine@redhat.com>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920142900.46305643.alex.williamson@redhat.com>
In-Reply-To: <20230920181259.GH13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230920120142.1a517d0c.alex.williamson@redhat.com>
 <20230920181259.GH13733@nvidia.com>
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

On Wed, 20 Sep 2023 15:12:59 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 20, 2023 at 12:01:42PM -0600, Alex Williamson wrote:
> > On Wed, 20 Sep 2023 03:42:20 +0000
> > "Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
> >  =20
> > > >-----Original Message-----
> > > >From: C=C3=A9dric Le Goater <clg@redhat.com>
> > > >Sent: Wednesday, September 20, 2023 1:08 AM
> > > >Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> > > >
> > > >On 8/30/23 12:37, Zhenzhong Duan wrote:   =20
> > > >> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> > > >> iommufd support, enabled by default.   =20
> > > >
> > > >Why would someone want to disable support at compile time ? It might=
   =20
> > >=20
> > > For those users who only want to support legacy container feature?
> > > Let me know if you still prefer to drop this patch, I'm fine with tha=
t.
> > >  =20
> > > >have been useful for dev but now QEMU should self-adjust at runtime
> > > >depending only on the host capabilities AFAIUI. Am I missing somethi=
ng ?   =20
> > >=20
> > > IOMMUFD doesn't support all features of legacy container, so QEMU
> > > doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> > > We need to specify it explicitly to use IOMMUFD as below:
> > >=20
> > >     -object iommufd,id=3Diommufd0
> > >     -device vfio-pci,host=3D0000:02:00.0,iommufd=3Diommufd0 =20
> >=20
> > There's an important point here that maybe we've let slip for too long.
> > Laine had asked in an internal forum whether the switch to IOMMUFD was
> > visible to the guest.  I replied that it wasn't, but this note about
> > IOMMUFD vs container features jogged my memory that I think we still
> > lack p2p support with IOMMUFD, ie. IOMMU mapping of device MMIO.  It
> > seemed like there was something else too, but I don't recall without
> > some research. =20
>=20
> I think p2p is the only guest visible one.
>=20
> I still expect to solve it :\
>=20
> > Ideally we'd have feature parity and libvirt could simply use the
> > native IOMMUFD interface whenever both the kernel and QEMU support it.
> >=20
> > Without that parity, when does libvirt decide to use IOMMUFD?
> >=20
> > How would libvirt know if some future IOMMUFD does have parity? =20
>=20
> At this point I think it is reasonable that iommufd is explicitly
> opted into.
>=20
> The next step would be automatic for single PCI device VMs (p2p is not
> relavent)

And when a second PCI device is hot-plugged into the VM and it behaves
differently from a VM with multiple statically attached devices?  Seems
like it's an opt-in until full p2p support, then an opt-out for
potential bugs.  Thanks,

Alex

> The final step would be automatic if kernel supports P2P. I expect
> libvirt will be able to detect this from an open'd /dev/iommu.
>=20
> Jason
>=20


