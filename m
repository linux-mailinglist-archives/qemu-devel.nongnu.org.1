Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602C7CD709
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2HK-0006Yj-5E; Wed, 18 Oct 2023 04:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt2HF-0006Iz-Py; Wed, 18 Oct 2023 04:51:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt2HC-0000oR-5I; Wed, 18 Oct 2023 04:51:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 8941760E1B;
 Wed, 18 Oct 2023 11:51:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b667::1:1d] (unknown
 [2a02:6b8:b081:b667::1:1d])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VpgnvgGOdSw0-H0jbdvXr; Wed, 18 Oct 2023 11:51:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697619092;
 bh=gUFGPkdz/60fTg+Odmhj5FYBZxbk8mHMYZAqndeoYso=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=k6RtALUWSGCI9ECc0c0SaxVJ5Q72vT2mnxTzEUKfeqVHDbCAwXq0TOco4ni36uLvb
 D2DYnVKwvyz2zsFJGYdlWFQBPjpx0sYiN5ZN20bI/JDsTw7yNm8z6h5BGPqpAy4F/g
 48st2bL9WYpXHIEMEgrBN8Pakh1CMusWlTS+EwvM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
Date: Wed, 18 Oct 2023 11:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 dave@treblig.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <877cnkzasr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 18.10.23 09:47, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 17.10.23 18:00, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Send a new event when guest reads virtio-pci config after
>>>> virtio_notify_config() call.
>>>>
>>>> That's useful to check that guest fetched modified config, for example
>>>> after resizing disk backend.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>>> index 2468f8bddf..37a8785b81 100644
>>>> --- a/qapi/qdev.json
>>>> +++ b/qapi/qdev.json
>>>> @@ -329,3 +329,25 @@
>>>>    # Since: 8.2
>>>>    ##
>>>>    { 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
>>>> +
>>>> +##
>>>> +# @X_CONFIG_READ:
>>>> +#
>>>> +# Emitted whenever guest reads virtio device config after config change.
>>>> +#
>>>> +# @device: device name
>>>> +#
>>>> +# @path: device path
>>>> +#
>>>> +# Since: 5.0.1-24
>>>> +#
>>>> +# Example:
>>>> +#
>>>> +# <- { "event": "X_CONFIG_READ",
>>>> +#      "data": { "device": "virtio-net-pci-0",
>>>> +#                "path": "/machine/peripheral/virtio-net-pci-0" },
>>>> +#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>>>> +#
>>>> +##
>>>> +{ 'event': 'X_CONFIG_READ',
>>>> +  'data': { '*device': 'str', 'path': 'str' } }
>>>
>>> The commit message talks about event CONFIG_READ, but you actually name
>>> it x-device-sync-config.
>>
>> will fix
>>
>>> I figure you use x- to signify "unstable".  Please use feature flag
>>> 'unstable' for that.  See docs/devel/qapi-code-gen.rst section
>>> "Features", in particular "Special features", and also the note on x- in
>>> section "Naming rules and reserved names".
>>
>> OK, will do.
>>
>> Hmm, it say
>>
>>     Names beginning with ``x-`` used to signify "experimental".  This
>>     convention has been replaced by special feature "unstable".
>>
>> "replaced".. So, I should use "unstable" flag without "x-" prefix? Can't find an example. Seems "unstable" always used together with "x-".
> 
> True.
> 
> The "x-" prefix originated with qdev properties.  First use might be
> commit f0c07c7c7b4.  The convention wasn't documented then, but QOM/qdev
> properties have always been a documentation wasteland.  It then spread
> to other places, and eventually to the QAPI schema.  Where we try pretty
> hard to document things properly.  We documented the "x-" prefix in
> commit e790e666518:
> 
>      Any name (command, event, type, field, or enum value) beginning with
>      "x-" is marked experimental, and may be withdrawn or changed
>      incompatibly in a future release.
> 
> Minor pain point: when things grow up from experimental to stable, we
> have to rename.
> 
> The convention didn't stop us from naming non-experimental things x-FOO,
> e.g. QOM property "x-origin" in commit 6105683da35.  Made it to the QAPI
> schema in commit 8825587b53c.  Point is: the prefix isn't a reliable
> marker for "unstable".
> 
> Since I needed a reliable marker for my "set policy for unstable
> interfaces" feature (see CLI option -compat), I created special feature
> flag "unstable", and dropped the "x-" convention for the QAPI schema.
> 
> Renaming existing "x-" names felt like pointless churn, so I didn't.
> 
> I'm not objecting to new names starting with "x-".  Nor am I objecting
> to feature 'unstable' on names that don't start with "x-".
> 
> I guess "x-" remains just fine for things we don't intend to make stable
> at some point.  The "x-" can remind humans "this is unstable" better
> than a feature flag can (for machines, it's the other way round).
> 
> For things we do intend (hope?) to make stable, I wouldn't bother with
> the "x-".
> 
> Clearer now?

Yes, thanks.

x- seems safer for management tool that doesn't know about "unstable" properties..

But on the other hand, changing from x- to no-prefix is already done when the feature is stable, and thouse who use it already use the latest version of interface, so, removing the prefix is just extra work.

So, I think, I'd go without prefix.

> 
>> Also, nothing said about events. Is using "X_" wrong idea? Should it be x-SOME_EVENT instead?
> 
> Since this is the first unstable event, there is no precedent.  Let's
> use no prefix, and move on.
> 
>>> The name CONFIG_READ feels overly generic for something that makes sense
>>> only with virtio devices.
>>
>> Hmm, right.. I think, we can say same thing about DEVICE_UNPLUG_GUEST_ERROR.
> 
> That one came to be as a generalization of existing MEM_UNPLUG_ERROR and
> a concrete need to signal CPU unplug errors.  Demonstrates "unplug guest
> errors" can happen for different kinds of devices.  So we went with a
> generic event we can use for all of them.
> 
> This doesn't seem to be the case for this patch's event.  Thoughts?

Right.. VIRTIO_CONFIG_READ maybe?

> 
>> So, what about DEVICE_GUEST_READ_CONFIG ?
>>
>>>
>>>> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>>>> index b485375049..d0f022e925 100644
>>>> --- a/softmmu/qdev-monitor.c
>>>> +++ b/softmmu/qdev-monitor.c
>>>> @@ -1252,3 +1252,8 @@ void qdev_hotplug_device_on_event(DeviceState *dev)
>>>>        dev->device_on_event_sent = true;
>>>>        qapi_event_send_x_device_on(dev->id, dev->canonical_path);
>>>>    }
>>>> +
>>>> +void qdev_config_read_event(DeviceState *dev)
>>>> +{
>>>> +    qapi_event_send_x_config_read(dev->id, dev->canonical_path);
>>>> +}
>>>
> 

-- 
Best regards,
Vladimir


