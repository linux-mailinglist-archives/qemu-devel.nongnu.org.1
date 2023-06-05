Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02430721D9A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 07:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q62xw-0007ma-HN; Mon, 05 Jun 2023 01:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q62xu-0007mN-DZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 01:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q62xq-0002Qs-BL
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 01:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685943668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ERF56QB1CswGDxTkYX6QfNoXakQ5y+8Qp6PVU3mWIc=;
 b=ewLm1vbfSqytTX13hgVkd27yRh4sq9KIQlSiHeGNjxOlL/45e7J7jDYc7Ajb/XxTfGK4ZV
 cE+nraRKnKAbN/SLmOcMAvLP0L5ZK/0xMczBKj8+iKu8d/NCjFAdgkyCp4tzcznHGzcFWi
 fT3hidgOe5uZPEadCV7bdMz8BmAwpPo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-R5EHPYgPNmeVvwUn4hl9Og-1; Mon, 05 Jun 2023 01:41:06 -0400
X-MC-Unique: R5EHPYgPNmeVvwUn4hl9Og-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f3f9e8a855so2741276e87.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 22:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685943665; x=1688535665;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ERF56QB1CswGDxTkYX6QfNoXakQ5y+8Qp6PVU3mWIc=;
 b=LsT8/uRH4U7KKqWvC+LxuGfHAGJHiIi9VBWVCTGmuHA1t8HI55Gus5/L+6RELuZNk+
 ck2wnSfyfiPAEsVrRgn7DafjUd6sDPo/Wel152KjYkbHc2Ot0PE23tFOUM60qUq/nQW0
 /PIbh8QAV3BBAY+kjeoAQNd0ucfGir9Yvu9tkF3xePkbMg3ksDT+KGRIKATqCVv8Tm7+
 G/riSaRuuQOtdMFUCkofrbFjHNGBQuBVqo4nbLZtI4EcH1MjwHmJYOkdyf83q6QOq/tr
 2DVPGptRYjYAcQQyhjfMBvDDhwyHoq27ZF3X3vRoIpe2JEzx7UQwwJNMsqt5Gz2KR9c+
 UPDw==
X-Gm-Message-State: AC+VfDxR4ZpdO3gEm5ojv9BN19LeT1VPogkhKehtFlrbXja/I/YxGuJT
 CVWin9sSk8RvwARYvGDqLdbAyUPL99iqi3KJ2P5oVKN3bHVebgdM/NIroomm2iL1VXdsqSUmMpm
 525bxoIA9zjz3EZ0=
X-Received: by 2002:a05:6512:96e:b0:4f1:3be7:e1d with SMTP id
 v14-20020a056512096e00b004f13be70e1dmr4374809lft.62.1685943665498; 
 Sun, 04 Jun 2023 22:41:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pb6BCCZokLoNlqdI5k/yFCk1dMMFJKzI7C95UrAeLGN511xzzc5NNTIWVUahwhDf+FS7WjA==
X-Received: by 2002:a05:6512:96e:b0:4f1:3be7:e1d with SMTP id
 v14-20020a056512096e00b004f13be70e1dmr4374803lft.62.1685943665157; 
 Sun, 04 Jun 2023 22:41:05 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 p25-20020a7bcc99000000b003f4289b18a7sm9564090wma.5.2023.06.04.22.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 22:41:04 -0700 (PDT)
Date: Mon, 5 Jun 2023 01:41:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/7] vhost-vdpa: add support for iommufd
Message-ID: <20230605014034-mutt-send-email-mst@kernel.org>
References: <20230503091337.2130631-1-lulu@redhat.com>
 <CACGkMEvssDLX0OAuVE2ZwK_SAdhjUr7fnbH6kbMAOzzJKbsJig@mail.gmail.com>
 <CACLfguXZiErCtA6UN4z8V3x6MSaGga7W86jjg6EYhKb3j8QqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguXZiErCtA6UN4z8V3x6MSaGga7W86jjg6EYhKb3j8QqiA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, May 05, 2023 at 02:29:23PM +0800, Cindy Lu wrote:
> On Fri, May 5, 2023 at 11:29 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Hi Cindy
> >
> > On Wed, May 3, 2023 at 5:13 PM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > Hi All
> > > There is the RFC to support the IOMMUFD in vdpa device
> > > any comments are welcome
> > > Thanks
> > > Cindy
> >
> > Please post the kernel patch as well as a reference.
> >
> > Thanks
> >
> sure，will do
> Thanks
> cindy

Is this effort going anywhere? It will soon be too late for
the next merge window.

> > >
> > > Cindy Lu (7):
> > >   vhost: introduce new UAPI to support IOMMUFD
> > >   qapi: support iommufd in vdpa
> > >   virtio : add a ptr for vdpa_iommufd in VirtIODevice
> > >   net/vhost-vdpa: Add the check for iommufd
> > >   vhost-vdpa: Add the iommufd support in the map/unmap function
> > >   vhost-vdpa: init iommufd function in vhost_vdpa start
> > >   vhost-vdpa-iommufd: Add iommufd support for vdpa
> > >
> > >  hw/virtio/meson.build          |   2 +-
> > >  hw/virtio/vhost-vdpa-iommufd.c | 240 +++++++++++++++++++++++++++++++++
> > >  hw/virtio/vhost-vdpa.c         |  74 +++++++++-
> > >  include/hw/virtio/vhost-vdpa.h |  47 +++++++
> > >  include/hw/virtio/virtio.h     |   5 +
> > >  linux-headers/linux/vhost.h    |  72 ++++++++++
> > >  net/vhost-vdpa.c               |  31 +++--
> > >  qapi/net.json                  |   1 +
> > >  8 files changed, 451 insertions(+), 21 deletions(-)
> > >  create mode 100644 hw/virtio/vhost-vdpa-iommufd.c
> > >
> > > --
> > > 2.34.3
> > >
> >


