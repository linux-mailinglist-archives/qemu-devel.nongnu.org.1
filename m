Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B537197F1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4f4J-0002Ja-VM; Thu, 01 Jun 2023 05:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4f4E-00026i-RH; Thu, 01 Jun 2023 05:58:05 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q4f4A-0007Sp-SV; Thu, 01 Jun 2023 05:58:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 5819A6057A;
 Thu,  1 Jun 2023 12:57:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b6ad::1:35] (unknown
 [2a02:6b8:b081:b6ad::1:35])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ivK9I10OlOs0-kTmL1Zkf; Thu, 01 Jun 2023 12:57:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685613465; bh=nd2leBO9vQ7bmcHyaB3nTIwr93RkkHZbzQGZLeZ7tOc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MIM/x2heRVNBNLC0lGIef9MTXleyyuQiACTPXw6PoV+r6FfNH+GnN0svCqwXkMBCV
 0fY3gWzFAut2eBUjL+5DADrOho4Ccenw8r78Nfhs4inKQEZzdoHr1TDihKO80eWK5a
 WlcYcK5LA/23fiOfXuoh8DPzwJ85ffI+NcR4mPbI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <789718bc-1348-77d4-134b-9e9356aa7378@yandex-team.ru>
Date: Thu, 1 Jun 2023 12:57:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 13/14] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-14-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-14-eblake@redhat.com>
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
> The next commit will add support for the new addition of
> NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
> request that the server only return a subset of negotiated contexts,
> rather than all contexts.  To make that task easier, this patch
> populates the list of contexts to return on a per-command basis (for
> now, identical to the full set of negotiated contexts).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/block/nbd.h |  15 ++++++
>   nbd/server.c        | 108 +++++++++++++++++++++++---------------------
>   2 files changed, 72 insertions(+), 51 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 865bb4ee2e1..6696d61bd59 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -60,6 +60,20 @@ typedef enum NBDHeaderStyle {
>       NBD_HEADER_EXTENDED,    /* NBD_OPT_EXTENDED_HEADERS negotiated */
>   } NBDHeaderStyle;
> 
> +/*
> + * NBDMetaContexts represents a list of meta contexts in use, as
> + * selected by NBD_OPT_SET_META_CONTEXT. Also used for
> + * NBD_OPT_LIST_META_CONTEXT, and payload filtering in
> + * NBD_CMD_BLOCK_STATUS.
> + */
> +typedef struct NBDMetaContexts {
> +    size_t count; /* number of negotiated contexts */
> +    bool base_allocation; /* export base:allocation context (block status) */
> +    bool allocation_depth; /* export qemu:allocation-depth */
> +    size_t nr_bitmaps; /* Length of bitmaps array */
> +    bool *bitmaps; /* export qemu:dirty-bitmap:<export bitmap name> */
> +} NBDMetaContexts;
> +
>   /*
>    * Note: NBDRequest is _NOT_ the same as the network representation of an NBD
>    * request!
> @@ -70,6 +84,7 @@ typedef struct NBDRequest {
>       uint64_t len;   /* Effect length; 32 bit limit without extended headers */
>       uint16_t flags; /* NBD_CMD_FLAG_* */
>       uint16_t type;  /* NBD_CMD_* */
> +    NBDMetaContexts contexts; /* Used by NBD_CMD_BLOCK_STATUS */
>   } NBDRequest;
> 
>   typedef struct NBDSimpleReply {
> diff --git a/nbd/server.c b/nbd/server.c
> index 6475a76c1f0..db550c82cd2 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -105,20 +105,6 @@ struct NBDExport {
> 
>   static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
> 
> -/* NBDExportMetaContexts represents a list of contexts to be exported,
> - * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
> - * NBD_OPT_LIST_META_CONTEXT. */
> -typedef struct NBDExportMetaContexts {
> -    NBDExport *exp;
> -    size_t count; /* number of negotiated contexts */
> -    bool base_allocation; /* export base:allocation context (block status) */
> -    bool allocation_depth; /* export qemu:allocation-depth */
> -    bool *bitmaps; /*
> -                    * export qemu:dirty-bitmap:<export bitmap name>,
> -                    * sized by exp->nr_export_bitmaps
> -                    */
> -} NBDExportMetaContexts;
> -
>   struct NBDClient {
>       int refcount;
>       void (*close_fn)(NBDClient *client, bool negotiated);
> @@ -144,7 +130,8 @@ struct NBDClient {
>       uint32_t check_align; /* If non-zero, check for aligned client requests */
> 
>       NBDHeaderStyle header_style;
> -    NBDExportMetaContexts export_meta;
> +    NBDExport *context_exp; /* export of last OPT_SET_META_CONTEXT */
> +    NBDMetaContexts contexts; /* Negotiated meta contexts */
> 
>       uint32_t opt; /* Current option being negotiated */
>       uint32_t optlen; /* remaining length of data in ioc for the option being
> @@ -457,8 +444,8 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
> 
>   static void nbd_check_meta_export(NBDClient *client)
>   {
> -    if (client->exp != client->export_meta.exp) {
> -        client->export_meta.count = 0;
> +    if (client->exp != client->context_exp) {
> +        client->contexts.count = 0;
>       }
>   }
> 
> @@ -852,7 +839,7 @@ static bool nbd_strshift(const char **str, const char *prefix)
>    * Handle queries to 'base' namespace. For now, only the base:allocation
>    * context is available.  Return true if @query has been handled.
>    */
> -static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
> +static bool nbd_meta_base_query(NBDClient *client, NBDMetaContexts *meta,
>                                   const char *query)
>   {
>       if (!nbd_strshift(&query, "base:")) {
> @@ -872,8 +859,8 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>    * and qemu:allocation-depth contexts are available.  Return true if @query
>    * has been handled.
>    */
> -static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> -                                const char *query)
> +static bool nbd_meta_qemu_query(NBDClient *client, NBDExport *exp,
> +                                NBDMetaContexts *meta, const char *query)
>   {
>       size_t i;
> 
> @@ -884,9 +871,9 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> 
>       if (!*query) {
>           if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> -            meta->allocation_depth = meta->exp->allocation_depth;
> -            if (meta->exp->nr_export_bitmaps) {
> -                memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
> +            meta->allocation_depth = exp->allocation_depth;
> +            if (meta->nr_bitmaps) {
> +                memset(meta->bitmaps, 1, meta->nr_bitmaps);
>               }
>           }
>           trace_nbd_negotiate_meta_query_parse("empty");
> @@ -895,7 +882,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> 
>       if (strcmp(query, "allocation-depth") == 0) {
>           trace_nbd_negotiate_meta_query_parse("allocation-depth");
> -        meta->allocation_depth = meta->exp->allocation_depth;
> +        meta->allocation_depth = exp->allocation_depth;
>           return true;
>       }
> 
> @@ -903,17 +890,17 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
>           trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
>           if (!*query) {
>               if (client->opt == NBD_OPT_LIST_META_CONTEXT &&
> -                meta->exp->nr_export_bitmaps) {
> -                memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
> +                exp->nr_export_bitmaps) {
> +                memset(meta->bitmaps, 1, exp->nr_export_bitmaps);

sometimes you change s/meta->exp->nr_export_bitmaps/meta->nr_bitmaps/ and sometimes s/meta->exp->nr_export_bitmaps/exp->nr_export_bitmaps/

>               }
>               trace_nbd_negotiate_meta_query_parse("empty");
>               return true;
>           }
> 
> -        for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
> +        for (i = 0; i < meta->nr_bitmaps; i++) {
>               const char *bm_name;
> 
> -            bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
> +            bm_name = bdrv_dirty_bitmap_name(exp->export_bitmaps[i]);

I don't like the change: we iterate through exp->export_bitmaps. So seems more correct to use exp->nr_export_bitmaps as a limit.

I understand why you want to duplicated nr_export_bitmaps in NBDMetaContexts, but the result doesn't seem better than just use exp->nr_export_bitmaps.

Probably, if we want to duplicate nr_export_bitmaps, we should duplicate export_bitmaps as well. But this leads actually to keeping meta->exp as is.

Hm, may be just do

size_t nr_bitmaps = meta->nr_bitmaps;
assert(nr_bitmaps == exp->nr_export_bitmaps)
at top of the function? and use nr_bitmaps everywhere.

But this again make me doubt that meta.nr_bitmaps is good idea: we have to pass exp together and check meta.nr_bitmaps == exp->nr_export_bitmaps every time.

So, I understand, that

     bool *bitmaps; /*
                     * export qemu:dirty-bitmap:<export bitmap name>,
                     * sized by exp->nr_export_bitmaps
                     */

sounds like not good design - we have an array, sized by field of another object. But, we have a link that that object (meta->exp).

But with your way we fall into bad design too: we have a duplicated field, and have to control that they not diverse. And we iterate things in exp, using field of meta.


I looked through, seems in all places where we use nr_bitmaps, we also have access to nr_export_bitmaps. So, maybe, drop this nr_bitmaps?
And why not to keep meta.exp? With it, meta is self-sufficient object, which fully describe some selected contexts.

For per-request filtering, meta.exp just must always point to current export. And anyway would be good to split refactoring of meta structure (if we need it) and new logic of per-command filtering.

>               if (strcmp(bm_name, query) == 0) {
>                   meta->bitmaps[i] = true;
>                   trace_nbd_negotiate_meta_query_parse(query);
> @@ -937,8 +924,8 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
>    *
>    * Return -errno on I/O error, 0 if option was completely handled by
>    * sending a reply about inconsistent lengths, or 1 on success. */
> -static int nbd_negotiate_meta_query(NBDClient *client,
> -                                    NBDExportMetaContexts *meta, Error **errp)
> +static int nbd_negotiate_meta_query(NBDClient *client, NBDExport *exp,
> +                                    NBDMetaContexts *meta, Error **errp)
>   {
>       int ret;
>       g_autofree char *query = NULL;
> @@ -965,7 +952,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>       if (nbd_meta_base_query(client, meta, query)) {
>           return 1;
>       }
> -    if (nbd_meta_qemu_query(client, meta, query)) {
> +    if (nbd_meta_qemu_query(client, exp, meta, query)) {
>           return 1;
>       }
> 
> @@ -977,14 +964,15 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>    * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
>    *
>    * Return -errno on I/O error, or 0 if option was completely handled. */
> -static int nbd_negotiate_meta_queries(NBDClient *client,
> -                                      NBDExportMetaContexts *meta, Error **errp)
> +static int nbd_negotiate_meta_queries(NBDClient *client, Error **errp)
>   {
>       int ret;
>       g_autofree char *export_name = NULL;
>       /* Mark unused to work around https://bugs.llvm.org/show_bug.cgi?id=3888 */
>       g_autofree G_GNUC_UNUSED bool *bitmaps = NULL;
> -    NBDExportMetaContexts local_meta = {0};
> +    NBDMetaContexts local_meta = {0};
> +    NBDMetaContexts *meta;
> +    NBDExport *exp;
>       uint32_t nb_queries;
>       size_t i;
>       size_t count = 0;
> @@ -1000,6 +988,9 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
>           /* Only change the caller's meta on SET. */
>           meta = &local_meta;
> +    } else {
> +        meta = &client->contexts;
> +        client->context_exp = NULL;
>       }
> 
>       g_free(meta->bitmaps);
> @@ -1010,14 +1001,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>           return ret;
>       }
> 
> -    meta->exp = nbd_export_find(export_name);
> -    if (meta->exp == NULL) {
> +    exp = nbd_export_find(export_name);
> +    if (exp == NULL) {
>           g_autofree char *sane_name = nbd_sanitize_name(export_name);
> 
>           return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
>                               "export '%s' not present", sane_name);
>       }
> -    meta->bitmaps = g_new0(bool, meta->exp->nr_export_bitmaps);
> +    meta->nr_bitmaps = exp->nr_export_bitmaps;
> +    meta->bitmaps = g_new0(bool, exp->nr_export_bitmaps);
>       if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
>           bitmaps = meta->bitmaps;
>       }
> @@ -1033,13 +1025,13 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
>           /* enable all known contexts */
>           meta->base_allocation = true;
> -        meta->allocation_depth = meta->exp->allocation_depth;
> -        if (meta->exp->nr_export_bitmaps) {
> -            memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
> +        meta->allocation_depth = exp->allocation_depth;
> +        if (exp->nr_export_bitmaps) {
> +            memset(meta->bitmaps, 1, meta->nr_bitmaps);
>           }
>       } else {
>           for (i = 0; i < nb_queries; ++i) {
> -            ret = nbd_negotiate_meta_query(client, meta, errp);
> +            ret = nbd_negotiate_meta_query(client, exp, meta, errp);
>               if (ret <= 0) {
>                   return ret;
>               }
> @@ -1066,7 +1058,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>           count++;
>       }
> 
> -    for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
> +    for (i = 0; i < meta->nr_bitmaps; i++) {
>           const char *bm_name;
>           g_autofree char *context = NULL;
> 
> @@ -1074,7 +1066,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>               continue;
>           }
> 
> -        bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
> +        bm_name = bdrv_dirty_bitmap_name(exp->export_bitmaps[i]);
>           context = g_strdup_printf("qemu:dirty-bitmap:%s", bm_name);
> 
>           ret = nbd_negotiate_send_meta_context(client, context,
> @@ -1089,6 +1081,9 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
>       if (ret == 0) {
>           meta->count = count;
> +        if (client->opt == NBD_OPT_SET_META_CONTEXT) {
> +            client->context_exp = exp;
> +        }
>       }
> 
>       return ret;
> @@ -1282,8 +1277,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
> 
>               case NBD_OPT_LIST_META_CONTEXT:
>               case NBD_OPT_SET_META_CONTEXT:
> -                ret = nbd_negotiate_meta_queries(client, &client->export_meta,
> -                                                 errp);
> +                ret = nbd_negotiate_meta_queries(client, errp);
>                   break;
> 
>               case NBD_OPT_EXTENDED_HEADERS:
> @@ -1514,7 +1508,7 @@ void nbd_client_put(NBDClient *client)
>               QTAILQ_REMOVE(&client->exp->clients, client, next);
>               blk_exp_unref(&client->exp->common);
>           }
> -        g_free(client->export_meta.bitmaps);
> +        g_free(client->contexts.bitmaps);
>           g_free(client);
>       }
>   }
> @@ -2489,6 +2483,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>                   return -ENOMEM;
>               }
>           }
> +    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
> +        request->contexts = client->contexts;
>       }
> 
>       if (payload_len) {
> @@ -2715,11 +2711,11 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>           }
>           assert(client->header_style >= NBD_HEADER_EXTENDED ||
>                  request->len <= UINT32_MAX);
> -        if (client->export_meta.count) {
> +        if (request->contexts.count) {
>               bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
> -            int contexts_remaining = client->export_meta.count;
> +            int contexts_remaining = request->contexts.count;
> 
> -            if (client->export_meta.base_allocation) {
> +            if (request->contexts.base_allocation) {
>                   ret = nbd_co_send_block_status(client, request,
>                                                  exp->common.blk,
>                                                  request->from,
> @@ -2732,7 +2728,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                   }
>               }
> 
> -            if (client->export_meta.allocation_depth) {
> +            if (request->contexts.allocation_depth) {
>                   ret = nbd_co_send_block_status(client, request,
>                                                  exp->common.blk,
>                                                  request->from, request->len,
> @@ -2745,8 +2741,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                   }
>               }
> 
> +            assert(request->contexts.nr_bitmaps ==
> +                   client->exp->nr_export_bitmaps);
>               for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
> -                if (!client->export_meta.bitmaps[i]) {
> +                if (!request->contexts.bitmaps[i]) {
>                       continue;
>                   }
>                   ret = nbd_co_send_bitmap(client, request,
> @@ -2762,6 +2760,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>               assert(!contexts_remaining);
> 
>               return 0;
> +        } else if (client->contexts.count) {
> +            return nbd_send_generic_reply(client, request, -EINVAL,
> +                                          "CMD_BLOCK_STATUS payload not valid",
> +                                          errp);
>           } else {
>               return nbd_send_generic_reply(client, request, -EINVAL,
>                                             "CMD_BLOCK_STATUS not negotiated",
> @@ -2840,6 +2842,10 @@ static coroutine_fn void nbd_trip(void *opaque)
>       } else {
>           ret = nbd_handle_request(client, &request, req->data, &local_err);
>       }
> +    if (request.type == NBD_CMD_BLOCK_STATUS &&
> +        request.contexts.bitmaps != client->contexts.bitmaps) {
> +        g_free(request.contexts.bitmaps);
> +    }
>       if (ret < 0) {
>           error_prepend(&local_err, "Failed to send reply: ");
>           goto disconnect;

-- 
Best regards,
Vladimir


