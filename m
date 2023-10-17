Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9F7CC787
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsm3J-0002Iz-Sg; Tue, 17 Oct 2023 11:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsm3H-0002IY-Fx; Tue, 17 Oct 2023 11:32:11 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsm3D-0007eE-IK; Tue, 17 Oct 2023 11:32:10 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 7EE936251B;
 Tue, 17 Oct 2023 18:32:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:24] (unknown
 [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0WmrmtHOj0U0-kfRkGQGQ; Tue, 17 Oct 2023 18:32:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697556721;
 bh=kecQllbRaymLebxLa8bUXVFrHYmJS7j/1ddWh9L2UE4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NdLDWCmKg6XeDZKZ3TCJjqcGX7cZ51Kx382fP6PGmxHvVLIf45zE1gY+Bw5OafeYP
 33cKRwhAwSyLpjRmWbxPRFyaIy9ZNW0H6GhDCxZ+Hj5bjDKE181PchPvXs2Fmcdwzm
 KlS8HlmF8YHiFHK89Jq2x8e0/4taZACGk27N0c/c=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9d62a50e-627e-4441-b760-56c096f99c53@yandex-team.ru>
Date: Tue, 17 Oct 2023 18:32:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] qapi: introduce device-sync-config
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 dave@treblig.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-3-vsementsov@yandex-team.ru>
 <87zg0h2t5q.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87zg0h2t5q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 17.10.23 17:57, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add command to sync config from vhost-user backend to the device. It
>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>> triggered interrupt to the guest or just not available (not supported
>> by vhost-user server).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index fa80694735..2468f8bddf 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -315,3 +315,17 @@
>>   # Since: 8.2
>>   ##
>>   { 'event': 'X_DEVICE_ON', 'data': 'DeviceAndPath' }
>> +
>> +##
>> +# @x-device-sync-config:
>> +#
>> +# Sync config from backend to the guest.
> 
> "Sync" is not a word; "synchronize" is :)

Seems, I learn English from code :)

> 
>> +#
>> +# @id: the device's ID or QOM path
>> +#
>> +# Returns: Nothing on success
>> +#          If @id is not a valid device, DeviceNotFound
> 
> Why not GenericError?

I just designed the command looking at device_del. device_del reports DeviceNotFound in this case. GenericError is OK for me, if you think it's better even in this case. I remember now that everything except GenericError is not recommended.

> 
>> +#
>> +# Since: 8.2
>> +##
>> +{ 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
> 
> The commit message above and the error message below talk about command
> device-sync-config, but you actually name it x-device-sync-config.
> 
> I figure you use x- to signify "unstable".  Please use feature flag
> 'unstable' for that.  See docs/devel/qapi-code-gen.rst section
> "Features", in particular "Special features", and also the note on x- in
> section "Naming rules and reserved names".
> 
> We tend to eschew abbreviations in QAPI schema names.
> device-synchronize-config is quite a mouthful, though.  What do you
> think?

OK for me.

Hmm, could I ask here, is "config" a word?)) device-synchronize-configuration would become a precedent, I'm afraid)

> 
>> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>> index 19c31446d8..b6da24389f 100644
>> --- a/softmmu/qdev-monitor.c
>> +++ b/softmmu/qdev-monitor.c
>> @@ -987,6 +987,29 @@ HotplugInfo *qmp_x_query_hotplug(const char *id, Error **errp)
>>       return hotplug_handler_get_state(hotplug_ctrl, dev, errp);
>>   }
>>   
>> +int qdev_sync_config(DeviceState *dev, Error **errp)
>> +{
>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>> +
>> +    if (!dc->sync_config) {
>> +        error_setg(errp, "device-sync-config is not supported for '%s'",
>> +                   object_get_typename(OBJECT(dev)));
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    return dc->sync_config(dev, errp);
>> +}
>> +
>> +void qmp_x_device_sync_config(const char *id, Error **errp)
>> +{
>> +    DeviceState *dev = find_device_state(id, errp);
> 
> Not your patch's fault, but here goes anyway: when @id refers to a
> non-device, find_device_state() fails with "is not a hotpluggable
> device".  "hotpluggable" is misleading.

Hmm. Thanks, OK, I'll rework it somehow in v2.

> 
>> +    if (!dev) {
>> +        return;
>> +    }
>> +
>> +    qdev_sync_config(dev, errp);
>> +}
>> +
>>   void hmp_device_add(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *err = NULL;
> 

-- 
Best regards,
Vladimir


