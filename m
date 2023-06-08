Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D262728822
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LB4-0006n7-5d; Thu, 08 Jun 2023 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7LB1-0006mv-NN
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7LB0-0008My-6U
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686252004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2yMD9OI1Ogg2y6Li0420cacFrcU0n4RbOJL0DzzTd0=;
 b=MKqEIkSE2Gm1aMRRWppl/V1Z7Oi4hoEU/nhHJq7lM/JnxDLjc3Vjne1ZEoaA3jMAPoTfWq
 Lk0JNuJAWh11US5NtgXmg6uAkuMoHf3FcIwGRRHcPsiiZevy1YWHrLUKqro7wfX71l4eTz
 nZDeg6LrY2d29IGQeObmryW9aO0RG8E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-mjaHeLrdP9S0xN-cLOzB7Q-1; Thu, 08 Jun 2023 15:20:01 -0400
X-MC-Unique: mjaHeLrdP9S0xN-cLOzB7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6FBF1C08DA9;
 Thu,  8 Jun 2023 19:20:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 419C52166B25;
 Thu,  8 Jun 2023 19:20:00 +0000 (UTC)
Date: Thu, 8 Jun 2023 14:19:58 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 24/24] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Message-ID: <nzcagqxx2hu3rjdpyvddcerwfw2fv3lbcveckq44pfoer53sbl@s4xxw6gfhpwf>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-25-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-25-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 08:56:53AM -0500, Eric Blake wrote:
> Allow a client to request a subset of negotiated meta contexts.  For
> example, a client may ask to use a single connection to learn about
> both block status and dirty bitmaps, but where the dirty bitmap
> queries only need to be performed on a subset of the disk; forcing the
> server to compute that information on block status queries in the rest
> of the disk is wasted effort (both at the server, and on the amount of
> traffic sent over the wire to be parsed and ignored by the client).
> 
> Qemu as an NBD client never requests to use more than one meta
> context, so it has no need to use block status payloads.  Testing this
> instead requires support from libnbd, which CAN access multiple meta
> contexts in parallel from a single NBD connection; an interop test
> submitted to the libnbd project at the same time as this patch
> demonstrates the feature working, as well as testing some corner cases
> (for example, when the payload length is longer than the export
> length), although other corner cases (like passing the same id
> duplicated) requires a protocol fuzzer because libnbd is not wired up
> to break the protocol that badly.
> 
> This also includes tweaks to 'qemu-nbd --list' to show when a server
> is advertising the capability, and to the testsuite to reflect the
> addition to that output.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> +++ b/nbd/server.c
> @@ -512,6 +512,9 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
>      if (client->mode >= NBD_MODE_STRUCTURED) {
>          myflags |= NBD_FLAG_SEND_DF;
>      }
> +    if (client->mode >= NBD_MODE_EXTENDED && client->contexts.count) {
> +        myflags |= NBD_FLAG_BLOCK_STAT_PAYLOAD;
> +    }

This one's awkward.  At the last minute, I changed what went into
upstream NBD to state that a client that successfully negotiates
extended headers MUST NOT use NBD_OPT_EXPORT_NAME, which means this
branch should never fire for a compliant client.  I don't think it
hurts to leave this in, but it does point out that I am missing code
(either here or in 17/24) that at least logs when we detect a
non-compliant client trying to connect with the wrong command.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


