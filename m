Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A10197187EC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PC7-0004Cz-EM; Wed, 31 May 2023 13:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4PC2-0004Bp-JJ; Wed, 31 May 2023 13:01:03 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4PBy-0003cc-Ce; Wed, 31 May 2023 13:01:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49a:0:640:edd6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id D0CF763363;
 Wed, 31 May 2023 20:00:44 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h0Rats3OquQ0-F5Bqhhe1; Wed, 31 May 2023 20:00:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685552443; bh=38S2vJmL/yGtKl97zQmkxTpWLgZJClHd09SHH+t3+WY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qRZ+b3KgUy/VojzXtkBivIAi+GBN/Q1EG+aWo7D3U1S3DVXXL6IKF6U8L4c7XMAKD
 KUlz9B6Dw+fEid0Pg/0yCB4vWE99tjj/eKfyvK43QjBW/CJd3dh+E1OXQrXP400a6S
 cu/Gq55jhTHAKZpXr0+244fXh4kyhyi6J6IWTIpw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f2f89a4e-816e-165e-2d6a-7076f1ced823@yandex-team.ru>
Date: Wed, 31 May 2023 20:00:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 11/14] nbd/client: Accept 64-bit block status chunks
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-12-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-12-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 15.05.23 22:53, Eric Blake wrote:
> Because we use NBD_CMD_FLAG_REQ_ONE with NBD_CMD_BLOCK_STATUS, a
> client in narrow mode should not be able to provoke a server into
> sending a block status result larger than the client's 32-bit request.
> But in extended mode, a 64-bit status request must be able to handle a
> 64-bit status result, once a future patch enables the client
> requesting extended mode.  We can also tolerate a non-compliant server
> sending the new chunk even when it should not.
> 
> In normal execution, we are only requesting "base:allocation" which
> never exceeds 32 bits. But during testing with x-dirty-bitmap, we can
> force qemu to connect to some other context that might have 64-bit
> status bit; however, we ignore those upper bits (other than mapping
> qemu:allocation-depth into something that 'qemu-img map --output=json'
> can expose), and since it is only testing, we really don't bother with
> checking whether more than the two least-significant bits are set.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/nbd.c        | 39 ++++++++++++++++++++++++++++-----------
>   block/trace-events |  1 +
>   2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index d6caea44928..150dfe7170c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -610,13 +610,16 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
>    */
>   static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
>                                            NBDStructuredReplyChunk *chunk,
> -                                         uint8_t *payload, uint64_t orig_length,
> -                                         NBDExtent *extent, Error **errp)
> +                                         uint8_t *payload, bool wide,
> +                                         uint64_t orig_length,
> +                                         NBDExtentExt *extent, Error **errp)
>   {
>       uint32_t context_id;
> +    uint32_t count = 0;
> +    size_t len = wide ? sizeof(*extent) : sizeof(NBDExtent);
> 
>       /* The server succeeded, so it must have sent [at least] one extent */
> -    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
> +    if (chunk->length < sizeof(context_id) + wide * sizeof(count) + len) {
>           error_setg(errp, "Protocol error: invalid payload for "
>                            "NBD_REPLY_TYPE_BLOCK_STATUS");
>           return -EINVAL;
> @@ -631,8 +634,14 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
>           return -EINVAL;
>       }
> 
> -    extent->length = payload_advance32(&payload);
> -    extent->flags = payload_advance32(&payload);
> +    if (wide) {
> +        count = payload_advance32(&payload);
> +        extent->length = payload_advance64(&payload);
> +        extent->flags = payload_advance64(&payload);
> +    } else {
> +        extent->length = payload_advance32(&payload);
> +        extent->flags = payload_advance32(&payload);
> +    }
> 
>       if (extent->length == 0) {
>           error_setg(errp, "Protocol error: server sent status chunk with "
> @@ -672,7 +681,8 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
>        * connection; just ignore trailing extents, and clamp things to
>        * the length of our request.
>        */
> -    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
> +    if (count != wide ||

hard to read for me. Could it be simply "count > 1 ||" ?

> +        chunk->length > sizeof(context_id) + wide * sizeof(count) + len) {
>           trace_nbd_parse_blockstatus_compliance("more than one extent");
>       }
>       if (extent->length > orig_length) {
> @@ -1117,7 +1127,7 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h
> 
>   static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>                                                            uint64_t handle, uint64_t length,
> -                                                         NBDExtent *extent,
> +                                                         NBDExtentExt *extent,
>                                                            int *request_ret, Error **errp)
>   {
>       NBDReplyChunkIter iter;
> @@ -1125,6 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>       void *payload = NULL;
>       Error *local_err = NULL;
>       bool received = false;
> +    bool wide = false;
> 
>       assert(!extent->length);
>       NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
> @@ -1134,7 +1145,13 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>           assert(nbd_reply_is_structured(&reply));
> 
>           switch (chunk->type) {
> +        case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
> +            wide = true;
> +            /* fallthrough */
>           case NBD_REPLY_TYPE_BLOCK_STATUS:
> +            if (s->info.extended_headers != wide) {
> +                trace_nbd_extended_headers_compliance("block_status");

You set wide to true once, on first "NBD_REPLY_TYPE_BLOCK_STATUS_EXT", and then parse following "NBD_REPLY_TYPE_BLOCK_STATUS" if the come with wide=true.

Should it be:

--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1135,7 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
      void *payload = NULL;
      Error *local_err = NULL;
      bool received = false;
-    bool wide = false;
+    bool wide;
  
      assert(!extent->length);
      NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
@@ -1146,9 +1146,8 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
  
          switch (chunk->type) {
          case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
-            wide = true;
-            /* fallthrough */
          case NBD_REPLY_TYPE_BLOCK_STATUS:
+            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
              if (s->info.extended_headers != wide) {
                  trace_nbd_extended_headers_compliance("block_status");
              }


> +            }
>               if (received) {
>                   nbd_channel_error(s, -EINVAL);
>                   error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
> @@ -1142,9 +1159,9 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
>               }
>               received = true;
> 
> -            ret = nbd_parse_blockstatus_payload(s, &reply.structured,
> -                                                payload, length, extent,
> -                                                &local_err);
> +            ret = nbd_parse_blockstatus_payload(
> +                s, &reply.structured, payload, wide,
> +                length, extent, &local_err);
>               if (ret < 0) {
>                   nbd_channel_error(s, ret);
>                   nbd_iter_channel_error(&iter, ret, &local_err);
> @@ -1374,7 +1391,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
>           int64_t *pnum, int64_t *map, BlockDriverState **file)
>   {
>       int ret, request_ret;
> -    NBDExtent extent = { 0 };
> +    NBDExtentExt extent = { 0 };
>       BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
>       Error *local_err = NULL;
> 
> diff --git a/block/trace-events b/block/trace-events
> index 48dbf10c66f..afb32fcce5b 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -168,6 +168,7 @@ iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, ui
>   # nbd.c
>   nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-compliant server: %s"
>   nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
> +nbd_extended_headers_compliance(const char *type) "server sent non-compliant %s chunk not matching choice of extended headers"
>   nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
>   nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
>   nbd_client_handshake(const char *export_name) "export '%s'"

-- 
Best regards,
Vladimir


