Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECB709B1F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01t6-0004os-89; Fri, 19 May 2023 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q01t3-0004jE-PJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q01t2-0004mV-4c
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQvpgsucfFCCsfKGXyH3B509dbUvCN8Nv3InmAPzWO4=;
 b=IkoyKy3X9H8iZ1djqTxv4Wht6H37Z/LJq0f5k/4OR4mRfIMTQmYBXKk8Q5aEmPuhlZtdnd
 hB5exvyy8Yi7sm/hNeWaR9DdkO6S7qYdt28tvR8HpKK5sZ2c+2KPxQGuW/2IbulO+0IQ+G
 v4xYQpJfb6cKaxf5Swr/CiBEtvjLpZ8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-MzwOq5BNNjW_At8KlxN6NA-1; Fri, 19 May 2023 11:19:16 -0400
X-MC-Unique: MzwOq5BNNjW_At8KlxN6NA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAE913C01C1A;
 Fri, 19 May 2023 15:19:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ACD2492B0A;
 Fri, 19 May 2023 15:19:14 +0000 (UTC)
Date: Fri, 19 May 2023 16:19:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] iotests: Fix test 104 under NBD
Message-ID: <ZGeTb2hMd1LteBWE@redhat.com>
References: <20230519150216.2599189-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519150216.2599189-1-eblake@redhat.com>
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

On Fri, May 19, 2023 at 10:02:16AM -0500, Eric Blake wrote:
> In the past, commit a231cb27 ("iotests: Fix 104 for NBD", v2.3.0)
> added an additional filter to _filter_img_info to rewrite NBD URIs
> into the expected output form.  This recently broke when we tweaked
> tests to run in a per-format directory, which did not match the regex,
> because _img_info itself is now already changing
> SOCK_DIR=/tmp/tmpphjfbphd/raw-nbd-104 into
> /tmp/tmpphjfbphd/IMGFMT-nbd-104 prior to _img_info_filter getting a
> chance to further filter things.
> 
> While diagnosing the problem, I also noticed some filter lines
> rendered completely useless by a typo when we switched from TCP to
> Unix sockets for NBD (in shell, '\\+' is different from "\\+" (one
> gives two backslash to the regex, matching the literal 2-byte sequence
> <\+> after a single digit; the other gives one backslash to the regex,
> as the metacharacter \+ to match one or more of <[0-9]>); since the
> literal string <nbd://127.0.0.1:0\+> is not a valid URI, that regex
> hasn't been matching anything for years so it is fine to just drop it
> rather than fix the typo.
> 
> Fixes: f3923a72 ("iotests: Switch nbd tests to use Unix rather than TCP", v4.2.0)
> Fixes: 5ba7db09 ("iotests: always use a unique sub-directory per test", v8.0.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 4 +---
>  tests/qemu-iotests/common.rc     | 3 ++-
>  2 files changed, 3 insertions(+), 4 deletions(-)

I was about submit something similar to common.rc

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


