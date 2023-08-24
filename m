Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AB7787795
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEul-0008Eh-3w; Thu, 24 Aug 2023 14:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qZEuj-0008EJ-2N
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qZEue-0002oC-Nx
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692901111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KgekEoQ+ruSEaUZRsNWzzr6lZPPaMGiZgjOB64uV+s=;
 b=eyh6SYSwX2IHRIVoQx0VpJMNA3InLPhhKMLpPnRzXeIPL/ORsEOyW3qHhsHNQFEaUdiGYv
 cPwCSOwrkuso9yzr6mioHUrxIYtswC9VicmpIe06mezA3rYS4ZlGMQaGI/yyxVz3mOAu2y
 cUDhCW08Y1JZqEf86JLn415P6aiEJrE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-TmIakxe9MCWgz4E1Xd3Mhg-1; Thu, 24 Aug 2023 14:18:27 -0400
X-MC-Unique: TmIakxe9MCWgz4E1Xd3Mhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19DB238035A7;
 Thu, 24 Aug 2023 18:18:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8661C1602B;
 Thu, 24 Aug 2023 18:18:25 +0000 (UTC)
Date: Thu, 24 Aug 2023 13:18:24 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <fam@euphon.net>, 
 Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Daniel Berrange <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] io: check there are no qio_channel_yield()
 coroutines during ->finalize()
Message-ID: <7slsrk2jydwyxot2wy2vmzcgiwidngrdjrdcwv6n74j4xipfhb@xtf6mau4lbt6>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823234504.1387239-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 23, 2023 at 07:45:03PM -0400, Stefan Hajnoczi wrote:
> Callers must clean up their coroutines before calling
> object_unref(OBJECT(ioc)) to prevent an fd handler leak. Add an
> assertion to check this.
> 
> This patch is preparation for the fd handler changes that follow.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  io/channel.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


