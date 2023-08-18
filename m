Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0B780F47
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1Uz-0001vh-Jd; Fri, 18 Aug 2023 11:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX1Uq-0001tL-M1
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX1Uo-0005pq-G8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692372881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbZBHxBS6f1NRqol718NP515SeJIK+VKS3d/wQlQTis=;
 b=exL3DBGuXc80QjsDbhphuwatVm30Dt2NaNAIaLZhNm8jlF8O2CPlwxP6HCjh+qG3N3CrYc
 9OXnPy2v8UZpw3fkoQpQLHkJsmLkpH2qVerhQDNlhRnL105uHVg/CSMKL+IJnL97drrQW4
 s6nNZBU9wJZRVcoFjudaAuReMwDVmTQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-qYrZlvEqM7mw1XS0z_j80A-1; Fri, 18 Aug 2023 11:34:39 -0400
X-MC-Unique: qYrZlvEqM7mw1XS0z_j80A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA02C28237D6;
 Fri, 18 Aug 2023 15:34:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33F6B492C13;
 Fri, 18 Aug 2023 15:34:38 +0000 (UTC)
Date: Fri, 18 Aug 2023 10:34:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/21] preallocate: Don't poll during permission updates
Message-ID: <lvj73pqyickfk2kinh2c3ibicvgfk2gld6v7a6bnxhk63xnjiz@rqdf4rwiwwew>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-4-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Thu, Aug 17, 2023 at 02:50:02PM +0200, Kevin Wolf wrote:
> When the permission related BlockDriver callbacks are called, we are in
> the middle of an operation traversing the block graph. Polling in such a
> place is a very bad idea because the graph could change in unexpected
> ways. In the future, callers will also hold the graph lock, which is
> likely to turn polling into a deadlock.

One I'm sure you encountered before writing this patch ;)

> 
> So we need to get rid of calls to functions like bdrv_getlength() or
> bdrv_truncate() there as these functions poll internally. They are
> currently used so that when no parent has write/resize permissions on
> the image any more, the preallocate filter drops the extra preallocated
> area in the image file and gives up write/resize permissions itself.

Sounds like a sane plan, and the patch matches the implementation
spelled out here.

> 
> In order to achieve this without polling in .bdrv_check_perm, don't
> immediately truncate the image, but only schedule a BH to do so. The
> filter keeps the write/resize permissions a bit longer now until the BH
> has executed.
> 
> There is one case in which delaying doesn't work: Reopening the image
> read-only. In this case, bs->file will likely be reopened read-only,
> too, so keeping write permissions a bit longer on it doesn't work. But
> we can already cover this case in preallocate_reopen_prepare() and not
> rely on the permission updates for it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/preallocate.c | 89 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 69 insertions(+), 20 deletions(-)
>  

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


