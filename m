Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6068D7FEB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 12:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4td-0004yz-N7; Mon, 03 Jun 2024 06:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4tc-0004yb-0w
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4ta-000470-Ck
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717410389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+NbPhl9WSk1+71l74SlAReWUmh6OfvLAcMJQhj8g4g=;
 b=DiVGYf0juaolhL8hSR967vqovF6viiJyQaTUypBj+GdL0vnpJoaW1jLPDtG7N4Ob+UMGy9
 i2IwwY/qBiJ9tGNBiKkA3RBYPkdURw4jE/qbFGQPqfncPPttIEdUkSZRu4Q20plwVIqEZf
 y7WExNlghoIWaOjWYFg7kjGbfHA3UTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-lw9vUNZhO7q1Z9GdSh6IJQ-1; Mon, 03 Jun 2024 06:26:25 -0400
X-MC-Unique: lw9vUNZhO7q1Z9GdSh6IJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D2F58058D5;
 Mon,  3 Jun 2024 10:26:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F484491037;
 Mon,  3 Jun 2024 10:26:23 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:26:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/18] monitor: Drop monitor_fdset_dup_fd_add()
Message-ID: <Zl2aTbNHdB_NGEwW@redhat.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523190548.23977-5-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Incorrect $SUBJECT - it claims to be removing monitor_fdset_dup_fd_add
but actually removes monitor_fdset_dup_fd_find.

On Thu, May 23, 2024 at 04:05:34PM -0300, Fabiano Rosas wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> This function is not needed, one remove function should already work.
> Clean it up.
> 
> Here the code doesn't really care about whether we need to keep that dupfd
> around if close() failed: when that happens something got very wrong,
> keeping the dup_fd around the fdsets may not help that situation so far.
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [add missing return statement, removal during traversal is not safe]
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/monitor/monitor.h |  1 -
>  monitor/fds.c             | 28 ++++++----------------------
>  stubs/fdset.c             |  5 -----
>  util/osdep.c              | 15 +--------------
>  4 files changed, 7 insertions(+), 42 deletions(-)

With $SUBJECT fixed

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


