Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9A74B79C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:05:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrgb-00070b-78; Fri, 07 Jul 2023 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHrgZ-00070K-LB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:04:11 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qHrgX-0003VX-Do
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688760246; x=1689365046; i=deller@gmx.de;
 bh=Q0tugVbyuW6OW1hS4a4rbN0ezLWFwt4QBMuARiMNwYk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=UzE+sgASV3q4Nkce7Nh+I/Er0ODWDuIn9QZOzuaNPC6jcK4tt7857CHbFFsmZLZd2unpzd9
 F5szQ67Ek0XLadlBbClLUWZGKUPG7h9M/xzGJhwWggmQlO11h0ATGmOnt0ObnH7HgMOxDxEZF
 qFec5DhyERkJKAGWAJ+E1mfCbNO/uQOKUGVz6o41e9iSBoVDDeljb99hpb1ksKGRcWp5XCkt7
 RuRLEZJY4/LaYVlW2hfA7fsfcgcI3S4X+jiFip0V2jqj2NSnHKqUqCEN8mndFCEcq5vqaxAon
 toa5jlk1zCN7pfgKNTq/vcHPg3zqCEGu1OxnkDTMJqbzjVSCIacw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.180]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1qaUUs2YWC-00Iodl; Fri, 07
 Jul 2023 22:04:06 +0200
Message-ID: <74be0ddd-b0f3-8fd3-8953-1595571db96f@gmx.de>
Date: Fri, 7 Jul 2023 22:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] linux-user: Fix mmap2() syscall on 32-bit targets to
 allow file mapping beyond 4GB
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-4-deller@gmx.de>
 <1147c41d-3bcc-eadf-f625-819caa349e97@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <1147c41d-3bcc-eadf-f625-819caa349e97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5jEkLvB4CoLkaNLoSL2JD00MznaNw5Qk6CiaexIv7ztrdWNR/yS
 3NhGyMnKymHYqpNcq//1M7PIffMFhwDXgq926y9mXN1Cl6nLYyl9pS9s4Nkhd1VC+g1akZD
 TGtTJzRqy7f5yzJrx4YDFjMWh8E2Cb8Osryr9S+OB/XIjIVgsK18C7Ie6eJt53a3xOwgIGG
 LoaAK4Xj7gbLp4/SwPZqA==
UI-OutboundReport: notjunk:1;M01:P0:Pcy6nIfFjSQ=;zIRp0gkcTnWRSPTof2/nXkgZhDC
 /WRHiHs67pPQmVCh8dun9AGaGykGQ3yTVOFXeUF+Na/1pHK37y0UP+wuUtVv8IxeJSeXwU76N
 X6AX4PJCbYborG9k+rm3KxhHB9fYEFrYsw6H8aaD12ITDRSTS+fex6JnPF264+scuq+OEkr4J
 E3wiVnTEMU05o8EgZLT/nARH+Djjx0PymGU6xNo+Tp/nuKfFrBgxoy0/NIsNk15P/4TbywnjF
 ZhWnxaufN35tljqNCEHqI6aaBcEB1KeHeUD0kI2xVUEd1KWmBPiYgfEKsz1H+wjKWLv4Ttjpz
 C/egiE+iUw1IjbSuKYC9x4BGVyHtlYdupzZfZqBCDfZHU4OHGKo1T/lO8hrMM4oTBVCQc6l+a
 8NM7+d91/OE6EiZex6uRKzV9IUyB/7YIQ6NrMxkhr7P0S1RXhEaBW/eudnMz2h70/BwDmKIb+
 fDRxNvZrlaDTZnOg8Th3R1nvhWbMkJ2u0vGMAUkruSE7Vpbp1rV52A+kuemXEZArWidlI7ATT
 jC0wNeCm16kLtAuY7Zs4Q5zMQ/+wa3A/gTfwdylAh8L/Yhr0LS337RzB3/PdU8h/3Be+oW2w5
 u5pdlVLxR+kidaC9jYXAYiQySvPYUBV73R1KS+oO7fcU4dKYTor+iDcgOwBD56sfNdrkXoYee
 QRL7T7Ftu+SQKxRAA4xL6nVC6gh5soGvXxRzyWcU75xUfLx+r2V9CxpvQ/1bB8hDf1Bn421og
 OByCVB5Xxj7+z2mGlX1J/OtDnVO3gxhPJAhql4L3FaJw6JljCqHt7fubpQa0HNavQ2DFvu1cg
 MK927NGX0BL3HY8xXPuOVM+ZtWglTSY9sr0cPBcj7/3yUMgx9LUIO4lfh8fuhjbTASkBDX4J7
 3jfqjsEb7mwggYgwrMpeh/qbbx7FXG5k+zjIWo7g8Q66pe6DxPBVCpsBe8DD04WbCFSXDEMFt
 n/nqSZZ0GqKctGkfjiIICs/fsyE=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/7/23 21:47, Richard Henderson wrote:
> On 7/7/23 14:19, Helge Deller wrote:
>> The mmap2() syscall allows 32-bit guests to specify the offset into a
>> file in page units (instead of bytes, as done by mmap(2)).
>> On physical machines this allows 32-bit applications to map such parts
>> of large files which are stored beyond the 4GB limit.
>>
>> Allow the same behaviour when emulating 32-bit guests with qemu.
>>
>> For that switch the mmap2() function to always take an abi_ullong
>> (64-bit) offset parameter for target_mmap() and mmap_frag() to avoid an
>> arithmetical overflow when shifing a 32-bit offset parameter by
>> 12 bits (=3DPAGE_SHIFT) and thus possibly overflow the abi_ulong (32-bi=
t)
>> type.
>>
>> Signed-off-by: Helge Deller<deller@gmx.de>
>> ---
>> =C2=A0 linux-user/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++----
>> =C2=A0 linux-user/syscall.c=C2=A0=C2=A0 | 2 +-
>> =C2=A0 linux-user/user-mmap.h | 2 +-
>> =C2=A0 3 files changed, 7 insertions(+), 6 deletions(-)
>
> https://patchew.org/QEMU/20230630132159.376995-1-richard.henderson@linar=
o.org/20230630132159.376995-12-richard.henderson@linaro.org/
>
> Wherein I use the host off_t (which must be 64-bits).

I like your patch.
But wouldn't it be better to use off64_t instead of off_t just to make
clear that this is a 64bit int?

And this part:
-                          arg5, arg6 << MMAP_SHIFT);
+                          arg5, (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
maybe should become (with brackets): ?
+                          arg5, ((off64_t)(abi_ulong)arg6) << MMAP_SHIFT)=
;

In any case I'm fine if your or my patch could be appled.

Helge

