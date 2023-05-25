Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93EA710F28
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CZk-0000rx-Dt; Thu, 25 May 2023 11:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CZi-0000po-L6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CZh-0003RX-3G
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685027300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9NYm8F75WnVZC31x0Hc/uS7CUDfVU1AzBm6rdMLrxAI=;
 b=XhNFRBmRflxvIscwmMqT7B433ATCn0V+5DrgsFUrUXYrOoIH+W+qxcJ+VGv1WcIbChJYb0
 zWl9Ps8VY0wTCtMO8X6EKiM8FaZI1TM6dXP4AUy9RG/tk+hwnmwXRuh7JKNhBtbNIL9YpZ
 7tVfQfiCbbOXptbiEMHo1lgze5c+CXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-PejIUoWYMf-qZJUr-M-6Ag-1; Thu, 25 May 2023 11:08:19 -0400
X-MC-Unique: PejIUoWYMf-qZJUr-M-6Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD6A3101A52C
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:08:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC247C154D2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:08:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A180E21E692E; Thu, 25 May 2023 17:08:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com
Subject: Re: [PATCH 2/4] monitor: allow calling monitor_resume under mon_lock
References: <20230518101804.992085-1-pbonzini@redhat.com>
 <20230518101804.992085-3-pbonzini@redhat.com>
Date: Thu, 25 May 2023 17:08:17 +0200
In-Reply-To: <20230518101804.992085-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 18 May 2023 12:18:02 +0200")
Message-ID: <87353ko3dq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> Move monitor_resume()'s call to readline_show_prompt() outside the
> potentially locked section.  Reuse the existing monitor_accept_input()
> bottom half for this purpose.

This describes what the patch changes, but not why we want the change.
Could you elaborate a bit?

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  monitor/monitor.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 4b11bca2a21d..7080d2da8ec6 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -567,6 +567,12 @@ static void monitor_accept_input(void *opaque)
>  {
>      Monitor *mon = opaque;
>  
> +    if (!monitor_is_qmp(mon)) {
> +        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +        assert(hmp_mon->rs);
> +        readline_show_prompt(hmp_mon->rs);
> +    }
> +
>      qemu_chr_fe_accept_input(&mon->chr);
>  }
>  
> @@ -585,12 +591,6 @@ void monitor_resume(Monitor *mon)
>              ctx = qemu_get_aio_context();
>          }
>  
> -        if (!monitor_is_qmp(mon)) {
> -            MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> -            assert(hmp_mon->rs);
> -            readline_show_prompt(hmp_mon->rs);
> -        }
> -
>          aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
>      }


