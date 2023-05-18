Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DA708179
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:40:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcuf-0004Ny-9K; Thu, 18 May 2023 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzcuX-0004Mp-Bb
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzcuV-0005ZJ-V3
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684413551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZqT5Q7lCSd3K0ucMqF+n3ExJbf0EbMoFEkscusaDTM=;
 b=Cke1jchiecmNVd9baoByFbaUNQukrlLHdCj39ooOnyVhlS51ng9Al9BmFm7gIFOKeuD1je
 8grbDL34FKPN4zgWyXGVJXkyF6jAJ7I3JlBiyoRNJmsv/6PVxNlPL1rScsfalQjvNuHl52
 292Xjur7zp0MTkOPMSWKGBb8nsXPFOU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-2NIA7KnuMs2IQA02BBzxiw-1; Thu, 18 May 2023 08:39:07 -0400
X-MC-Unique: 2NIA7KnuMs2IQA02BBzxiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60A823C1485C;
 Thu, 18 May 2023 12:39:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C9E1415304;
 Thu, 18 May 2023 12:39:06 +0000 (UTC)
Date: Thu, 18 May 2023 07:39:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] graph-lock: Disable locking for now
Message-ID: <n2mxiegyv7cyjyxg2e6547nvifcztfgfi2n4ltb4awh4egww3a@krexmm6lxs3m>
References: <20230517152834.277483-1-kwolf@redhat.com>
 <20230517152834.277483-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517152834.277483-2-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Wed, May 17, 2023 at 05:28:32PM +0200, Kevin Wolf wrote:
> In QEMU 8.0, we've been seeing deadlocks in bdrv_graph_wrlock(). They
> come from callers that hold an AioContext lock, which is not allowed
> during polling. In theory, we could temporarily release the lock, but
> callers are inconsistent about whether they hold a lock, and if they do,
> some are also confused about which one they hold. While all of this is
> fixable, it's not trivial, and the best course of action for 8.0.1 is
> probably just disabling the graph locking code temporarily.
> 
> We don't currently rely on graph locking yet. It is supposed to replace
> the AioContext lock eventually to enable multiqueue support, but as long
> as we still have the AioContext lock, it is sufficient without the graph
> lock. Once the AioContext lock goes away, the deadlock doesn't exist any
> more either and this commit can be reverted. (Of course, it can also be
> reverted while the AioContext lock still exists if the callers have been
> fixed.)

Makes sense - certainly easier than finding all the lurking bugs,
while we still have the AioContext lock protection.

> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/graph-lock.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


