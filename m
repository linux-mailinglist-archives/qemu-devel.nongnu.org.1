Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181EA7EC406
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3GDs-0007L4-R2; Wed, 15 Nov 2023 08:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3GDp-0007J2-RI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3GDn-0006dK-Qf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700055981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrWAfx5ha8/7J67VVqrgCProEYFnRJc6cu662AbqwV4=;
 b=BPYoBeOrr73DZ2Du9uXOQ+bgyJyFsVzyrYqQ1r73kkv+zEcaDwDBl8MHw4J5t2YwRcKsih
 M5IRYsPZm0sJn3W5zCKDiBchHPEHl7F1dOoJMcCb/CvHZF0hAkvfiMxjrg3aFUZepnlacm
 ifOG4oV412Qy21rPetOAOJGh6HBBXIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Jg1YJDKLPHidt2BHlhS0JA-1; Wed, 15 Nov 2023 08:46:17 -0500
X-MC-Unique: Jg1YJDKLPHidt2BHlhS0JA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16EE2101A53B;
 Wed, 15 Nov 2023 13:46:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5E053709;
 Wed, 15 Nov 2023 13:46:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC70021E6A1F; Wed, 15 Nov 2023 14:46:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  yc-core@yandex-team.ru,
 zeil@yandex-team.ru,  xeor@yandex-team.ru,  kwolf@redhat.com,
 hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
References: <20231107085842.602188-1-vsementsov@yandex-team.ru>
Date: Wed, 15 Nov 2023 14:46:15 +0100
In-Reply-To: <20231107085842.602188-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 7 Nov 2023 11:58:42 +0300")
Message-ID: <87r0krnn88.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> From: Leonid Kaplan <xeor@yandex-team.ru>
>
> BLOCK_IO_ERROR events comes from guest, so we must throttle them.

Really?  Can you describe how a guest can trigger these errors?

> We still want per-device throttling, so let's use device id as a key.
>
> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  monitor/monitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 01ede1babd..ad0243e9d7 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      /* Limit guest-triggerable events to 1 per second */
>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>      }
>  
> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> +    }
> +
>      return hash;
>  }
>  
> @@ -525,6 +530,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                         qdict_get_str(evb->data, "qom-path"));
>      }
>  
> +    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
> +        return !strcmp(qdict_get_str(eva->data, "device"),
> +                       qdict_get_str(evb->data, "device"));
> +    }
> +
>      return TRUE;
>  }

Missing:

  diff --git a/qapi/block-core.json b/qapi/block-core.json
  index ca390c5700..32c2c2f030 100644
  --- a/qapi/block-core.json
  +++ b/qapi/block-core.json
  @@ -5559,6 +5559,8 @@
   # Note: If action is "stop", a STOP event will eventually follow the
   #     BLOCK_IO_ERROR event
   #
  +# Note: This event is rate-limited.
  +#
   # Since: 0.13
   #
   # Example:


