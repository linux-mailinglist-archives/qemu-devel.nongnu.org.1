Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63EE7AE61E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1iK-0003Lo-4r; Tue, 26 Sep 2023 02:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1iH-0003L3-LQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1iG-00085X-3M
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695710307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=trB9urMxlCM7CV2ZLoxy+rjnPuykl04IjVLHwEA0hC8=;
 b=BVbBSmoqnPbX6fYh/593K9TzseBm+1+IQlsOuXzXS7jK6qFRjbjWwX2Pl8BoJ2T2Uh11FQ
 X38VR4hu3tc5fGleXtRFl6w1Wqemjsb2yDpf3Nz65NusnMPhtbbY3+V33lrbzmBDOpUqmd
 TKongEM1Km1BmlBhmKKMlOLMmi0SNCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-g6WQSWaGPke512CHd_Akqg-1; Tue, 26 Sep 2023 02:38:22 -0400
X-MC-Unique: g6WQSWaGPke512CHd_Akqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB5B4801779;
 Tue, 26 Sep 2023 06:38:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2B6651E3;
 Tue, 26 Sep 2023 06:38:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9565B21E6900; Tue, 26 Sep 2023 08:38:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Markus Armbruster <armbru@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  David Hildenbrand
 <david@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Thomas Huth <thuth@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v7 6/7] qapi: Add HV_BALLOON_STATUS_REPORT event and its
 QMP query command
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <03f58582c27a729ab305f8337ca2d2b8034bdd3b.1693240836.git.maciej.szmigiero@oracle.com>
 <87jzse79rj.fsf@pond.sub.org>
 <d38753d5-ac73-4b44-abfa-14e81888a4e9@maciej.szmigiero.name>
Date: Tue, 26 Sep 2023 08:38:20 +0200
In-Reply-To: <d38753d5-ac73-4b44-abfa-14e81888a4e9@maciej.szmigiero.name>
 (Maciej S. Szmigiero's message of "Mon, 25 Sep 2023 19:12:21 +0200")
Message-ID: <87pm25jv6r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 25.09.2023 13:49, Markus Armbruster wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Used by the hv-balloon driver for (optional) guest memory status reports.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> [...]
>> 
>>>   static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>> index dc352f9e9d95..81513c642691 100644
>>> --- a/monitor/monitor.c
>>> +++ b/monitor/monitor.c
>>> @@ -315,6 +315,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>>>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>>>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>>> +    [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
>>>   };
>>>     /*
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 5ede977cf2bc..f592876964af 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -1113,6 +1113,70 @@
>>>  { 'event': 'BALLOON_CHANGE',
>>>    'data': { 'actual': 'int' } }
>>> +##
>>> +# @HvBalloonInfo:
>>> +#
>>> +# hv-balloon guest-provided memory status information.
>>> +#
>>> +# @committed: the amount of memory in use inside the guest plus the
>>> +#     amount of the memory unusable inside the guest (ballooned out,
>>> +#     offline, etc.)
>>> +#
>>> +# @available: the amount of the memory inside the guest available for
>>> +#     new allocations ("free")
>>> +#
>>> +# Since: 8.2
>>> +##
>>> +{ 'struct': 'HvBalloonInfo', 'data': { 'committed': 'size', 'available': 'size' } }

Long line.  Wrap it like

     { 'struct': 'HvBalloonInfo',
       'data': { 'committed': 'size', 'available': 'size' } }

>>> +
>>> +##
>>> +# @query-hv-balloon-status-report:
>>> +#
>>> +# Returns the hv-balloon driver data contained in the last received "STATUS"
>>> +# message from the guest.
>>> +#
>>> +# Returns:
>>> +# - @HvBalloonInfo on success
>>> +# - If no hv-balloon device is present, DeviceNotFound
>>> +# - If guest memory status reporting not enabled or no guest memory status
>>> +#     report received yet, GenericError
>>
>> Indentation is off, confusing Sphinx.
>>
>> Do you actually need to tell the two failures apart?
>
> Technically no, it's just for the API consumer convenience.

Error classes are remnants of a failed error reporting design ("rich"
error objects), and new code should stick to GenericError.  Exceptions
can be made when there's a proven need for distinguishing errors, or for
consistency, say when extending an existing interface.

The commit burying "rich" errors:

    de253f1491 qmp: switch to the new error format on the wire

Followup commits:

    6ec46ad541 block: Fix block-set-write-threshold not to use funky error class
    f3cf80e805 vnc: Fix QMP change not to use funky error class
    5b347c5410 block: Fix blockdev-backup not to use funky error class
    71568864c4 qapi: Fix up references to long gone error classes

[...]


