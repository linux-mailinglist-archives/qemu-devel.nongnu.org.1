Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63047B9D94
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOjg-0003ft-JI; Thu, 05 Oct 2023 09:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoOje-0003fj-3A
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoOjb-0007jk-P2
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696513787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhBEQpwJGHngATaGB5FMEbYXSre5urSJHCpf9OHdp1E=;
 b=PjjB1Z151jruyCXgPifaZhs7m6e/wwU5qpnYMVdlV0DHudbVrzMxDwZGJkPOqmZk41+aZf
 nVCdfsjtl2T4TcFDftvRVCGMZHDE9sRoeComtyi4XD6kEpNX2U/pIvKS4f8b76tsfI/X53
 zDwqIMQgLrYn7kO45QuXMiYCsTMtXPo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-etSOHMfDP86LcgtZL9mNAw-1; Thu, 05 Oct 2023 09:49:35 -0400
X-MC-Unique: etSOHMfDP86LcgtZL9mNAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 631CA1C041AD;
 Thu,  5 Oct 2023 13:49:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB35F402F1E;
 Thu,  5 Oct 2023 13:49:34 +0000 (UTC)
Date: Thu, 5 Oct 2023 08:49:32 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, libguestfs@redhat.com
Subject: Re: [Libguestfs] [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Message-ID: <dlaxybxq6zrujpqfztz26rbr4kyru6upy5wdiv3c7j3akaijhg@twyctydbcg6g>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
 <6b380866-b707-89d5-7478-476582cdd255@yandex-team.ru>
 <bhi75jjd4pv2va73e2h6ypkfuo4wdzpl4s7dqesalsqkrda5ec@js77c4frs25o>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhi75jjd4pv2va73e2h6ypkfuo4wdzpl4s7dqesalsqkrda5ec@js77c4frs25o>
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

On Wed, Oct 04, 2023 at 04:55:02PM -0500, Eric Blake wrote:
> > > +static int
> > > +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> > > +                                 Error **errp)
> > 
> > [..]

> > > +    for (i = 0; i < count; i++) {
> > > +        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
> > > +        if (id == NBD_META_ID_BASE_ALLOCATION) {
> > > +            if (request->contexts->base_allocation) {
> > > +                goto skip;
> > > +            }
> > 
> > should we also check that base_allocation is negotiated?
> 
> Oh, good point.  Without that check, the client can pass in random id
> numbers that it never negotiated.  I've queued 1-11 and will probably
> send a pull request for those this week, while respinning this patch
> to fix the remaining issues you pointed out.

I'm squashing in the following. If you can review it today, I'll
include it in my pull request this afternoon; if not, we still have
time before soft freeze to get it in the next batch.

diff --git i/nbd/server.c w/nbd/server.c
index 30816b42386..62654579cbc 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -2478,19 +2478,22 @@ nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
     for (i = 0; i < count; i++) {
         id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
         if (id == NBD_META_ID_BASE_ALLOCATION) {
-            if (request->contexts->base_allocation) {
+            if (!client->contexts.base_allocation ||
+                request->contexts->base_allocation) {
                 goto skip;
             }
             request->contexts->base_allocation = true;
         } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
-            if (request->contexts->allocation_depth) {
+            if (!client->contexts.allocation_depth ||
+                request->contexts->allocation_depth) {
                 goto skip;
             }
             request->contexts->allocation_depth = true;
         } else {
-            int idx = id - NBD_META_ID_DIRTY_BITMAP;
+            unsigned idx = id - NBD_META_ID_DIRTY_BITMAP;

-            if (idx > nr_bitmaps || request->contexts->bitmaps[idx]) {
+            if (idx > nr_bitmaps || !client->contexts.bitmaps[idx] ||
+                request->contexts->bitmaps[idx]) {
                 goto skip;
             }
             request->contexts->bitmaps[idx] = true;
diff --git i/nbd/trace-events w/nbd/trace-events
index 3cf2d00e458..00ae3216a11 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -70,7 +70,7 @@ nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t si
 nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
 nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
 nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
-nbd_co_receive_block_status_payload_compliance(uint64_t from, int len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%x"
+nbd_co_receive_block_status_payload_compliance(uint64_t from, uint64_t len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%" PRIx64
 nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
 nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


