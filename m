Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71F760B47
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 09:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOCGc-00050t-Hr; Tue, 25 Jul 2023 03:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOCGW-00050h-R7
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOCGS-0004G7-GM
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690269322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vc0i3l3GIHUJKCmYvMQWYvV9YmLD0AMmdF3h+StBX9A=;
 b=bDZRpf0yAfzuYzy1G2rIF2ppR2S6p/XtaeHT9FXZFQHwYhTs0D5PlwQTiM+p3EfbqhQeSO
 0dFToF+TrU9K/iRQKbETa3vh2JymqYmOzzpYUgV/6YXDZS/MUCSDIrZWlffEheCVM3Cwij
 wqYM34Z3MATRyBG+k1ciD6u3bESCzTU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-6HhUfmPbPkypokoSvVEd7w-1; Tue, 25 Jul 2023 03:15:21 -0400
X-MC-Unique: 6HhUfmPbPkypokoSvVEd7w-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1bbb7ae553aso4586145ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 00:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690269320; x=1690874120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vc0i3l3GIHUJKCmYvMQWYvV9YmLD0AMmdF3h+StBX9A=;
 b=UQoLdNdXc0/unNafQxesP5C8lYL1CieTwkTBGESbjlTyLSUfHfojZ4WacEC0oA2L9H
 xDxOSfHJ/Ft7DOrbFVTlUgClJPOY+b6wo3NarEmJnn4nxFKpWPa413y1JpvLSPxwONuO
 w9J+kNyjj6Irj5x6ObDo1iW+xeeGq1m3VxUB5NvMn0LtzxbvwIowNfgouC57ssPI4Vm9
 G0OfAHb2WSOwA0sgpJeB5E62EzyB3YbcH7acJ4t+4t/0yqNI0QOM4Bv6Zlbp5HnqmaRb
 YSrFZHxSf8h5mJyFdaGyk9ZZX9Xsh9sUEoTrlUsBHBONnUnU6UWRs7QIDGDmoYsxUgwW
 3SVA==
X-Gm-Message-State: ABy/qLbXAkvjEHmPEfHZ4BUC9tcMd/ktzG9Qm51lE3Vjn0rRuk7Sp4iV
 2CVP0QIjwoxvpME4FUnSVSojiGeAkPdpMfQE+wAbKk3Wbb7l9d2wRhr/8jPKoYEKTO714all2mR
 SwluyxmJunHNlvTU=
X-Received: by 2002:a17:902:7fcd:b0:1b7:f64b:378a with SMTP id
 t13-20020a1709027fcd00b001b7f64b378amr9360028plb.16.1690269320395; 
 Tue, 25 Jul 2023 00:15:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdrwDodXDGp5pgQrqHi6Y0s7P9ZDtcYs8kkdf5H+//anl9SxJr1REiH0YGgSj4htRCfxxE5A==
X-Received: by 2002:a17:902:7fcd:b0:1b7:f64b:378a with SMTP id
 t13-20020a1709027fcd00b001b7f64b378amr9360018plb.16.1690269320068; 
 Tue, 25 Jul 2023 00:15:20 -0700 (PDT)
Received: from [10.72.12.72] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a170902b94b00b001ac7f583f72sm10243862pls.209.2023.07.25.00.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 00:15:19 -0700 (PDT)
Message-ID: <18f8d9c7-fa1d-7e45-82cc-7bd742ec18fd@redhat.com>
Date: Tue, 25 Jul 2023 15:15:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC
 state restore through CVQ
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, si-wei.liu@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shannon Nelson <snelson@pensando.io>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


在 2023/7/21 14:48, Eugenio Perez Martin 写道:
> On Thu, Jul 20, 2023 at 8:15 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>> At this moment the migration of net features that depends on CVQ is not
>> possible, as there is no reliable way to restore the device state like mac
>> address, number of enabled queues, etc to the destination.  This is mainly
>> caused because the device must only read CVQ, and process all the commands
>> before resuming the dataplane.
>>
>> This series uses the VirtIO feature _F_RING_RESET to achieve it, adding an
>> alternative method to late vq enabling proposed in [1][2].  It expose SVQ to
>> the device until it process all the CVQ messages, and then replaces the vring
>> for the guest's one.
>>
> A couple of things I forgot to add:
> * Assuming the implementation of _F_RING_RESET in vdpa is calling
> kernel vdpa ops .set_vq_ready(vq, false). I'm not sure if this is the
> best implementation, but it is currently unused in the kernel. At the
> same time, .set_vq_ready(vq, true) also enables the vq again.


I think we need another ops, as set_vq_ready() tends to be functional 
equivalent to queue_enable.

If we reuse set_vq_ready(vq, false), we would get conflict in the future 
when driver is allowed to stop/resume a specific virtqueue via setting 0 
to queue_enable. And that's also the reason why queue_enable is not 
resued to reset a virtqueue.


>
>> As an advantage, it uses a feature well deviced in the VirtIO standard.  As a
>> disadvantage, current HW already support the late enabling and it does not
>> support RING_RESET.
>>
>> This patch must be applied on top of the series ("Enable vdpa net migration
>> with features depending on CVQ") [1][2].
>>
>> The patch has been tested with vp_vdpa, but using high IOVA instead of a
>> sepparated ID for shadow CVQ and shadow temporal vrings.
>>
> And with _F_STATE implementation I sent long ago.
>
> Based on this, my suggestion is:
> * Leave the late enable for vDPA devices.
> * Make them fail if the vDPA parent device does not support it. This
> can be considered as a fix.
> * Leave _F_RING_RESET to be added on top, as the semantics are not
> implemented in vDPA at the moment.
>
> Would that work?


I think it can work, let's start from late enabling which seems 
lightweight than reset and see. We can leave the vp_vdpa to be done on 
top with another series.

Thanks


>
>> [1] Message-id: <20230706191227.835526-1-eperezma@redhat.com>
>> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg01325.html
>>
>> Eugenio Pérez (12):
>>    vhost: add vhost_reset_queue_op
>>    vhost: add vhost_restart_queue_op
>>    vhost_net: Use ops->vhost_restart_queue in vhost_net_virtqueue_restart
>>    vhost_net: Use ops->vhost_reset_queue in vhost_net_virtqueue_reset
>>    vdpa: add vhost_vdpa_set_vring_ready_internal
>>    vdpa: add vhost_vdpa_svq_stop
>>    vdpa: add vhost_vdpa_reset_queue
>>    vdpa: add vhost_vdpa_svq_start
>>    vdpa: add vhost_vdpa_restart_queue
>>    vdpa: enable all vqs if the device support RING_RESET feature
>>    vdpa: use SVQ to stall dataplane while NIC state is being restored
>>    vhost: Allow _F_RING_RESET with shadow virtqueue
>>
>>   include/hw/virtio/vhost-backend.h  |   6 ++
>>   hw/net/vhost_net.c                 |  16 ++--
>>   hw/virtio/vhost-shadow-virtqueue.c |   1 +
>>   hw/virtio/vhost-vdpa.c             | 139 +++++++++++++++++++++--------
>>   net/vhost-vdpa.c                   |  55 ++++++++++--
>>   hw/virtio/trace-events             |   2 +-
>>   6 files changed, 171 insertions(+), 48 deletions(-)
>>
>> --
>> 2.39.3
>>
>>


