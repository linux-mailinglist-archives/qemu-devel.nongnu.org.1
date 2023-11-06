Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637777E2FC2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:21:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07wk-0005MV-RY; Mon, 06 Nov 2023 17:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r07wi-0005MG-Sq; Mon, 06 Nov 2023 17:19:48 -0500
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r07wh-0000PC-3T; Mon, 06 Nov 2023 17:19:48 -0500
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
 by mailout10.t-online.de (Postfix) with SMTP id CAD9E3AFB6;
 Mon,  6 Nov 2023 23:19:42 +0100 (CET)
Received: from [192.168.211.200] ([93.236.156.187]) by fwd88.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r07wc-0ykyyv0; Mon, 6 Nov 2023 23:19:42 +0100
Message-ID: <37a09aa4-155f-4d0c-ba0c-c408b7d33abf@t-online.de>
Date: Mon, 6 Nov 2023 23:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/audio/hda-codec bug fixes
To: Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
 <8d37dc7c-c270-4ce6-8913-e19a71761574@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <8d37dc7c-c270-4ce6-8913-e19a71761574@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699309182-EEFFADD2-1CFD534D/0/0 CLEAN NORMAL
X-TOI-MSGID: 79a1c964-c375-4376-a396-c55e1383b940
Received-SPF: pass client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 06.11.23 um 20:54 schrieb Michael Tokarev:
> 05.11.2023 20:23, Volker Rümelin :
>> Patch 1/2 fixes a bug that was reported and correctly diagnosed on the
>> QEMU devel mailing list.
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02539.html
>> There was another patch to fix this bug, but I had an objection.
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02925.html
>>
>> Patch 2/2 corrects the sense of hda codec property mixer during
>> initialization. It was inverted not too long ago.
>
> It looks like -stable material, is it not?
>

Patch 1/2 ("hw/audio/hda-codec: fix multiplication overflow") is stable
material. Sorry, I forgot to cc qemu-stable.

With best regards,
Volker


