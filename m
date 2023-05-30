Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05245716986
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Ef-0004bP-FN; Tue, 30 May 2023 12:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q42Ec-0004aj-Fa
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q42Ea-0007NX-Ss
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oCFqvWSddpjnoYZEQUtG7+hIEJGGG3lZ5hL9zo44apY=;
 b=btvqQ0SI0FdZLRzQBLkZO0lwlGnfn9LZR67fgogfoqKz9EBjATB1QxzT4VeG/oKXSA4WaS
 wM3zN0w1YX1JDcPoA65l3vOWrdhoMHQHvjM8FnS4nEs5aCVPbgGsfrNjIww2SryYEwEqNV
 8OkIHZrPcWOZGob8Fv46zA7aBwTe1KU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-1fg8AX0vNBeEYAcMH_bSPA-1; Tue, 30 May 2023 12:29:50 -0400
X-MC-Unique: 1fg8AX0vNBeEYAcMH_bSPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D6D0811E86;
 Tue, 30 May 2023 16:29:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDEFB2166B25;
 Tue, 30 May 2023 16:29:48 +0000 (UTC)
Date: Tue, 30 May 2023 11:29:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 03/14] nbd/server: Prepare for alternate-size headers
Message-ID: <xheanhxhevlqm7fcnvnvpjv3e3bnmjbf2nwfnu7g54pzeu2jn4@rybss73nu4gq>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-4-eblake@redhat.com>
 <7f9afa94-4817-d33a-4565-20b654190e3d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9afa94-4817-d33a-4565-20b654190e3d@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Mon, May 29, 2023 at 05:26:50PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Upstream NBD now documents[1] an extension that supports 64-bit effect
> > lengths in requests.  As part of that extension, the size of the reply
> > headers will change in order to permit a 64-bit length in the reply
> > for symmetry[2].  Additionally, where the reply header is currently
> > 16 bytes for simple reply, and 20 bytes for structured reply; with the
> > extension enabled, there will only be one structured reply type, of 32
> > bytes.  Since we are already wired up to use iovecs, it is easiest to
> > allow for this change in header size by splitting each structured
> > reply across two iovecs, one for the header (which will become
> > variable-length in a future patch according to client negotiation),
> > and the other for the payload, and removing the header from the
> > payload struct definitions.  Interestingly, the client side code never
> > utilized the packed types, so only the server code needs to be
> > updated.
> 
> Actually, it does, since previous patch :) But, it becomes even better now? Anyway some note somewhere is needed I think.

Oh, indeed - but only in a sizeof expression for an added assertion
check, and not actually for in-memory storage.

If you are envisioning a comment addition, where are you thinking it
should be placed?

> 
> > 
> > -static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
> > -                                uint16_t type, uint64_t handle, uint32_t length)
> > +static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
> 
> Suggestion: pass niov here too, and caluculate "length" as a sum of iov lengths starting from second extent automatically.

Makes sense.

> 
> Also, worth documenting that set_be_chunk() expects half-initialized iov, with .iov_base pointing to NBDReply (IN parameter) and .iov_len unset (OUT parameter), as that's not usual practice

Yeah, I'm not sure if there is a better interface, but either I come
up with one, or at least better document what I landed on.

> 
> > +                                uint16_t flags, uint16_t type,
> > +                                uint64_t handle, uint32_t length)
> >   {
> > +    NBDStructuredReplyChunk *chunk = iov->iov_base;
> > +
> > +    iov->iov_len = sizeof(*chunk);
> >       stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
> >       stw_be_p(&chunk->flags, flags);
> >       stw_be_p(&chunk->type, type);
> 
> [..]
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


