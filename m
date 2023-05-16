Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6D705252
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:36:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywiJ-0002rV-5u; Tue, 16 May 2023 11:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pywiE-0002pI-HD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pywiA-0008Ny-AA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684251337;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oj1CC9Lsi/TVd8vfMqWP/Bf6L1hsE4O5WzAJkYnrTwI=;
 b=BcDc1J1w5aijCsRyofEEDVLmiatkyYNgof8Re+ruU7dHOloYHduDOG6/NrIFK6w3a6Spq5
 RIWvz/0datGWAOjfKH9mxebPkUZ5Al7W9oGIAb7HpdE6TE8UH+IhAHXPkHIiTTaW+efZsz
 8Q+UClc0RXV9MZ2ehcXpfhEa2xh/wvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-2odykDX-Osq3Ucevkr_niA-1; Tue, 16 May 2023 11:35:35 -0400
X-MC-Unique: 2odykDX-Osq3Ucevkr_niA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DD4088B770
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 15:35:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3619400F5A;
 Tue, 16 May 2023 15:35:33 +0000 (UTC)
Date: Tue, 16 May 2023 16:35:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] migration: Fix duplicated included in meson.build
Message-ID: <ZGOiwzj5fp6LeL8r@redhat.com>
References: <20230509170217.83246-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509170217.83246-1-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 09, 2023 at 07:02:17PM +0200, Juan Quintela wrote:
> This is the commint with the merge error (not in the submited patch).
> 
> commit 52623f23b0d114837a0d6278180b3e3ae8947117
> Author: Lukas Straub <lukasstraub2@web.de>
> Date:   Thu Apr 20 11:48:35 2023 +0200
> 
>     ram-compress.c: Make target independent
> 
>     Make ram-compress.c target independent.
> 
> Fixes: 52623f23b0d114837a0d6278180b3e3ae8947117
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/meson.build | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


