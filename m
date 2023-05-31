Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20979718B26
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SPP-0001wA-Us; Wed, 31 May 2023 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4SPK-0001v6-8G
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4SPI-0001S1-Ll
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685564816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q8hKTWT1fHe/hM1DfttyKajGJZs036JyEbAyIJZUHJU=;
 b=WpcNBTc04Ff1OLUTrlDy/s3AelhCMAx3D7angIFQn2sD+JGNhI/wE5AuliVH8k5JH7skzw
 N4H+LQeLNvGQSyhUbL1nIeMnkwgwwLoMPg31gvywpl4Kn27mYU8Pvi6FJMbFvj5AsLXr6h
 f8njii1t17tGRaWh1ro/RPxCBRaB0SI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-5ZYp884zOmmeLVxsDV0AgQ-1; Wed, 31 May 2023 16:26:54 -0400
X-MC-Unique: 5ZYp884zOmmeLVxsDV0AgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0F1B38149AD;
 Wed, 31 May 2023 20:26:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B834B140E95D;
 Wed, 31 May 2023 20:26:52 +0000 (UTC)
Date: Wed, 31 May 2023 15:26:50 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 12/14] nbd/client: Request extended headers during
 negotiation
Message-ID: <hbjtjovry4e5kb6oyii4g2hncetfo2uic67r5ipufcikvgyb5x@idenexfxits4>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-13-eblake@redhat.com>
 <1af7f692-b5de-c767-2568-1fc024a57133@yandex-team.ru>
 <cqb3yww5ceeinh2pb5nqaljrsllu3ejkjsdueuw32cwcocumsn@okgujto2lzmn>
 <cd83b0bc-0e6b-fc94-1cc2-9bf00d516140@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd83b0bc-0e6b-fc94-1cc2-9bf00d516140@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 31, 2023 at 09:33:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 31.05.23 20:54, Eric Blake wrote:
> > On Wed, May 31, 2023 at 08:39:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 15.05.23 22:53, Eric Blake wrote:
> > > > All the pieces are in place for a client to finally request extended
> > > > headers.  Note that we must not request extended headers when qemu-nbd
> > > 
> > > why must not? It should gracefully report ENOTSUP? Or not?
> > 
> > The kernel code does not yet know how to send extended requests; once
> > extended mode is negotiated, sending a simple request requires the
> 
> but how it could be negotiated if kernel doesn't support it?

That's the problem.  The kernel doesn't do the negotiation, userspace
does.  There is an ioctl for the userspace to tell the kernel what
flags were advertised as part of the negotiation, but that does not
include a flag for extended operation.  The kernel ONLY takes care of
NBD_CMD_ operations, it does not do NBD_OPT_ operations.  So when
qemu-nbd is preparing to connect to /dev/nbdN, it first has to
negotiate in userspace, avoiding any attempt to use extended headers,
then call the right ioctls for the kernel to take over command phase
using the older compact headers.

> 
> I mean if we request extended headers during negotiation with kernel, the kernel will just say "unsupported option", isn't it?

If we request extended headers in userspace before calling the ioctl
to tell the kernel to start transmission, then the kernel's first
command will use the compact style, which the server is not expecting,
and while we can hope the server will hang up on the kernel, I didn't
test what actually happens.


> 
> Or, in other words, I understand that kernel doesn't support it, I don't understand why you note it here. Is kernel different from other NBD server implementations which doesn't support extended requests at the moment?

The kernel is an NBD client, not a server.  But if we are about to
connect an NBD server over to the kernel for /dev/nbdN, we better make
sure the server is not using any features the kernel doesn't support.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


