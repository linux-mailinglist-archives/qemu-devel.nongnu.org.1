Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88855768726
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 20:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQB1A-0003QM-R5; Sun, 30 Jul 2023 14:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQB13-0003Pv-V6
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 14:19:42 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQB12-0004mm-3I
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 14:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690741177; x=1691345977; i=deller@gmx.de;
 bh=Z3q52t1v1UQnxe4FkcGRXfBd6lGumkKUY9u/ltaHTAQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=TDB10boiS7hRb3emSmtUDBsf/Ab1yCZJq0ECpPxWLlG8HOP7sRS50gjEGtvqSM8CdbbWxZo
 tKaljyZzCl47tqJ8rcqFOByKHs3zfUKekpSpc2drYr67tv6Lel/16tgyzpxT9eo86QFZqyrrX
 yTP5WDrBZgyIetmnabksvTcCO7jReuffOzY6nzOxDZ/UqIMjMgscSMQkv+9IYrrtiOrkqFSPU
 sN2diBh0qGd4CD0acpEndynoQYxHYPaLFAnA7ZtLnAzF0JqWoC4A9jmH0BugTATpOnv/r+2vj
 3NO37VYm952TGJkCg7njvoxx8R/bUt35ZevBzZR7KLNZyeBR96OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1peY8U0c5H-00zZMA; Sun, 30
 Jul 2023 20:19:37 +0200
Message-ID: <3eaa136d-c95b-41f1-17b6-5ee8df902de7@gmx.de>
Date: Sun, 30 Jul 2023 20:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user
 in translator_use_goto_tb()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <ZMakYpOgco2Ihg0G@p100>
 <1f3bd7a5-ac39-1706-99f1-6ae56a7cf4a7@linaro.org>
 <f12379de-1e90-74f4-2c24-6199e904344c@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <f12379de-1e90-74f4-2c24-6199e904344c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nu7HKmbI/KngS+31InYXVFSW95vn3l6H0KKTnyyvPspmmFSnipk
 jO4/sK+rMdjs0LGReE569qB7R8lK2iLNS8F9OTOOBfCW2zFK0EUmSVID+lysArV332Fzc5+
 ccebT3LeJmUCoX1J52tXsxiRVMLkVG7Bk6z1IaiKNvL7bY5V9n+qI8yslcsROEOl10REzK5
 7mMHDKF1vf0x8EQfJ2TkA==
UI-OutboundReport: notjunk:1;M01:P0:AGEXAFHeGfE=;DDFDSycTi/xyNOtqxcHJWN6q3sa
 KZ63z4G/f8XuY6skoLK5E5sw32abP9aC87lB56n5fahewAsz0ef1CRVkNPSS0GSN0JVSIkSVL
 moDjfyobaK7R/5mws7kUYgmwG8sH3UVDcTOLMjYoreG6Kj/OlFPo86i2znE5e9p9g7fHbbtKf
 9jg1ySN9yGnVSU2PHjr3UGxpDde4P1q/6DtP02a6vnnB8psaIwXLtSyKk98n4bsBqBJaAqFpX
 9RNQRj+A66hmGUxjcyfXPC8NOWTTuSMz/NkEH7Ccwjfg8Efy2AqhWgWBs9BfBvrdMsfN1ZOCg
 zIfB3w8yToXRkM47parW3FXx4T9rDMxmoafpl/XLM+jKZN0YYk43pEVkDlo5DPMTtYhZQbdTF
 zV+5wvDMFTmugCRqQ4l9ioEVJoOrlMxvLH1qNzDYCvvgL8FKMb6Ge1lVJD6L06SyLtTH3k9Pj
 cfPxrHWT8dgGzNnlYu+u2tq4/w9NdP3jkYb2nq8MuR3rMIEG8S1MOYToNY5gMKtmUqWYmbliw
 nhoO/+YiNoviZ1YzFO/jvlUevEuJi7NIlpYdOzTQLI+z13AjHLY+QVnjuX5YG3dkZSiWjMT41
 rPH4iXCJJZKi5B5/U4SJ+Aw9FZ+BAlH1565Mv1ix0vYk81D5rKUo1cSDlpGNYoPd/TXehd/3A
 yAyuwy6p5fCs1G3VyyF/sqqzax86GXGJCsqnmrYnT9iJs/e09JldfEr+YsF0pcu3D4WA2Ehbl
 QYfvwLTgd7QME0QWpj09FpXRcAulS6HR+/cbaflzZhaDOghtNyO4FTZ2r0hnRZarmaK+XRFEF
 +GeSPXULqsXWT+w+wyFdLhKM2hhDgFFyAgicVREZjk7qckYt6JYjIg/GmdPdUplCRCCEP700O
 4wzsofA44cOc38q78ayCKDk1IBnF1y0ceQe31Ubcdox8IGTLVmHrRtZn5sBTVLFXRXgtqW1vg
 6rSh6Z8BKK3MZU+j7Sp6AwE7xBY=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/30/23 20:02, Richard Henderson wrote:
> On 7/30/23 11:01, Richard Henderson wrote:
>> On 7/30/23 10:56, Helge Deller wrote:
>>> +++ b/accel/tcg/translator.c
>>> @@ -124,8 +124,13 @@ bool translator_use_goto_tb(DisasContextBase *db,=
 vaddr dest)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +#ifndef CONFIG_USER_ONLY
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check for the dest on the same page =
as the start of the TB.=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ((db->pc_first ^ dest) & TARGET_=
PAGE_MASK) =3D=3D 0;
>>> +#else
>>> +=C2=A0=C2=A0=C2=A0 /* linux-user doesn't need to fear pagefaults for =
exec swap-in */
>>> +=C2=A0=C2=A0=C2=A0 return false;
>>> +#endif
>>> =C2=A0 }
>>
>> No, we still need to stop at pages for breakpoints.
> ... and munmap for e.g. dlclose.

Ok, so we can't optimize for linux-user.
But what about my other question: Shouldn't it be
   return ((db->pc_first ^ dest) & TARGET_PAGE_MASK) !=3D 0;
?

helge

