Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34197712858
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YSs-0004Xc-SA; Fri, 26 May 2023 10:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2YSn-0004XC-T6
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2YSm-0000oh-9N
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685111439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6/N87vPtE14qzYz+LaLxoF0i5xRY+o1iMIYzaPCJ9M8=;
 b=VSGZCZUqLmkiYGmDaXY1Vz/azZeWle0wIt4IeA4EgJmULSEOw2u3lnRKjbjg93Z2GhVU3G
 4P7P39c3aklD1pTdJxfBPS6g56a5QCFGn0gIyBX/ik4Ie9G2CpeG5Y7ffu6S4r/4wAF9VT
 /LrtEoTrCcQRApt2KC/Pn4K/eSG0Itk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-BeR8Rw1nMEyU_8EMtUodmA-1; Fri, 26 May 2023 10:30:37 -0400
X-MC-Unique: BeR8Rw1nMEyU_8EMtUodmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4786E802E58;
 Fri, 26 May 2023 14:30:37 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71FA1121314;
 Fri, 26 May 2023 14:30:36 +0000 (UTC)
Date: Fri, 26 May 2023 09:30:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, hreitz@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 08/12] copy-before-write: Fix open with child in iothread
Message-ID: <eeobvobc5u23dgkxioqg24bpg63xotaqasbm72ovnfhhtazmcd@fp74jmdfauru>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-9-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 25, 2023 at 02:47:09PM +0200, Kevin Wolf wrote:
> The AioContext lock must not be held for bdrv_open_child(), but it is
> necessary for the followig operations, in particular those using nested

following

> event loops in coroutine wrappers.
> 
> Temporarily dropping the main AioContext lock is not necessary because
> we know we run in the main thread.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/copy-before-write.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


