Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC67BF89F
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9vz-0000Q9-4C; Tue, 10 Oct 2023 06:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qq9vh-0000IT-DV; Tue, 10 Oct 2023 06:25:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qq9vd-00030I-5a; Tue, 10 Oct 2023 06:25:32 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C72647456AC;
 Tue, 10 Oct 2023 12:24:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7CB4D7456A7; Tue, 10 Oct 2023 12:24:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7AF66745681;
 Tue, 10 Oct 2023 12:24:30 +0200 (CEST)
Date: Tue, 10 Oct 2023 12:24:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "open list:sam460ex" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 16/18] hw/sm501: allow compiling without PIXMAN
In-Reply-To: <CAJ+F1C+CA1_5t9f_iqxYyHuRqBbPXjZvQ4kyuZkFVZX37VC17w@mail.gmail.com>
Message-ID: <c886f90a-ee06-b459-88ad-1f04d9469202@eik.bme.hu>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-17-marcandre.lureau@redhat.com>
 <433e2db8-e85e-d1ce-e54f-80edadd71643@eik.bme.hu>
 <CAJ+F1C+w3mQY2B3A=-6TQyyCT9kZT2EEprnLygK7t7rKLSwBvw@mail.gmail.com>
 <4ea37bd5-7278-b0e7-6cd4-652ac3eb0ae7@eik.bme.hu>
 <CAJ+F1CLSkdRcpkA3Mud+q3-J21SWXExKMoEARFhiWzaQAVtR9w@mail.gmail.com>
 <84e30518-cab1-ef52-fed2-a5b65d13d334@eik.bme.hu>
 <CAJ+F1C+CA1_5t9f_iqxYyHuRqBbPXjZvQ4kyuZkFVZX37VC17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-903578746-1696933470=:4084"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-903578746-1696933470=:4084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2023, Marc-André Lureau wrote:
> Hi
>
> On Tue, Oct 10, 2023 at 2:09 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Tue, 10 Oct 2023, Marc-André Lureau wrote:
>>> On Tue, Oct 10, 2023 at 1:53 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Tue, 10 Oct 2023, Marc-André Lureau wrote:
>>>>> Hi Zoltan
>>>>>
>>>>> On Mon, Sep 18, 2023 at 9:59 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>>>
>>>>>> On Mon, 18 Sep 2023, marcandre.lureau@redhat.com wrote:
>>>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>>
>>>>>>> Drop the "x-pixman" property and use fallback path in such case.
>>>>>>>
>>>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>>> ---
>>>>>>> hw/display/sm501.c | 19 ++++++++++++++++---
>>>>>>> 1 file changed, 16 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>>>>>>> index 0eecd00701..a897c82f04 100644
>>>>>>> --- a/hw/display/sm501.c
>>>>>>> +++ b/hw/display/sm501.c
>>>>>>> @@ -730,7 +730,6 @@ static void sm501_2d_operation(SM501State *s)
>>>>>>>     switch (cmd) {
>>>>>>>     case 0: /* BitBlt */
>>>>>>>     {
>>>>>>> -        static uint32_t tmp_buf[16384];
>>>>>>>         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
>>>>>>>         unsigned int src_y = s->twoD_source & 0xFFFF;
>>>>>>>         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
>>>>>>> @@ -828,9 +827,11 @@ static void sm501_2d_operation(SM501State *s)
>>>>>>>                 de = db + (width + (height - 1) * dst_pitch) * bypp;
>>>>>>>                 overlap = (db < se && sb < de);
>>>>>>>             }
>>>>>>> +#ifdef CONFIG_PIXMAN
>>>>>>>             if (overlap && (s->use_pixman & BIT(2))) {
>>>>>>>                 /* pixman can't do reverse blit: copy via temporary */
>>>>>>>                 int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
>>>>>>> +                static uint32_t tmp_buf[16384];
>>>>>>>                 uint32_t *tmp = tmp_buf;
>>>>>>>
>>>>>>>                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
>>>>>>> @@ -860,9 +861,12 @@ static void sm501_2d_operation(SM501State *s)
>>>>>>>                                        dst_pitch * bypp / sizeof(uint32_t),
>>>>>>>                                        8 * bypp, 8 * bypp, src_x, src_y,
>>>>>>>                                        dst_x, dst_y, width, height);
>>>>>>> -            } else {
>>>>>>> +            } else
>>>>>>> +#else
>>>>>>> +            {
>>>>>>>                 fallback = true;
>>>>>>>             }
>>>>>>> +#endif
>>>>>>>             if (fallback) {
>>>>>>>                 uint8_t *sp = s->local_mem + src_base;
>>>>>>>                 uint8_t *d = s->local_mem + dst_base;
>>>>>>> @@ -894,10 +898,13 @@ static void sm501_2d_operation(SM501State *s)
>>>>>>>             color = cpu_to_le16(color);
>>>>>>>         }
>>>>>>>
>>>>>>> +#ifdef CONFIG_PIXMAN
>>>>>>>         if (!(s->use_pixman & BIT(0)) || (width == 1 && height == 1) ||
>>>>>>>             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
>>>>>>>                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
>>>>>>> -                         dst_x, dst_y, width, height, color)) {
>>>>>>> +                         dst_x, dst_y, width, height, color))
>>>>>>> +#endif
>>>>>>> +        {
>>>>>>>             /* fallback when pixman failed or we don't want to call it */
>>>>>>>             uint8_t *d = s->local_mem + dst_base;
>>>>>>>             unsigned int x, y, i;
>>>>>>> @@ -2038,7 +2045,9 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
>>>>>>>
>>>>>>> static Property sm501_sysbus_properties[] = {
>>>>>>>     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
>>>>>>> +#ifdef CONFIG_PIXMAN
>>>>>>>     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
>>>>>>> +#endif
>>>>>>
>>>>>> Do we want to omit the property when compiled without pixman? I think we
>>>>>> could leave it there and it would just be ignored without pixman but the
>>>>>> same command line would still work and need less ifdefs in code.
>>>>>
>>>>> That's a reasonable idea to me. At least, it can handle x-pixman=0
>>>>> fine when !CONFIG_PIXMAN then.
>>>>>
>>>>> Btw, looking at it, it seems it should be DEFINE_PROP_BIT instead. I
>>>>> will add a TODO :)
>>>>
>>>> Erm, a bit can be 1 or 0 but the default value of it is 7. It's not a
>>>> single but but a bitmask the enable/disable pisman for different
>>>> operations separately so I think it can't be _BIT.
>>>
>>> Sure, but we could have more explicitly different BIT properties
>>> ("x-pixman-fill", "x-pixman-blit", "x-pixman-overlap-blit").
>>
>> That was also proposed when I've added it and concluded that we don't want
>> that. This is a debug option for experts and adding a lot of experimental
>> options for that that are also harder to type is not an improvement so
>> having just a value is fine.
>
> Ok, I'll change the comment to:
> /* this a debug option, prefer UINT over PROP_BIT for simplicity */
>
> r-b with that?

I don't think it needs a comment but I don't mind if you add one. I'll 
review the latest version later and if you add a comment that won't change 
it.

Regards,
BALATON Zoltan
--3866299591-903578746-1696933470=:4084--

