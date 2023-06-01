Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE6719674
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eEM-0003RV-Sj; Thu, 01 Jun 2023 05:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4eD2-0002cn-Ls
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4eD0-0001EA-Us
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685610182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SNeeSau94R7ND3ozEwowWElvP7x0UEvY8oyvIybsrKM=;
 b=Cqkgi0Cu8enuYomO2ivbQ0ecZOP2ybctRMfox3uvWuMbt9b6jrfIH0pmtFQOlFDFTn48hA
 xMaapMKy6EAj5gh+3JY10WsIER5tAYzBVamKOhpepY232LfXK+LV5/L97kHZc0GD9QwhcO
 6wFKPHpFNq4lmbYW3+zA2gO8KcVZh6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Iag6WJVKPfGtebwUW6BFog-1; Thu, 01 Jun 2023 05:03:01 -0400
X-MC-Unique: Iag6WJVKPfGtebwUW6BFog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6AA811E7C
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 09:03:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0614C154D7;
 Thu,  1 Jun 2023 09:02:46 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:02:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 16/21] migration/rdma: Unfold hook_ram_load()
Message-ID: <ZHhesX4O2hNOLraR@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <20230530182531.6371-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530182531.6371-17-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Tue, May 30, 2023 at 08:25:26PM +0200, Juan Quintela wrote:
> There is only one flag called with: RAM_CONTROL_BLOCK_REG.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230509120700.78359-6-quintela@redhat.com>
> ---
>  migration/qemu-file.h | 11 -----------
>  migration/rdma.h      |  3 +++
>  migration/qemu-file.c | 10 ----------
>  migration/ram.c       |  6 ++++--
>  migration/rdma.c      | 29 +++++++++--------------------
>  5 files changed, 16 insertions(+), 43 deletions(-)

> diff --git a/migration/rdma.c b/migration/rdma.c
> index a477985c6d..948e93256d 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3811,20 +3811,22 @@ out:
>  }
>  
>  /* Destination:
> - * Called via a ram_control_load_hook during the initial RAM load section which
> - * lists the RAMBlocks by name.  This lets us know the order of the RAMBlocks
> - * on the source.
> - * We've already built our local RAMBlock list, but not yet sent the list to
> - * the source.
> + * Called during the initial RAM load section which lists the
> + * RAMBlocks by name.  This lets us know the order of the RAMBlocks on
> + * the source.  We've already built our local RAMBlock list, but not
> + * yet sent the list to the source.
>   */
> -static int
> -rdma_block_notification_handle(QEMUFile *f, const char *name)
> +int rdma_block_notification_handle(QEMUFile *f, const char *name)
>  {
>      RDMAContext *rdma;
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));

Casting to QIOChannelRDMA ...

>      int curr;
>      int found = -1;
>  
> +    if (!migrate_rdma()) {

..before checking if this is RDMA

> +        return 0;
> +    }
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


