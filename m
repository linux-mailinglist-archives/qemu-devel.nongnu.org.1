Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B97ADDAB
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkp8b-0006Uh-OZ; Mon, 25 Sep 2023 13:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qkp8X-0006Tf-Vn
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:12:46 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qkp8W-0002iS-2j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:12:45 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qkp8F-0000uH-Gz; Mon, 25 Sep 2023 19:12:27 +0200
Message-ID: <d38753d5-ac73-4b44-abfa-14e81888a4e9@maciej.szmigiero.name>
Date: Mon, 25 Sep 2023 19:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] qapi: Add HV_BALLOON_STATUS_REPORT event and its
 QMP query command
Content-Language: en-US, pl-PL
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <03f58582c27a729ab305f8337ca2d2b8034bdd3b.1693240836.git.maciej.szmigiero@oracle.com>
 <87jzse79rj.fsf@pond.sub.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87jzse79rj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.09.2023 13:49, Markus Armbruster wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Used by the hv-balloon driver for (optional) guest memory status reports.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> [...]
> 
>>   static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index dc352f9e9d95..81513c642691 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -315,6 +315,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>> +    [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
>>   };
>>   
>>   /*
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 5ede977cf2bc..f592876964af 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -1113,6 +1113,70 @@
>>   { 'event': 'BALLOON_CHANGE',
>>     'data': { 'actual': 'int' } }
>>   
>> +##
>> +# @HvBalloonInfo:
>> +#
>> +# hv-balloon guest-provided memory status information.
>> +#
>> +# @committed: the amount of memory in use inside the guest plus the
>> +#     amount of the memory unusable inside the guest (ballooned out,
>> +#     offline, etc.)
>> +#
>> +# @available: the amount of the memory inside the guest available for
>> +#     new allocations ("free")
>> +#
>> +# Since: 8.2
>> +##
>> +{ 'struct': 'HvBalloonInfo', 'data': { 'committed': 'size', 'available': 'size' } }
>> +
>> +##
>> +# @query-hv-balloon-status-report:
>> +#
>> +# Returns the hv-balloon driver data contained in the last received "STATUS"
>> +# message from the guest.
>> +#
>> +# Returns:
>> +# - @HvBalloonInfo on success
>> +# - If no hv-balloon device is present, DeviceNotFound
>> +# - If guest memory status reporting not enabled or no guest memory status
>> +#     report received yet, GenericError
> 
> Indentation is off, confusing Sphinx.
> 
> Do you actually need to tell the two failures apart?

Technically no, it's just for the API consumer convenience.

> Do me a favour and break the lines a bit earlier, like
> 
>     # Returns the hv-balloon driver data contained in the last received
>     # "STATUS" message from the guest.
>     #
>     # Returns:
>     # - @HvBalloonInfo on success
>     # - If no hv-balloon device is present, DeviceNotFound
>     # - If guest memory status reporting not enabled or no guest memory
>     #   status report received yet, GenericError

Will do.

>> +#
>> +# Since: 8.2
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-hv-balloon-status-report" }
>> +# <- { "return": {
>> +#          "committed": 816640000,
>> +#          "available": 3333054464
>> +#       }
>> +#    }
>> +##
>> +{ 'command': 'query-hv-balloon-status-report', 'returns': 'HvBalloonInfo' }
>> +
>> +##
>> +# @HV_BALLOON_STATUS_REPORT:
>> +#
>> +# Emitted when the hv-balloon driver receives a "STATUS" message from
>> +# the guest.
>> +#
>> +# @data - a @HvBalloonInfo equivalent to the one returned by the
> 
> This needs to be
> 
>     # @data: ... text ...
> 
> to be rendered correctly.
> 
> Suggest
> 
>     # @data: contents of "STATUS" message received from the guest.

Will do.

Thanks,
Maciej


