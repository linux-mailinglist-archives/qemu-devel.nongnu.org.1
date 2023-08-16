Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E6177ED0A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 00:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWOxA-0005Ha-0k; Wed, 16 Aug 2023 18:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qWOx8-0005HP-Jt
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:25:22 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qWOx6-0007QX-2M
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692224713; x=1692829513; i=deller@gmx.de;
 bh=qHYxpMELgQDlbAzujPzxymX+MnNX1RFMCelelSXF488=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LlTaAWbqHOoMDzzAx/LHBdHp/EvlCLEhNjL467KpPYqVffrtwIy5V3z74QjJm1bg8emsXaV
 OdbCASS0L3b3bn+pbNh894Z2pIFeUSw+qc29v9AY0y4EENMTU0q14yvS2McXy93W6Mk3XIcpb
 zGhKmytlUbKGOCYafz9lzxiFngDqCtpMB2m80iHZ8FNUAOZKTNFGqa4uQRernoRue73jkRGnI
 e9zBxCIPnMwAbQdmhloHtR7x7SVLUpfDiV7MLNM3WRh2PRkIodhoj0BM5xop+Dbj3/wm9Zrar
 tioZSEHUpFcvTWqP4KJS1mqZocYp3a23R5avgAr3W5dRRB/Jmz5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.66]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1q3xxY3zJo-00kQEt; Thu, 17
 Aug 2023 00:25:13 +0200
Message-ID: <6e220406-773e-e5f2-7146-64b987dec26c@gmx.de>
Date: Thu, 17 Aug 2023 00:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] linux-user: Rewrite open_self_maps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com
References: <20230816181437.572997-1-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ZXj4/ItdstAPphIKGbuZzNTg7fxjuK5OFrzkTFpzDB7MgEV1Tz
 Sv3YfmBasZVkBG/JS9m/4C1G7WCdInARonY+ybDOVqxq8rHLVU00AEuLoxsGt97fK/TN+qK
 f1dl6yLLJ96BvuuYMf3mIHKaizUdRMIBgsYpAyHt2BQ760MaK51VZ2WNL14AaZTxFrmghNU
 HGup9S42+N6lOuuA1q3RQ==
UI-OutboundReport: notjunk:1;M01:P0:YF2EU5L9gJw=;6fYlJ8cWj0+TClDrr640Dw6tAgX
 12SRJ+5LRZGxFWmi4c6hp6QaRtszTtxcUmIMPoe0A2WAw0qexw+mPdei+YBe/e/HyX5xPcKLK
 oYfgqPD1Zd84oI4LROJ0iRFhGWX1aTSRVJRJAJsJt5qGtzo7aql+rzM2RWhZQU7h8HfkdeTQ3
 FTSQWxOB6d4VTHvatB6kIvpcf0RmsWVHI7dfsuu8TiZn4Df+ZYpV3XZ0l/ZIBJDkj2ki7Vxqg
 HYUxuulc9Nl2v9bV76Ycy3rUaYcumnwYOC1mt0EWgjj6jwGI9fWwLw+286mQO6dyPYiPLskBP
 zsU10FmiY0Z6KhQXMlTJdT98XuJimM4zPrWC+uhSZ2Ad1ynV1hB0DAZHZww1oYo5Gfh93GY2X
 0v9iIeHSTGone2fJW9iFjRiglQ1oADyXc4tcf8XMNLpxRYtI1NgdBOrWOg/eCSx7VCc3RK7LU
 AXYflGbVJb3Pq5YCwNt/zYDDekdnKD0hLRvhPV1c/MPbHf5P8aUY9VhnMHNvSOlKcSDuIxD8c
 Fx2e8cXeLMdI6aWDjtPtIUMXVcSyvgmwDrsbaGOfga0fJmwNBXt6Jt2L4MJ9zcFY+G7539Kbx
 aAab2a/V/QCdYs3PHqmrRREKXDHxlt12l4YJP11FirZLT6x+LKPKhhHBTEa9vapMqCGN7Vx1y
 gaoE7XtIlBaHDL084A0svJ05Twy78LnRGhDTyikg96A5Xv4lAUq4JFdWAezgH4+2y8DpxarqE
 dMj9y80IwCwUF7zBnVKy6inmdipQotg0QyZ3L7hy7+lA0iW/9gjVYZul8K7BS9jumKAvxOYfB
 MDfocKBcZVXngV3xbfY4oYyrPkge0jKdekmv07Y1Cvo0qhCASiIbi3L83z0WOCVFlv5v62hzh
 u/Yy5k4TmNogb6KyvoBI1Hw0T8GPUnYW3CKFplE9xv2rH7C22gwoYvq7Swj3I9HeUgjeoyW3M
 JQJgmiL1RDKNGPcZZw5OAOozQ8g=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.165, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Richard,

On 8/16/23 20:14, Richard Henderson wrote:
> Based-on: 20230816180338.572576-1-richard.henderson@linaro.org
> ("[PATCH v4 00/18] linux-user: Implement VDSOs")
>
> As promised, a rewrite of /proc/self/{maps,smaps} emulation
> using interval trees.
>
> Incorporate Helge's change to mark [heap], and also mark [vdso].

Series looks good, so you may add

Tested-by: Helge Deller <deller@gmx.de>

to this series and the previous one (linux-user: Implement VDSOs).


The only thing I noticed is, that mips64el doesn't seem to have heap?

mips64el-chroot
Linux p100 6.4.10-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 11 12:20:=
29 UTC 2023 mips64 GNU/Linux
555555556000-555555557000 ---p 00000000 00:00 0
555555557000-555555d57000 rwxp 00000000 00:00 0                          [=
stack]
555555d57000-555555d84000 r-xp 00000000 fd:00 806056                     /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
555555d84000-555555d96000 ---p 00000000 00:00 0
555555d96000-555555d97000 r--p 0002f000 fd:00 806056                     /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
555555d97000-555555d99000 rw-p 00030000 fd:00 806056                     /=
usr/lib/mips64el-linux-gnuabi64/ld.so.1
555555d99000-555555d9a000 r-xp 00000000 00:00 0
555555d9a000-555555d9c000 rw-p 00000000 00:00 0
555555da0000-555555f8a000 r-xp 00000000 fd:00 806059                     /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
555555f8a000-555555f9a000 ---p 001ea000 fd:00 806059                     /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
555555f9a000-555555fa0000 r--p 001ea000 fd:00 806059                     /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
555555fa0000-555555fa5000 rw-p 001f0000 fd:00 806059                     /=
usr/lib/mips64el-linux-gnuabi64/libc.so.6
555555fa5000-555555fb2000 rw-p 00000000 00:00 0
555555fbe000-5555560c0000 rw-p 00000000 00:00 0
7f9bc9987000-7f9bc9992000 r-xp 00000000 fd:00 811277                     /=
usr/bin/cat
7f9bc9992000-7f9bc99a6000 ---p 00000000 00:00 0
7f9bc99a6000-7f9bc99a7000 r--p 0000f000 fd:00 811277                     /=
usr/bin/cat
7f9bc99a7000-7f9bc99a8000 rw-p 00010000 fd:00 811277                     /=
usr/bin/cat

Helge

