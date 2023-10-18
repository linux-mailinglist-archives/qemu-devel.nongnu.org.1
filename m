Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579F7CD4A4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0Lm-000688-1o; Wed, 18 Oct 2023 02:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0Lb-00067a-Bj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0LZ-0003Py-Ip
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697611680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOWdYwxuXwTUhsnGcyfJ2hrvkOQmJmcblh6uZhWR1oQ=;
 b=EqXT4QpzcpbHFDWCDYK+pc9C6Yf/yHVL8WnoSPj688+LRVpxScGChi1PSORkPqFN266Gjs
 Trc9y7aZsuDhUBjlpGv5pisfeKteubbKCAAzLcpD5RXT5HgLWB1W9iAYewtbUKAtEHt0Nu
 foeNMOJ2HVgECJZvL27q/hRnnZF8Yp4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-61-Zzur8PBqdGmVu84IiXA-1; Wed, 18 Oct 2023 02:47:50 -0400
X-MC-Unique: 61-Zzur8PBqdGmVu84IiXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE0DA88D024;
 Wed, 18 Oct 2023 06:47:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7617C8C1;
 Wed, 18 Oct 2023 06:47:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65C5621E6A1F; Wed, 18 Oct 2023 08:47:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  eblake@redhat.com,  dave@treblig.org,
 eduardo@habkost.net,  berrange@redhat.com,  pbonzini@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  raphael.norwitz@nutanix.com,
 mst@redhat.com,  yc-core@yandex-team.ru,  den-plotnikov@yandex-team.ru,
 daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
Date: Wed, 18 Oct 2023 08:47:48 +0200
In-Reply-To: <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Oct 2023 18:44:03 +0300")
Message-ID: <877cnkzasr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 17.10.23 18:00, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Send a new event when guest reads virtio-pci config after
>>> virtio_notify_config() call.
>>>
>>> That's useful to check that guest fetched modified config, for example
>>> after resizing disk backend.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index 2468f8bddf..37a8785b81 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -329,3 +329,25 @@
>>>   # Since: 8.2
>>>   ##
>>>   { 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
>>> +
>>> +##
>>> +# @X_CONFIG_READ:
>>> +#
>>> +# Emitted whenever guest reads virtio device config after config change.
>>> +#
>>> +# @device: device name
>>> +#
>>> +# @path: device path
>>> +#
>>> +# Since: 5.0.1-24
>>> +#
>>> +# Example:
>>> +#
>>> +# <- { "event": "X_CONFIG_READ",
>>> +#      "data": { "device": "virtio-net-pci-0",
>>> +#                "path": "/machine/peripheral/virtio-net-pci-0" },
>>> +#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>>> +#
>>> +##
>>> +{ 'event': 'X_CONFIG_READ',
>>> +  'data': { '*device': 'str', 'path': 'str' } }
>>
>> The commit message talks about event CONFIG_READ, but you actually name
>> it x-device-sync-config.
>
> will fix
>
>> I figure you use x- to signify "unstable".  Please use feature flag
>> 'unstable' for that.  See docs/devel/qapi-code-gen.rst section
>> "Features", in particular "Special features", and also the note on x- in
>> section "Naming rules and reserved names".
>
> OK, will do.
>
> Hmm, it say
>
>    Names beginning with ``x-`` used to signify "experimental".  This
>    convention has been replaced by special feature "unstable".
>
> "replaced".. So, I should use "unstable" flag without "x-" prefix? Can't find an example. Seems "unstable" always used together with "x-".

True.

The "x-" prefix originated with qdev properties.  First use might be
commit f0c07c7c7b4.  The convention wasn't documented then, but QOM/qdev
properties have always been a documentation wasteland.  It then spread
to other places, and eventually to the QAPI schema.  Where we try pretty
hard to document things properly.  We documented the "x-" prefix in
commit e790e666518:

    Any name (command, event, type, field, or enum value) beginning with
    "x-" is marked experimental, and may be withdrawn or changed
    incompatibly in a future release.

Minor pain point: when things grow up from experimental to stable, we
have to rename.

The convention didn't stop us from naming non-experimental things x-FOO,
e.g. QOM property "x-origin" in commit 6105683da35.  Made it to the QAPI
schema in commit 8825587b53c.  Point is: the prefix isn't a reliable
marker for "unstable".

Since I needed a reliable marker for my "set policy for unstable
interfaces" feature (see CLI option -compat), I created special feature
flag "unstable", and dropped the "x-" convention for the QAPI schema.

Renaming existing "x-" names felt like pointless churn, so I didn't.

I'm not objecting to new names starting with "x-".  Nor am I objecting
to feature 'unstable' on names that don't start with "x-".

I guess "x-" remains just fine for things we don't intend to make stable
at some point.  The "x-" can remind humans "this is unstable" better
than a feature flag can (for machines, it's the other way round).

For things we do intend (hope?) to make stable, I wouldn't bother with
the "x-".

Clearer now?

> Also, nothing said about events. Is using "X_" wrong idea? Should it be x-SOME_EVENT instead?

Since this is the first unstable event, there is no precedent.  Let's
use no prefix, and move on.

>> The name CONFIG_READ feels overly generic for something that makes sense
>> only with virtio devices.
>
> Hmm, right.. I think, we can say same thing about DEVICE_UNPLUG_GUEST_ERROR.

That one came to be as a generalization of existing MEM_UNPLUG_ERROR and
a concrete need to signal CPU unplug errors.  Demonstrates "unplug guest
errors" can happen for different kinds of devices.  So we went with a
generic event we can use for all of them.

This doesn't seem to be the case for this patch's event.  Thoughts?

> So, what about DEVICE_GUEST_READ_CONFIG ?
>
>> 
>>> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>>> index b485375049..d0f022e925 100644
>>> --- a/softmmu/qdev-monitor.c
>>> +++ b/softmmu/qdev-monitor.c
>>> @@ -1252,3 +1252,8 @@ void qdev_hotplug_device_on_event(DeviceState *dev)
>>>       dev->device_on_event_sent = true;
>>>       qapi_event_send_x_device_on(dev->id, dev->canonical_path);
>>>   }
>>> +
>>> +void qdev_config_read_event(DeviceState *dev)
>>> +{
>>> +    qapi_event_send_x_config_read(dev->id, dev->canonical_path);
>>> +}
>> 


