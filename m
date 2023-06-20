Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E4736B80
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBa3X-000186-5l; Tue, 20 Jun 2023 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBa3U-00015e-1N
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBa3R-00008W-Ng
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687262508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUCP4hxRcrJGtgQ1zT4MZFw4TJOuSavFfDzjF/DkxMg=;
 b=G9xB/WANB/ui3vyLBLg+5yOj1LL1ZZFuGoxeVopHDmZteuYM1Ywx3biHn46HYwmMSqjjG1
 onw998Hmxyh526Z9bC9dkvmXHClFznZczUEbpc5oABkafTSQ5kMXnq2rxlG65iSDbXtQNF
 qnJXfb8dmFssiMjbaqAq7J6+oJ8ba0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-MWHv1edmPXilqwBsK2W0kg-1; Tue, 20 Jun 2023 08:01:46 -0400
X-MC-Unique: MWHv1edmPXilqwBsK2W0kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B96A85A59D;
 Tue, 20 Jun 2023 12:01:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B616A112132C;
 Tue, 20 Jun 2023 12:01:44 +0000 (UTC)
Date: Tue, 20 Jun 2023 13:01:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/6] migration: skipped field is really obsolete.
Message-ID: <ZJGVJiL7HX49RSfu@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612193344.3796-2-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Mon, Jun 12, 2023 at 09:33:39PM +0200, Juan Quintela wrote:
> Has return zero for more than 10 years.  Just mark it deprecated.

Specifically we introduced the field in 1.5.0

commit f1c72795af573b24a7da5eb52375c9aba8a37972
Author: Peter Lieven <pl@kamp.de>
Date:   Tue Mar 26 10:58:37 2013 +0100

    migration: do not sent zero pages in bulk stage
    
    during bulk stage of ram migration if a page is a
    zero page do not send it at all.
    the memory at the destination reads as zero anyway.
    
    even if there is an madvise with QEMU_MADV_DONTNEED
    at the target upon receipt of a zero page I have observed
    that the target starts swapping if the memory is overcommitted.
    it seems that the pages are dropped asynchronously.
    
    this patch also updates QMP to return the number of
    skipped pages in MigrationStats.
    


but removed its usage in 1.5.3

commit 9ef051e5536b6368a1076046ec6c4ec4ac12b5c6
Author: Peter Lieven <pl@kamp.de>
Date:   Mon Jun 10 12:14:19 2013 +0200

    Revert "migration: do not sent zero pages in bulk stage"
    
    Not sending zero pages breaks migration if a page is zero
    at the source but not at the destination. This can e.g. happen
    if different BIOS versions are used at source and destination.
    It has also been reported that migration on pseries is completely
    broken with this patch.
    
    This effectively reverts commit f1c72795af573b24a7da5eb52375c9aba8a37972.


> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/about/deprecated.rst | 10 ++++++++++
>  qapi/migration.json       | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> diff --git a/qapi/migration.json b/qapi/migration.json
> index cb7cd3e578..bcae193733 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -23,7 +23,8 @@
>  #
>  # @duplicate: number of duplicate (zero) pages (since 1.2)
>  #
> -# @skipped: number of skipped zero pages (since 1.5)
> +# @skipped: number of skipped zero pages. Don't use, only provided for
> +#     compatibility (since 1.5)

I'd say

   @skipped: number of skipped zero pages. Always zero, only provided for
   compatibility (since 1.5)

>  #
>  # @normal: number of normal pages (since 1.2)
>  #
> @@ -62,11 +63,18 @@
>  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>  #     7.1)
>  #
> +# Features:
> +#
> +# @deprecated: Member @skipped has not been used for a long time.

  @deprecated: Member @skipped is always zero since 1.5.3


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


