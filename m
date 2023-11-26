Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EF7F92DB
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 14:34:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7FFm-0004yt-Ao; Sun, 26 Nov 2023 08:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r7FFj-0004yl-VJ
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:32:51 -0500
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r7FFi-0008Ce-1Z
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:32:51 -0500
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout01.t-online.de (Postfix) with SMTP id B9C852A767;
 Sun, 26 Nov 2023 14:32:44 +0100 (CET)
Received: from [192.168.211.200] ([93.236.147.152]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r7FFc-167jDV0; Sun, 26 Nov 2023 14:32:44 +0100
Message-ID: <20d1b5db-c931-49af-af91-9de1af074fa7@t-online.de>
Date: Sun, 26 Nov 2023 14:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: pending hw/audio patches for 8.2
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1701005564-B880499C-7E05A23A/0/0 CLEAN NORMAL
X-TOI-MSGID: 350e9541-749a-412c-b612-457103e9ea59
Received-SPF: pass client-ip=194.25.134.80; envelope-from=vr_qemu@t-online.de;
 helo=mailout01.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

there are five pending reviewed hw/audio patches for 8.2. They are all
bug fixes. It would be good if someone could send a pull request for
rc2. I don't think Gerd will send it.

The five patches are:

("hw/audio/hda-codec: fix multiplication overflow")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg00828.html

("hw/audio/hda-codec: reenable the audio mixer")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg00827.html

("hw/audio/virtio-snd-pci: fix the PCI class code")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02084.html

("virtio-snd: check AUD_register_card return value")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02545.html

("virtio-sound: add realize() error cleanup path")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03878.html

IIRC the last patch needs a rebase.

I omitted another reviewed patch, which is a variant of
("hw/audio/hda-codec: reenable the audio mixer").
("hw/audio: Fix logic error in hda audio")
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03951.html

I have a repository at https://gitlab.com/volker.ruemelin/qemu.git. The
five rebased patches are in the hw-audio-fixes-for-8.2 branch.

With best regards,
Volker


