Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 788027A8B05
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:02:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Wf-0001Gr-C4; Wed, 20 Sep 2023 14:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj1Wc-0001Ga-TG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj1Wb-00068a-CE
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695232916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7KfMrEIE1LMTICBED7ksArxJ51GOTj2Y4q/qI3s16w=;
 b=ghE6HjD3Cezz2Yjb2bTypWKUwQRjplEJFA2o1LqpnmsdKPaGXPjM+EaxujJ/oBIHyNJ9+p
 OAe5zWle/51Zd5OMs3lOzj/ywJ2B0S6SNgeGGvzdbEtKGDSqPdkLoyJpiS3K9SeoZ+SEpJ
 3Du6y5zwIDWfVshpL5PCoeflJXHwAm0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-3nemuDlVNR-hni72WCWtiA-1; Wed, 20 Sep 2023 14:01:55 -0400
X-MC-Unique: 3nemuDlVNR-hni72WCWtiA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7872be95468so8796139f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695232905; x=1695837705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7KfMrEIE1LMTICBED7ksArxJ51GOTj2Y4q/qI3s16w=;
 b=ppBkK1vvVwTMvcZQ6CMxUu044c+fNL9Mp8flvttBl6KHmnEf7XyuwiM2PCVq3E1YRT
 8bIQ6uuxLBaRY56+Uf0MyMEJTLQ1u1f9c0jbRqseXoik/dcE/SNPvj041w0fmwa7P/wB
 GF2Rq2+laQZWKp2VeySvkqxO7WOXLT/EsbBJ1Wbi5gj4TDpsxWlr5puBAXf7AMiEXNB1
 Wnls/lMOHj9mL/d42AGA3uLmQJywKtJsmjcTo4qTU942vt+3AQCfjXVcOPhnjL1oSoFd
 iVbvW3nQ2rmEt7SAygcHrpRQE6XQ7HMdcmbxBx0sUBas1TdGnFcYy4ys9rI9U8IP4T03
 qC5Q==
X-Gm-Message-State: AOJu0YwsBPoNEyRwn3PGBQO4D1rsheGuDbS7YTxPuZl3gRjBhW7cX66k
 GsvQXZZlU+F/GxUQ/aRFttt+kENGoD1RtNjB98drBYmGPdFNO5mI1eiYtpiGMfUL1t1OpAp/Zb3
 4RJ/D2rx/54cg3Fo=
X-Received: by 2002:a6b:7603:0:b0:785:5917:a35f with SMTP id
 g3-20020a6b7603000000b007855917a35fmr4078785iom.8.1695232905027; 
 Wed, 20 Sep 2023 11:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNZKeMWsyp9L6nuioV9jKwJVaZU/d2RbJx2UcJP2nfkCrPxgYPqcUPs0bvt0o88RpufDJs1Q==
X-Received: by 2002:a6b:7603:0:b0:785:5917:a35f with SMTP id
 g3-20020a6b7603000000b007855917a35fmr4078751iom.8.1695232904799; 
 Wed, 20 Sep 2023 11:01:44 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 a24-20020a5d9558000000b00783b0780bd8sm4192829ios.4.2023.09.20.11.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 11:01:44 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:01:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
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
Message-ID: <20230920120142.1a517d0c.alex.williamson@redhat.com>
In-Reply-To: <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On Wed, 20 Sep 2023 03:42:20 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> >-----Original Message-----
> >From: C=C3=A9dric Le Goater <clg@redhat.com>
> >Sent: Wednesday, September 20, 2023 1:08 AM
> >Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> >
> >On 8/30/23 12:37, Zhenzhong Duan wrote: =20
> >> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> >> iommufd support, enabled by default. =20
> >
> >Why would someone want to disable support at compile time ? It might =20
>=20
> For those users who only want to support legacy container feature?
> Let me know if you still prefer to drop this patch, I'm fine with that.
>=20
> >have been useful for dev but now QEMU should self-adjust at runtime
> >depending only on the host capabilities AFAIUI. Am I missing something ?=
 =20
>=20
> IOMMUFD doesn't support all features of legacy container, so QEMU
> doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> We need to specify it explicitly to use IOMMUFD as below:
>=20
>     -object iommufd,id=3Diommufd0
>     -device vfio-pci,host=3D0000:02:00.0,iommufd=3Diommufd0

There's an important point here that maybe we've let slip for too long.
Laine had asked in an internal forum whether the switch to IOMMUFD was
visible to the guest.  I replied that it wasn't, but this note about
IOMMUFD vs container features jogged my memory that I think we still
lack p2p support with IOMMUFD, ie. IOMMU mapping of device MMIO.  It
seemed like there was something else too, but I don't recall without
some research.

Ideally we'd have feature parity and libvirt could simply use the
native IOMMUFD interface whenever both the kernel and QEMU support it.

Without that parity, when does libvirt decide to use IOMMUFD?

How would libvirt know if some future IOMMUFD does have parity?

Does the XML direct this through some new interpretation of the driver
field? ex. "vfio-container" vs "vfio-iommufd" where "vfio" becomes an
alias or priority preference.  Thanks,

Alex


