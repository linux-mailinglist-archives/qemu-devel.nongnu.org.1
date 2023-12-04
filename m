Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0C802C6B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 08:53:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3kU-00026d-QA; Mon, 04 Dec 2023 02:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rA3kS-00026G-KU
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:52:12 -0500
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rA3kQ-0007wc-Ko
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:52:12 -0500
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
 by mailout07.t-online.de (Postfix) with SMTP id 4AD16216D0;
 Mon,  4 Dec 2023 08:52:08 +0100 (CET)
Received: from [192.168.211.200] ([93.236.147.152]) by fwd89.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rA3kN-19yPfV0; Mon, 4 Dec 2023 08:52:07 +0100
Message-ID: <383e2947-c0ec-4157-8c48-e95f205908c9@t-online.de>
Date: Mon, 4 Dec 2023 08:52:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 8.2] hw/audio/virtio-sound: mark the device as
 unmigratable
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20231204072837.6058-1-vr_qemu@t-online.de>
Content-Language: en-US
In-Reply-To: <20231204072837.6058-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1701676327-13FFC820-8F8DBD5E/0/0 CLEAN NORMAL
X-TOI-MSGID: 97bd7cd1-6be6-4ed6-b179-3991594699ee
Received-SPF: pass client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
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

Am 04.12.23 um 08:28 schrieb Volker Rümelin:

> The virtio-sound device is currently not migratable. QEMU crashes
> on the source machine at some point during the migration with a
> segmentation fault.
>
> Even with this bug fixed, the virtio-sound device doesn't migrate
> the state of the audio streams. For example, running streams leave
> the device on the destination machine in a broken condition.
>
> Mark the device as unmigratable until these issues have been fixed.
>
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c | 1 +
>  1 file changed, 1 insertion(+)

I already have a working patch series with 6 patches to fix these
issues. I wrote them in the last two days, which means they are not yet
in a reviewable state and the series is too big for 8.2. I think I need
another weekend or two before I send them to the qemu-devel mailing list.

With best regards,
Volker

> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 2fe966e311..b10fad1228 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -68,6 +68,7 @@ static const VMStateDescription vmstate_virtio_snd_device = {
>  
>  static const VMStateDescription vmstate_virtio_snd = {
>      .name = TYPE_VIRTIO_SND,
> +    .unmigratable = 1,
>      .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>      .version_id = VIRTIO_SOUND_VM_VERSION,
>      .fields = (VMStateField[]) {


