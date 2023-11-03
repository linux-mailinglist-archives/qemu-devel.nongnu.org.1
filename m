Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259EC7E0018
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:46:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqjy-00062g-Or; Fri, 03 Nov 2023 05:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyqjw-000627-Sr
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyqjv-0001nm-BC
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699004717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDsXqmr735XngXXLrmtT2VOrSnX1jNpmU/ylsdRgnPk=;
 b=dh8nwsl6jGbZqYJy/hEQ7jLMHP2BqGo+Lpoc7MaJJPq2T2+xsuZp4yDf2xBOFK6zPO0K7q
 qaKf07paBQe6fhNToeCypzRoQWjCjdTlSmYkuuhvwxOUl47l2lg/9MGwe7IILTKEwFnRjW
 n0jFbsNNJutnJYSYNsQhCq6Eev1CH8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-oWCxn9RZM4qJD_TW9fOYhg-1; Fri, 03 Nov 2023 05:45:14 -0400
X-MC-Unique: oWCxn9RZM4qJD_TW9fOYhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3929E8F15C6;
 Fri,  3 Nov 2023 09:45:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CF2C25C0;
 Fri,  3 Nov 2023 09:45:12 +0000 (UTC)
Date: Fri, 3 Nov 2023 10:45:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/24] block: Mark bdrv_root_attach_child() GRAPH_WRLOCK
Message-ID: <ZUTBJ0j7ZZDiqSdX@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
 <20231027155333.420094-5-kwolf@redhat.com>
 <iniiwlxhldnjmb65cr5cfao4tsynwpu5apfkqcuhhupwkodpvl@hfdxidvzspyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iniiwlxhldnjmb65cr5cfao4tsynwpu5apfkqcuhhupwkodpvl@hfdxidvzspyc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 27.10.2023 um 22:22 hat Eric Blake geschrieben:
> On Fri, Oct 27, 2023 at 05:53:13PM +0200, Kevin Wolf wrote:
> > Instead of taking the writer lock internally, require callers to already
> > hold it when calling bdrv_root_attach_child(). These callers will
> > typically already hold the graph lock once the locking work is
> > completed, which means that they can't call functions that take it
> > internally.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block_int-global-state.h | 13 +++++++------
> >  block.c                                |  5 +----
> >  block/block-backend.c                  |  2 ++
> >  blockjob.c                             |  2 ++
> >  4 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > +++ b/block.c
> > @@ -3214,8 +3214,6 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
> >  
> >      GLOBAL_STATE_CODE();
> >  
> > -    bdrv_graph_wrlock(child_bs);
> > -
> >      child = bdrv_attach_child_common(child_bs, child_name, child_class,
> 
> Do we need some sort of assertion that the caller did indeed grab the
> lock at this point?  Or is that redundant with assertions made in all
> helper functions we are calling where the lock already matters?

The GRAPH_WRLOCK in the header file makes it a compiler error with TSA
enabled if the caller doesn't already hold the lock. And our CI has some
builds with TSA, so even if the maintainer only uses gcc, we'll catch
it.

Kevin


