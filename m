Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DF837260
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:22:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzsS-0004wg-VF; Mon, 22 Jan 2024 14:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRzsO-0004uP-6d
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRzsL-0005E0-DK
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705951348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkFnR5s5hHboIXmh32DuvnLiAWHl6aY0Xd0TaXengGQ=;
 b=AtAtVWqV+M0skGlAaaok4Cq2hht4Q4QbE8wCivZEMnXG1bv9UyAK8MVOS+6DfFfFHkL1ho
 zvVBzNscBfVZyCGCRiGav0ou8EVko59gCD0VInYhjnh/2lAyV0sHI39YBIN7Vp7/YsbXzh
 X5WWpI/NojowE5IenmKiqnNhwTWkxHM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6GEUQM0kMJ6igf4ns0CbSw-1; Mon,
 22 Jan 2024 14:22:24 -0500
X-MC-Unique: 6GEUQM0kMJ6igf4ns0CbSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 698AE29AC004;
 Mon, 22 Jan 2024 19:22:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2F3927;
 Mon, 22 Jan 2024 19:22:22 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:22:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/5] util/uri: Simplify the code, remove unused functions
Message-ID: <Za7AbEhGXWvWd8Id@redhat.com>
References: <20240122191753.103118-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122191753.103118-1-thuth@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On Mon, Jan 22, 2024 at 08:17:48PM +0100, Thomas Huth wrote:
> The URI function uri_string_unescape() has some overlap with functions
> from the glib, so we can simplify our code here quite a bit.
> While at it, I also noticed that there are many unused functions in
> here which we likely can drop nowadays (it's better to use the functions
> from glib anyway).
> 
> Thomas Huth (5):
>   util/uri: Remove the unused "target" argument from
>     uri_string_unescape()
>   util/uri: Simplify uri_string_unescape()
>   util/uri: Remove the uri_string_escape() function
>   util/uri: Remove unused functions uri_resolve() and
>     uri_resolve_relative()
>   util/uri: Remove unused macros ISA_RESERVED() and ISA_GEN_DELIM()
> 
>  include/qemu/uri.h |   5 +-
>  util/uri.c         | 843 +--------------------------------------------
>  2 files changed, 16 insertions(+), 832 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


