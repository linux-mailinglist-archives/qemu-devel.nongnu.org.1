Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599F77D1D1
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 20:27:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVylN-0005Bn-5x; Tue, 15 Aug 2023 14:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVylG-00057G-0s
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 14:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVyl5-00068R-AB
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 14:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692124022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lODYwc1GtQTiwSlrbnjx3oJaogfQZnS2Gf8LDyXLHmw=;
 b=a4qgl6+7YRKjbUJMG4QJU/t82Ex+xOOgXNtVRLtHlqCe1aIkgXkKAhkF69DqEpR4r6Mtsa
 zFF3Fjp6RqLejak+0mXzLHLNUBWhGxKEhwEiOJLDCbGJqK867xgTqiFuA6SP9dmAORPI5A
 fAIHjfkarXUvruoGLxJBtNTRvHG6EhM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-hPbq06LPOXu5yj6Dl66Ntw-1; Tue, 15 Aug 2023 14:26:25 -0400
X-MC-Unique: hPbq06LPOXu5yj6Dl66Ntw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69234381C16C;
 Tue, 15 Aug 2023 18:25:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 259F81121314;
 Tue, 15 Aug 2023 18:25:48 +0000 (UTC)
Date: Tue, 15 Aug 2023 13:25:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 7/7] util/async-teardown.c: move to softmmu/, only
 build it when system build is requested
Message-ID: <jghjzzs4d2bj2kculsbpvy3fyay2ffpz46l5vlp5usjafldbbf@2bjvb6sljdn4>
References: <cover.1691843673.git.mjt@tls.msk.ru>
 <6ca70f5b206c6231b17ad24769140a6f73b5cc6e.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca70f5b206c6231b17ad24769140a6f73b5cc6e.1691843673.git.mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Sat, Aug 12, 2023 at 03:48:01PM +0300, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  {util => softmmu}/async-teardown.c | 0
>  softmmu/meson.build                | 1 +
>  util/meson.build                   | 1 -
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename {util => softmmu}/async-teardown.c (100%)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


