Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796DE7A33FF
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhlhA-0005rs-VQ; Sun, 17 Sep 2023 02:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qhlh8-0005rb-NF; Sun, 17 Sep 2023 02:55:50 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qhlh6-0004Pv-SL; Sun, 17 Sep 2023 02:55:50 -0400
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout07.t-online.de (Postfix) with SMTP id 6D785147F5;
 Sun, 17 Sep 2023 08:55:44 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.89]) by fwd78.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhlh2-02oc3V0; Sun, 17 Sep 2023 08:55:44 +0200
Message-ID: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
Date: Sun, 17 Sep 2023 08:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/8] hw/audio/es1370: bug fix
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933744-366FC16C-99710F23/0/0 CLEAN NORMAL
X-TOI-MSGID: 78d7ee89-61b5-4bd0-9aff-6df9258933f8
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Cc: qemu-stable. Patch 1/8 is a bug fix.
Cc: more people. The maintainer of hw/audio is busy with other projects.

Earlier this year I was asked if I could help to debug an audio playback
speed issue with the es1370 device. While debugging the playback speed
error, I noticed that the debug code of the ES1370 device has not been
compiled for a long time and has bit-rotted. This patch series fixes the
rotten code and also fixes a bug I found while debugging the code. The
bug fix is in patch 1/8 and prevents corrupted data streams. The
playback speed issue was caused by lost interrupts. Patch 8/8 helps to
debug this kind of issues.

Volker Rümelin (8):
  hw/audio/es1370: reset current sample counter
  hw/audio/es1370: replace bit-rotted code with tracepoints
  hw/audio/es1370: remove unused dolog macro
  hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit rot
  hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid bit rot
  hw/audio/es1370: block structure coding style fixes
  hw/audio/es1370: change variable type and name
  hw/audio/es1370: trace lost interrupts

 hw/audio/es1370.c     | 289 +++++++++++++++++++-----------------------
 hw/audio/trace-events |  11 ++
 2 files changed, 143 insertions(+), 157 deletions(-)

-- 
2.35.3

