Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3538171D3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:04:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFECh-0000sr-1D; Mon, 18 Dec 2023 09:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFECd-0000s7-5a
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFECa-0003i8-Qs
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702908154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9DK5YSlv9uF1Lmdx4qMkQ/lfRNdyPwYcrpXMB/3ClY=;
 b=RoWuPQ8qIEPjMBCCeBgu3q94Du7yhYJOrR1JUh4C1LWxy1Mj3hHARgQ19jLqkHcfiTfVv3
 Nto6BpgCBAfLWPwOiomu4NwTxMnuk5SG/MsUc0LotF53J5ARSSm9K12wGfifAdUOUvksLP
 zByYJC9cxLf3Dt6DRMuwJjpOoT0crSk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-jKpEcjakPtSvy0g6hBVZpw-1; Mon,
 18 Dec 2023 09:02:33 -0500
X-MC-Unique: jKpEcjakPtSvy0g6hBVZpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EC8D3833369;
 Mon, 18 Dec 2023 14:02:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF83A492BC6;
 Mon, 18 Dec 2023 14:02:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF19C21E6920; Mon, 18 Dec 2023 15:02:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
In-Reply-To: <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com> (Akihiko
 Odaki's message of "Wed, 13 Dec 2023 18:50:47 +0900")
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
Date: Mon, 18 Dec 2023 15:02:11 +0100
Message-ID: <8734vzsj6k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/12/11 15:51, Markus Armbruster wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>> 
>>> The HotplugHandler of the machine will be used when the parent bus does
>>> not exist, but the machine may not have one. Report an error in such a
>>> case instead of aborting.
>>>
>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Do you have a reproducer for the crash?
>> 
>>> ---
>>> Changes in v2:
>>> - Fixed indention.
>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>> ---
>>>   system/qdev-monitor.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>> index a13db763e5..5fe5d49c20 100644
>>> --- a/system/qdev-monitor.c
>>> +++ b/system/qdev-monitor.c
>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>   void qdev_unplug(DeviceState *dev, Error **errp)
>>   {
>>       DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>       HotplugHandler *hotplug_ctrl;
>>       HotplugHandlerClass *hdc;
>>       Error *local_err = NULL;
>>       if (qdev_unplug_blocked(dev, errp)) {
>>           return;
>>       }
>>       if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>           error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>           return;
>>       }
>>       if (!dc->hotpluggable) {
>>           error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>                      object_get_typename(OBJECT(dev)));
>>           return;
>>       }
>>       if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>           error_setg(errp, "device_del not allowed while migrating");
>>           return;
>>       }
>> 
>>>      qdev_hot_removed = true;
>>>         hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>> -     * then something is very wrong with it */
>>> -    g_assert(hotplug_ctrl);
>>> +    if (!hotplug_ctrl) {
>>> +        /*
>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>> +         * then something is very wrong with it
>>> +         */
>>> +        assert(!dev->parent_bus);
>>> +
>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>> +        return;
>>> +    }
>>
>> Extended version of my question above: what are the devices where
>> qdev_get_hotplug_handler(dev) returns null here?
>
> Start a VM: qemu-system-aarch64 -M virt -nographic
> Run the following on its HMP: device_del /machine/unattached/device[0]
>
> It tries to unplug cortex-a15-arm-cpu and crashes.

This device has no parent bus (dev->parent_bus is null), but is marked
hot-pluggable (dc->hotpluggable is true).  Question for somebody
familiar with the hot-plug machinery: is this sane?


