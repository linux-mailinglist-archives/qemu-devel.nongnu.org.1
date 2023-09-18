Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9BC7A4AFB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEsu-0007EY-J1; Mon, 18 Sep 2023 10:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiEsi-00079y-Bn
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:05:52 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qiEsg-0003sb-B6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695045936; x=1695650736; i=deller@gmx.de;
 bh=uiBbR9mAMXpPpxa8eDrH9+uLnYilTIcxI5+9f9fpBmo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=qd9t0nw+s4L73C2sY35VFogwh49wFIKWw+gp1c3bWaoeQomUtaeSVDbZut5tDEthhggzAFqv3Tp
 iHJGG18Wny4v5RL7e/sZEeZdlYSZWqyKJ/DJ5jdyPd4RoMw1Ln4NQJMmB6A2lGRVd0jGT9fjMSyhL
 OGoWOUWZSCA/IKCkV3wS/2f+u5dKUNErP+xYgKxtKGGlcYObliyfUACNv5xpi5lNTFRz8n6GrIDch
 I6/KV+yVi4FJ9dPgAAeQHo0PnJG2n0jR1PP5d/u7cuDiqVmXY0iIGiTbd7m/PWG9Rvu03QZj+c4n5
 1BBz0VdPX39PeTc2Tzwv3CcwCAeJKyIAZAnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.231]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1rlUVW3zCv-017ksQ; Mon, 18
 Sep 2023 16:05:35 +0200
Message-ID: <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
Date: Mon, 18 Sep 2023 16:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XH+c7ZBkD7iX+fmKYUuHkBU2TPrnO33i6gOM6wZyAwcg/AodtAR
 Oym3jZwn7QNVS+bifpM+hh5feUa32b1nd4EwiVy2LngUBTYRrzXQCrVP2xD4RjKHLZKGn7d
 YLpLn4zAVDFFNW/jPDEZnpYQIe+Ys/C/firO+AzC2PSceI0rV4aT7iDkRN21096pRHvUQeE
 GFk+SZTnl3XuVKPxOie0A==
UI-OutboundReport: notjunk:1;M01:P0:BEBIWgtwdKo=;F85dSHH2H21VAvH830SaWaO3XZa
 iUGtBSEJPP0vKmW1QmOjdTJ929t29yJqgcnp2Aa5OGNP2BQVovdfd1wdfPWvRt94WymwZ9BYN
 qtrkB1RI/7qNgWlQTb99kiekV0YDH6Is3w/7Ro2KiJ4/cGIryNYGsNLi8NA0HvHTosfWYVJR5
 wbKe6DU3T+b2LqftLVc1ZPY3D4MZ96UlPu83X+n2tsu03hH38/4C+xfCaL61GS5PNJAgiTBnl
 8PXecc8OYLEIQc1e33++ZiQ/IZWlCK1mSElZ+8mj4WOrTimLXKqEm9GiQvcjGhR1g9iqsO/uo
 3404t69ZwxrfX0a0557p/m2sVVzOVbNWmmOpDQX0B57LfS7HrDd2VjbV31ZH0DgDTYnFYH9zT
 qGNjUXq15VfDU7QBD7O5XZlJOw7ePXJjvVrtnjF8/IauGRA2hk9RkK9W3IOkUIE/7PvWnwfdd
 OXsNa5g2Iw+gJ6YsPxAzfjNVHN90rdZG435ws6EmR0S8to3QJoaMqMALASxgMpB1GNa3A56nR
 br97jsQCSlq1aTwlXuyzjoQ3djdupzepaC0fGAnYyfUGaDwLSob8OccyetQ2AbdtKwgGPIsYY
 Z3mkfkgcOIW1wOVB6d1xF+UmuYFUXdEAIaUvTbxKm3wrc9wRqYfmD3LSw6EXNZ9yKnG+pyEeQ
 4acgpfyQDzHkEX5eesQuoC4wSrFV7/IFiYTIrgbcf9fNsNqcvGN32yu1BY2Z3Gla+xNay0h3n
 zBFXALfI7sU3Q10EZBgxDN8P50YgL813vLhqAEDtTZ3RsvfsJ2xmzIJdOhFIjtj2mBN/hGSRa
 g/BfN1kZUHms0aThHkOPSl67mHPvx03i3q9fvMFB+mql8MR2wI1hSF2f0Spd1peRsYt9VA3JJ
 QJyc7d1AGrMWhPDGfLr9rjWJZyljNCWova1hJt54ZO5XBINExGqgnop12D5Z6m4imMVpSYXLK
 A+MZcQ==
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

On 9/12/23 12:34, Michael Tokarev wrote:
> 12.09.2023 12:45, Helge Deller:
>
>> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/13/../../../../lib64/libc=
.a(abort.o): in function `abort':
>> (.text.unlikely+0x0): multiple definition of `abort'; libqemu-aarch64-l=
inux-user.fa.p/linux-user_signal.c.o:/srv/_build/../../home/cvs/qemu/qemu/=
linux-user/signal.c:723: first defined here
>
> [PATCH v4 03/10] linux-user: Use die_with_signal with abort
>
> Sigh.
>
> I'd be double-cautious when overriding system functions like this, - it'=
s
> almost always a bad idea.

Richard, I'm not sure, but with that change:

-void abort(void)
+void  __attribute__((weak)) abort(void)

it will at least successfully link the binary. Not sure which effects it h=
as,
but probably not worse than before your patch series...

Helge

