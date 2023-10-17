Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AAF7CC349
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjIR-0007kh-CD; Tue, 17 Oct 2023 08:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjIO-0007jG-5B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:35:36 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjIL-0006cn-67
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:35:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id F060061B78;
 Tue, 17 Oct 2023 15:35:28 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:24] (unknown
 [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RZjEtbGOiW20-uiJKkZMH; Tue, 17 Oct 2023 15:35:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697546128;
 bh=/S9xeneCqxhTbqhl3JLBC8lCvNkjSNaEYTcwzYni9L0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KZ1oJQpg1aQqTKX2n5PsQhH0aeyVM82DMYifEtHvX48XXzDu2YihZ8y/jpgop+HbS
 d5InUwlx0lNse+V2fMmDYcG4BBl2Bmz1RE+t+mat6JI55No1k2IfX9e+JN9TEc59pK
 2geTJUFR9fJcbfHFVhB3X8aichamY0IocEdu7Hpo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1e76cbe8-d20a-417a-9edc-752655142006@yandex-team.ru>
Date: Tue, 17 Oct 2023 15:35:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio: add VIRTQUEUE_ERROR QAPI event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, dave@treblig.org, mst@redhat.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20231003075129.27440-1-vsementsov@yandex-team.ru>
 <87jzrqfyeb.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87jzrqfyeb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 13.10.23 16:24, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> For now we only log the vhost device error, when virtqueue is actually
>> stopped. Let's add a QAPI event, which makes possible:
>>
>>   - collect statistics of such errors
>>   - make immediate actions: take core dumps or do some other debugging
>>   - inform the user through a management API or UI, so that (s)he can
>>    react somehow, e.g. reset the device driver in the guest or even
>>    build up some automation to do so
>>
>> Note that basically every inconsistency discovered during virtqueue
>> processing results in a silent virtqueue stop.  The guest then just
>> sees the requests getting stuck somewhere in the device for no visible
>> reason.  This event provides a means to inform the management layer of
>> this situation in a timely fashion.
>>
>> The event could be reused for some other virtqueue problems (not only
>> for vhost devices) in future. For this it gets a generic name and
>> structure.
>>
>> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
>> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 6bc5a733b8..55d6c9018e 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -161,3 +161,31 @@
>>   ##
>>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>>     'data': { '*device': 'str', 'path': 'str' } }
>> +
>> +##
>> +# @VirtqueueError:
>> +#
>> +# @vhost-vring-error: Vhost device reported failure through
>> +#     through vring error fd.
>> +#
>> +# Since: 8.2
>> +##
>> +{ 'enum': 'VirtqueueError',
>> +  'data': [ 'vhost-vring-error' ] }
>> +
>> +##
>> +# @VIRTQUEUE_ERROR:
>> +#
>> +# Emitted when a device virtqueue fails in runtime.
>> +#
>> +# @device: the device's ID if it has one
>> +# @path: the device's QOM path
>> +# @virtqueue: virtqueue index
>> +# @error: error identifier
>> +# @description: human readable description
> 
> Please add blank lines between the @argument sections, to blend in with
> recent commit a937b6aa739 (qapi: Reformat doc comments to conform to
> current conventions).
> 
>> +#
>> +# Since: 8.2
>> +##
>> +{ 'event': 'VIRTQUEUE_ERROR',
>> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
>> +            'error': 'VirtqueueError', 'description': 'str'} }
> 
> With that:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir


