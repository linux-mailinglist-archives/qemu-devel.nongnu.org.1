Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A844F7D3AB3
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwow-0005BW-BS; Mon, 23 Oct 2023 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quwos-00059I-9i
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quwoq-0001Ir-7T
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698074775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9uTfxbLG36YjodNUJq6jleTJ5tVh5ds3FOlqEnYlCM=;
 b=B1SZ0KNGp78IfVKLiZZyPpy8YWYnC3sSaE4BDi/A9uYVDQqMXOsnFEm0HfkLhUkn5GRKeq
 K3wwtww1zvD5WcZ0C4WDGdNCmFSLWtDd9m/a08r114M3AX7TircdHv5wJRrScPzutxdYl4
 nt3yA50eNiUfpRjdfzTdCWQdbfLSfJ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-e7E9CJlyOnuOOMunWP6V0w-1; Mon, 23 Oct 2023 11:26:02 -0400
X-MC-Unique: e7E9CJlyOnuOOMunWP6V0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED8953C14916;
 Mon, 23 Oct 2023 15:26:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC77125C2;
 Mon, 23 Oct 2023 15:26:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C072821E6A1F; Mon, 23 Oct 2023 17:26:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH] block/snapshot: Fix compiler warning with -Wshadow=local
References: <20231023144402.103139-1-thuth@redhat.com>
Date: Mon, 23 Oct 2023 17:26:00 +0200
In-Reply-To: <20231023144402.103139-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 23 Oct 2023 16:44:02 +0200")
Message-ID: <87zg09jr7b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> No need to declare a new variable in the the inner code block
> here, we can re-use the "ret" variable that has been declared
> at the beginning of the function. With this change, the code
> can now be successfully compiled with -Wshadow=local again.
>
> Fixes: a32e781838 ("Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 6e16eb803a..50adf5381e 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -629,8 +629,8 @@ int bdrv_all_goto_snapshot(const char *name,
>      while (iterbdrvs) {
>          BlockDriverState *bs = iterbdrvs->data;
>          AioContext *ctx = bdrv_get_aio_context(bs);
> -        int ret = 0;
>          bool all_snapshots_includes_bs;

Blank line between declarations and statements, please.

I'm not sure we actually need the assignment.  Proving we don't looks
like a poor use of our time, though.

I recommend to move the assignment from here...

> +        ret = 0;
>  
>          aio_context_acquire(ctx);
>          bdrv_graph_rdlock_main_loop();
           all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
           bdrv_graph_rdunlock_main_loop();

... down to here.

           if (devices || all_snapshots_includes_bs) {
               ret = bdrv_snapshot_goto(bs, name, errp);
           }
           aio_context_release(ctx);
           if (ret < 0) {

We lose the symmetry with the other three while (iterbdrvs) loops.  Do
we care?


