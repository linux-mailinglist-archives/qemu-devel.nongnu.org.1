Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFFB263F8
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 13:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVvc-0003EE-Ny; Thu, 14 Aug 2025 07:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umVvY-0003CE-TV; Thu, 14 Aug 2025 07:15:25 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umVvS-0005FK-NA; Thu, 14 Aug 2025 07:15:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F25280748;
 Thu, 14 Aug 2025 14:15:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:422::1:1d] (unknown
 [2a02:6bf:8080:422::1:1d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CFKBGM0GwiE0-jpMcvwSS; Thu, 14 Aug 2025 14:15:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755170112;
 bh=fpbCBEG5Elsv7xiiDvFAh5J0IDN8ckiiTb2DvT1Slhc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Zrv/wyzB+5ttOTc7ceq9UUz15mPJCa8DNdkQzEwJV1yoTYwTpBpFMp5X/jXLgDLBa
 VpurKhavWjIKuaD2Q14QLbAIVNKEweJ3MCsa1m0p/QHVaazW1bxPv4BvKQkHBQ/g/4
 yJ21bK1kyxRel86vxZ01jC0C5jpFbOWhqXKXUB1A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <75dcff77-7bc8-4103-b6a5-f0b564c8c317@yandex-team.ru>
Date: Thu, 14 Aug 2025 14:15:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] virtio: move common part of _set_guest_notifier to
 generic code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-8-vsementsov@yandex-team.ru>
 <8b2cd3c9-4795-47fc-a4ab-3c854c42b99d@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <8b2cd3c9-4795-47fc-a4ab-3c854c42b99d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.08.25 07:53, Philippe Mathieu-Daudé wrote:
> Hi Vladimir,
> 
> On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
>> virtio-pci and virtio-mmiio handle config notifier equally but
> 
> Typo virtio-mmio.
> 
>> with different code (mmio adds a separate function, when pci
>> use common function). Let's chose the more compact way (pci)
>> and reuse it for mmio.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>>   hw/virtio/virtio-pci.c         | 34 +++---------------------
>>   hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>>   include/hw/virtio/virtio-pci.h |  3 ---
>>   include/hw/virtio/virtio.h     |  7 +++--
>>   5 files changed, 58 insertions(+), 75 deletions(-)
> 
> 
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 9a81ad912e..7880c3bcd9 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
> 
> 
>> +static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,
>> +                                                     VirtQueue *vq,
>> +                                                     int n, bool assign,
>> +                                                     bool with_irqfd)
>> +{
>> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
>> +        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
>> +    } else {
>> +        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
>> +    }
>> +}
>> +
>> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
>> +                                    bool with_irqfd)
>> +{
>> +    VirtQueue *vq = NULL;
>> +    EventNotifier *notifier = NULL;
>> +
>> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
>> +        notifier = virtio_config_get_guest_notifier(vdev);
>> +    } else {
>> +        vq = virtio_get_queue(vdev, n);
>> +        notifier = virtio_queue_get_guest_notifier(vq);
>> +    }
>> +
>> +    if (assign) {
>> +        int r = event_notifier_init(notifier, 0);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
>> +    } else {
>> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
>> +                                                 with_irqfd);
>> +        event_notifier_cleanup(notifier);
>> +    }
>> +
>> +    return 0;
>> +}
> 
> 
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index c594764f23..8b9db08ddf 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
> 
> 
>> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
>> -                                                 bool assign, bool with_irqfd);
>> +
>> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
>> +                                    bool with_irqfd);
> 
> Please add a @docstring to document (@n in particular).
> 
> Thanks,
> 
> Phil.

Will do. Thanks for reviewing!



-- 
Best regards,
Vladimir

