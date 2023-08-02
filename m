Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6B76C839
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR729-0001HW-PY; Wed, 02 Aug 2023 04:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qR726-0000xv-W9
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qR725-0006XI-0s
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690964195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKKG8Hjl0G8JZSyEDbTleDCllGmaKVn7mYPvBwuzKgs=;
 b=Dj1cDM5h+08hHwuILwhV/wtLZ0ll9KGwVtpQqIYFUeJnYyN9LJjnb2HUZ2cOQ31/gq4+Rw
 BKX9VXz1mdCTEMits61ZE+EfoTm559OLGxejGWc9JQF2RROy9cRdgD/pcg2wXneS1CcGpt
 VAvWmOL+s8xgB5AiGCgHdE2Mn538Omk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-7W5qzLw6MUetb3vBF8S-RQ-1; Wed, 02 Aug 2023 04:16:32 -0400
X-MC-Unique: 7W5qzLw6MUetb3vBF8S-RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E345686D01D;
 Wed,  2 Aug 2023 08:16:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC08D1121325;
 Wed,  2 Aug 2023 08:16:30 +0000 (UTC)
Date: Wed, 2 Aug 2023 09:16:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 1/3] linux-user: Fix openat() emulation to correctly
 detect accesses to /proc
Message-ID: <ZMoQ3N2VShyR73fR@redhat.com>
References: <20230801230842.414421-1-deller@gmx.de>
 <20230801230842.414421-2-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801230842.414421-2-deller@gmx.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 02, 2023 at 01:08:40AM +0200, Helge Deller wrote:
> In qemu we catch accesses to files like /proc/cpuinfo or /proc/net/route
> and return to the guest contents which would be visible on a real system
> (instead what the host would show).
> 
> This patch fixes a bug, where for example the accesses
>     cat /proc////cpuinfo
> or
>     cd /proc && cat cpuinfo
> will not be recognized by qemu and where qemu will wrongly show
> the contents of the host's /proc/cpuinfo file.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> --
> v3:
> - use g_autofree on returned value from realpath
> 
> v2:
> - use g_autofree instead of pathname on stack
>   Daniel P. Berrangé requested to not put buffers on stack.
>   Using g_autofree keeps code much cleaner than using
>   extended semantics of realpath(), unless I can use g_autofree
>   on malloced area from realpath().
> ---
>  linux-user/syscall.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


