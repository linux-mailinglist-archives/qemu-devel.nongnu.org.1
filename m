Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD370BC13
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13wn-0002M0-Rd; Mon, 22 May 2023 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q13wg-0002L7-3p
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:43:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q13wc-0006L8-RD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:43:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 10EA75FF9D;
 Mon, 22 May 2023 14:43:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b50f::1:35] (unknown
 [2a02:6b8:b081:b50f::1:35])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7hfoYH4MiCg0-lrfEqmy9; Mon, 22 May 2023 14:43:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684755788; bh=Bbu2xonIcUQ+wLAPjrb7XSbvLpDbGUU7MQPyk1pQUjg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=v+DjA5IaUIQAUZ5Td2QmM7kzl4SKipGq3ccG0NCyUI4IRaPxOh1ZDc4ry5Ezmac62
 7gkp9ix6y07c2RFD65JN23cchMiqLv9dqaVqJN2h6ZasjEhyZzmBtgqNfXNfH2Fhap
 MdZ5b7ux9vaZVg3CuSIwi00pX9tL2/MPMPevEixw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0b692f6f-4d9a-60be-e1c0-9aa0f7869eed@yandex-team.ru>
Date: Mon, 22 May 2023 14:43:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 1/4] qapi/qdev.json: unite DEVICE_* event data into
 single structure
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, antonkuchin@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-2-vsementsov@yandex-team.ru>
 <20230518160434-mutt-send-email-mst@kernel.org> <87a5xwogw0.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87a5xwogw0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22.05.23 12:27, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
>> On Fri, Apr 21, 2023 at 01:32:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> DEVICE_DELETED and DEVICE_UNPLUG_GUEST_ERROR has equal data, let's
>>> refactor it to one structure. That also helps to add new events
>>> consistently.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> Can QAPI maintainers please review this patchset?
>> It's been a month.
> 
> It's been a busy month; sorry for the delay.
> 
>>> ---
>>>   qapi/qdev.json | 39 +++++++++++++++++++++++++++------------
>>>   1 file changed, 27 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index 2708fb4e99..135cd81586 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -114,16 +114,37 @@
>>>   { 'command': 'device_del', 'data': {'id': 'str'} }
>>>   
>>>   ##
>>> -# @DEVICE_DELETED:
>>> +# @DeviceAndPath:
>>>   #
>>> -# Emitted whenever the device removal completion is acknowledged by the guest.
>>> -# At this point, it's safe to reuse the specified device ID. Device removal can
>>> -# be initiated by the guest or by HMP/QMP commands.
>>> +# In events we designate devices by both their ID (if the device has one)
>>> +# and QOM path.
>>> +#
>>> +# Why we need ID? User specify ID in device_add command and in command line
>>> +# and expects same identifier in the event data.
>>> +#
>>> +# Why we need QOM path? Some devices don't have ID and we still want to emit
>>> +# events for them.
>>> +#
>>> +# So, we have a bit of redundancy, as QOM path for device that has ID is
>>> +# always /machine/peripheral/ID. But that's hard to change keeping both
>>> +# simple interface for most users and universality for the generic case.
> 
> Hmm.  I appreciate rationale, but I'm not sure it fits here.  Would
> readers be worse off if we dropped it?

Is there a syntax to add comment to the QAPI structure, which doesn't go into compiled public documentation?

I agree that we don't need this in compiled documentation, but this place in the code really good for the rationale, to avoid starting the discussion from the beginning again.

> 
>>>   #
>>>   # @device: the device's ID if it has one
>>>   #
>>>   # @path: the device's QOM path
>>>   #
>>> +# Since: 8.0
>>> +##
>>> +{ 'struct': 'DeviceAndPath',
>>> +  'data': { '*device': 'str', 'path': 'str' } }
>>> +
>>
>> Should be Since: 8.1 no?
> 
> Yes.
> 
> Please format like
> 
>     ##
>     # @DeviceAndPath:
>     #
>     # In events we designate devices by both their ID (if the device has
>     # one) and QOM path.
>     #
>     # Why we need ID?  User specify ID in device_add command and in
>     # command line and expects same identifier in the event data.
>     #
>     # Why we need QOM path?  Some devices don't have ID and we still want
>     # to emit events for them.
>     #
>     # So, we have a bit of redundancy, as QOM path for device that has ID
>     # is always /machine/peripheral/ID. But that's hard to change keeping
>     # both simple interface for most users and universality for the
>     # generic case.
>     #
>     # @device: the device's ID if it has one
>     #
>     # @path: the device's QOM path
>     #
>     # Since: 8.0
>     ##
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
> 
>>> +##
>>> +# @DEVICE_DELETED:
>>> +#
>>> +# Emitted whenever the device removal completion is acknowledged by the guest.
>>> +# At this point, it's safe to reuse the specified device ID. Device removal can
>>> +# be initiated by the guest or by HMP/QMP commands.
>>> +#
> 
> Conflict resolution:
> 
>      # Emitted whenever the device removal completion is acknowledged by
>      # the guest.  At this point, it's safe to reuse the specified device
>      # ID. Device removal can be initiated by the guest or by HMP/QMP
>      # commands.
> 
>>>   # Since: 1.5
>>>   #
>>>   # Example:
>>> @@ -134,18 +155,13 @@
>>>   #      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>>>   #
>>>   ##
>>> -{ 'event': 'DEVICE_DELETED',
>>> -  'data': { '*device': 'str', 'path': 'str' } }
>>> +{ 'event': 'DEVICE_DELETED', 'data': 'DeviceAndPath' }
>>>   
>>>   ##
>>>   # @DEVICE_UNPLUG_GUEST_ERROR:
>>>   #
>>>   # Emitted when a device hot unplug fails due to a guest reported error.
>>>   #
>>> -# @device: the device's ID if it has one
>>> -#
>>> -# @path: the device's QOM path
>>> -#
>>>   # Since: 6.2
>>>   #
>>>   # Example:
>>> @@ -156,5 +172,4 @@
>>>   #      "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
>>>   #
>>>   ##
>>> -{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>>> -  'data': { '*device': 'str', 'path': 'str' } }
>>> +{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
>>> -- 
>>> 2.34.1
> 

-- 
Best regards,
Vladimir


