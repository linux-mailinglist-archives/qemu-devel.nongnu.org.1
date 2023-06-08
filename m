Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E172873A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 20:31:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7KOj-0002Dz-Jb; Thu, 08 Jun 2023 14:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7KOd-0002DT-B0
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7KOb-0006qp-FM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686249004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3T69WCB7mosAPxm7LPr8klos0c8UGf0hsAu1nm4Kiec=;
 b=Qky7joE5mjjMtbMy3mNCkZAxMDxX9uAgfs1jDs6B030TAp94jPz3NJIEWNWAeqboc8Fw4w
 NbO0+WfY6Cpyx+H2oxLAI/mqovCEfPx59lGEHni0jhdC9S8RyI4izUdvVF50cX+adnFQaC
 AhW/tAv1t6cEIfSZio4jh2qe1IlkW0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-7tlpnDTDP_qQgaFl81uRbw-1; Thu, 08 Jun 2023 14:30:00 -0400
X-MC-Unique: 7tlpnDTDP_qQgaFl81uRbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 304EF1022F09;
 Thu,  8 Jun 2023 18:30:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D52F140E955;
 Thu,  8 Jun 2023 18:29:59 +0000 (UTC)
Date: Thu, 8 Jun 2023 13:29:57 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org, 
	vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 13/24] nbd/server: Refactor handling of
 request payload
Message-ID: <f6pzwl5mat6b7axgi4jalhfacxnxsnzix5r7urp4sbmwsg2phj@c5fuaartjd7d>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-14-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-14-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Thu, Jun 08, 2023 at 08:56:42AM -0500, Eric Blake wrote:
> Upcoming additions to support NBD 64-bit effect lengths allow for the
> possibility to distinguish between payload length (capped at 32M) and
> effect length (up to 63 bits).  Without that extension, only the

Technically, the NBD spec does not (yet) have a documented cap of a
63-bit size limit; although I should probably propose a patch upstream
that does that (I had one in my draft work, but it hasn't yet made it
upstream)

> NBD_CMD_WRITE request has a payload; but with the extension, it makes
> sense to allow at least NBD_CMD_BLOCK_STATUS to have both a payload
> and effect length (where the payload is a limited-size struct that in
> turns gives the real effect length as well as a subset of known ids
> for which status is requested).  Other future NBD commands may also
> have a request payload, so the 64-bit extension introduces a new
> NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
> length is a payload length or an effect length, rather than
> hard-coding the decision based on the command.  Note that we do not
> support the payload version of BLOCK_STATUS yet.
> 
> For this patch, no semantic change is intended for a compliant client.
> For a non-compliant client, it is possible that the error behavior
> changes (a different message, a change on whether the connection is
> killed or remains alive for the next command, or so forth), in part
> because req->complete is set later on some paths, but all errors
> should still be handled gracefully.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v4: less indentation on several 'if's [Vladimir]
> ---
>  nbd/server.c     | 76 ++++++++++++++++++++++++++++++------------------
>  nbd/trace-events |  1 +
>  2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 4ac05d0cd7b..d7dc29f0445 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2329,6 +2329,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>                                                 Error **errp)
>  {
>      NBDClient *client = req->client;
> +    bool extended_with_payload;
> +    unsigned payload_len = 0;
>      int valid_flags;
>      int ret;
> 
> @@ -2342,48 +2344,63 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>      trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>                                               nbd_cmd_lookup(request->type));
> 
> -    if (request->type != NBD_CMD_WRITE) {
> -        /* No payload, we are ready to read the next request.  */
> -        req->complete = true;
> -    }
> -
>      if (request->type == NBD_CMD_DISC) {
>          /* Special case: we're going to disconnect without a reply,
>           * whether or not flags, from, or len are bogus */
> +        req->complete = true;
>          return -EIO;
>      }
> 
> -    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
> -        request->type == NBD_CMD_CACHE)
> -    {
> -        if (request->len > NBD_MAX_BUFFER_SIZE) {
> -            error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
> -                       request->len, NBD_MAX_BUFFER_SIZE);
> -            return -EINVAL;
> +    /* Payload and buffer handling. */
> +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
> +        (request->flags & NBD_CMD_FLAG_PAYLOAD_LEN);
> +    if ((request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
> +         request->type == NBD_CMD_CACHE || extended_with_payload) &&
> +        request->len > NBD_MAX_BUFFER_SIZE) {

I'm still debating about rewriting this series of slightly-different
'if' into a single switch (request->type) block; the benefit is that
all actions for one command will be localized instead of split over
multiple lines of if, the drawback is that some code will now have to
be duplicated across commands (such as the buffer allocation code for
CMD_READ and CMD_WRITE).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


