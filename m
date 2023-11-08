Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673C7E5FE8
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:23:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0q0H-00083X-Lq; Wed, 08 Nov 2023 16:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r0q0C-00083A-P9
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r0q0A-0002rL-VN
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699478535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFqpGd1lH9TPwRe2nTD1OQK2MlAUMTRnAfWVtjsGzq4=;
 b=f0O7CNDdKBpS+T/BRZCzkbhilUM0ynmpL5LZxmodDTkWfA5X8ygji3lFeY3um/iKLewfKN
 k0J0D19d/zh0YsVqS4mrs2h3j1vc21pnzHXhBW3oWqPe/oyNUN0MgiJeFfpuDUtsJIZE26
 qURwPIl04XtNiGHAO+Nn48oSkkLHYpM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-T5j2urt7MAqvtMW1Od39ng-1; Wed,
 08 Nov 2023 16:22:12 -0500
X-MC-Unique: T5j2urt7MAqvtMW1Od39ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C18EF3C11C63;
 Wed,  8 Nov 2023 21:22:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 672D22166B26;
 Wed,  8 Nov 2023 21:22:10 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:22:08 -0600
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, dave@treblig.org, armbru@redhat.com, 
 yc-core@yandex-team.ru, zeil@yandex-team.ru, xeor@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
Message-ID: <tl4b6tcrlwchbgrkq2zuqyxqqsxe3oclrgt6pr62ggm2nbtkfz@lah5uyiomzp5>
References: <20231107085842.602188-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107085842.602188-1-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 07, 2023 at 11:58:42AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> From: Leonid Kaplan <xeor@yandex-team.ru>
> 
> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
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

Wouldn't ^= be better than += for combining hashes?

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

At any rate, the idea makes sense for me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


