Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C155678B4C0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaeTz-0005uy-W5; Mon, 28 Aug 2023 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeTx-0005tw-19
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:48:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeTu-000487-Hc
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:48:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2105936f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693237725; x=1693842525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGkbhu7L5tIW2RuSrStsNpoDWicOkl4ffRZJpNln4sE=;
 b=Uy7CMmu6mAMEIs57SdhggS/HonujQtX8LGa3O2gDp2R7nJTxKqI4wHn3Z9KCIfYUU6
 iRS6fBxFZlL+0002I43W37AWheUA1/UJbjIcnwpVhaExODJPRPKE+mfYqakZs2AVbrZu
 sWmAcAGLn/1YyAt95Uzpc5TjEh0AjpagEgRKJcTvwcN4bhe+oFwIi7kkAoOZO+4g6F+A
 K0G+/Zakq5TBcQhRMv4o73J6p3ha95/ke2nB/4ujc123JKZ2gufGG31oLUSIM47QnKoM
 qbG4tXrC7rTydqXEkNCU4ip/3699DqqqFpGQat08kKXzUiSYnvACux7pDyE/cEOtuFOG
 /Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237725; x=1693842525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGkbhu7L5tIW2RuSrStsNpoDWicOkl4ffRZJpNln4sE=;
 b=KrvuwxRZiagqjdUXTz8a0ut7CHp0/8gaWSoD+TNakOE4eyv+3y4Y1bagkvoXS3e2VR
 tH/9xhXx7nnxK/nBbK9whomH6g0WYVnfkgnJZPvhgzLRz5G0jwnmraxUYK45mDo6bi7n
 FZ16J4SBXv4rv3puuhCATX+lpyTbpF8KHg9Wqi7r0m5A6uv8Uhankd8O+A46Tak5igli
 632ibj9xqy9sTH5dhXgYC6WK1wsBvJ8MWUgeNcnASCQ9QYHdEJ2hnxtiflkb3TCL+W3i
 IUq2FyslorHJRLzJhLqqquMK2rcKwYFRtN7qEzpbOV7uCMqc94xFIT24VL0Zq0mIE2o4
 3dhw==
X-Gm-Message-State: AOJu0YwQAUfEDIbewIaeIRqebklo+j5rh+UbYTln6eITMJHpnNDp59m4
 jUA9lRNwMoKiMFZjoW8gPMD1LA==
X-Google-Smtp-Source: AGHT+IGIOkyPOnnRcNsKQGf40NbEmigr4TKrlTe79H8SqQYkQXl3jlLi+2JBIhJuxX0xDSQKdL5hjA==
X-Received: by 2002:a5d:49cd:0:b0:317:5efa:c46a with SMTP id
 t13-20020a5d49cd000000b003175efac46amr3451wrs.27.1693237724635; 
 Mon, 28 Aug 2023 08:48:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adff1c8000000b0031c612146f1sm10749369wro.100.2023.08.28.08.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 08:48:44 -0700 (PDT)
Message-ID: <665924a0-dec5-cfe1-6d97-0021036b8723@linaro.org>
Date: Mon, 28 Aug 2023 17:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] hw/mips/jazz: Remove the big_endian variable
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230825175123.624114-1-thuth@redhat.com>
 <20230825175123.624114-2-thuth@redhat.com>
 <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
 <0b618261-b056-ff46-061c-7a0845e58ea9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0b618261-b056-ff46-061c-7a0845e58ea9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28/8/23 14:41, Thomas Huth wrote:
> On 28/08/2023 14.19, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 25/8/23 19:51, Thomas Huth wrote:
>>> There is an easier way to get a value that can be used to decide
>>> whether the target is big endian or not: Simply use the
>>> target_words_bigendian() function instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/mips/jazz.c | 10 ++--------
>>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>>
>>> @@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machine,
>>>           [JAZZ_PICA61] = {33333333, 4},
>>>       };
>>> -#if TARGET_BIG_ENDIAN
>>> -    big_endian = 1;
>>> -#else
>>> -    big_endian = 0;
>>> -#endif
>>> -
>>>       if (machine->ram_size > 256 * MiB) {
>>>           error_report("RAM size more than 256Mb is not supported");
>>>           exit(EXIT_FAILURE);
>>> @@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
>>>               dev = qdev_new("dp8393x");
>>>               qdev_set_nic_properties(dev, nd);
>>>               qdev_prop_set_uint8(dev, "it_shift", 2);
>>> -            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
>>> +            qdev_prop_set_bit(dev, "big_endian", 
>>> target_words_bigendian());
>>
>> IIRC last time I tried that Peter pointed me at the documentation:
>>
>> /**
>>   * target_words_bigendian:
>>   * Returns true if the (default) endianness of the target is big endian,
>>   * false otherwise. Note that in target-specific code, you can use
>>   * TARGET_BIG_ENDIAN directly instead. On the other hand, common
>>   * code should normally never need to know about the endianness of the
>>   * target, so please do *not* use this function unless you know very
>>   * well what you are doing!
>>   */
>>
>> (Commit c95ac10340 "cpu: Provide a proper prototype for
>>   target_words_bigendian() in a header")
>>
>> Should we update the comment?
> 
> What would you change? My motivation here was mainly to decrease the 
> size of the code - I think it's way more complicated via the #if + extra 
> variable compared to simply calling target_words_bigendian(), isn't it? 
> I think the diffstat says it all...

Is the comment misleading then? Why not decrease the code
size using target_words_bigendian() in all the similar cases?

$ git grep -A4 'if TARGET_BIG_ENDIAN' hw/

hw/microblaze/boot.c:145:#if TARGET_BIG_ENDIAN
hw/microblaze/boot.c-146-        big_endian = 1;
hw/microblaze/boot.c-147-#endif
--
hw/mips/jazz.c:160:#if TARGET_BIG_ENDIAN
hw/mips/jazz.c-161-    big_endian = 1;
hw/mips/jazz.c-162-#else
hw/mips/jazz.c-163-    big_endian = 0;
hw/mips/jazz.c-164-#endif
--
hw/mips/malta.c:378:#if TARGET_BIG_ENDIAN
hw/mips/malta.c-379-        val = 0x00000012;
hw/mips/malta.c-380-#else
hw/mips/malta.c-381-        val = 0x00000010;
hw/mips/malta.c-382-#endif
--
hw/mips/malta.c:631:#if TARGET_BIG_ENDIAN
hw/mips/malta.c-632-#define cpu_to_gt32(x) (x)
hw/mips/malta.c-633-#else
hw/mips/malta.c-634-#define cpu_to_gt32(x) bswap32(x)
hw/mips/malta.c-635-#endif
--
hw/mips/malta.c:881:#if TARGET_BIG_ENDIAN
hw/mips/malta.c-882-    big_endian = 1;
hw/mips/malta.c-883-#else
hw/mips/malta.c-884-    big_endian = 0;
hw/mips/malta.c-885-#endif
--
hw/mips/malta.c:1147:#if TARGET_BIG_ENDIAN
hw/mips/malta.c-1148-    be = 1;
hw/mips/malta.c-1149-#else
hw/mips/malta.c-1150-    be = 0;
hw/mips/malta.c-1151-#endif
--
hw/mips/mipssim.c:67:#if TARGET_BIG_ENDIAN
hw/mips/mipssim.c-68-    big_endian = 1;
hw/mips/mipssim.c-69-#else
hw/mips/mipssim.c-70-    big_endian = 0;
hw/mips/mipssim.c-71-#endif
--
hw/nios2/boot.c:153:#if TARGET_BIG_ENDIAN
hw/nios2/boot.c-154-        big_endian = 1;
hw/nios2/boot.c-155-#endif
--
hw/xtensa/sim.c:99:#if TARGET_BIG_ENDIAN
hw/xtensa/sim.c-100-    int big_endian = true;
hw/xtensa/sim.c-101-#else
hw/xtensa/sim.c-102-    int big_endian = false;
hw/xtensa/sim.c-103-#endif
--
hw/xtensa/xtfpga.c:222:#if TARGET_BIG_ENDIAN
hw/xtensa/xtfpga.c-223-    int be = 1;
hw/xtensa/xtfpga.c-224-#else
hw/xtensa/xtfpga.c-225-    int be = 0;
hw/xtensa/xtfpga.c-226-#endif

I'm just trying to be consistent. HW devices should be target
agnostic, thus not use anything related to target endianness
(TARGET_BIG_ENDIAN nor target_words_bigendian).

Machines know about their target endianness, and can propagate
that knowledge when creating their devices. Therefore using
TARGET_BIG_ENDIAN / target_words_bigendian is accepted there.
If TARGET_BIG_ENDIAN is too verbose, then let's use
target_words_bigendian() in all machines. That said, if we
use target_words_bigendian() in machine files, then some of
these files can be moved from specific_ss[] to system_ss[].

So within hw/ I'd restrict target_words_bigendian() use to
MachineClass::init() handlers, and prohibit TARGET_BIG_ENDIAN
from hw/. Only use in softmmu/, target, *-user/. If we agree
we can rewrite the comment, removing the "do *not* use this
function unless you know very well what you are doing!" which
is hard to interpret IMHO.

Regards,

Phil.

