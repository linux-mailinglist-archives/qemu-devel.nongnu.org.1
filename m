Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2CA7AD3D9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 10:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhLz-0007kD-0f; Mon, 25 Sep 2023 04:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhLw-0007j9-PH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhLv-0001Te-6D
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7T6Q3CR7JaT1rHUh/kN9bqSYLtMX6JCgLfnsTHS7FXE=;
 b=bY4Z5F5k8K7vdydMY6MTIvnecBOf7QvdUfO+1XvHDb1l5HBPxtDL/aiLCTQSo/BRLKayKj
 t6zFsBJnv09slghkoki5zCz064mp0arBnfNtWrGJv+OITMpnU050prJeFbpf0v25PxmUDp
 Tc5jtEkG4cVBqedqeqZkJBjjTYlUFbM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-nOR_slmYMBKQpG2ja4CHCA-1; Mon, 25 Sep 2023 04:53:59 -0400
X-MC-Unique: nOR_slmYMBKQpG2ja4CHCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C41EE29A9D42;
 Mon, 25 Sep 2023 08:53:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 960C340C2070;
 Mon, 25 Sep 2023 08:53:57 +0000 (UTC)
Date: Mon, 25 Sep 2023 09:53:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] qemu-nbd: changes towards enabling -Wshadow=local
Message-ID: <ZRFKo+PzSY5/zLBB@redhat.com>
References: <20230922205019.2755352-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922205019.2755352-2-eblake@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 22, 2023 at 03:50:20PM -0500, Eric Blake wrote:
> Address all compiler complaints from -Wshadow in qemu-nbd.  Several
> instances of 'int ret' became shadows when commit 4fbec260 added 'ret'
> at a higher scope in main.  More interesting was the 'void *ret'
> capturing the result of a pthread; where we were conceptually doing
> '(void*)(intptr_t)EXIT_FAILURE != NULL' which just feels wrong (even
> though it happens to compile correctly), so it was worth a better
> cleanup.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I'm happy to let Markus collect this with the growing pile on
> shadow-next, instead of going through my NBD tree.
> 
>  qemu-nbd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


