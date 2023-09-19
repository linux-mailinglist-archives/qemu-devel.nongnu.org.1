Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B767A5D94
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWrF-0003uW-9O; Tue, 19 Sep 2023 05:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiWrC-0003uO-9q
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:17:22 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiWrA-0007lD-Hn
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695115038; x=1695719838; i=deller@gmx.de;
 bh=/q1RU7ycCnX541fGQb8pt/8QkhbeUHJCSzPL9NQIoPk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=hV9U3AZOVwWtWdJZ1H2MNxUZtwWuyUfIsBPxfBOM0srO3s4Zdk+61rlTJK3fHXmYY3pD10bZkdD
 XQgoyX52/fFFbXui3Th53HcOqMGNisJ1kAapa2guCV2ZaHndP+HR1RvpK/4unhwIbzpUiznIti46/
 5oTiU/SeX4ARohAb15xJgXsnXibkrBHSfxAuBa/qVSJRSUWjjtutiMjPoU3Oy7b/185xGbhAoJ3hw
 x36EtfUIlGmUQd0TWrJO78Yx4zkTlExITXU+KCRWKO/Ei6JDsWq7wZWTG1AuH+5L61UP0VJaYXG7N
 fJ8PvszuCzekjhVZKWd+wzSfIzzFvojCoTbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.254]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1qsOE53otY-00A1Gc; Tue, 19
 Sep 2023 11:17:17 +0200
Message-ID: <6a245159-4885-aa51-28fd-e126940439dd@gmx.de>
Date: Tue, 19 Sep 2023 11:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
 <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
 <7a2ccda6-4f23-961c-4d53-b6929af6bd6f@tls.msk.ru>
 <c3e39816-b16a-d3f2-135e-95796814ebf0@gmx.de>
 <4aa85a6c-26ce-0683-e65e-e0e0cb9546a7@tls.msk.ru>
 <df4b309f-6de2-42f5-4c2b-3103fb0d929e@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <df4b309f-6de2-42f5-4c2b-3103fb0d929e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YDA3rBLp0Y2Whoe/0EWr1u/Az1uWaTVJqPx/ZZJgW6LlmUcsbCw
 B/GcExNPFneQzmBK4d4rXYdntADZNlOcI6a8mbvp3mcRA2KVSwXEN7XwlxiTK0G/mNEX5dM
 mU9RbEdpjqiyLgyz4NUO5XyVkNCkYtHLelTFj6WfrQg4WMB+tUFR9JxOgZnyo1YJzKi04Tk
 3doooPxISck+5VZY58vyg==
UI-OutboundReport: notjunk:1;M01:P0:kI/BQL1iYKQ=;lfkoCk1wfV2AORP2jhBfzBazr0X
 fGBKDfjlEdEscLi0WMfOaMQ7B3QD9VV1ECel4DpNAAWmmMgmrsPGYcm0AGGUZnJVN6i7UYCp8
 7Fd7Y9804NL4mSvycZN2TEiRWJbsnHw63VAlU/2+P8HFIjVplUH54FrnAtWPH4s347TKWq03Q
 cjFSDnwd3wOVrpafVHpjW5jqgpQOMggcmvWI93ufFk0qy9FDAXLfwNOKoD20eXrAOkUXiJ8c/
 /iPNk6njIp1cADZXXTKfBlogkGJuDprsVDiKbieT63SJWDfG/9eESWOcGSOQQi6uW76KpQJ3t
 Ll+o91ix/Hj8TuJLtNcEhxcX98qvyLuLiWHzwUHPrRfUKdNbv+VYWgT56tSFfn21AHsGivfhd
 8ybOSe/VV8N1diMja8ycN/xMJ4vAXW2i2yZgN11xtViBjtZWZnpYbLCp7ZVDJlveeTZyOLUGO
 8bzNt2roLxmc6aWqhkiRUTZlxNjUmqZUhZc7OQfX0mZ7SvZjPsoBz83FdlJZKLJ6KMROM2rfE
 VASh+UlWvovwdHJqMo2oxAwjxfqjM8UupBUKTLz/FxypimGqJ3dKisG7Re3uEK4N5SGiP841w
 aEW8lHKiHw89R2BszT75MS82pUum1cqzvIpk6MbxbsmLEOgIks+09IS3SWVxTElEbqnjpXNzr
 8fiXO8lDcMJ3B6xA2pDZ3Q8yjSoZHIpsCs7uGYV2tBxPVN2dMdC0xJak3h8rq7Lnh94ghIg91
 +DqpZm2oums2goe4QCsqKHa/0vQMzGwCHB/dWbSLUg1DUjxjWJpb+xv2agpPipgFRMHmuvM0/
 g5Sfskfqy/4n99diDVU9o5Y2HndZY1dskvm6CwUYaYGpQ5fNBvU9Bj842XJEhBqj7arBT/19w
 qm4X8B1f2mT4glyCTp3wSoy4CteyeAkhZ+IeES7dQvtd+I5JTOago+nu73kAn3Tk5SQygDBxW
 GbsGT9LJDDqroCko4xWwC98WwPk=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/19/23 10:38, Richard Henderson wrote:
> On 9/19/23 10:26, Michael Tokarev wrote:
>> 19.09.2023 11:00, Helge Deller wrote:
>> ..
>>>> Probably the right solution is to use qemu_abort() (and qemu_assert()=
 etc),
>>>> and maybe #define abort(x) qemu_abort(x).=C2=A0 Even if some way to r=
edefine
>>>> abort like the above will work on glibc, it does not mean it will wor=
k
>>>> on *bsd and in other contexts.
>>>
>>> True. That's probably the better solution.
>>
>> That wont work, since abort() gets called from a lot of libraries
>> (gilbc has 1000s of calls to it)
>>
>> Sigh.
>>
>> /mjt
>
> A possible solution that occurs to me is to treat SIGABRT like patch 7 o=
f this patch set treats SIGPROF: remap the guest signal to one of the host=
 RT signals.
>
> Then we leave the host SIGABRT as SIG_DFL, producing the expected crash =
when the signal originates from a host abort() (etc).=C2=A0 A guest abort(=
) would use a different signal which is caught and emulated.
>
> Things do get confusing across processes, but should be no worse than an=
y of the existing signal number swizzling.
>
> Thoughts?

Yes, this could work.

Helge


