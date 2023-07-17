Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD77565EC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOwb-0006DV-Tl; Mon, 17 Jul 2023 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qLOwM-0006CP-Px
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qLOwJ-00088R-Dt
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689603059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jajd5ddbmg+9zomRuViVcFjcOtptx9iN0UkLy+MmMLs=;
 b=HFHREOFZTzE2ODbgbAxr2N1+kj4kS3VWbRx2sRe3YMyohC0dWsvoWmGAG9wwReUwSUoqas
 bynMLcv5JqRfIpHEkLCQ960XikzM46j7FRd150RX5ceuJsITxI8ogLFWCrUoDAIyTJ8uEo
 Y8a5IumCFyZaDboaT81OJuPD6mZJdyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377--8Db5E6LMYq0HwT7O0RRDg-1; Mon, 17 Jul 2023 10:10:55 -0400
X-MC-Unique: -8Db5E6LMYq0HwT7O0RRDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1824510504B2;
 Mon, 17 Jul 2023 14:10:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D941E4CD0F1;
 Mon, 17 Jul 2023 14:10:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 87E46180078D; Mon, 17 Jul 2023 16:10:52 +0200 (CEST)
Date: Mon, 17 Jul 2023 16:10:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@gmail.com, cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
Message-ID: <p5un3r5vrwv45vhv6m22u3wf5za2edding7klna2semi73qxfp@sr6c7adyhm2w>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
 <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:
> Hi Michael,
> 
> True. It may be a good idea to impose a limit in the number of entries that
> can be added to the table.
> And fail to add new entries once it reaches the limit.
> 
> Not sure what would be a good limit though. For example,
> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers
> does not limit the number of buffers that can be allocated simultaneously,
> it is an unsigned 32-bits value.
> However, I guess 16-bits (65535) would suffice to cover the vast majority
> of usecases. Or even lower, and
> can be adjusted later, as this API gets (more) used.

virtio-gpu does accounting on the total amount of memory (look for
'hostmem').  That is only used in case virgl is *not* used, with virgl
it is much harder to figure how much host memory is actually used.
Probably the virglrenderer library would have to implement that.

If we want apply limits to the memory used by buffers it probably makes
sense to do the same, i.e. account the total amount of memory used.
dma-bufs have a fixed size, so that should be doable without too much
trouble.  Might need some changes to the API because that'll give us a
few new possible failure modes.

take care,
  Gerd


