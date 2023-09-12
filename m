Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADD79CC37
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 11:46:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzxa-0001r0-55; Tue, 12 Sep 2023 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qfzxX-0001pl-TE
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:45:27 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qfzxV-0001IB-IX
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694511922; x=1695116722; i=deller@gmx.de;
 bh=fdWDsBe2HrvvEsMkhcN0Jgjv6DCei5V/6dBWxDA1ezs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jz/HJnJT2MfsenWXi9z4OkGAhwapRxbA5JQCpx9elGt4A9mFzfjeJGku+xYgqV67KZL/sUv
 xc10JRSj1r4ofvEe/jRO9Hn0Bn1Rl0gAp2BPLoSJ+PBpasWdBiF+pHj8tGsVymk6bq+Yflhmq
 9vJpsM4tLE6syYBn72Ifh1VzJ8tRs8132DQnZ+WvHmBZTITvLVje/l1TaOH3jkq+h0RGu1mZK
 EpSMVLOXt/W9yEvQySRFBLBEolcfMruWVZx4woJA2HJcCcJRJyrUuiE+1jiVydIQ1P/qQFXLm
 5YZdx2jT0w9zWNQpTQ3rBCz+VGhlX3hyzOXATeGkKFrz/12uK1kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1quWXf0OBh-00EeLh; Tue, 12
 Sep 2023 11:45:22 +0200
Message-ID: <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
Date: Tue, 12 Sep 2023 11:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
In-Reply-To: <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FeoDNf2TymdasF26jjLiZl2zjH0smPP5ASxYF4qJJcYsgdM4Wh
 8HF1zU+O837UDix2m7Lo2SwLeaTCMosq9b+SPHRXXdYOG423zghbBHIYYyxhqWQ8Rq/iPRP
 w3c/AhFyLM1S1AQaUdb2q34EaYmvJZCaHbUZHL87H93FFzcBFUm185+pb9pu3YtMkjn7utt
 dNoWYUzZFMTBkrdRJg7vg==
UI-OutboundReport: notjunk:1;M01:P0:1+SPZxnpqSM=;73MbCN7DtxQJ0FI4FvyWtw8SrHD
 +/aooJTjsRswTsKfthvUH3pn+p0NRI4dG5jy44KjatgAd/cZlbJu1+0lwTaLAmWvdHdYxjO08
 /bIMbJUd0ynQqZAnOtdU/TTKlivSiqcHZb3Ew1w2c87LcY0Vn+Aft4cOqlbCFRag8cUJShZio
 pGMZo63pGLG8kPguo5ylCT4yX4+O40XIVPd1VNXJK3uL+YcVfjOm0klqzNnGyTEwx45S81DK9
 GLUCcBGC1ICrp/CnmrTNuuTecFV5mnqaLqJ1RM9+pasGiHytEeQzzv4ViYnXgzYShBrBLkb75
 Eji+iyMb7WREuBUQwPOO7MeysBvTicrvr52Y+W3e2wpeNF9bGhCbbi9JDOzeqnsc0gWIPhoYi
 ubpod2syJxIc3yE13eUw6hnc3qgDRKitdx7c3hACIjSeTH6ONr3lBX7xn6Pxar1RpmalEXv13
 7JQzmb3JYqX1kzSi93mCroPDAVPP2g4nYLJ8bV7S+SrIhLUns1hMdw0KHLm1eNUDsUdKACTJl
 Dr6haVuRt1gSUPYrq7MFT3f85iWcnn98woja88lAu0Om+Q8X726LebJfoROQu06MPvNQFUiQ1
 uj/lBZeGoJ5D3eyCiPGcW8O2BODCTCHbJQZWGnOkvlNpL8wjqcpUXDdk2ivFxJF8fsidIAAcz
 3Dy18HgtwPs+CM+IGOuKNqMgPzpJC+Gk//VKc2kJjJkI5wJC5+DCVICfkbYZg0ulTDlzDxkrq
 6atUp/DgOrubLcyHzUH5o0mpGQliGTahUYeVmJxm6DXQy8ge/slB5uu53yvEQPIRxZ2hZQABk
 nTPS6hR7+KtoPnc9UE35PNbGT/coGU3SddzGcmzTJKkcZ+MkBpjrPH6JWfPXMybN9gbD/ylQ9
 4qXbg9G/l6ei50S34ouMuYm2ytgYzK847dWzDVxf8/hSRKmrBKeJVIGFf5zjrVevI1n6bxWpv
 ZzeHM34TYPHeC6bF1WZUld+Ne60=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/9/23 21:12, Richard Henderson wrote:
> On 8/22/23 22:16, Richard Henderson wrote:
>> More signal cleanups.=C2=A0 Mostly tested by temporarily adding an
>> abort, divide by zero, undefined instruction, null dereference,
>> within the implementation of a guest syscall to induce an error.

Applied on top of git head, linking fails when builing the *static* qemu-u=
ser binary:

/usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/13/../../../../lib64/libc.a(=
abort.o): in function `abort':
(.text.unlikely+0x0): multiple definition of `abort'; libqemu-aarch64-linu=
x-user.fa.p/linux-user_signal.c.o:/srv/_build/../../home/cvs/qemu/qemu/lin=
ux-user/signal.c:723: first defined here

Helge


>>
>> Helge Deller (1):
>> =C2=A0=C2=A0 linux-user: Detect and report host crashes
>>
>> Richard Henderson (9):
>> =C2=A0=C2=A0 linux-user: Split out die_with_signal
>> =C2=A0=C2=A0 linux-user: Exit not abort in die_with_backtrace
>> =C2=A0=C2=A0 linux-user: Use die_with_signal with abort
>> =C2=A0=C2=A0 linux-user: Only register handlers for core_dump_signal by=
 default
>> =C2=A0=C2=A0 linux-user: Map unsupported signals to an out-of-bounds va=
lue
>> =C2=A0=C2=A0 linux-user: Remap SIGPROF when CONFIG_GPROF
>> =C2=A0=C2=A0 linux-user: Simplify signal_init
>> =C2=A0=C2=A0 linux-user: Split out host_sig{segv,bus}_handler
>> =C2=A0=C2=A0 linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP
>>
>> =C2=A0 linux-user/signal.c | 400 ++++++++++++++++++++++++++------------=
------
>> =C2=A0 1 file changed, 240 insertions(+), 160 deletions(-)
>>
>
>


