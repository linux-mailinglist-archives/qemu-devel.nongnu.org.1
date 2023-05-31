Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A6718463
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MXR-0004pZ-1o; Wed, 31 May 2023 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4MXO-0004o9-EW; Wed, 31 May 2023 10:10:54 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4MXL-0008Cw-59; Wed, 31 May 2023 10:10:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5515:0:640:d92d:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id DD80760390;
 Wed, 31 May 2023 17:10:38 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:34] (unknown
 [2a02:6b8:b081:a512::1:34])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bAO8bL0OciE0-nGFfkWIu; Wed, 31 May 2023 17:10:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685542238; bh=ygsXoVGL424Ab2H6NBLULn3p7Nhi4WPJMZzL6/Ta3Co=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=oXVW57TlvAIf0i9cfYMB2cAmo91XYXA77cebmQys+ijazu8H5d+Uv3MutvMTziiJD
 PaVRRcdXJic6CrPlyEGtsAuVlt+/oNYv508h/HDOY3S73Qws75ZWRU35FBg4j9FjVQ
 +RaaVy38UwqDOcCYqrFPAWyo4cXxNWQ95xm4Gnso=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7a92bd41-3499-a6a2-e0e7-6a532acf32df@yandex-team.ru>
Date: Wed, 31 May 2023 17:10:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/14] nbd/server: Support 64-bit block status
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-9-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 15.05.23 22:53, Eric Blake wrote:
> The NBD spec states that if the client negotiates extended headers,
> the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
> NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
> the reply does not need more than 32 bits.  As of this patch,
> client->header_style is still never NBD_HEADER_EXTENDED, so the code
> added here does not take effect until the next patch enables
> negotiation.
> 
> For now, all metacontexts that we know how to export never populate
> more than 32 bits of information, so we don't have to worry about
> NBD_REP_ERR_EXT_HEADER_REQD or filtering during handshake, and we
> always send all zeroes for the upper 32 bits of status during
> NBD_CMD_BLOCK_STATUS.
> 
> Note that we previously had some interesting size-juggling on call
> chains, such as:
> 
> nbd_co_send_block_status(uint32_t length)
> -> blockstatus_to_extents(uint32_t bytes)
>    -> bdrv_block_status_above(bytes, &uint64_t num)
>    -> nbd_extent_array_add(uint64_t num)
>      -> store num in 32-bit length
> 
> But we were lucky that it never overflowed: bdrv_block_status_above
> never sets num larger than bytes, and we had previously been capping
> 'bytes' at 32 bits (since the protocol does not allow sending a larger
> request without extended headers).  This patch adds some assertions
> that ensure we continue to avoid overflowing 32 bits for a narrow
> client, while fully utilizing 64-bits all the way through when the
> client understands that.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 86 +++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 62 insertions(+), 24 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index ffab51efd26..b4c15ae1a14 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2073,7 +2073,15 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>   }
> 
>   typedef struct NBDExtentArray {
> -    NBDExtent *extents;
> +    NBDHeaderStyle style;           /* 32- or 64-bit extent descriptions */
> +    union {
> +        NBDStructuredMeta id;       /* style == NBD_HEADER_STRUCTURED */
> +        NBDStructuredMetaExt meta;  /* style == NBD_HEADER_EXTENDED */
> +    };
> +    union {
> +        NBDExtent *narrow;          /* style == NBD_HEADER_STRUCTURED */
> +        NBDExtentExt *extents;      /* style == NBD_HEADER_EXTENDED */
> +    };
>       unsigned int nb_alloc;
>       unsigned int count;
>       uint64_t total_length;
> @@ -2081,12 +2089,15 @@ typedef struct NBDExtentArray {
>       bool converted_to_be;
>   } NBDExtentArray;
> 
> -static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
> +static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc,
> +                                            NBDHeaderStyle style)
>   {
>       NBDExtentArray *ea = g_new0(NBDExtentArray, 1);
> 
> +    assert(style >= NBD_HEADER_STRUCTURED);
>       ea->nb_alloc = nb_alloc;
> -    ea->extents = g_new(NBDExtent, nb_alloc);
> +    ea->extents = g_new(NBDExtentExt, nb_alloc);
> +    ea->style = style;
>       ea->can_add = true;
> 
>       return ea;
> @@ -2100,17 +2111,37 @@ static void nbd_extent_array_free(NBDExtentArray *ea)
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free)
> 
>   /* Further modifications of the array after conversion are abandoned */
> -static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea,
> +                                           uint32_t context_id,
> +                                           struct iovec *iov)
>   {
>       int i;
> 
>       assert(!ea->converted_to_be);
> +    assert(iov[0].iov_base == &ea->meta);
> +    assert(iov[1].iov_base == ea->extents);

Hmm. Maybe just pass unitialized iov, and set bases here? It would be more clear interface.

>       ea->can_add = false;
>       ea->converted_to_be = true;
> 
> -    for (i = 0; i < ea->count; i++) {
> -        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
> -        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
> +    stl_be_p(&ea->meta.context_id, context_id);
> +    if (ea->style >= NBD_HEADER_EXTENDED) {
> +        stl_be_p(&ea->meta.count, ea->count);
> +        for (i = 0; i < ea->count; i++) {
> +            ea->extents[i].length = cpu_to_be64(ea->extents[i].length);
> +            ea->extents[i].flags = cpu_to_be64(ea->extents[i].flags);
> +        }
> +        iov[0].iov_len = sizeof(ea->meta);
> +        iov[1].iov_len = ea->count * sizeof(ea->extents[0]);
> +    } else {
> +        /* Conversion reduces memory usage, order of iteration matters */
> +        for (i = 0; i < ea->count; i++) {
> +            assert(ea->extents[i].length <= UINT32_MAX);
> +            assert((uint32_t) ea->extents[i].flags == ea->extents[i].flags);
> +            ea->narrow[i].length = cpu_to_be32(ea->extents[i].length);
> +            ea->narrow[i].flags = cpu_to_be32(ea->extents[i].flags);

IMHO, this union-magic significantly increases the complexity of the code..

For example, if simply swap these two lines:

            ea->narrow[i].flags = cpu_to_be32(ea->extents[i].flags);
            ea->narrow[i].length = cpu_to_be32(ea->extents[i].length);

that would be a bug, which's not simple to find.


I have an idea:

1. rewrite the common logic to work with new extended structures
2. add a separate function, which produces old style array, allocating it in flight.

let me try. Something like this (applied on top of this patch). This way we can avoid both unions and passing half-initialized iovs:

diff --git a/nbd/server.c b/nbd/server.c
index 70cc1808c4..b0075dd1ee 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2073,14 +2073,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
  
  typedef struct NBDExtentArray {
      NBDHeaderStyle style;           /* 32- or 64-bit extent descriptions */
-    union {
-        NBDStructuredMeta id;       /* style == NBD_HEADER_STRUCTURED */
-        NBDStructuredMetaExt meta;  /* style == NBD_HEADER_EXTENDED */
-    };
-    union {
-        NBDExtent *narrow;          /* style == NBD_HEADER_STRUCTURED */
-        NBDExtentExt *extents;      /* style == NBD_HEADER_EXTENDED */
-    };
+    NBDExtentExt *extents;
      unsigned int nb_alloc;
      unsigned int count;
      uint64_t total_length;
@@ -2110,38 +2103,35 @@ static void nbd_extent_array_free(NBDExtentArray *ea)
  G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free)
  
  /* Further modifications of the array after conversion are abandoned */
-static void nbd_extent_array_convert_to_be(NBDExtentArray *ea,
-                                           uint32_t context_id,
-                                           struct iovec *iov)
+static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
  {
      int i;
  
      assert(!ea->converted_to_be);
-    assert(iov[0].iov_base == &ea->meta);
-    assert(iov[1].iov_base == ea->extents);
      ea->can_add = false;
      ea->converted_to_be = true;
  
-    stl_be_p(&ea->meta.context_id, context_id);
-    if (ea->style >= NBD_HEADER_EXTENDED) {
-        stl_be_p(&ea->meta.count, ea->count);
-        for (i = 0; i < ea->count; i++) {
-            ea->extents[i].length = cpu_to_be64(ea->extents[i].length);
-            ea->extents[i].flags = cpu_to_be64(ea->extents[i].flags);
-        }
-        iov[0].iov_len = sizeof(ea->meta);
-        iov[1].iov_len = ea->count * sizeof(ea->extents[0]);
-    } else {
-        /* Conversion reduces memory usage, order of iteration matters */
-        for (i = 0; i < ea->count; i++) {
-            assert(ea->extents[i].length <= UINT32_MAX);
-            assert((uint32_t) ea->extents[i].flags == ea->extents[i].flags);
-            ea->narrow[i].length = cpu_to_be32(ea->extents[i].length);
-            ea->narrow[i].flags = cpu_to_be32(ea->extents[i].flags);
-        }
-        iov[0].iov_len = sizeof(ea->id);
-        iov[1].iov_len = ea->count * sizeof(ea->narrow[0]);
+    for (i = 0; i < ea->count; i++) {
+        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
+        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
+    }
+}
+
+static NBDExtent *nbd_extent_array_make_old_style_extents(NBDExtentArray *ea)
+{
+    int i;
+    NBDExtent *extents = g_new(NBDExtent, ea->count);
+
+    assert(!ea->converted_to_be);
+
+    for (i = 0; i < ea->count; i++) {
+        assert(ea->extents[i].length <= UINT32_MAX);
+        assert((uint32_t) ea->extents[i].flags == ea->extents[i].flags);
+        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
+        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
      }
+
+    return extents;
  }
  
  /*
@@ -2244,7 +2234,7 @@ static int coroutine_fn blockalloc_to_extents(BlockBackend *blk,
  /*
   * nbd_co_send_extents
   *
- * @ea is converted to BE by the function
+ * @ea may be converted to BE by the function
   * @last controls whether NBD_REPLY_FLAG_DONE is sent.
   */
  static int coroutine_fn
@@ -2252,15 +2242,35 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
                      bool last, uint32_t context_id, Error **errp)
  {
      NBDReply hdr;
-    struct iovec iov[] = {
-        {.iov_base = &hdr},
-        {.iov_base = &ea->meta},
-        {.iov_base = ea->extents}
-    };
-    uint16_t type = client->header_style == NBD_HEADER_EXTENDED ?
-        NBD_REPLY_TYPE_BLOCK_STATUS_EXT : NBD_REPLY_TYPE_BLOCK_STATUS;
+    NBDStructuredMeta meta;
+    NBDStructuredMetaExt meta_ext;
+    g_autofree NBDExtent *extents = NULL;
+    uint16_t type;
+    struct iovec iov[] = { {.iov_base = &hdr}, {0}, {0} };
+
+    if (client->header_style == NBD_HEADER_EXTENDED) {
+        type = NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
+
+        iov[1].iov_base = &meta_ext;
+        iov[1].iov_len = sizeof(meta_ext);
+        stl_be_p(&meta_ext.context_id, context_id);
+        stl_be_p(&meta_ext.count, ea->count);
+
+        nbd_extent_array_convert_to_be(ea);
+        iov[2].iov_base = ea->extents;
+        iov[2].iov_len = ea->count * sizeof(ea->extents[0]);
+    } else {
+        type = NBD_REPLY_TYPE_BLOCK_STATUS;
+
+        iov[1].iov_base = &meta;
+        iov[1].iov_len = sizeof(meta);
+        stl_be_p(&meta.context_id, context_id);
+
+        extents = nbd_extent_array_make_old_style_extents(ea);
+        iov[2].iov_base = extents;
+        iov[2].iov_len = ea->count * sizeof(extents[0]);
+    }
  
-    nbd_extent_array_convert_to_be(ea, context_id, &iov[1]);
  
      trace_nbd_co_send_extents(request->handle, ea->count, context_id,
                                ea->total_length, last);



-- 
Best regards,
Vladimir


