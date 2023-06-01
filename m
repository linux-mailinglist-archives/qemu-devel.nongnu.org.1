Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39735719624
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4e8L-0007H9-SZ; Thu, 01 Jun 2023 04:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4e8K-0007Gj-21
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4e8H-0000Aa-OD
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685609888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FQV/YSOMi2Xdh3XqezR5C79nq6bf6BjyTK9g5kJUb8k=;
 b=U3NWM0OmJbZSv7waiAGKUA4gNqZlk7KHogpopTi+aAU+5L03qKgib1DJFbukrpHQs0MVl3
 niMsQpFIablgNY3n0EwQEPvr2JyGCgEDE6m8Zd8T+bJwuxUG8RGeVrpDAPQpBIu7ptfyc2
 Tdt8OuHxUNPpM9OeAcYVtcHcdNqfg1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-qc9wZgQ_OhODlJ0Te7m4mw-1; Thu, 01 Jun 2023 04:58:07 -0400
X-MC-Unique: qc9wZgQ_OhODlJ0Te7m4mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB75F8007D9
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 08:58:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1099240CFD45;
 Thu,  1 Jun 2023 08:58:02 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:57:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 13/21] migration/rdma: Unfold ram_control_before_iterate()
Message-ID: <ZHhdlw9BBJxti6/A@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <20230530182531.6371-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530182531.6371-14-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 30, 2023 at 08:25:23PM +0200, Juan Quintela wrote:
> Once there:
> - Remove unused data parameter
> - unfold it in its callers.
> - change all callers to call qemu_rdma_registration_start()
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230509120700.78359-3-quintela@redhat.com>
> ---
>  migration/qemu-file.h |  2 --
>  migration/rdma.h      |  7 +++++++
>  migration/qemu-file.c | 13 +------------
>  migration/ram.c       | 16 +++++++++++++---
>  migration/rdma.c      |  6 ++----
>  5 files changed, 23 insertions(+), 21 deletions(-)

> diff --git a/migration/rdma.c b/migration/rdma.c
> index c11863e614..6ca89ff090 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3863,13 +3863,12 @@ static int rdma_load_hook(QEMUFile *f, uint64_t flags, void *data)
>      }
>  }
>  
> -static int qemu_rdma_registration_start(QEMUFile *f,
> -                                        uint64_t flags, void *data)
> +int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));

This is cast the migration QIOChannel to a QIOChannelRDMA....

>      RDMAContext *rdma;
>  
> -    if (migration_in_postcopy()) {
> +    if (!migrate_rdma () || migration_in_postcopy()) {


....before the code checks whether this is an RDMA migration.

This looks unsafe.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


