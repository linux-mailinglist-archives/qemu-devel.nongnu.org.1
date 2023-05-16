Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F370500C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvBE-00010Q-KJ; Tue, 16 May 2023 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1pyvBB-0000zs-Bo
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:57:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1pyvB8-0005vr-GF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:57:29 -0400
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLHnM1gtXz6DB59;
 Tue, 16 May 2023 21:55:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:57:22 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.023; 
 Tue, 16 May 2023 14:57:22 +0100
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, "Juan
 Quintela" <quintela@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Vladimir
 Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: RE: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Thread-Topic: [PATCH v11 05/11] vfio/migration: Block multiple devices
 migration
Thread-Index: AQHZQhQ7Fuj3Zst8rUyBXFad0ORVja9dM+pwgAAS8oCAAC6S0A==
Date: Tue, 16 May 2023 13:57:22 +0000
Message-ID: <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com> <ZGNwK+6HmM8lPjAU@nvidia.com>
In-Reply-To: <ZGNwK+6HmM8lPjAU@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 16 May 2023 13:00
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Avihai Horon <avihaih@nvidia.com>; qemu-devel@nongnu.org; Alex
> Williamson <alex.williamson@redhat.com>; Juan Quintela
> <quintela@redhat.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>;
> Michael S. Tsirkin <mst@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru>; C=E9dric Le Goater <clg@redhat.com>; Yishai
> Hadas <yishaih@nvidia.com>; Maor Gottlieb <maorg@nvidia.com>; Kirti
> Wankhede <kwankhede@nvidia.com>; Tarun Gupta <targupta@nvidia.com>;
> Joao Martins <joao.m.martins@oracle.com>
> Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices
> migration
>=20
> On Tue, May 16, 2023 at 10:03:54AM +0000, Shameerali Kolothum Thodi
> wrote:
>=20
> > > Currently VFIO migration doesn't implement some kind of intermediate
> > > quiescent state in which P2P DMAs are quiesced before stopping or
> > > running the device. This can cause problems in multi-device migration
> > > where the devices are doing P2P DMAs, since the devices are not stopp=
ed
> > > together at the same time.
> > >
> > > Until such support is added, block migration of multiple devices.
> >
> > Missed this one. Currently this blocks even if the attached devices are=
 not
> > capable of P2P DMAs. eg; HiSilicon ACC devices. These are integrated en=
d
> point
> > devices without any P2P capability between them. Is it Ok to check for
> > VFIO_MIGRATION_P2P flag and allow if the devices are not supporting
> that?
>=20
> Lacking VFIO_MIGRATION_P2P doesn't mean the device is incapable of
> P2P, it means the migration can't support P2P.
>=20
> We'd need some kind of new flag to check and such devices should be
> blocked from creating P2P mappings. Basically we don't currently
> fully support devices that are incapable of P2P operations.

Ok. I will take a look.

> What happens on your platform if a guest tries to do P2P? Does the
> platform crash?

I am not sure. Since the devices are behind SMMU, I was under the assumptio=
n
that we do have the guarantee of isolation here(grouping). Or this is somet=
hing
we are worried only during migration?

Thanks,
Shameer
=20

