Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732E811F01
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 20:35:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDUzo-0000Zz-QR; Wed, 13 Dec 2023 14:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDUzl-0000ZZ-Q9
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:34:13 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDUzj-0003Z7-B8
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:34:13 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 076E875A4CB;
 Wed, 13 Dec 2023 20:34:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id A5NDtkacrG6F; Wed, 13 Dec 2023 20:34:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 235D775A4C2; Wed, 13 Dec 2023 20:34:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21A6875A4BC;
 Wed, 13 Dec 2023 20:34:03 +0100 (CET)
Date: Wed, 13 Dec 2023 20:34:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
In-Reply-To: <37746458-0986-4e60-882d-78274413791c@linaro.org>
Message-ID: <067e9f3f-2c05-8c7d-3c38-1986a369b1f3@eik.bme.hu>
References: <20231124182615.94943-1-philmd@linaro.org>
 <37746458-0986-4e60-882d-78274413791c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-619242492-1702496043=:56817"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-619242492-1702496043=:56817
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Philippe Mathieu-Daudé wrote:
> ping?
>
> On 24/11/23 19:26, Philippe Mathieu-Daudé wrote:
>> Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
>> fields has been converted to qdev properties, so don't need to be

Typo: fields have been

>> migrated:
>>
>>    static Property sb16_properties[] = {
>>        DEFINE_AUDIO_PROPERTIES(SB16State, card),
>>        DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
>>        DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
>>        DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
>>        DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
>>        DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
>>        DEFINE_PROP_END_OF_LIST (),
>>    };
>> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/audio/sb16.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
>> index 18f6d252db..be614d7bc3 100644
>> --- a/hw/audio/sb16.c
>> +++ b/hw/audio/sb16.c
>> @@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 = {
>>       .minimum_version_id = 1,
>>       .post_load = sb16_post_load,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_UINT32 (irq, SB16State),
>> -        VMSTATE_UINT32 (dma, SB16State),
>> -        VMSTATE_UINT32 (hdma, SB16State),
>> -        VMSTATE_UINT32 (port, SB16State),
>> -        VMSTATE_UINT32 (ver, SB16State),
>> +        VMSTATE_UNUSED(  4 /* irq */
>> +                       + 4 /* dma */
>> +                       + 4 /* hdma */
>> +                       + 4 /* port */
>> +                       + 4 /* ver */),
>>           VMSTATE_INT32 (in_index, SB16State),
>>           VMSTATE_INT32 (out_data_len, SB16State),
>>           VMSTATE_INT32 (fmt_stereo, SB16State),
>
>
>
--3866299591-619242492-1702496043=:56817--

