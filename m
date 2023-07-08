Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F474BF50
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 23:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIFbq-00025x-VA; Sat, 08 Jul 2023 17:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qIFbo-00025b-G6
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 17:36:52 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qIFbm-0006rv-PK
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 17:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688852207; x=1689457007; i=deller@gmx.de;
 bh=LGgnTiIJheekdaknuZwTReisjOGcef9hBBRqI2QlI64=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=drdyhYSE98+pTY3Q3YYcp6nu1TuYEIC/FMpcnonD8Kki5D1Ahy2r4KsWlcOC8q9EnvhBLpS
 lu4gvZv97HRgqUutDZN9wFqqYeDyNTQcfnnC7chGP4ayZSuQ/yZq1RI1tdarrAVqES1t2hv/o
 j04BZJVmOHT4BB+sjxqc5FaqZT+A3X+5Y+O+5Q0Kab30rNeSAjS3IpQYgdUG3QL46mSzFdNHR
 l5wbuPM/r91+9ILXwyZDlS/DMhlmoZBs6KwjznvA9yRbOMjlGgt9a14hVGP8ua00+ZttO8Sy0
 Sm5eU4hPw9WubvwraO09vg0tg5lcfKcBClbz0NI8RCu+WZbHyIQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1q87Fa0ykP-00CNiz; Sat, 08
 Jul 2023 23:36:47 +0200
Message-ID: <9bde924d-55c6-9254-e7c9-6cbf7b7c9b5a@gmx.de>
Date: Sat, 8 Jul 2023 23:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user: make sure brk(0) returns a page-aligned value
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <mvmpm55qnno.fsf@suse.de>
 <0110c2c4-e9de-a2d0-5c0a-6831415beb9f@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <0110c2c4-e9de-a2d0-5c0a-6831415beb9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y6MwzLoBDmyy4XJWgfuCJNlHEbRAlF1WfIiOgl/v10dwo1y2Mx3
 uOta6zYQ26FhJwZF6+KdJg60Ght+HBmHynmKjVexYZfFSD0NxwD8UtrejsJSdZCF8c20sQp
 f6VmK+NCxUx9hWD/ULUn5CBnYFfliycph0jQqYtZjLm7G7NunY1SecpP49OSC3tYvUzJJNA
 ji4ixhsLFo9icU4QYDBvA==
UI-OutboundReport: notjunk:1;M01:P0:lDj+an79j5s=;bAK1GSmXOKPSlXX48yVZHe+73f4
 xxLAMoAthIaJFsXqweL63bUQ/v7QwCAvQh1iEPVu89OTLJ9XKMGk1X8p0oR4J26MFG/UyoqDj
 SMJYnHx7ULtvhLZXnTZR6nljn8yEKWzW3tlghirCGnh9ehdxVNiVJ/4sLFDpDg8PPZQRGwzt6
 0uiVWDFxWV9s9c0ae7kEszRzoLjzllv0BLBu1pbg9eRHaO+mndOaOCJBoiCFM6K6jepZ4HI/F
 d5s6NQQxQ5pjvx83rSSyT7+qxw5Y5ZA36gOH6hqW7nQfCSaWVWNCoRlZxueVOf/r7E/TKqNt7
 zTNRfFcWZCWT9+cYLk1VJQSdTxM88MbNMlg+3zkDS5xLib15+Zlin5jLvS2hVF4InOslsBxUR
 Lc/KxVL2aDyV23/Y/gObqRhPSRv+5YqrROno6jkYwHKqLBnPDwUF9ZRDtjVCITx7U53/q+l28
 S5hRPbt2Zig9r4AgnpPp5W4mwnb9u07/pwftewOLygLzzDsUtDHUWQS9cSISL70KhoQEiwgDT
 jWAR8wPd3NR6xcinE7fpyhlNYGCJKi4+66K2BAhAPvVs0Kbq9BfAykepBOxkEU2uSiYtinQPP
 lm86inQXlAyf4W8eGFmrM7Wd/DF3mcIPfGPdkI4WYVYlc8xL5J4T1nSCzAzyYpWY4GKgtfb1r
 b/jCVhMJ2/i5foXarglVnGdqf0Vph4B3lu11ASjiQBTjK6s9NJt4V/p6BxQKIW82c5QraTJS6
 D+G2e6T76wHWSIeSFUe+hOFjI61V6DdeXj/NZgt3VjtsfoIPaJPheCFC4fLumUktv0Ks/GTkJ
 c1wMpaOd0pZx+82lWe+L7KEmIyIPmWbrkWETCsn87OsB43ZITtagTsA6u0pIqi/TP8B59GNqw
 0KhdV4WqUaIJ261K3udbQgqcPsCCzUcHzEdFdAUvosnbzq7VTIhfSP558GvYJCylCK9wWRhkW
 tgsHLiWaU653Ib5TMjHcyizbQ9Y=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/8/23 19:26, Richard Henderson wrote:
> On 7/6/23 12:34, Andreas Schwab wrote:
>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>> =C2=A0 linux-user/syscall.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 08162cc966..e8a17377f5 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -805,7 +805,7 @@ static abi_ulong brk_page;
>> =C2=A0 void target_set_brk(abi_ulong new_brk)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 target_brk =3D new_brk;
>> +=C2=A0=C2=A0=C2=A0 target_brk =3D TARGET_PAGE_ALIGN(new_brk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brk_page =3D HOST_PAGE_ALIGN(target_brk)=
;
>> =C2=A0 }
>
> It make sense, since that's how do_brk aligns things.

Yes, patch looks good.
I haven't tested, but it seems it adjusts the initial brk(0) value
only to make sure that it's target page aligned.
Maybe the title should be: ?
linux-user: make sure the initial brk(0) is page-aligned

> I'm curious why this error might have produced host memory clobbering, b=
ut I'm not going to debug that.

I don't believe that this un-alignment triggers host memory clobbering eit=
her.

Helge

