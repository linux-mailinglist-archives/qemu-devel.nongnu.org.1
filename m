Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD19716C42
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q440h-00009W-OD; Tue, 30 May 2023 14:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q440f-00008C-0z
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q440P-0008J0-ML
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHgS4/6a7PZb7HKnXF+ZMGXcXLohkP+VZG2UZuBOI/4=;
 b=W9Lq6o2+qKBms4fmuIrd+be1B85K1QJ9eQrzgp2aV3avx9uDhxhDJdQVH/c4UtCthX4Wr7
 Ta9/4q/UsOtCB3j5jokyHIilNzsZHBBGjvmcejyGxt8u8bKgDk+ca84SyffuWILUVpGlXA
 oMUexv9icHhP9cn5CptWz7t0gaWV38c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-YwYVavOROqCUD7e3Z0JZZw-1; Tue, 30 May 2023 14:23:31 -0400
X-MC-Unique: YwYVavOROqCUD7e3Z0JZZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1916F85A5B5;
 Tue, 30 May 2023 18:23:31 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 753AC140E956;
 Tue, 30 May 2023 18:23:30 +0000 (UTC)
Date: Tue, 30 May 2023 13:23:28 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, libguestfs@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 04/14] nbd: Prepare for 64-bit request effect lengths
Message-ID: <y6aacamrljxcqzncawzgg5kriq2c5lqkoopd3keolcsnrvj4mf@q2hgmxzwk7cd>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-5-eblake@redhat.com>
 <15122ad7-bc5b-a54c-d412-ac82ce7215b0@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15122ad7-bc5b-a54c-d412-ac82ce7215b0@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, May 30, 2023 at 04:05:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.05.23 22:53, Eric Blake wrote:
> > Widen the length field of NBDRequest to 64-bits, although we can
> > assert that all current uses are still under 32 bits.  Move the
> > request magic number to nbd.h, to live alongside the reply magic
> > number.  Convert 'bool structured_reply' into a tri-state enum that
> > will eventually track whether the client successfully negotiated
> > extended headers with the server, allowing the nbd driver to pass
> > larger requests along where possible; although in this patch the enum
> > never surpasses structured replies, for no semantic change yet.
> > 
> > Signed-off-by: Eric Blake<eblake@redhat.com>
> 
> Seems too much for one patch, could it could be split into
> - Convert 'bool structured_reply'
> - introduce third parameter for nbd_send_request()
> - rework len to 64bit

Okay, will give that a shot for v4.

> 
> otherwise, looks good to me
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


