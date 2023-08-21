Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E678307D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 20:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYA1L-00066F-QO; Mon, 21 Aug 2023 14:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qYA1I-00065p-H5
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:52:56 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qYA1F-0004eU-JS
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 14:52:56 -0400
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
 by mailout12.t-online.de (Postfix) with SMTP id 2734C7E76;
 Mon, 21 Aug 2023 20:52:49 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd73.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qYA14-1MuXKb0; Mon, 21 Aug 2023 20:52:42 +0200
Content-Type: multipart/alternative;
 boundary="------------rmUos7dTBuGfb0BAXcc2wfIe"
Message-ID: <52573d37-cbcb-2d6c-b979-9a2a66b53c1d@t-online.de>
Date: Mon, 21 Aug 2023 20:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 01/12] Add virtio-sound device stub
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
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
 <f49650d9-f80f-bbbe-1c0a-4a42a6c6ec76@t-online.de>
 <zq93g.y1gwybb8v8l9@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <zq93g.y1gwybb8v8l9@linaro.org>
X-TOI-EXPURGATEID: 150726::1692643962-99E88904-C36120FA/0/0 CLEAN NORMAL
X-TOI-MSGID: 910584d0-ff03-4976-b8c1-866d9c49d5dd
Received-SPF: none client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-3.374, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------rmUos7dTBuGfb0BAXcc2wfIe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.08.23 um 08:06 schrieb Manos Pitsidianakis:
> Hello Volker!
>
> On Sun, 20 Aug 2023 12:33, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> I think the virtio-snd.c code, the trace events and the Kconfig 
>> VIRTIO_SND should be moved to hw/audio. The code for nearly all audio 
>> devices is in this directory. This would be similar to other virtio 
>> devices. E.g. the virtio-scsi code is in hw/scsi and the virtio-net 
>> code is in hw/net.
>
> This was where it was initially but in previous patchset versions it 
> was recommended to move them to hw/virtio. I don't mind either 
> approach though.

Hi Manos,

Ok, then don't change the directory. I guess I will have to discuss this 
with Alex first.

With best regards,
Volker
--------------rmUos7dTBuGfb0BAXcc2wfIe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 21.08.23 um 08:06 schrieb Manos
      Pitsidianakis:<br>
    </div>
    <blockquote type="cite" cite="mid:zq93g.y1gwybb8v8l9@linaro.org">Hello
      Volker!
      <br>
      <br>
      On Sun, 20 Aug 2023 12:33, Volker Rümelin
      <a class="moz-txt-link-rfc2396E" href="mailto:vr_qemu@t-online.de">&lt;vr_qemu@t-online.de&gt;</a> wrote:
      <br>
      <blockquote type="cite">I think the virtio-snd.c code, the trace
        events and the Kconfig VIRTIO_SND should be moved to hw/audio.
        The code for nearly all audio devices is in this directory. This
        would be similar to other virtio devices. E.g. the virtio-scsi
        code is in hw/scsi and the virtio-net code is in hw/net.
        <br>
      </blockquote>
      <br>
      This was where it was initially but in previous patchset versions
      it was recommended to move them to hw/virtio. I don't mind either
      approach though.</blockquote>
    <br>
    Hi Manos,<br>
    <br>
    <span _d-id="12281" class="--l --r sentence_highlight">Ok, then
      don't change the directory. </span><span _d-id="12284" class="
      --l --r bg-[#E1F0F5] text-[#25282D]
      alignedSentenceHighlight--Ugo-N sentence_highlight">I guess I will
      have to discuss this with Alex first.<br>
      <br>
      With best regards,<br>
      Volker</span><br>
  </body>
</html>

--------------rmUos7dTBuGfb0BAXcc2wfIe--

