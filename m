Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C963881AED4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:36:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCe6-0004Ek-Ut; Thu, 21 Dec 2023 01:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGCe5-0004ES-4h
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGCe3-0000fz-DH
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703140497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6bC0aeV+aAOc9MY6fRzWq66WxPe5y8huMHlMzC+ENAU=;
 b=eCpVXCIb98EA+7tL70MWUZsLDJzgEWS+fpgz010TdOGUwCWneFd9TJU4G2S+09hqXWeH6G
 rf50DieHSB/JnB5e7bkjdhVhaeHRodH0ETymqmgae7qR7Vw7DCg6e4Xugeq9J/7ofs7tlE
 QVdoK7/vYR6bTCp5yF+PkvJOotsz5ik=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-jsXtEf-lOKWeVRvuaelzWA-1; Thu,
 21 Dec 2023 01:34:55 -0500
X-MC-Unique: jsXtEf-lOKWeVRvuaelzWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B27D3869142;
 Thu, 21 Dec 2023 06:34:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17D31492BFA;
 Thu, 21 Dec 2023 06:34:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFCBE21E6920; Thu, 21 Dec 2023 07:34:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
In-Reply-To: <ZYMaS8v8sIWhteFm@intel.com> (Zhao Liu's message of "Thu, 21 Dec
 2023 00:46:03 +0800")
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org> <ZYMaS8v8sIWhteFm@intel.com>
Date: Thu, 21 Dec 2023 07:34:53 +0100
Message-ID: <871qbg9i7m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Markus,
>
> On Wed, Dec 20, 2023 at 08:53:21AM +0100, Markus Armbruster wrote:
>> Date: Wed, 20 Dec 2023 08:53:21 +0100
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH v2] qdev: Report an error for machine without
>>  HotplugHandler
>> 
>> Having hotpluggable = true when the device cannot be hot-plugged is
>> *wrong*.  You might be able to paper over the wrongness so the code
>> works anyway, but nothing good can come out of lying to developers
>> trying to understand how the code works.
>> 
>> Three ideas to avoid the lying:
>> 
>> 1. default hotpluggable to bus_type != NULL.
>> 
>> 2. assert(dc->bus_type || !dc->hotpluggable) in a suitable spot.
>> 
>> 3. Change the meaning of hotpluggable, and rename it to reflect its new
>> meaning.  Requires a careful reading of its uses.  I wouldn't go there.
>> 
>
> What about 4 (or maybe 3.1) - droping this hotpluggable flag and just use a
> helper (like qbus) to check if device is hotpluggable?
>
> This removes the confusion of that flag and also reduces the number of
> configuration items for DeviceState that require developer attention.
> A simple helper is as follows:
>
> static inline bool qdev_is_hotpluggable(DeviceState *dev)
> {
>     /*
>      * Many Machines don't implement qdev_hotplug_allowed().
>      *
>      * TODO: Once all of them complete missing qdev_hotplug_allowed(),
>      *       use qdev_hotplug_allowed() here.
>      */
>     bool hotpluggable = !!qdev_get_machine_hotplug_handler(dev);
>
>     if (!hotpluggable && dev->parent_bus) {
>         hotpluggable = qbus_is_hotpluggable(dev->parent_bus);
>     }
>
>     return hotpluggable;
> }

Worth exploring, I think.


