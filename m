Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2628E7CC014
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsguP-00040x-8V; Tue, 17 Oct 2023 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsguM-00040l-Qa
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsguL-00075e-AA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697536955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Ja+AaBPPiaEeiGYsXV5YsJJXqFvRIA8Ue6LjSc+qKM=;
 b=KFgj4nCWGEM8Pl1KGBcvhrdsEQLZHn6DnVZMlAs8tIyCLW+VDyZrtWXFYbWubiqFD0IQik
 QAaj/AAO5CK0sRJQnk97eS1TQgXh+yu16VV6P40NFCXltTiPXGftPFJpcVc62grAeXt4n2
 0/Cm8HF2lJYwgeYJfEcJU61nMZlxwUg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-tlTSeVfOPh6-3TqHDULUmA-1; Tue, 17 Oct 2023 06:02:29 -0400
X-MC-Unique: tlTSeVfOPh6-3TqHDULUmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A102985A5BE;
 Tue, 17 Oct 2023 10:02:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ECC540C6CA3;
 Tue, 17 Oct 2023 10:02:27 +0000 (UTC)
Date: Tue, 17 Oct 2023 12:02:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, hujian <hu.jian@zte.com.cn>
Subject: Re: [PULL 1/1] virtio-blk: don't start dataplane during the stop of
 dataplane
Message-ID: <ZS5bstofOtQIdz84@redhat.com>
References: <20231016194028.163610-1-stefanha@redhat.com>
 <20231016194028.163610-2-stefanha@redhat.com>
 <851be4cf-d3e1-4031-bc5a-95fbef1ce21f@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851be4cf-d3e1-4031-bc5a-95fbef1ce21f@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 17.10.2023 um 11:01 hat Fiona Ebner geschrieben:
> Am 16.10.23 um 21:40 schrieb Stefan Hajnoczi:
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 39e7f23fab..c2d59389cb 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1166,7 +1166,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      VirtIOBlock *s = (VirtIOBlock *)vdev;
> >  
> > -    if (s->dataplane && !s->dataplane_started) {
> > +    if (s->dataplane && !s->dataplane_started && !s->stopping) {
> 
> Isn't 'stopping' a property of VirtIOBlockDataPlane? Here, s is VirtIOBlock.

Indeed, this patch doesn't even build for me.

However, even if we wrote !s->dataplane->stopping, would it really be
right to be handling I/O in the main thread while the dataplane hasn't
stopped yet? At least without all the multiqueue changes, it's not
obvious to me that it can't cause problems. Unfortunately, the commit
message doesn't say anything about why it's safe.

Kevin


