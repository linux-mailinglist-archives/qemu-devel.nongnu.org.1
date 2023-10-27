Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9F7DA1D2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 22:34:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwTWU-0000EF-9E; Fri, 27 Oct 2023 16:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTWQ-00007y-De
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qwTWO-0001OF-VW
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698438812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DF7MmXdmLCyWqPo3hN5mzkGReFSrKLB81x8j3qDyWw4=;
 b=hqmC+WgLXZU1uOIwA1GeDL57trBsVHbg4QZnjQeGlxBSQYruG/09Cu0ZB5rs3/4Qbsa6NZ
 7Ke7DqJk2pB4JI8W3s3yHKAInja2F3vHg8XfbdvG+RdsCS1FmN4PJUl7kPpVht1uccpFL1
 nrAiwXCTuC+ccxoSTjWEmNS+xV4MIzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503--k5zbwEXMxiq40hJkSXKAQ-1; Fri,
 27 Oct 2023 16:33:29 -0400
X-MC-Unique: -k5zbwEXMxiq40hJkSXKAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 885283C23648;
 Fri, 27 Oct 2023 20:33:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25D4A492BE9;
 Fri, 27 Oct 2023 20:33:27 +0000 (UTC)
Date: Fri, 27 Oct 2023 15:33:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 06/24] block: Mark bdrv_filter_or_cow_bs() and callers
 GRAPH_RDLOCK
Message-ID: <uqnd6cmqt23prby6rgcxlzdja2ldrdiizg6me4v5lbkdirr2fu@dzcpqcijtkn2>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027155333.420094-7-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Oct 27, 2023 at 05:53:15PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_filter_or_cow_bs() need to hold a reader lock for the graph because
> it calls bdrv_filter_or_cow_child(), which accesses bs->file/backing.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-io.h |  3 ++-
>  block.c                      | 31 ++++++++++++++++++-------------
>  block/stream.c               |  4 ++++
>  blockdev.c                   |  2 +-
>  nbd/server.c                 |  6 ++++++
>  5 files changed, 31 insertions(+), 15 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


