Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23D7CD3DD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszjp-0008Ds-2d; Wed, 18 Oct 2023 02:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qszjn-0008Dg-JU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qszjl-00053f-U9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697609337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVMdIbbDc/31aRzyw6acoIAphGQRYfYT+ENMjNCZgrI=;
 b=OvVyvFu1lZFO0lmsoHHDCqEMYimEdVQwx/V7fn8sMTeD11JgkIdAfegl1d3KWeo7XboWYO
 OXU37mxpArJ5QslgoDw/tYXbQ4IOpvQU4N007oFDNDp52IhMrtzmasQz+t19G6O6K9NLyS
 7OGsh+jJSHprLEZerDNuDIIeM7nTsh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-4hpcN22sNGuMdTeEungHfw-1; Wed, 18 Oct 2023 02:08:51 -0400
X-MC-Unique: 4hpcN22sNGuMdTeEungHfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B13D857F8C;
 Wed, 18 Oct 2023 06:08:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6922A40C6CAF;
 Wed, 18 Oct 2023 06:08:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59FCC21E6A1F; Wed, 18 Oct 2023 08:08:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 dave@treblig.org,  eduardo@habkost.net,  berrange@redhat.com,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 raphael.norwitz@nutanix.com,  mst@redhat.com,  yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru,  daniil.tatianin@yandex.ru
Subject: Re: [PATCH 2/4] qapi: introduce device-sync-config
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-3-vsementsov@yandex-team.ru>
 <87zg0h2t5q.fsf@pond.sub.org>
 <9d62a50e-627e-4441-b760-56c096f99c53@yandex-team.ru>
Date: Wed, 18 Oct 2023 08:08:49 +0200
In-Reply-To: <9d62a50e-627e-4441-b760-56c096f99c53@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Oct 2023 18:32:00 +0300")
Message-ID: <87ttqozclq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

> On 17.10.23 17:57, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Add command to sync config from vhost-user backend to the device. It
>>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>>> triggered interrupt to the guest or just not available (not supported
>>> by vhost-user server).
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> [...]
>> 
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index fa80694735..2468f8bddf 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -315,3 +315,17 @@
>>>   # Since: 8.2
>>>   ##
>>>   { 'event': 'X_DEVICE_ON', 'data': 'DeviceAndPath' }
>>> +
>>> +##
>>> +# @x-device-sync-config:
>>> +#
>>> +# Sync config from backend to the guest.
>>
>> "Sync" is not a word; "synchronize" is :)
>
> Seems, I learn English from code :)

It's working, so no worries ;)

>>> +#
>>> +# @id: the device's ID or QOM path
>>> +#
>>> +# Returns: Nothing on success
>>> +#          If @id is not a valid device, DeviceNotFound
>>
>> Why not GenericError?
>
> I just designed the command looking at device_del. device_del reports DeviceNotFound in this case. GenericError is OK for me, if you think it's better even in this case. I remember now that everything except GenericError is not recommended.

I figure you picked up DeviceNotFound by reusing find_device_state().

Same happened when commit 9680caee0fa added blk_by_qdev_id().  At least
some of its users don't document the error code.  I'm not sure the
unwanted use of DeviceNotFound is worth fixing after all this time.  But
I certainly don't want it documented.

For your patch, not reusing find_device_state() would let you avoid
DeviceNotFound at the price of a few more lines of code.

>>> +#
>>> +# Since: 8.2
>>> +##
>>> +{ 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
>>
>> The commit message above and the error message below talk about command
>> device-sync-config, but you actually name it x-device-sync-config.
>>
>> I figure you use x- to signify "unstable".  Please use feature flag
>> 'unstable' for that.  See docs/devel/qapi-code-gen.rst section
>> "Features", in particular "Special features", and also the note on x- in
>> section "Naming rules and reserved names".
>>
>> We tend to eschew abbreviations in QAPI schema names.
>> device-synchronize-config is quite a mouthful, though.  What do you
>> think?
>
> OK for me.
>
> Hmm, could I ask here, is "config" a word?)) device-synchronize-configuration would become a precedent, I'm afraid)

In the words of Captain Barbossa, it's "more what you'd call
'guidelines' than actual rules."

I didn't come up with the "avoid abbreviations" stylistic guideline.  I
inherited it.

I do like consistent style.  I don't like excessively long names.
Sometimes these likes conflict, and we need to pick.

Checking... alright, there precedence both for 'config' and for 'sync'
in the QAPI schema.  You pick what you like best.

>>> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>>> index 19c31446d8..b6da24389f 100644
>>> --- a/softmmu/qdev-monitor.c
>>> +++ b/softmmu/qdev-monitor.c
>>> @@ -987,6 +987,29 @@ HotplugInfo *qmp_x_query_hotplug(const char *id, Error **errp)
>>>       return hotplug_handler_get_state(hotplug_ctrl, dev, errp);
>>>   }
>>>   +int qdev_sync_config(DeviceState *dev, Error **errp)
>>> +{
>>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>> +
>>> +    if (!dc->sync_config) {
>>> +        error_setg(errp, "device-sync-config is not supported for '%s'",
>>> +                   object_get_typename(OBJECT(dev)));
>>> +        return -ENOTSUP;
>>> +    }
>>> +
>>> +    return dc->sync_config(dev, errp);
>>> +}
>>> +
>>> +void qmp_x_device_sync_config(const char *id, Error **errp)
>>> +{
>>> +    DeviceState *dev = find_device_state(id, errp);
>>
>> Not your patch's fault, but here goes anyway: when @id refers to a
>> non-device, find_device_state() fails with "is not a hotpluggable
>> device".  "hotpluggable" is misleading.
>
> Hmm. Thanks, OK, I'll rework it somehow in v2.

I think "hotpluggable" is misleading for all the existing uses of
find_device_state().  Suggest a preliminary patch deleting the word.

>>> +    if (!dev) {
>>> +        return;
>>> +    }
>>> +
>>> +    qdev_sync_config(dev, errp);
>>> +}
>>> +
>>>   void hmp_device_add(Monitor *mon, const QDict *qdict)
>>>   {
>>>       Error *err = NULL;
>> 


