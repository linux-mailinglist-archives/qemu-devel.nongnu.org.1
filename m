Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA771FEBC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51ns-0006nt-TJ; Fri, 02 Jun 2023 06:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q51nr-0006nk-7K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q51np-0005fr-1i
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685700875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KboCMttqzmq9fnad+u2dDJNypnXIV/u5wGG3Pt0f5Pg=;
 b=Vthd5TebjSGXGJkRtOrlmsMl5CfegWYy0WROVv+TTE8ZWrhWFI6LFK4n1IxKaRWMlJcYq3
 whPvcZ+dRTZu7yNha5YNb/BKgl4+wn4l8yMvkUN1q+LEvZQ0PvHKxZFrozKZrDnbXTW0wJ
 KEzuYNF4nYz+E4wO5/RXkcxNgY6pVvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-xOyY-sq5NhWOlmgCLT1h3g-1; Fri, 02 Jun 2023 06:14:31 -0400
X-MC-Unique: xOyY-sq5NhWOlmgCLT1h3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD6CC185A78B;
 Fri,  2 Jun 2023 10:14:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0848D492B00;
 Fri,  2 Jun 2023 10:14:29 +0000 (UTC)
Date: Fri, 2 Jun 2023 11:14:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <rth@twiddle.net>
Subject: Re: Big TCG slowdown when using zstd with aarch64
Message-ID: <ZHnBAjY/B/rEQzTB@redhat.com>
References: <87y1l2rixp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1l2rixp.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 11:06:42PM +0200, Juan Quintela wrote:
> 
> Hi
> 
> Before I continue investigating this further, do you have any clue what
> is going on here.  I am running qemu-system-aarch64 on x86_64.

FYI, the trigger for this behaviour appears to be your recent change
to stats accounting in:

commit cbec7eb76879d419e7dbf531ee2506ec0722e825 (HEAD)
Author: Juan Quintela <quintela@redhat.com>
Date:   Mon May 15 21:57:09 2023 +0200

    migration/multifd: Compute transferred bytes correctly
    
    In the past, we had to put the in the main thread all the operations
    related with sizes due to qemu_file not beeing thread safe.  As now
    all counters are atomic, we can update the counters just after the
    do the write.  As an aditional bonus, we are able to use the right
    value for the compression methods.  Right now we were assuming that
    there were no compression at all.
    
    Signed-off-by: Juan Quintela <quintela@redhat.com>
    Reviewed-by: Peter Xu <peterx@redhat.com>
    Message-Id: <20230515195709.63843-17-quintela@redhat.com>



Before that commit the /aarch64/migration/multifd/tcp/plain/{none,zlib,zstd}
tests all took 21 seconds eachs.

After that commit the 'none' test takes about 3 seconds, and the zlib/zstd
test take about 1 second, except when zstd is suddenly very slow.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


