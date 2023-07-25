Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D484760C9D
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOD1o-0005ym-P4; Tue, 25 Jul 2023 04:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOD1m-0005yX-BR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOD1k-0005ev-M3
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690272255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K83/uiFAEc/635jCGEjEegMkwrTKTDlmeyBHds3CpGs=;
 b=gamrD1lw3FIEaTNHxDFl5rgUpbGF92waT09AfnAi1wH+8ektg/ValW8cOkWgd4Cu9fq1k7
 fQQnGpccXA97Up/kgN0rzcqwUQxNcWAQ2sgBVmj7nQ9Dhi+H2m7Z/9k+6xkwu9WOh5RA18
 IEWXzvCW7Y03C3LbClstTkVKCeDMgAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-DqjMCR_AOJGNP1Qitjzc2Q-1; Tue, 25 Jul 2023 04:04:10 -0400
X-MC-Unique: DqjMCR_AOJGNP1Qitjzc2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9AE38002BF;
 Tue, 25 Jul 2023 08:04:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6453F40C2063;
 Tue, 25 Jul 2023 08:04:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A47821E6690; Tue, 25 Jul 2023 10:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 5/6] qapi: Add HV_BALLOON_STATUS_REPORT event
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <22d53a9cc8756bc39b5d951436dc276fa2c665cc.1689786474.git.maciej.szmigiero@oracle.com>
Date: Tue, 25 Jul 2023 10:04:08 +0200
In-Reply-To: <22d53a9cc8756bc39b5d951436dc276fa2c665cc.1689786474.git.maciej.szmigiero@oracle.com>
 (Maciej S. Szmigiero's message of "Thu, 20 Jul 2023 12:13:02 +0200")
Message-ID: <87fs5cifif.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Used by the hv-balloon driver for (optional) guest memory status reports.

Inhowfar optional?  What enables / triggers it?

Use case for the event?

Could a status event make sense for other balloon drivers as well?

> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  qapi/machine.json | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 5ede977cf2bc..9649616b9ed2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1113,6 +1113,31 @@
>  { 'event': 'BALLOON_CHANGE',
>    'data': { 'actual': 'int' } }
>  
> +##
> +# @HV_BALLOON_STATUS_REPORT:
> +#
> +# Emitted when the hv-balloon driver receives a "STATUS" message from
> +# the guest.

Aha, the event is triggered by the guest.  It must therefore be
rate-limited, just like BALLOON_CHANGE.  To do that, add it to
monitor_qapi_event_conf[] in monitor/monitor.c, and document it as noted
below.

> +#
> +# @commited: the amount of memory in use inside the guest plus the amount
> +#            of the memory unusable inside the guest (ballooned out,
> +#            offline, etc.)
> +#
> +# @available: the amount of the memory inside the guest available for new
> +#             allocations ("free")

Spelling: committed.  Remember to update the example, too.

Please format like

# @committed: the amount of memory in use inside the guest plus the
#     amount of the memory unusable inside the guest (ballooned out,
#     offline, etc.)
#
# @available: the amount of the memory inside the guest available for
#     new allocations ("free")

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +#

To document rate-limiting, add:

   # Note: this event is rate-limited.
   #

> +# Since: TBD
> +#
> +# Example:
> +#
> +# <- { "event": "HV_BALLOON_STATUS_REPORT",
> +#      "data": { "commited": 816640000, "available": 3333054464 },
> +#      "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
> +#
> +##
> +{ 'event': 'HV_BALLOON_STATUS_REPORT',
> +  'data': { 'commited': 'size', 'available': 'size' } }
> +
>  ##
>  # @MemoryInfo:
>  #

An event is commonly paired with a query command, so that QMP clients
can resynchronize state after missing events, e.g. when reconnecting
after a client restart.

query-balloon isn't such a query: it returns less than the event.

If a paired query doesn't make sense, explain why.


