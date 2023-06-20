Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D70736B92
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBa82-0004UP-3f; Tue, 20 Jun 2023 08:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBa7o-0004Ca-4O
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBa7m-0001IH-8c
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687262777;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XEe+rqyOS2wQHWo6YBYvALkmljftsmD2Q2TmT+g9A/I=;
 b=PZzleN9wIG//cplpMc4bEN0LgG9fCakTxz17lhpNnv4pYLNG56vQQNEGLxyiGW14/ahsb8
 7++T/v1P7UehPhDCt7FnxAoklKBg1hjKiC4T7ACEZA3QPGQ8V5YZKDD5qROqxGm1q+0oA0
 xl+/E9yT0YLjLcY4BHPbZmHX8yZHkwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-3bOTQpUnPsaNeRxR2Dsw9A-1; Tue, 20 Jun 2023 08:06:15 -0400
X-MC-Unique: 3bOTQpUnPsaNeRxR2Dsw9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F0AD803CB0;
 Tue, 20 Jun 2023 12:06:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDE4D2166B26;
 Tue, 20 Jun 2023 12:06:06 +0000 (UTC)
Date: Tue, 20 Jun 2023 13:06:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 3/6] migration: migrate 'blk' command option is deprecated.
Message-ID: <ZJGWLI9jl8MfJnd/@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612193344.3796-4-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 12, 2023 at 09:33:41PM +0200, Juan Quintela wrote:
> Use 'migrate_set_capability block true' instead.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  qapi/migration.json       | 11 +++++++----
>  migration/migration.c     |  5 +++++
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index c75a3a8f5a..47e98dc95e 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -440,3 +440,10 @@ The new way to modify migration is using migration parameters.
>  ``inc`` functionality can be acchieved using
>  ``migrate_set_parameter block-incremental true``.
>  
> +``blk`` migrate command option (since 8.1)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The new way to modify migration is using migration parameters.
> +``blk`` functionality can be acchieved using
> +``migrate_set_parameter block-incremental true``.

Same comments on rewording as the previous patch, so won't repeate them
all.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


