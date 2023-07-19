Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B7759F60
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:11:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDW1-0000ed-Fq; Wed, 19 Jul 2023 16:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDW0-0000eU-7N
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDVy-0001GS-Mo
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689797473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhB4iUIR3A2zjUNmVam+x1DErkkajhJ2TvadBsNgLgM=;
 b=cfFmI/fLkjbZ2UyG1f2mhDaArwMLYe/UKpN9faDCoJ2ICCv2i6hNIy3n4uPr9qlo8Tan76
 QRL2RPLzp6dKHzujJ17GXjuTMb8rhY1XFw6W3/39hjtjGOI6WAtJCrX57OEemujubLHWoP
 hnyjFdbD0UBi+oPqNnlM0+HdZq7tbHs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-8cLkOTeWP-GvwGmKJ7PM9A-1; Wed, 19 Jul 2023 16:11:12 -0400
X-MC-Unique: 8cLkOTeWP-GvwGmKJ7PM9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF72F3806638;
 Wed, 19 Jul 2023 20:11:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49EED40C206F;
 Wed, 19 Jul 2023 20:11:10 +0000 (UTC)
Date: Wed, 19 Jul 2023 15:11:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, libguestfs@redhat.com
Subject: Re: [Libguestfs] [PATCH v4 09/24] nbd: Replace bool structured_reply
 with mode enum
Message-ID: <wyjaoueclq5i3eazwbwu3jx3qir4yeophcdkb6ltg3covu2qxk@ujz6c4h2slmi>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-10-eblake@redhat.com>
 <0b857f56-8d61-dcad-d62f-5ca067c138bd@yandex-team.ru>
 <vzwphyejirnqfwk6bnncsai2eftfybq3jz7bvqhrufgtbbi2pw@lnr6zcmtmzar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vzwphyejirnqfwk6bnncsai2eftfybq3jz7bvqhrufgtbbi2pw@lnr6zcmtmzar>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 12, 2023 at 02:24:52PM -0500, Eric Blake wrote:
> On Mon, Jun 12, 2023 at 06:07:59PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > On 08.06.23 16:56, Eric Blake wrote:
> > > The upcoming patches for 64-bit extensions requires various points in
> > > the protocol to make decisions based on what was negotiated.  While we
> > > could easily add a 'bool extended_headers' alongside the existing
> > > 'bool structured_reply', this does not scale well if more modes are
> > > added in the future.  Better is to expose the mode enum added in the
> > > previous patch out to a wider use in the code base.
> > > 
> > > Where the code previously checked for structured_reply being set or
> > > clear, it now prefers checking for an inequality; this works because
> > > the nodes are in a continuum of increasing abilities, and allows us to
> > > touch fewer places if we ever insert other modes in the middle of the
> > > enum.  There should be no semantic change in this patch.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > > 
> > > v4: new patch, expanding enum idea from v3 4/14
> > > ---
> > 
> > [..]
> > 
> > > diff --git a/nbd/server.c b/nbd/server.c
> > > index 8486b64b15d..bade4f7990c 100644
> > > --- a/nbd/server.c
> > > +++ b/nbd/server.c
> 
> > > @@ -1261,13 +1262,13 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
> > >               case NBD_OPT_STRUCTURED_REPLY:
> > >                   if (length) {
> > >                       ret = nbd_reject_length(client, false, errp);
> > > -                } else if (client->structured_reply) {
> > > +                } else if (client->mode >= NBD_MODE_STRUCTURED) {
> > >                       ret = nbd_negotiate_send_rep_err(
> > >                           client, NBD_REP_ERR_INVALID, errp,
> > >                           "structured reply already negotiated");
> > >                   } else {
> > >                       ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
> > > -                    client->structured_reply = true;
> > > +                    client->mode = NBD_MODE_STRUCTURED;
> > 
> > Hmm. in all other cases in server code client.mode remains zero = OLDSTYLE, which is not quite correct.
> 
> Good catch.  Consider this squashed in (note that as a server we NEVER
> talk NBD_MODE_OLDSTYLE - we ripped that out back in commit 7f7dfe2a;
> but whether we end up on EXPORT_NAME or SIMPLE depends on the client's
> response to our initial flag advertisement.  The only reason I didn't
> spot it sooner is that in the server, all subsequent checks of
> client->mode grouped OLDSTYLE, EXPORT_NAME, and SIMPLE into the same
> handling.

To move things along, I have now staged 1-8 in my NBD queue for a pull
request, and will then repost this patch and the remainder of the
series as v5, to make it easier to pick up the final needed R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


