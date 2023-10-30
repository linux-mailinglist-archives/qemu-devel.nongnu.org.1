Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED67DC1FF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZuP-0002h9-EI; Mon, 30 Oct 2023 17:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZuN-0002gJ-1h
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxZuL-00015z-H7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698701688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Oasw1gRdDWBsXP5jDqDQeY9U0WCb0IPCp2eB9YWUa4=;
 b=brLNaTUb3Xnwh8fltbRYmTl+8qfhXdM1iNmLI0WVQCJWhYQUUN6KnA+2ktL1in22AgUKiA
 rTiZcPMo8DZflFWtoGabU88w76eodo3aWmXcOPBDw3HMEYZ81uQVy2+wsMDYsvQqZkjPHX
 6oUdYJhN+fuo79YJezMVgKN2IpmQrj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-yXCEXMSwMAe--Mvq80bW6g-1; Mon, 30 Oct 2023 17:34:45 -0400
X-MC-Unique: yXCEXMSwMAe--Mvq80bW6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21606101A529;
 Mon, 30 Oct 2023 21:34:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2089502D;
 Mon, 30 Oct 2023 21:34:43 +0000 (UTC)
Date: Mon, 30 Oct 2023 16:34:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 23/24] block: Take graph lock for most of .bdrv_open
Message-ID: <pmp364kq4s6ejk5xdcofx3ccfqphtmp22a3h3ddfay6nc2ltd2@asi3pud6qxhj>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-24-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-24-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 05:53:32PM +0200, Kevin Wolf wrote:
> Most implementations of .bdrv_open first open their file child (which is
> an operation that internally takes the write lock and therefore we
> shouldn't hold the graph lock while calling it), and afterwards many
> operations that require holding the graph lock, e.g. for accessing
> bs->file.
> 
> This changes block drivers that follow this pattern to take the graph
> lock after opening the child node.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/blkdebug.c          | 16 ++++++++++------
>  block/bochs.c             |  4 ++++
>  block/cloop.c             |  4 ++++
>  block/copy-before-write.c |  2 ++
>  block/copy-on-read.c      |  4 ++--
>  block/crypto.c            |  4 ++++
>  block/dmg.c               |  5 +++++
>  block/filter-compress.c   |  2 ++
>  block/parallels.c         |  4 ++--
>  block/preallocate.c       |  4 ++++
>  block/qcow.c              | 11 +++++++----
>  block/raw-format.c        |  6 ++++--
>  block/snapshot-access.c   |  3 +++
>  block/throttle.c          |  3 +++
>  block/vdi.c               |  4 ++--
>  block/vpc.c               |  4 ++--
>  16 files changed, 60 insertions(+), 20 deletions(-)
> 

> +++ b/block/qcow.c
> @@ -124,9 +124,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
>      if (ret < 0) {
> -        goto fail;
> +        goto fail_unlocked;
>      }
>  
> +    bdrv_graph_rdlock_main_loop();
> +
>      ret = bdrv_pread(bs->file, 0, sizeof(header), &header, 0);
>      if (ret < 0) {
>          goto fail;
> @@ -301,11 +303,9 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      /* Disable migration when qcow images are used */
> -    bdrv_graph_rdlock_main_loop();
>      error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    bdrv_graph_rdunlock_main_loop();
>  
>      ret = migrate_add_blocker(s->migration_blocker, errp);
>      if (ret < 0) {
> @@ -316,9 +316,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      qobject_unref(encryptopts);
>      qapi_free_QCryptoBlockOpenOptions(crypto_opts);
>      qemu_co_mutex_init(&s->lock);
> +    bdrv_graph_rdunlock_main_loop();
>      return 0;
>  
> - fail:
> +fail:

Why the change in indentation?  At least emacs intentionally prefers
to indent top-level labels 1 column in, so that they cannot be
confused with function declarations in the first column.  But that's cosmetic.

> +    bdrv_graph_rdunlock_main_loop();
> +fail_unlocked:
>      g_free(s->l1_table);
>      qemu_vfree(s->l2_cache);
>      g_free(s->cluster_cache);

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


