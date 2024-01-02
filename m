Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E7821EBF
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 16:33:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKgkf-0000oS-KB; Tue, 02 Jan 2024 10:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rKgkd-0000nq-Ec
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rKgkb-0005Vm-V0
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704209537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gMqZkoedzQY3vSkIWdqk5Imu1PiDZF/l29zl6IvstiA=;
 b=aYUkf/5dvaNYNunZ8VKYj+M6kDFeomYqu30wzTEjdwfg9nX8GPyaNndI/YYUNBXX5qHFud
 1PiCWb27SZjo3afZyc98XLnaExHXfohcZKRbU17WPMpJorMr98FBD1uCoudhkbI9U0Bekm
 CRyvwzK/zIVNviAhVQ4GL1OvAELlrIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-LVkors4xOmyFarwRvy3_Pg-1; Tue, 02 Jan 2024 10:32:14 -0500
X-MC-Unique: LVkors4xOmyFarwRvy3_Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A9C88D543;
 Tue,  2 Jan 2024 15:32:13 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C26DC15968;
 Tue,  2 Jan 2024 15:32:11 +0000 (UTC)
Date: Tue, 2 Jan 2024 09:32:09 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, 
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 5/6] nbd/server: only traverse NBDExport->clients from
 main loop thread
Message-ID: <5mdx2vuifvbg6umrktor3g4hyvgbfxkzajvlk6lfv4od5e2cej@wul2u4rz3iuy>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221014903.1537962-6-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Dec 20, 2023 at 08:49:02PM -0500, Stefan Hajnoczi wrote:
> The NBD clients list is currently accessed from both the export
> AioContext and the main loop thread. When the AioContext lock is removed
> there will be nothing protecting the clients list.
> 
> Adding a lock around the clients list is tricky because NBDClient
> structs are refcounted and may be freed from the export AioContext or
> the main loop thread. nbd_export_request_shutdown() -> client_close() ->
> nbd_client_put() is also tricky because the list lock would be held
> while indirectly dropping references to NDBClients.
> 
> A simpler approach is to only allow nbd_client_put() and client_close()
> calls from the main loop thread. Then the NBD clients list is only
> accessed from the main loop thread and no fancy locking is needed.
> 
> nbd_trip() just needs to reschedule itself in the main loop AioContext
> before calling nbd_client_put() and client_close(). This costs more CPU
> cycles per NBD request but is needed for thread-safety when the
> AioContext lock is removed.

Late review (now that this is already in), but this is a bit
misleading.  The CPU penalty is only incurred for NBD_CMD_DISC or
after detection of a protocol error (that is, only when the connection
is being shut down), and not on every NBD request.

Thanks for working on this!

> 
> Note that nbd_client_get() can still be called from either thread, so
> make NBDClient->refcount atomic.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  nbd/server.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


