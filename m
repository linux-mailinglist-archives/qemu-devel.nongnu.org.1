Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB25E8036DA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAA1b-0007wg-Bk; Mon, 04 Dec 2023 09:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rAA1Y-0007vl-Nl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rAA1S-0006Ci-RG
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701700449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmAAnk2hgXAxz3YwAXy2av/6HBbaMs5STpe6b+ZkGUU=;
 b=RfrZKOmdxqeWXbjsNPEXB/pgEcfcrzKRanXo388cCKZdR39NWAqC2ePwXfSrBtk3eAVZBm
 +BqIN4Tf6WLwUAQG8h/vv1QMF7j+U8EHbw8Ihq7x0E+0ZRkXHJfohTggLdUoSeKh4Vpl6H
 BWMkVwhm1okJidFMPihcZtCKuzUWKWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-j35TmjwUNKevqb14ZTIcdA-1; Mon,
 04 Dec 2023 09:34:06 -0500
X-MC-Unique: j35TmjwUNKevqb14ZTIcdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5A631C06535;
 Mon,  4 Dec 2023 14:34:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F2240C6EB9;
 Mon,  4 Dec 2023 14:33:58 +0000 (UTC)
Date: Mon, 4 Dec 2023 15:33:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Ari Sundholm <ari@tuxera.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 05/12] block: remove AioContext locking
Message-ID: <ZW3jVZZ_Kuf99g8O@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195553.942921-6-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 29.11.2023 um 20:55 hat Stefan Hajnoczi geschrieben:
> This is the big patch that removes
> aio_context_acquire()/aio_context_release() from the block layer and
> affected block layer users.
> 
> There isn't a clean way to split this patch and the reviewers are likely
> the same group of people, so I decided to do it in one patch.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> @@ -7585,29 +7433,12 @@ void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx)
>  
>  void coroutine_fn bdrv_co_lock(BlockDriverState *bs)
>  {
> -    AioContext *ctx = bdrv_get_aio_context(bs);
> -
> -    /* In the main thread, bs->aio_context won't change concurrently */
> -    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> -
> -    /*
> -     * We're in coroutine context, so we already hold the lock of the main
> -     * loop AioContext. Don't lock it twice to avoid deadlocks.
> -     */
> -    assert(qemu_in_coroutine());
> -    if (ctx != qemu_get_aio_context()) {
> -        aio_context_acquire(ctx);
> -    }
> +    /* TODO removed in next patch */
>  }

It's still there at the end of the series.

>  void coroutine_fn bdrv_co_unlock(BlockDriverState *bs)
>  {
> -    AioContext *ctx = bdrv_get_aio_context(bs);
> -
> -    assert(qemu_in_coroutine());
> -    if (ctx != qemu_get_aio_context()) {
> -        aio_context_release(ctx);
> -    }
> +    /* TODO removed in next patch */
>  }

This one, too.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


