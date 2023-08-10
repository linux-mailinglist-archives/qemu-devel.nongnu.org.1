Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16628776E66
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 05:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTw8Q-0004MC-T0; Wed, 09 Aug 2023 23:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTw8O-0004Lc-UY
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 23:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTw8N-0004jC-Fh
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 23:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691637285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBUE9a0yfHqhxRi6TgK7xL/bQerEadSEGWDo2x8xEYE=;
 b=bg6qjTxgqR6OR3WWVDOSGo2DBvhQoN4UZ8zHveuJeIZrXcwAfS8poT1zD9xsEusL2XtkH7
 phhffqv5TKdw7qTTYWNNL8EaKslYNtK0GdOw4IGUCPoJiYNPLh2QdKTArMOeemM21pFrhz
 mMuTMw9PMZdH5Uphqh1nHpqi2KkUErA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-D2zWawf_OUek7E5EDBpoRA-1; Wed, 09 Aug 2023 23:14:44 -0400
X-MC-Unique: D2zWawf_OUek7E5EDBpoRA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9bf49342dso4817271fa.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 20:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691637282; x=1692242082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBUE9a0yfHqhxRi6TgK7xL/bQerEadSEGWDo2x8xEYE=;
 b=YgRHVR2J7f9AEh9A6hh78JONILIE8LEB+jCTAIH0xBxqferjnRgTdP33uZ1wc/oeLU
 RFwWz386GTNZPxPCDHJyC8zd0QG5cAuejEJ6smKRDfkt3ZDOyIoT0JXRfIAz5/YZYQC9
 McQp2dTdUoQvghHfAOChpRouH9co6L7SivhB83hxZVCM9uzTUMhXzoZVeSvW5bmC9g7X
 r98nb9qhZMfQgfmV3UFOJ5oERTRDHp7/LGid+eiY14SuUmNNX7qajLGHVPbmca9d6u/5
 NPdmxJdlWa5SwAPPQGFesUUOIh623YTjWhdZHDnQqX9V2xePes2WQi7QCAG2ojefY72P
 pPAw==
X-Gm-Message-State: AOJu0Yy0t1DEvvIRNK0JmGHb4aStygFkopnr63huXxP+KAcGJTKT9r9r
 7K3SKHsRwCMzKU0aKD6Pph0t4kBAUC8lEHFXJraXBsUKkRfySZMoxeUhum3F8xqwBv38oE5zfIh
 HoNC59lf4H1iRzoZ/lTduAmDmcvq1cYI=
X-Received: by 2002:a2e:804e:0:b0:2b6:dc55:c3c7 with SMTP id
 p14-20020a2e804e000000b002b6dc55c3c7mr789017ljg.20.1691637282506; 
 Wed, 09 Aug 2023 20:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDXHq6qAaPsNBK0y/c55MVQXqbYt6nMpJeRm+d2vgGzHkXyBW59Kl8OumNYY9AISmiTJhet8zUtlPQMrnlrrE=
X-Received: by 2002:a2e:804e:0:b0:2b6:dc55:c3c7 with SMTP id
 p14-20020a2e804e000000b002b6dc55c3c7mr789008ljg.20.1691637282233; Wed, 09 Aug
 2023 20:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <CAOEp5Ocvd=WByDkh4jDO1mcbQbcAxA=As61_JaUxaP-t3+FMzQ@mail.gmail.com>
In-Reply-To: <CAOEp5Ocvd=WByDkh4jDO1mcbQbcAxA=As61_JaUxaP-t3+FMzQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:14:31 +0800
Message-ID: <CACGkMEs8KFmtJJNH6X1TqomVGZHp7fFVr6wr4qz6zN3t=FHgxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] virtio-net: add USO feature (UDP segmentation
 offload)
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 sriram.yagnaraman@est.tech, mst@redhat.com, sw@weilnetz.de, 
 qemu-devel@nongnu.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 10, 2023 at 4:21=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> ping

I've queued this.

Thanks

>
> On Tue, Aug 1, 2023 at 1:32=E2=80=AFAM Yuri Benditovich <yuri.benditovich=
@daynix.com> wrote:
>>
>> Starting from 6.2 the kernel supports UDP segmentation offload, it
>> uses GSO_UDP_L4 to mark packets with UDP sermentation request
>>
>> v1->v2:
>>  Enable USO features by default starting from 8.1
>>  Move command-line parameters to the last patch
>>
>> Andrew Melnychenko (2):
>>   tap: Add USO support to tap device.
>>   virtio-net: Add USO flags to vhost support.
>>
>> Yuri Benditovich (2):
>>   tap: Add check for USO features
>>   virtio-net: Add support for USO features
>>
>>  hw/core/machine.c    |  4 ++++
>>  hw/net/e1000e_core.c |  2 +-
>>  hw/net/igb_core.c    |  2 +-
>>  hw/net/vhost_net.c   |  3 +++
>>  hw/net/virtio-net.c  | 35 ++++++++++++++++++++++++++++++++---
>>  hw/net/vmxnet3.c     |  2 ++
>>  include/net/net.h    |  7 +++++--
>>  net/net.c            | 13 +++++++++++--
>>  net/tap-bsd.c        |  7 ++++++-
>>  net/tap-linux.c      | 27 ++++++++++++++++++++++++---
>>  net/tap-linux.h      |  2 ++
>>  net/tap-solaris.c    |  7 ++++++-
>>  net/tap-stub.c       |  7 ++++++-
>>  net/tap-win32.c      |  2 +-
>>  net/tap.c            | 18 +++++++++++++++---
>>  net/tap_int.h        |  4 +++-
>>  net/vhost-vdpa.c     |  3 +++
>>  17 files changed, 125 insertions(+), 20 deletions(-)
>>
>> --
>> 2.34.3
>>


