Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB11710F1C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CY8-0007XV-CI; Thu, 25 May 2023 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CY5-0007Wu-7R
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CY2-0003IS-2y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685027196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wiNH1LiMaHERdGIwp5K+cwXHk3kN7jeT0AyZoZ4aRtg=;
 b=grwzY5a0hMTJjWlvD9zHzN6kFRbkKHx2LdT/RQmUYUEKA4z9RyAtY21M33+WV7I1sCaPJF
 iYIrNInsITwcGCUGxvZtEIxJ4TpiuTk9t2l2zmI7+mJRyl5nYj4UgDWkxIgJlPSMv5nMjv
 zHTlLqqkakuyVJkVq2sfeqf9GTMQb2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-a4rbWyLxOhWNT2raD0Iu6Q-1; Thu, 25 May 2023 11:06:34 -0400
X-MC-Unique: a4rbWyLxOhWNT2raD0Iu6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B092385A5BD
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:06:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 900ED400E118
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:06:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8263121E692E; Thu, 25 May 2023 17:06:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] monitor: use QEMU_LOCK_GUARD a bit more
References: <20230518101804.992085-1-pbonzini@redhat.com>
 <20230518101804.992085-2-pbonzini@redhat.com>
Date: Thu, 25 May 2023 17:06:32 +0200
In-Reply-To: <20230518101804.992085-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 18 May 2023 12:18:01 +0200")
Message-ID: <877cswo3gn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  monitor/monitor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 602535696c59..4b11bca2a21d 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -161,10 +161,9 @@ static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
>  {
>      Monitor *mon = opaque;
>  
> -    qemu_mutex_lock(&mon->mon_lock);
> +    QEMU_LOCK_GUARD(&mon->mon_lock);
>      mon->out_watch = 0;
>      monitor_flush_locked(mon);
> -    qemu_mutex_unlock(&mon->mon_lock);
>      return FALSE;
>  }
>  
> @@ -203,9 +202,8 @@ static void monitor_flush_locked(Monitor *mon)
>  
>  void monitor_flush(Monitor *mon)
>  {
> -    qemu_mutex_lock(&mon->mon_lock);
> +    QEMU_LOCK_GUARD(&mon->mon_lock);
>      monitor_flush_locked(mon);
> -    qemu_mutex_unlock(&mon->mon_lock);
>  }
>  
>  /* flush at every end of line */

I wouldn't bother to make this change when the protected region is this
short and doesn't branch, but since you did, why not take it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


