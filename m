Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2AD7E8F35
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 09:52:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r26BQ-0004cg-9a; Sun, 12 Nov 2023 03:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r26BN-0004cX-Tr
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 03:51:05 -0500
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r26BK-0000mq-5z
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 03:51:05 -0500
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
 by mailout02.t-online.de (Postfix) with SMTP id 23F6E28ACC;
 Sun, 12 Nov 2023 09:50:58 +0100 (CET)
Received: from [192.168.211.200] ([93.236.156.187]) by fwd81.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r26BE-1kNT6H0; Sun, 12 Nov 2023 09:50:56 +0100
Message-ID: <df72a284-3222-4f37-9bab-a0695f231f89@t-online.de>
Date: Sun, 12 Nov 2023 09:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix Windows 2000 and XP HDAudio Support
To: Christopher Lentocha <christopherericlentocha@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <737e8de1-9c14-453e-35eb-bff1e6b34a4a@gmail.com>
 <1b3f57dd-7a3f-4630-b1e1-298578bbc5b7@linaro.org>
 <lfrzsbncmlbxoelzt4asbctne5wq7mnjtv6yo3kc6nroocxsdc@45urch4n6pi4>
 <dcb9ee68-2839-f2f4-f9c1-46a149a315f8@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <dcb9ee68-2839-f2f4-f9c1-46a149a315f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699779056-FEB02990-45D9F30E/0/0 CLEAN NORMAL
X-TOI-MSGID: 41cfcd84-1f89-40b2-b4eb-434c21d990fe
Received-SPF: pass client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
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

Am 12.11.23 um 01:37 schrieb Christopher Lentocha:
> So wait, you want me to add it as another device name? Because 
> it is going to be the same exact way as the 1af4 device
> just with a number change. Ok, work it is then ...
> (Sorry about not getting back sooner also)
>
> Christopher

Hi Christopher,

why do you want the device to be exactly the same as the generic hda
codec? A new device gives you the opportunity to model it closer to the
specs in the ALC885 datasheet. This could improve compatibility with the
old guest drivers.

With best regards,
Volker

> On 11/8/23 6:12 AM, Gerd Hoffmann wrote:
>> On Wed, Nov 08, 2023 at 11:02:06AM +0100, Philippe Mathieu-Daudé wrote:
>>> Thanks Christopher for your patch,
>>>
>>> I'm Cc'ing Volker and Gerd who know better this hardware model.
>>>
>>> On 7/11/23 20:27, Christopher Lentocha wrote:
>>>> Change the ID to be a Realtek ALC885 so that both
>> No.  Rewriting the existing codecs is clearly a non-starter.
>>
>> You can add a 'hda-realtek-alc885' variant which tries to
>> mimic the realtek coded close enough to make old guests
>> without generic hda driver happy.
>>
>>>> +#define QEMU_HDA_ID 0x10EC0885
>> Nope.  Somemething like 'REALTEK_ALC885_ID' please.
>>
>> [ remaining bits of the patch snipped, needs major rework ]
>>
>> take care,
>>   Gerd
>>


