Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 926617DA187
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 21:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwSzC-0008Bk-0s; Fri, 27 Oct 2023 15:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwSzA-0008Bb-ET
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 15:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwSz8-0002DD-Pr
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 15:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698436749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bnf1b74O04wJl5B2f8JkRGp/Qsv9AIK+litJCJG+xCY=;
 b=CuyZDtjZvnrq6RHxIFstDph8fH5Bv3RM5VrtmhBawKmrQYdOhLe7xMcbixZnghmVkXcO5t
 jfMjSLcPnJX+rokrin68AuXMp3G8k8gIrizkUTI8lweA3Yd1ldFXHNg3NGDLb6IaYahVPu
 oVPJHqqY0zyP7wFhq9m0w1V3VNN9YyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-QgkolCkdOBWQPf5BRBcq7g-1; Fri, 27 Oct 2023 15:59:08 -0400
X-MC-Unique: QgkolCkdOBWQPf5BRBcq7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E543B801956;
 Fri, 27 Oct 2023 19:59:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 783BD40C6F79;
 Fri, 27 Oct 2023 19:59:06 +0000 (UTC)
Date: Fri, 27 Oct 2023 14:59:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 02/24] block: Mark bdrv_has_zero_init() and callers
 GRAPH_RDLOCK
Message-ID: <lvzpmt745dpzpw7dgeadkhwzvali755hwxrtuvaakki2jsrpia@rn3aqaxrqysa>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-3-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 27, 2023 at 05:53:11PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_has_zero_init() need to hold a reader lock for the graph because
> it calls bdrv_filter_bs(), which accesses bs->file/backing.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  2 +-
>  include/block/block_int-common.h   |  2 +-
>  block.c                            |  2 +-
>  block/qcow2.c                      |  3 ++-
>  block/raw-format.c                 |  2 +-
>  block/vdi.c                        |  2 +-
>  block/vhdx.c                       | 13 +++++++++----
>  block/vmdk.c                       |  2 +-
>  block/vpc.c                        |  2 +-
>  blockdev.c                         |  2 ++
>  qemu-img.c                         |  2 ++
>  11 files changed, 22 insertions(+), 12 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


