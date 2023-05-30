Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5A716C2C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43zA-0007fA-Jq; Tue, 30 May 2023 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q43z9-0007f2-AK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q43z7-0007vA-RU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685470936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmH09dm4QP0vUJo/pyMHQO1q6VVUgihYoHwVj0LCyE0=;
 b=RF0etdmpuB5+mw7/FRcGJLWKT4yptip68yaA8Mgzw8YKNcuTfyHVcVhglCokYtpdzcIuig
 a5OLbZttsrUai8J3RwbCCPX2ow1023ot0iVY7PtCDiOIdWn9spuZV0hZo8+L6KObkJB6+5
 BYJvy/Xy0sSVU/HFM7j2Y/8tNOC2xyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-Wtp1TD-EMwS6-OfuP6n75g-1; Tue, 30 May 2023 14:22:15 -0400
X-MC-Unique: Wtp1TD-EMwS6-OfuP6n75g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5CFA85A5BB;
 Tue, 30 May 2023 18:22:14 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F2440CFD45;
 Tue, 30 May 2023 18:22:13 +0000 (UTC)
Date: Tue, 30 May 2023 13:22:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, 
 libguestfs@redhat.com
Subject: Re: [Libguestfs] [PATCH v3 05/14] nbd: Add types for extended headers
Message-ID: <xbf2ds5njx76p2sfv47dvq6p376gcoc437ezq667awgbm4nji4@x3fxx7ub4a7m>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-6-eblake@redhat.com>
 <b81e6f07-7c1c-f1e2-10bc-5c0ea436b5cf@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81e6f07-7c1c-f1e2-10bc-5c0ea436b5cf@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 30, 2023 at 04:23:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Add the constants and structs necessary for later patches to start
> > implementing the NBD_OPT_EXTENDED_HEADERS extension in both the client
> > and server, matching recent commit e6f3b94a934] in the upstream nbd
> > project.  This patch does not change any existing behavior, but merely
> > sets the stage.
> > 
> > This patch does not change the status quo that neither the client nor
> > server use a packed-struct representation for the request header.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> > ---
> >   docs/interop/nbd.txt |  1 +
> >   include/block/nbd.h  | 74 ++++++++++++++++++++++++++++++++------------
> >   nbd/common.c         | 10 +++++-
> >   3 files changed, 65 insertions(+), 20 deletions(-)
> > 
> > diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> > index f5ca25174a6..abaf4c28a96 100644
> > --- a/docs/interop/nbd.txt
> > +++ b/docs/interop/nbd.txt
> > @@ -69,3 +69,4 @@ NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
> >   NBD_CMD_FLAG_FAST_ZERO
> >   * 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
> >   * 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
> > +* 8.1: NBD_OPT_EXTENDED_HEADERS
> > diff --git a/include/block/nbd.h b/include/block/nbd.h
> > index 50626ab2744..d753fb8006f 100644
> > --- a/include/block/nbd.h
> > +++ b/include/block/nbd.h
> > @@ -87,13 +87,24 @@ typedef struct NBDStructuredReplyChunk {
> >       uint32_t length; /* length of payload */
> >   } QEMU_PACKED NBDStructuredReplyChunk;
> > 
> 
> [..]
> 
> > -/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
> > +/* Extent array for NBD_REPLY_TYPE_BLOCK_STATUS */
> 
> Why? NBDExtent is one extent, not extent array.

It's not the entire chunk either, because that also includes the
header and the metacontext id that are not part of the extent array.
Maybe 'Extent array element', which matches our wire layout of:

<-  chunk                  ->
<- hdr -><- payload        ->
 ...     id  <- array      ->
             ext[0] ext[1]...

> 
> >   typedef struct NBDExtent {
> >       uint32_t length;
> >       uint32_t flags; /* NBD_STATE_* */
> >   } QEMU_PACKED NBDExtent;
> > 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


