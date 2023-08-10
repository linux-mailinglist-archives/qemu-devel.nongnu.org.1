Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F920778011
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUAB3-00061S-30; Thu, 10 Aug 2023 14:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qUAAu-00060q-P8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qUAAt-0002pw-2A
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691691257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2k3NY8OvUsNx3imMVJqu/roJzPvuFQVs7pEmwPCxxU=;
 b=bmoUTONO+zFeIGLJEZzVtfj9Y988vdDaDIsh8i0Orp6DouEYuounQZD3fwah3FFzXjl5vr
 AqOQzO+mwKvLtelzhA4K0jH20leDFGqBAaxJKaI9fwRF2nPX64Ple8uxY5xCHn7pD/VOPN
 +cliMC/pLQmbnZpOy9u+y7Q2oE7iIOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-XX-vuAMCMdqk7QerHHQWQA-1; Thu, 10 Aug 2023 14:14:16 -0400
X-MC-Unique: XX-vuAMCMdqk7QerHHQWQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F66A85CBE2;
 Thu, 10 Aug 2023 18:13:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F33B61121314;
 Thu, 10 Aug 2023 18:13:44 +0000 (UTC)
Date: Thu, 10 Aug 2023 13:13:43 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v5 17/17] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
Message-ID: <wnlvp6k3f5swentqvqdrwbpculytdao6wi7gnpx4jt7rp4vu7y@5d34mblxlqo6>
References: <20230810173646.17695-19-eblake@redhat.com>
 <20230810173646.17695-36-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810173646.17695-36-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Thu, Aug 10, 2023 at 12:37:04PM -0500, Eric Blake wrote:
> Allow a client to request a subset of negotiated meta contexts.  For
> example, a client may ask to use a single connection to learn about
> both block status and dirty bitmaps, but where the dirty bitmap
> queries only need to be performed on a subset of the disk; forcing the
> server to compute that information on block status queries in the rest
> of the disk is wasted effort (both at the server, and on the amount of
> traffic sent over the wire to be parsed and ignored by the client).
> 

> +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
> +                                 Error **errp)
> +{
> +    int payload_len = request->len;
> +    g_autofree char *buf = NULL;
> +    size_t count, i, nr_bitmaps;
> +    uint32_t id;
> +
> +    if (payload_len > NBD_MAX_BUFFER_SIZE) {
> +        error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
> +                   request->len, NBD_MAX_BUFFER_SIZE);

Copy and paste specing bug produces "len (12345678980 ) is larger...",
should be 'PRIu64 ")'; will touch up here and in all other places it
occurs.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


