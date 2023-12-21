Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F1781BD6F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:39:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGN0E-0007jI-W7; Thu, 21 Dec 2023 12:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGN0B-0007it-9U
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:38:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGN09-0002kI-Kx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703180308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bG8puuc3jARFslQEkLEHvYUCBULCO8atthBG6xj1+HE=;
 b=HskRZhOVITWPh2W0oQ3+zqVmTHQnQt5dXd8fZv84iNdHmCWLXQ9J+ZEejW8UyY12Aiu2OS
 dNkeJeyH2OUaxHGSrWrNP82I8RQlJI6skNPR0W/AVzDC5FkBe2rTqo05sdPbK0ToJo7t1W
 /SXui//37Czj4vM63IL0Dj6qJSNqffM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-xtYhoMXLPpi0O-G_TEchNQ-1; Thu,
 21 Dec 2023 12:38:24 -0500
X-MC-Unique: xtYhoMXLPpi0O-G_TEchNQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 708B41C06912;
 Thu, 21 Dec 2023 17:38:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 737F0492BC6;
 Thu, 21 Dec 2023 17:38:19 +0000 (UTC)
Date: Thu, 21 Dec 2023 18:38:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 6/6] nbd/server: introduce NBDClient->lock to protect
 fields
Message-ID: <ZYR4CKeZD7EmCYuv@redhat.com>
References: <20231221153548.1752005-1-stefanha@redhat.com>
 <20231221153548.1752005-7-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221153548.1752005-7-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 21.12.2023 um 16:35 hat Stefan Hajnoczi geschrieben:
> NBDClient has a number of fields that are accessed by both the export
> AioContext and the main loop thread. When the AioContext lock is removed
> these fields will need another form of protection.
> 
> Add NBDClient->lock and protect fields that are accessed by both
> threads. Also add assertions where possible and otherwise add doc
> comments stating assumptions about which thread and lock holding.
> 
> Note this patch moves the client->recv_coroutine assertion from
> nbd_co_receive_request() to nbd_trip() where client->lock is held.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> +/* Runs in export AioContext */
> +static void nbd_wake_read_bh(void *opaque)
> +{
> +    NBDClient *client = opaque;
> +    qio_channel_wake_read(client->ioc);
> +}
> +
>  static bool nbd_drained_poll(void *opaque)
>  {
>      NBDExport *exp = opaque;
>      NBDClient *client;
>  
> +    assert(qemu_in_main_thread());
> +
>      QTAILQ_FOREACH(client, &exp->clients, next) {
> -        if (client->nb_requests != 0) {
> -            /*
> -             * If there's a coroutine waiting for a request on nbd_read_eof()
> -             * enter it here so we don't depend on the client to wake it up.
> -             */
> -            if (client->recv_coroutine != NULL && client->read_yielding) {
> -                qio_channel_wake_read(client->ioc);
> +        WITH_QEMU_LOCK_GUARD(&client->lock) {
> +            if (client->nb_requests != 0) {
> +                /*
> +                 * If there's a coroutine waiting for a request on nbd_read_eof()
> +                 * enter it here so we don't depend on the client to wake it up.
> +                 *
> +                 * Schedule a BH in the export AioContext to avoid missing the
> +                 * wake up due to the race between qio_channel_wake_read() and
> +                 * qio_channel_yield().
> +                 */
> +                if (client->recv_coroutine != NULL && client->read_yielding) {
> +                    aio_bh_schedule_oneshot(nbd_export_aio_context(client->exp),
> +                                            nbd_wake_read_bh, client);
> +                }

Doesn't the condition have to move inside the BH to avoid the race?

Checking client->recv_coroutine != NULL could work here because I don't
think it can go from NULL to something while we're quiescing, but
client->read_yielding can still change until the BH runs and we know
that the nbd_co_trip() coroutine has yielded. It seems easiest to just
move the whole condition to the BH.

> +                return true;
>              }
> -
> -            return true;
>          }
>      }

The rest looks good to me.

Kevin


