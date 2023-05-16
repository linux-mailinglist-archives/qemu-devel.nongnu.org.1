Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FFE7050B4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyveS-0004ei-QP; Tue, 16 May 2023 10:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pyveP-0004a2-SI
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pyveO-00030Y-63
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684247257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpkelC2N1ke9Tl44k8LKgB4HVmi+T7RiyUbSq0/QmA8=;
 b=SNPMwFSGVkxJ5xXbd+nXE4kGWkRzKUg1nHC5dGNsIzE2TOwWPvZGt4SwbN4s8ab0WO+vwp
 rRo9hklAb3VnNS8dMlTnoBRYUxDFBdoB8c8NRCAYXQjO0XRMcj7PXWrTEccLiGTMgc+p6Q
 S25tt2VyO5mQH0hXejFvwLe10AczaZs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-OGK6GsaBN7WbkuocUMA46w-1; Tue, 16 May 2023 10:27:36 -0400
X-MC-Unique: OGK6GsaBN7WbkuocUMA46w-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3351e9dbf1dso166760815ab.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 07:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684247255; x=1686839255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpkelC2N1ke9Tl44k8LKgB4HVmi+T7RiyUbSq0/QmA8=;
 b=PEfmLOnqMCmiObkRdrqGxpYy91psC7pXFQOYrHl3xeENP4cSsMY6NfN1yMrgor94M9
 FF/UFi19Ai+dTPTMhLhRBjDarj8iAy7V8pQdNz5h3TklBkNNG4AoQbd5ulRMPNTbN0Se
 CNbnNyr0ESa8rH7aNaXx36rLskUIgHhO6E1V9Ygj2WDewXmf7tUaZLOc67S1RIkVP0Pr
 zjMP2Fpws9nwo57lrGR70bPUUxClHn4t0vK1uK+4C9XYKfgmn2iZapkn6r6sirtHABC7
 PK4yUgovsqID4xg3Id8wJFe4Rwvw2oxVKpWoK2oBwYv7CTlYU99gYSOhdx+oR+aGL+iq
 G4hA==
X-Gm-Message-State: AC+VfDxgBvATlDQ3Ngyr/V3x8fS9D9YvPfA2Uoj9gBCoMZERgKkDbrj0
 oHBO+hcwGC096s56xIEiP7cnt5rXAyAwGXF28DSvSDer+h73p+uMHzt7iuTdNh5PPI0P0JzpWxW
 OdsXUH5HqiLn7kVQ=
X-Received: by 2002:a92:d991:0:b0:335:25e7:1897 with SMTP id
 r17-20020a92d991000000b0033525e71897mr21526200iln.32.1684247255635; 
 Tue, 16 May 2023 07:27:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5d65wVGADF9eMZNMiHCHDixeOPuwu/zfx2qyTu7n29huroiQCmaOBD0hmFLtbZuSgeOz2MUg==
X-Received: by 2002:a92:d991:0:b0:335:25e7:1897 with SMTP id
 r17-20020a92d991000000b0033525e71897mr21526181iln.32.1684247255394; 
 Tue, 16 May 2023 07:27:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 ck8-20020a0566383f0800b0040f7db6a264sm7425254jab.114.2023.05.16.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 07:27:34 -0700 (PDT)
Date: Tue, 16 May 2023 08:27:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Juan Quintela"
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Vladimir Sementsov-Ogievskiy"
 <vsementsov@yandex-team.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Message-ID: <20230516082732.702e8788.alex.williamson@redhat.com>
In-Reply-To: <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com>
 <ZGNwK+6HmM8lPjAU@nvidia.com>
 <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 16 May 2023 13:57:22 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 16 May 2023 13:00
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Avihai Horon <avihaih@nvidia.com>; qemu-devel@nongnu.org; Alex
> > Williamson <alex.williamson@redhat.com>; Juan Quintela
> > <quintela@redhat.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> > Paolo Bonzini <pbonzini@redhat.com>; Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru>; C=C3=A9dric Le Goater <clg@redhat.com>; Yi=
shai
> > Hadas <yishaih@nvidia.com>; Maor Gottlieb <maorg@nvidia.com>; Kirti
> > Wankhede <kwankhede@nvidia.com>; Tarun Gupta <targupta@nvidia.com>;
> > Joao Martins <joao.m.martins@oracle.com>
> > Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices
> > migration
> >=20
> > On Tue, May 16, 2023 at 10:03:54AM +0000, Shameerali Kolothum Thodi
> > wrote:
> >  =20
> > > > Currently VFIO migration doesn't implement some kind of intermediate
> > > > quiescent state in which P2P DMAs are quiesced before stopping or
> > > > running the device. This can cause problems in multi-device migrati=
on
> > > > where the devices are doing P2P DMAs, since the devices are not sto=
pped
> > > > together at the same time.
> > > >
> > > > Until such support is added, block migration of multiple devices. =
=20
> > >
> > > Missed this one. Currently this blocks even if the attached devices a=
re not
> > > capable of P2P DMAs. eg; HiSilicon ACC devices. These are integrated =
end =20
> > point =20
> > > devices without any P2P capability between them. Is it Ok to check for
> > > VFIO_MIGRATION_P2P flag and allow if the devices are not supporting =
=20
> > that?
> >=20
> > Lacking VFIO_MIGRATION_P2P doesn't mean the device is incapable of
> > P2P, it means the migration can't support P2P.
> >=20
> > We'd need some kind of new flag to check and such devices should be
> > blocked from creating P2P mappings. Basically we don't currently
> > fully support devices that are incapable of P2P operations. =20
>=20
> Ok. I will take a look.
>=20
> > What happens on your platform if a guest tries to do P2P? Does the
> > platform crash? =20
>=20
> I am not sure. Since the devices are behind SMMU, I was under the assumpt=
ion
> that we do have the guarantee of isolation here(grouping). Or this is som=
ething
> we are worried only during migration?

Grouping doesn't guarantee that mappings cannot be created through the
SMMU between devices.  When we refer to devices being isolated between
groups, that only excludes internal P2P between devices, for example
across the internal link between functions with implementation specific
routing.  For group isolation, the guarantee is that DMA is always
routed upstream, not that the ultimate target cannot be another device.
To guarantee lack of P2P the SMMU would need to reject non-memory
translation targets.  Thanks,

Alex


