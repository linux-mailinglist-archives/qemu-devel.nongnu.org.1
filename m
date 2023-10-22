Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E97D2301
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 13:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quWzz-0004Tf-Lp; Sun, 22 Oct 2023 07:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1quWzw-0004T9-G5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 07:52:00 -0400
Received: from mailout03.t-online.de ([194.25.134.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1quWzu-0008CJ-EY
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 07:52:00 -0400
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout03.t-online.de (Postfix) with SMTP id 88A301E75C;
 Sun, 22 Oct 2023 13:51:52 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.16.231]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1quWzl-0OVYGH0; Sun, 22 Oct 2023 13:51:49 +0200
Message-ID: <c9519870-e781-4873-a355-ca157773cc23@t-online.de>
Date: Sun, 22 Oct 2023 13:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/11] Add virtio-sound-pci device
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6Egbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
 <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
 <235cbc94-8de9-4960-bb4d-3d861784436a@t-online.de>
 <2xdn2.m5cl6s6mv22s@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <2xdn2.m5cl6s6mv22s@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1697975509-F27FBDFA-B1FBE348/0/0 CLEAN NORMAL
X-TOI-MSGID: 53a921f6-84b8-4c6e-86a0-4c7c2c75c965
Received-SPF: pass client-ip=194.25.134.81; envelope-from=vr_qemu@t-online.de;
 helo=mailout03.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 22.10.23 um 11:58 schrieb Manos Pitsidianakis:
> Hello Volker,
>
> On Sat, 21 Oct 2023 12:07, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> the virtio-sound device alias doesn't work.
>
> Yes, there's no virtio-sound alias hence why it does not work.

Sorry, I don't understand your last sentence. You add this alias with
the following line in patch 02/11, so there is a virtio-sound alias.
This alias doesn't work because there is a device with the same name.

+    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},

With best regards,
Volker

>
> I will wait a bit before spinning a new version of the series because
> the goal post keeps moving forward everytime there's a new version
> while there is still stuff to address. If this is the only change I'd
> like to hear from Gerd if this is ok to merge otherwise, and perhaps I
> can send a new version of this patch only?
>
> Manos


