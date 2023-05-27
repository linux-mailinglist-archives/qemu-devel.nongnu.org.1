Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181807132D4
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 08:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2nZS-0000qT-G3; Sat, 27 May 2023 02:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nZ6-0000pS-8e
 for qemu-devel@nongnu.org; Sat, 27 May 2023 02:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nZ4-0000sK-09
 for qemu-devel@nongnu.org; Sat, 27 May 2023 02:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685169488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=THf4pcP401XmwYVo3Gj+9vg/eBiHuCMoXVD/0ik5wv8=;
 b=F+nIKehW8hLc9yY32msiIg9dLHHWaV7ntFNV1ZghZnlW1Yu21R/qZyvwfjVgmDMrOVWBSY
 zX208qRX1Gk1+sqawLksHLhlRyygAE8e148PoEPK3/Hoo9LUAGmZhN21P6yjQWxq3pxqBw
 eMS9dDPxqcebImMwNh15Eq71Y9sXQ+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-TP5wbfISOxqPZKKTsHoj_w-1; Sat, 27 May 2023 02:38:05 -0400
X-MC-Unique: TP5wbfISOxqPZKKTsHoj_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 982C48007D9;
 Sat, 27 May 2023 06:38:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EF0A40CFD00;
 Sat, 27 May 2023 06:38:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02B1921E692E; Sat, 27 May 2023 08:38:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "T.J. Alumbaugh" <talumbau@google.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Yuanchu Xie <yuanchu@google.com>,  Yu
 Zhao <yuzhao@google.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 3/5] virtio-balloon: Add QMP functions for
 Working Set
References: <20230525222016.35333-1-talumbau@google.com>
 <20230525222016.35333-4-talumbau@google.com>
Date: Sat, 27 May 2023 08:38:02 +0200
In-Reply-To: <20230525222016.35333-4-talumbau@google.com> (T. J. Alumbaugh's
 message of "Thu, 25 May 2023 22:20:14 +0000")
Message-ID: <87r0r22sad.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

"T.J. Alumbaugh" <talumbau@google.com> writes:

>   - Adds QMP function 'working-set-config'
>   - Adds QMP function 'working-set-request'
>   - Retrieve working set via 'guest-working-set' property on balloon
>
>>> cat script.py
>
> NAME = "name"
> SOCKET = 'vm.sock'
> BALLOON =  "/machine/peripheral/balloon0"
>
> import json
> import asyncio
> from qemu.qmp import QMPClient
>
> async def main():
>     client = QMPClient(NAME)
>     await client.connect(SOCKET)
>     config = { "i0": 200, "i1": 800, "i2": 3000, "refresh": 750, "report": 1000 }
>     await client.execute('working-set-config', config)
>     await client.execute('working-set-request')
>     property = {"path":BALLOON, "property":"guest-working-set"}
>     res = await client.execute('qom-get', property)
>     return res
>
> if __name__ == "__main__":
>     ret = asyncio.run(main())
>     print(json.dumps(ret, indent=2))
>
>>> (Execute qemu with flag '-qmp unix:path=vm.sock,server=on,wait=off'
>>> (Perform normal activities on VM to exercise MM code)
>
>>> python3 script.py
> {
>   "working_set": {
>     "ws3": {
>       "memory-size-bytes": {
>         "anon": 890478592,
>         "file": 1285832704
>       },
>       "idle-age": 4294967292
>     },
>     "ws2": {
>       "memory-size-bytes": {
>         "anon": 173465600,
>         "file": 83353600
>       },
>       "idle-age": 3000
>     },
>     "ws1": {
>       "memory-size-bytes": {
>         "anon": 44236800,
>         "file": 20889600
>       },
>       "idle-age": 800
>     },
>     "ws0": {
>       "memory-size-bytes": {
>         "anon": 14540800,
>         "file": 6963200
>       },
>       "idle-age": 200
>     }
>   }
> }
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>

[...]

> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 602535696c..fad1b4aed5 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -333,6 +333,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>      [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_WORKING_SET_EVENT] = { 1000 * SCALE_MS },
>  };
>  
>  /*
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 37660d8f2a..5e03ff21e2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1055,6 +1055,57 @@
>  ##
>  { 'command': 'balloon', 'data': {'value': 'int'} }
>  
> +##
> +# @working-set-config:
> +#
> +# Specify the config parameters for Working Set reporting.

Don't capitalize "Working Set" unless it is a proper noun.  Is it?

What about "Configure working set reporting"?

> +#
> +# @i0: the endpoint of the first interval (in ms)
> +#
> +# @i1: the endpoint of the second interval (in ms)
> +#
> +# @i2: the endpoint of the third interval (in ms)

An "endpoint" doesn't define an interval.  Also, a "in milliseconds"
suggests relative time.  Relative to what?

What do these intervals do?

> +#
> +# @refresh: the refresh threshold (in ms) for Working Set reporting
> +#
> +# @report: the report threshold (in ms) for Working Set reporting

What do these do?

> +#
> +# Returns: - Nothing on success
> +#          - If no balloon device is present, DeviceNotActive

We use errors other than GenericError only when we have a compelling
reason.  I figure the reason is consistency with other commands
operating on a ballon device.  Correct?

Please format like

   # Returns:
   #     - Nothing on success
   #     - If no balloon device is present, DeviceNotActive

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +#
> +# Example:
> +#
> +# -> { "execute": "working-set-config",
> +#                 "arguments": { "i0": 100,
> +#                                "i1": 500,
> +#                                "i2": 2000,
> +#                                "refresh": 750,
> +#                                "report": 1000 } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'working-set-config', 'data': {'i0': 'uint64',
> +                                            'i1': 'uint64',
> +                                            'i2': 'uint64',
> +                                            'refresh': 'uint64',
> +                                            'report': 'uint64'} }
> +##
> +# @working-set-request:
> +#
> +# Request the Working Set report from the guest.

"Request a"

> +#
> +# Returns: - Nothing on success
> +#          - If no balloon device is present, DeviceNotActive
> +#
> +# Example:
> +#
> +# -> { "execute": "working-set-request", "arguments": {} }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'working-set-request', 'data': {} }
> +
> +
>  ##
>  # @BalloonInfo:
>  #
> @@ -1113,6 +1164,21 @@
>  { 'event': 'BALLOON_CHANGE',
>    'data': { 'actual': 'int' } }
>  
> +##
> +# @WORKING_SET_EVENT:
> +#
> +# Emitted when the guest sends a new Working Set report.

Where does it send the report to?

> +#
> +# Note: this event is rate-limited.
> +#
> +# Example:
> +#
> +# <- { "event": "WORKING_SET_EVENT",
> +#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
> +#
> +##
> +{ 'event': 'WORKING_SET_EVENT' }
> +
>  ##
>  # @MemoryInfo:
>  #

Documentation needs to answer:

1. What is working set reporting about, and why would I want to use it?

2. How are the reports to be interpreted?

3. What do the configuration parameters do?

[...]


