Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CD781D32
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 11:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXer4-00023f-O5; Sun, 20 Aug 2023 05:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXer1-00023U-2o
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 05:36:15 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXeqy-0007TP-Hy
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 05:36:14 -0400
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout04.t-online.de (Postfix) with SMTP id C6DB33D78;
 Sun, 20 Aug 2023 11:33:40 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qXeoU-2C3uNd0; Sun, 20 Aug 2023 11:33:38 +0200
Message-ID: <f49650d9-f80f-bbbe-1c0a-4a42a6c6ec76@t-online.de>
Date: Sun, 20 Aug 2023 11:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 01/12] Add virtio-sound device stub
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <86f98e0b7da6cf1a8b308b1e14400f66d18fd010.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <86f98e0b7da6cf1a8b308b1e14400f66d18fd010.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1692524018-2B024649-BD601FEE/0/0 CLEAN NORMAL
X-TOI-MSGID: 2dba8bd6-8929-4f29-9360-837257e63317
Received-SPF: none client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.862, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Manos,

> Add a new VIRTIO device for the virtio sound device id. Functionality
> will be added in the following commits.

I think the virtio-snd.c code, the trace events and the Kconfig 
VIRTIO_SND should be moved to hw/audio. The code for nearly all audio 
devices is in this directory. This would be similar to other virtio 
devices. E.g. the virtio-scsi code is in hw/scsi and the virtio-net code 
is in hw/net.

With best regards,
Volker

> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                    |   6 +
>   hw/virtio/Kconfig              |   5 +
>   hw/virtio/meson.build          |   1 +
>   hw/virtio/trace-events         |   9 ++
>   hw/virtio/virtio-snd.c         | 231 +++++++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-snd.h |  80 ++++++++++++
>   6 files changed, 332 insertions(+)
>   create mode 100644 hw/virtio/virtio-snd.c
>   create mode 100644 include/hw/virtio/virtio-snd.h
>
>


