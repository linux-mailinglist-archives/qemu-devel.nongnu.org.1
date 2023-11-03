Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE57E0028
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:07:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyr3s-0001jR-JI; Fri, 03 Nov 2023 06:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyr3r-0001j0-0N
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyr3p-0007OP-FV
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699005952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qdWY7gLTE8zUc4F6PrIksYiDnuk3fw86un2/vnTE7c=;
 b=htgDwBWZLUydDWtBe6sHnFlUC1I8Gm7Tb8oH4Zp4KpE4SxyvaN4IIHK0ve6+nCnsgYlQhE
 gsk2dcThaQ7iWw8L5iU2ixr1XDtU5rKTYO9vDbUOR4CRpYQTBKMPLFec8zDsv88NlwAltf
 PYgMk9dTgXS22LIewSkndsk0ERu3jCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-eeEn1H_xMh6z8DIe_wU57Q-1; Fri, 03 Nov 2023 06:05:48 -0400
X-MC-Unique: eeEn1H_xMh6z8DIe_wU57Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D96F185A785;
 Fri,  3 Nov 2023 10:05:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E4AD492BFA;
 Fri,  3 Nov 2023 10:05:47 +0000 (UTC)
Date: Fri, 3 Nov 2023 11:05:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 23/24] block: Take graph lock for most of .bdrv_open
Message-ID: <ZUTF+hkXxLLOE1/R@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-24-kwolf@redhat.com>
 <pmp364kq4s6ejk5xdcofx3ccfqphtmp22a3h3ddfay6nc2ltd2@asi3pud6qxhj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmp364kq4s6ejk5xdcofx3ccfqphtmp22a3h3ddfay6nc2ltd2@asi3pud6qxhj>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 30.10.2023 um 22:34 hat Eric Blake geschrieben:
> On Fri, Oct 27, 2023 at 05:53:32PM +0200, Kevin Wolf wrote:
> > Most implementations of .bdrv_open first open their file child (which is
> > an operation that internally takes the write lock and therefore we
> > shouldn't hold the graph lock while calling it), and afterwards many
> > operations that require holding the graph lock, e.g. for accessing
> > bs->file.
> > 
> > This changes block drivers that follow this pattern to take the graph
> > lock after opening the child node.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/blkdebug.c          | 16 ++++++++++------
> >  block/bochs.c             |  4 ++++
> >  block/cloop.c             |  4 ++++
> >  block/copy-before-write.c |  2 ++
> >  block/copy-on-read.c      |  4 ++--
> >  block/crypto.c            |  4 ++++
> >  block/dmg.c               |  5 +++++
> >  block/filter-compress.c   |  2 ++
> >  block/parallels.c         |  4 ++--
> >  block/preallocate.c       |  4 ++++
> >  block/qcow.c              | 11 +++++++----
> >  block/raw-format.c        |  6 ++++--
> >  block/snapshot-access.c   |  3 +++
> >  block/throttle.c          |  3 +++
> >  block/vdi.c               |  4 ++--
> >  block/vpc.c               |  4 ++--
> >  16 files changed, 60 insertions(+), 20 deletions(-)
> > 
> 
> > +++ b/block/qcow.c
> > @@ -124,9 +124,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
> >  
> >      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
> >      if (ret < 0) {
> > -        goto fail;
> > +        goto fail_unlocked;
> >      }
> >  
> > +    bdrv_graph_rdlock_main_loop();
> > +
> >      ret = bdrv_pread(bs->file, 0, sizeof(header), &header, 0);
> >      if (ret < 0) {
> >          goto fail;
> > @@ -301,11 +303,9 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
> >      }
> >  
> >      /* Disable migration when qcow images are used */
> > -    bdrv_graph_rdlock_main_loop();
> >      error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
> >                 "does not support live migration",
> >                 bdrv_get_device_or_node_name(bs));
> > -    bdrv_graph_rdunlock_main_loop();
> >  
> >      ret = migrate_add_blocker(s->migration_blocker, errp);
> >      if (ret < 0) {
> > @@ -316,9 +316,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
> >      qobject_unref(encryptopts);
> >      qapi_free_QCryptoBlockOpenOptions(crypto_opts);
> >      qemu_co_mutex_init(&s->lock);
> > +    bdrv_graph_rdunlock_main_loop();
> >      return 0;
> >  
> > - fail:
> > +fail:
> 
> Why the change in indentation?  At least emacs intentionally prefers
> to indent top-level labels 1 column in, so that they cannot be
> confused with function declarations in the first column.  But that's cosmetic.

The coding style document isn't explicit about it, but the overwhelming
majority of code both in the block layer and QEMU in general prefers the
style without indentation:

$ git grep '^ [A-Za-z_]\+:$' | wc -l
392
$ git grep '^[A-Za-z_]\+:$' | wc -l
2739

$ git grep '^ [A-Za-z_]\+:$' block | wc -l
27
$ git grep '^[A-Za-z_]\+:$' block | wc -l
332

So I wanted to add the new label with the usual convention, but also not
make the function inconsistent, which is why I reindented the existing
label.

Kevin


