Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E178D00A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mz-0000lp-4y; Tue, 29 Aug 2023 19:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb3UR-0006Uk-BM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb3UL-0006xn-WB
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693333852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PqcEaVo78QiUZsXIxV7txO2etr3uiuMP599efIjKBcI=;
 b=gvOnOzlLLJt5AiqR5/ZZ15evuLHyO/N9y1NXfbe/fYd3C1SLEvFrsTbtSXK7CAWKjqGBuQ
 714pzZieLbs3N1Zg2vSk9KchCWasXdsb+Bi7RferCVA+Y2t6mZSWTTfaSHoABOI3k4Q7k4
 xMez8GOk/VNnbpJtke6okxu6LF04+m0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-9xZDQEnAPVKbAkCtv7oEVw-1; Tue, 29 Aug 2023 14:30:50 -0400
X-MC-Unique: 9xZDQEnAPVKbAkCtv7oEVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3A748030AC;
 Tue, 29 Aug 2023 18:30:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1EAB492C14;
 Tue, 29 Aug 2023 18:30:47 +0000 (UTC)
Date: Tue, 29 Aug 2023 13:30:45 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, farosas@suse.de,
 kwolf@redhat.com, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: drop unused nbd_receive_negotiate()
 aio_context argument
Message-ID: <acljwcnp2moupxhzsfvr5zasv5ai4ydmrjtc7yjsuermgjiquo@n67tbjn7q4ug>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829160623.277411-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Tue, Aug 29, 2023 at 12:06:19PM -0400, Stefan Hajnoczi wrote:
> aio_context is always NULL, so drop it.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/nbd.h     | 3 +--
>  nbd/client-connection.c | 3 +--
>  nbd/client.c            | 5 ++---
>  qemu-nbd.c              | 4 ++--
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


