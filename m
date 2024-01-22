Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E66836D4D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:27:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRy4Y-0005se-Fr; Mon, 22 Jan 2024 12:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRy4T-0005rL-EL
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRy4R-0001Um-Fu
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705944410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wOHcSM+I5Nj4Sr/xYcv69oHjnECFRd3TfqQLoTWI5c4=;
 b=QyLPkyxbbK/GL3BYsmG9vfqxEIePm8LCcTHmYBoSI3+JtdVzehRaL+KuMbV16ce0G+Yl6a
 CLfdxdSMktUsuoClIThPWKpFLkQ4oX3rTIfnJcaFGy7OJliFHb+Z2UQttsYzm/SQDlTi8D
 h5L3v25arylCX3K4role66Lk05oykOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-YJqmBa7TM-egqExTHzj2Yg-1; Mon, 22 Jan 2024 12:26:45 -0500
X-MC-Unique: YJqmBa7TM-egqExTHzj2Yg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B82E880007C;
 Mon, 22 Jan 2024 17:26:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C26B492BE2;
 Mon, 22 Jan 2024 17:26:44 +0000 (UTC)
Date: Mon, 22 Jan 2024 17:26:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Subject: Re: [PATCH v2 1/4] Include new arbitrary limits if not already defined
Message-ID: <Za6lUaLwYm1Y4gvj@redhat.com>
References: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jan 18, 2024 at 05:02:23PM +0100, Manolo de Medici wrote:
> qemu uses the PATH_MAX and IOV_MAX constants extensively
> in the code. Define these constants to sensible values ourselves
> if the system doesn't define them already.

Please give details of what platform(s) lack these constants
in the commit message.

Presumably this is a platform that is outside of our normal
support build target list, since we have at least build
coverage for everything mainstream.

> 
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  include/qemu/osdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 9a405bed89..9fb6ac5c64 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
>  #define TIME_MAX TYPE_MAXIMUM(time_t)
>  #endif
> 
> +#ifndef PATH_MAX
> +#define PATH_MAX 1024
> +#endif
> +
> +#ifndef IOV_MAX
> +#define IOV_MAX 1024
> +#endif

If we're going to add this, since we should be removing the
later duplication:

  #define IOV_MAX 1024

in this same file

> +
>  /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
>   * the wrong type. Our replacement isn't usable in preprocessor
>   * expressions, but it is sufficient for our needs. */
> --
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


