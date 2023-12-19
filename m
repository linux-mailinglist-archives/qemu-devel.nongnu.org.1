Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA03818971
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 15:12:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFani-0004cy-O0; Tue, 19 Dec 2023 09:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFanU-0004aA-Bh
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:10:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFanJ-00053R-TY
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702995000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/M+fq/M+aW2mQvLAXyCZuqg9Xt/VZvvHXvwXnIgth4=;
 b=edgvgnXFd/2MQhtZadCP7eGLqE1qy5SLYLYXz2knYJ0isFpWOlexL2o6DBXYGf2ugfXXPT
 +CNAZImOfP1vq2jyIK4XInQARUD4ldcPfR+DRACAQ6FCxvpbld/oMqDh/DSWx/DfiV63lR
 oQTaFcYOfLiKR+tgZvsmepun4Sw/QJY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-sS7upHjfN1yRC7legS8w8A-1; Tue,
 19 Dec 2023 09:09:59 -0500
X-MC-Unique: sS7upHjfN1yRC7legS8w8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 036D22818763;
 Tue, 19 Dec 2023 14:09:59 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2468051D5;
 Tue, 19 Dec 2023 14:09:57 +0000 (UTC)
Date: Tue, 19 Dec 2023 15:09:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/4] virtio-blk: prepare for the multi-queue block layer
Message-ID: <ZYGkNO0RThjhOPGv@redhat.com>
References: <20230914140101.1065008-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140101.1065008-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 14.09.2023 um 16:00 hat Stefan Hajnoczi geschrieben:
> The virtio-blk device will soon be able to assign virtqueues to IOThreads,
> eliminating the single IOThread bottleneck. In order to do that, the I/O code
> path must support running in multiple threads.
> 
> This patch series removes the AioContext lock from the virtio-blk I/O code
> path, adds thread-safety where it is required, and ensures that Linux AIO and
> io_uring are available regardless of which thread calls into the block driver.
> With these changes virtio-blk is ready for the iothread-vq-mapping feature,
> which will be introduced in the next patch series.
> 
> Based-on: 20230913200045.1024233-1-stefanha@redhat.com ("[PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of notification BH")
> Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")
> 
> Stefan Hajnoczi (4):
>   block/file-posix: set up Linux AIO and io_uring in the current thread
>   virtio-blk: add lock to protect s->rq
>   virtio-blk: don't lock AioContext in the completion code path
>   virtio-blk: don't lock AioContext in the submission code path

Thanks, applied to the block branch.

Kevin


