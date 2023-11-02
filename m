Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D837DF3C7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:29:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXkk-0002tv-Vl; Thu, 02 Nov 2023 09:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyXkj-0002tn-EO
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:28:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyXkg-0004SO-Ct
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:28:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:88b:0:640:d9e4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 35C0661AF8;
 Thu,  2 Nov 2023 16:28:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8005::1:a] (unknown
 [2a02:6b8:b081:8005::1:a])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hSXpw40OjOs0-9n9BU32c; Thu, 02 Nov 2023 16:28:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1698931724;
 bh=IqiMaXoKhlJAkSROKmJ7x+Y/MeFJV/u5OSi1GCVcg+M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yjSLyut0UyNDVUBe/I8gEaQVfoLhZotO3ZDAz2xu8G63R5KdU7Q5+XBCJuQdKCoQd
 +4aCNfGyJjvZK0Tr8/NjK7jiQNrksDnxQyqXyibn2Ni8fJtelqtOHYsXRcf36TKbFQ
 HQZhIp+DDhEY8tyJ/gqv222SJkHtrFja6VAAVG3M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <70c14ba7-10a6-45de-95cd-6033f35bba32@yandex-team.ru>
Date: Thu, 2 Nov 2023 16:28:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] pci hotplug tracking
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, den-plotnikov@yandex-team.ru,
 yc-core@yandex-team.ru, Peter Krempa <pkrempa@redhat.com>,
 nshirokovskiy@openvz.org, devel@lists.libvirt.org
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
 <20231102072800-mutt-send-email-mst@kernel.org>
 <d69f0aeb-303a-4721-b25b-52a08b8cd63f@yandex-team.ru>
 <20231102080801-mutt-send-email-mst@kernel.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231102080801-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02.11.23 15:12, Michael S. Tsirkin wrote:
> On Thu, Nov 02, 2023 at 03:00:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 02.11.23 14:31, Michael S. Tsirkin wrote:
>>> On Thu, Oct 05, 2023 at 12:29:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> Main thing this series does is DEVICE_ON event - a counter-part to
>>>> DEVICE_DELETED. A guest-driven event that device is powered-on.
>>>> Details are in patch 2. The new event is paried with corresponding
>>>> command query-hotplug.
>>>
>>> Several things questionable here:
>>> 1. depending on guest activity you can get as many
>>>      DEVICE_ON events as you like
>>
>> No, I've made it so it may be sent only once per device
> 
> Maybe document that?

Right, my fault

> 
>>> 2. it's just for shpc and native pcie - things are
>>>      confusing enough for management, we should make sure
>>>      it can work for all devices
>>
>> Agree, I'm thinking about it
>>
>>> 3. what about non hotpluggable devices? do we want the event for them?
>>>
>>
>> I think, yes, especially if we make async=true|false flag for device_add, so that successful device_add must be always followed by DEVICE_ON - like device_del is followed by DEVICE_DELETED.
>>
>> Maybe, to generalize, it should be called not DEVICE_ON (which mostly relate to hotplug controller statuses) but DEVICE_ADDED - a full counterpart for DEVICE_DELETED.
>>
>>>
>>> I feel this needs actual motivation so we can judge what's the
>>> right way to do it.
>>
>> My first motivation for this series was the fact that successful device_add doesn't guarantee that hard disk successfully hotplugged to the guest. It relates to some problems with shpc/pcie hotplug we had in the past, and they are mostly fixed. But still, for management tool it's good to understand that all actions related to hotplug controller are done and we have "green light".
> 
> what does "successfully" mean though? E.g. a bunch of guests will not
> properly show you the device if the disk is not formatted properly.

Yes, I understand, that we may say only about "some degree of success".

But here is some physical sense still: DEVICE_ON indicates, that it's now safe to call device_del. And calling device_del before DEVICE_ON is a kind of unexpected behavior.


> 
>>
>> Recently new motivation come, as I described in my "ping" letter <6bd19a07-5224-464d-b54d-1d738f5ba8f7@yandex-team.ru>, that we have a performance degradation because of 7bed89958bfbf40df, which introduces drain_call_rcu() in device_add, to make it more synchronous. So, my suggestion is make it instead more asynchronous (probably with special flag) and rely on DEVICE_ON event.
> 
> This one?
> 
> commit 7bed89958bfbf40df9ca681cefbdca63abdde39d
> Author: Maxim Levitsky <mlevitsk@redhat.com>
> Date:   Tue Oct 6 14:38:58 2020 +0200
> 
>      device_core: use drain_call_rcu in in qmp_device_add
>      
>      Soon, a device removal might only happen on RCU callback execution.
>      This is okay for device-del which provides a DEVICE_DELETED event,
>      but not for the failure case of device-add.  To avoid changing
>      monitor semantics, just drain all pending RCU callbacks on error.
>      
>      Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>      Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
>      Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>      Message-Id: <20200913160259.32145-4-mlevitsk@redhat.com>
>      [Don't use it in qmp_device_del. - Paolo]
>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index e9b7228480..bcfb90a08f 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -803,6 +803,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>           return;
>       }
>       dev = qdev_device_add(opts, errp);
> +
> +    /*
> +     * Drain all pending RCU callbacks. This is done because
> +     * some bus related operations can delay a device removal
> +     * (in this case this can happen if device is added and then
> +     * removed due to a configuration error)
> +     * to a RCU callback, but user might expect that this interface
> +     * will finish its job completely once qmp command returns result
> +     * to the user
> +     */
> +    drain_call_rcu();
> +
>       if (!dev) {
>           qemu_opts_del(opts);
>           return;
> 
> 
> 
> So maybe just move drain_call_rcu under if (!dev) then and be done with
> it?
> 

Hmm, I read the commit message thinking that it saying about device removal by mistake and actually want to say both about device_add and device_del.. But I was wrong?

Hmm, it directly say "just drain all pending RCU callbacks on error", but does that on success path as well.

Yes, moving drain_call_rcu makes sense for me, and will close the second "motivation". I can make a patch.

-- 
Best regards,
Vladimir


