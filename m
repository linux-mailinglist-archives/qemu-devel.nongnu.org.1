Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB87824997
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:34:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUOn-0002Ll-VC; Thu, 04 Jan 2024 15:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rLUOm-0002Ld-4c
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:33:04 -0500
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rLUOk-00046P-9x
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:33:03 -0500
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
 by mailout05.t-online.de (Postfix) with SMTP id 4098CD6C8;
 Thu,  4 Jan 2024 21:32:58 +0100 (CET)
Received: from [192.168.211.200] ([93.236.158.98]) by fwd79.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUOe-2KR4iX0; Thu, 4 Jan 2024 21:32:56 +0100
Message-ID: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
Date: Thu, 4 Jan 2024 21:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 00/10] virtio-sound migration part 1
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400376-54FA2986-BE11952D/0/0 CLEAN NORMAL
X-TOI-MSGID: 6c9cd68e-15cb-41e8-bf5a-cf19476ce02d
Received-SPF: pass client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
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

Here is the first part of my virtio-sound patches. Most of them are a
preparation to make migration work. Patch 09/10 enables migration of the
virtio-sound device.

The second part isn't finished yet and will have to do with virtio-sound
jack and channel maps configuration and migration.

Volker Rümelin (10):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate all streams in advance
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: return correct command response size
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler
  hw/audio/virtio-sound: add missing vmstate fields
  hw/audio/virtio-sound: add placeholder for buffer write position

 hw/audio/trace-events         |   3 +-
 hw/audio/virtio-snd.c         | 771 +++++++++++++++++++---------------
 include/hw/audio/virtio-snd.h |  36 +-
 3 files changed, 441 insertions(+), 369 deletions(-)

-- 
2.35.3

