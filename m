Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E937BA27C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQQd-0001Fg-27; Thu, 05 Oct 2023 11:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoQQb-0001FN-A6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoQQZ-0000Ab-NC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696520294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOYbt2aGA8JOuKNih7IEd68Z/5qFG4YhjvmQRpwkX+E=;
 b=PqhBmyj+stmm5WK/HQkpqcHovElG8z4HLp82npBs1P2Uzm9nIoxJERlLbLrZ/FGISzWT9r
 vt7Fx4tAhezc4K6SiT5mbUb3FtbCevzre1KKEweNmnX1w1k0h30tbk03fxRwxPnkq9qfWp
 eN7SkrilwBA7AM785brwlD6FFrgimuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-ooE4G4ekMQCRkyBm0hspIQ-1; Thu, 05 Oct 2023 11:38:11 -0400
X-MC-Unique: ooE4G4ekMQCRkyBm0hspIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18A58811E7B;
 Thu,  5 Oct 2023 15:38:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 639AA492B05;
 Thu,  5 Oct 2023 15:38:10 +0000 (UTC)
Date: Thu, 5 Oct 2023 10:38:08 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, 
	vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v7 01/12] nbd/server: Support a request
 payload
Message-ID: <ck34pqcdui6vpzncmvjchzy7vjgdb32apfpau3nztlsfwdd32n@4xuctbm2ycdb>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925192229.3186470-15-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Mon, Sep 25, 2023 at 02:22:31PM -0500, Eric Blake wrote:
> Upcoming additions to support NBD 64-bit effect lengths allow for the
> possibility to distinguish between payload length (capped at 32M) and
> effect length (64 bits, although we generally assume 63 bits because
> of off_t limitations).
[...]

> +++ b/nbd/server.c
> @@ -2322,9 +2322,11 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>                                                 Error **errp)
>  {
>      NBDClient *client = req->client;
> +    bool extended_with_payload;
>      bool check_length = false;
>      bool check_rofs = false;
>      bool allocate_buffer = false;
> +    bool payload_okay = false;
>      unsigned payload_len = 0;

Pre-existing type mismatch caught as a result of Vladimir's review of
12/12, but:

>      int valid_flags = NBD_CMD_FLAG_FUA;
>      int ret;
> @@ -2338,6 +2340,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
> 
>      trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>                                               nbd_cmd_lookup(request->type));
> +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
> +    if (extended_with_payload) {
> +        payload_len = request->len;

this can assign a 64-bit number into a 32-bit variable, which can
truncate to 0,...

> +        check_length = true;
> +    }
> +
>      switch (request->type) {
>      case NBD_CMD_DISC:
>          /* Special case: we're going to disconnect without a reply,
> @@ -2354,6 +2363,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>          break;
> 
>      case NBD_CMD_WRITE:
> +        if (client->mode >= NBD_MODE_EXTENDED) {
> +            if (!extended_with_payload) {
> +                /* The client is noncompliant. Trace it, but proceed. */
> +                trace_nbd_co_receive_ext_payload_compliance(request->from,
> +                                                            request->len);
> +            }
> +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
> +        }
> +        payload_okay = true;
>          payload_len = request->len;

...the pre-existing code is safe only as long as request->len cannot
exceed 32 bytes (which it can't do until later in this series actually
enables extended requests).  Switching the type now is prudent...

>          check_length = true;
>          allocate_buffer = true;
> @@ -2395,6 +2413,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>                     request->len, NBD_MAX_BUFFER_SIZE);
>          return -EINVAL;
>      }
> +    if (payload_len && !payload_okay) {
> +        /*
> +         * For now, we don't support payloads on other commands; but
> +         * we can keep the connection alive by ignoring the payload.
> +         */
> +        assert(request->type != NBD_CMD_WRITE);
> +        request->len = 0;

...otherwise, this check is bypassed for a request size of exactly 4G
if check_length is false and thus the previous conditional for
request->len vs. NBD_MAX_BUFFER_SIZE didn't trigger (prior to this
patch, payload_len was only set for CND_WRITE which also set
check_length).  Thus, I'm squashing in:

diff --git i/nbd/server.c w/nbd/server.c
index 5258064e5ac..1cb66e86a89 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -2327,7 +2327,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
     bool check_rofs = false;
     bool allocate_buffer = false;
     bool payload_okay = false;
-    unsigned payload_len = 0;
+    uint64_t payload_len = 0;
     int valid_flags = NBD_CMD_FLAG_FUA;
     int ret;



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


