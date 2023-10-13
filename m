Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9767C862A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHfp-0005s8-SO; Fri, 13 Oct 2023 08:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qrHfn-0005rK-GN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:53:47 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qrHfk-0001uV-53
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697201619; x=1697806419; i=deller@gmx.de;
 bh=vX74lVmhWrYnmgAHDGw1TKxcpatuyTjYbSFtyhx9Afs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ul/MMxxaQUBAPg+xz1Qht+3SX474XmrJF5c3A8eDs8bFYh0UniAUEdoRL9B5BUaavXolRO570dU
 x2LkD8juhW+HIVyJy7gwRo5Gghu+MM8AOO92AFdv2eZazJKZy41XghlIciYSvLQ3+chOjYnIGiZ9m
 fQWCn5sI0FBY1HzIgSbYPm8Yb0cleymzCZdMjjmd54KlwEolAF0C7pL9koeYGqWzTVr0+Vy6rACvt
 G7D59YFdh5B1n1vL71+RX15KtO4ReU34Xfgcs+KSlPcvs2raSodTO5mIfthSPSd7FP7SKvGwrRuBZ
 GT6+dQb5copOU4mDJe7rHOCuV+4mC3caiQvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.13]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1rRiLv1Dt6-00aX0B; Fri, 13
 Oct 2023 14:53:39 +0200
Message-ID: <61512eb6-b999-48da-a2fb-58f6b3ec9b51@gmx.de>
Date: Fri, 13 Oct 2023 14:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] linux-user: Detect and report host crashes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
 <aa9f3112-7e34-4eff-8d93-59d036e82ff9@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aa9f3112-7e34-4eff-8d93-59d036e82ff9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djR6JEOWovoiHGBfmBKGplrIlEu+nn1OQevJukn82U87OGCA1Zo
 plzUk5hLr+qNZOcEMMn8dffwW+WutcKUUvXHrSvos6xe+UIxwxhdbhgAmSCOgrnWEbR8ag5
 NbIdiZAcB03W27s6RHfIlIIGhw6KEuV50RfJxKNbFgUzoc6FO7jhqfyVziisBRNqjY+ZaRw
 M/ai6MrmKnMAQWMoZ8Nhw==
UI-OutboundReport: notjunk:1;M01:P0:Ryk4o3JsFx4=;zqI6suoJw0VH8XDF/cnqdXHS1Pg
 IMww7SGHe9rEOYDfAb8mPj+fOOjyhlOlbNtN6vK1VaHvRaN0LVicUKePrHUtDrgeFWdjWiSOH
 ezpR3wxQnE9wDF4AvOICN9HIniqaCyFOK8rNHIIi6G+RtCDM4GS/8bDMVZqzc1rdQBpmxjDId
 MeCD7ynek3FYrHm8GushQuz6iB+/TYzyIKw3YzEtqbsfCnjDsNmCBRv+6i1Z75RoSwDtVW7vR
 L1Qyi2WsfFODSqGcowxyMEe40DzWQ857M1HT7s02FPnKgfdN4kuMQX2/W/4d++s/Gra92RCqd
 9KnOSyLoQ403EI5A7FqbvJ+vjzJM9yNvB9hkQiZ9whVqt69WS8QcTQkOcPELNSYoESefMeJGT
 F4OS9Rv1QQPKgOItzxxM1mrS97xGCeDLl4KpfH61ylPVpJVOU9/dKdrlyxvXw0Agdc6xm3DtF
 Mhgab0hlPDGIH/2n+UMlvM24G9VAu/3QYlagp/hCSwlPl8v4RyD9ZKZzN0BVeGHs2/poAntDh
 eSMknXcT9VWXuiE3ycaDNqMcsC/qvEh3lh9BKHpifmasvT0xhMtMy2rxhO3VuZjtnLqlUgAgQ
 wJkTDJ0cNpeFEmx7mqlzCCg5/NCk4KJjcfLmG7obE8zPPpL03a4mPWR/PlMZGVcVN1gtZ3qi1
 Ymv1trO/H0XjFOcsAUdhzVKCJIjFe3v8qpJgFIyYgwpwoXB4pzclxAILnfm0JHQMbXCIHQi9D
 8/8FN4JIEupDxE5dkzgo2f7n8jdQ82RDCURyYJZPZLfNnX/x2iv3JmU/WRKMTgDQBO5CsO+6D
 rZWYR6M7Ol8q7MMvTp0INSp7yHwfgNRKzNcluCMNg1j7mFdgIiygOP20B4ex75WPYV+PZbtBK
 HLwWhj+mfVXBnybgJJN8X6bgldFeXtay1FqPsAtXHtvnL7yDYkk/41WRbtm4xrqXHq6RWvUIx
 VQKXrw==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/23 05:52, Richard Henderson wrote:
> On 10/3/23 12:20, Richard Henderson wrote:
>> More signal cleanups.=C2=A0 Mostly tested by temporarily adding an
>> abort, divide by zero, undefined instruction, null dereference,
>> within the implementation of a guest syscall to induce an error.
>>
>> Changes for v5:
>> =C2=A0=C2=A0 * Remap guest abort, which means we need to try less hard =
on
>> =C2=A0=C2=A0=C2=A0=C2=A0 the host side to handle assertion failures.
>> =C2=A0=C2=A0 * Drop the backtrace.=C2=A0 Since backtrace_symbols only l=
ooks at the
>> =C2=A0=C2=A0=C2=A0=C2=A0 dynamic symbol set, we don't much that's usefu=
l -- we still
>> =C2=A0=C2=A0=C2=A0=C2=A0 need to use the debugger.

I've attached this series on git head and did some basic tests.
My various chroots still work, and after adding some temporary code to tri=
gger
a segfault in qemu code it works as expected and reports the fault.

So:
Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge

