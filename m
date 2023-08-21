Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5747826C6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 12:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1ok-0006U3-Qh; Mon, 21 Aug 2023 06:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qY1oi-0006Tv-4M
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:07:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qY1of-00048v-Kf
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:07:23 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mn2Jj-1pqP0W2ZwV-00kA2U; Mon, 21 Aug 2023 12:07:15 +0200
Message-ID: <fe3ff30d-cf2c-0c45-b4f5-107dead420ac@vivier.eu>
Date: Mon, 21 Aug 2023 12:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Funny results with long double denorms on m68k
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <87bkf1l9hf.fsf@keithp.com>
 <75b13a6f-5866-4948-00fb-fbfdb7866e3d@vivier.eu>
In-Reply-To: <75b13a6f-5866-4948-00fb-fbfdb7866e3d@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vps4mOigRLtgmGheiWP1m0QFWT7G3yX0dbBtxmjC5oyBNmGmtXr
 /7fvucsH9iWzE/+8xf1IFtPl4vN7HUZB5a4d8VUUaBQlNayijMUiuDkg/tiI2WcP9DpTtmO
 2KKRcbFrvWaczmqGvEY7CpeT3h5bb5hNG99+jmxjYgyMwc/tkwX50IbyxW4YrKMRTe1nsrL
 2kxUnxGjdNiMiRKwPQJXA==
UI-OutboundReport: notjunk:1;M01:P0:5Hb71H4mZs0=;6Jz2sUm/QBfWTTxR5jtLUsZO+Cz
 Ujka9cTHK8dEgZoky8acS0OieL8zHnQzAx36iMhU6vcFx3MmM/i1xDZYUIzeSxqCZLHnEhAz6
 +yXhRID2869KWFHydJ81gcVtGVP3dWFtQRYFb6n1HyV7QqPV7v/G8kZJMyvUn1hfw4jCE1Moe
 TtL1Zx/1ttrzdAkYb7Kidf8Gbo+7dNT1sD+lSwbUqWnZH1dzm/NveopSAmMFqQRz2dtzyrZ3G
 g9+wP7EcBimGt8CWPaAt3pz+yR01CPVW2v9Gji3aa+9rm1hHA4MRIntIrolGap1Mej3S53f8K
 hIZdhlx2SFM5G88raFxI8NHTuEDZnOSBY7KSPV/3CCQP68hVwRTU4z2PZWotdGpEGg357zTga
 n6/4nvK06c4QLhqnBVLzGB2n3I+PQ9nFupZk7TL0H18RBBx87Wzbp4/4UgBkKYrCXnQezaAXX
 6fulK7Q3LJ8ZEBBtyHYTyyNF95keYWmW/JahhzrP+PFC/wdbCN0NU4k89UL+Xv+M/gHBb+Gzl
 W0VG5jb/dFuTjunw7W9SDy1AhWjpv7F+mHaeArkEQcUtDMWkvqUQK2pQa2usDI6tW77FQrhLR
 69POsOThx0uqe8TisYk83g2OOnXW+sgDI0wFvhg0ovUitdR2nZgMy/BC3faHQKoOXm8a2RzNZ
 7u5XHSoCbKcrPYxIfQAnW1KTStTTy9DxaFHQcxWnGQnPbn9301goPBm70Aq6RGLYRwoeOrksm
 7ncweQQ47tr04QZ95/cKrRBiyBpJWfBXpppD3bferALkAkgNDVpKzsW53xnrIi4NtZ7q+BTdW
 0uDFJBkPlpHPzaaD2wE7IAh1wmPq6mH8nBU+dOTiNaIIRNsw9hsctV4led5QEvGWX7FCFNyBB
 Qhrhbe7Qx8Lp7/w==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.279,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 21/08/2023 à 10:34, Laurent Vivier a écrit :
> Le 20/08/2023 à 22:55, Keith Packard a écrit :
>> #include <stdio.h>
>> #include <stdint.h>
>>
>> #define X       0x1p+16383l
>> #define Y       0x1p-16446l
>>
>> static long double build_mul = X * Y;
>> static volatile long double x = X;
>> static volatile long double y = Y;
>>
>> static void
>> dump_ld(const char *label, long double ld)
>> {
>>      union {
>>          long double     d;
>>          struct {
>>              uint32_t    exp:16;
>>              uint32_t    space:16;
>>              uint32_t    h;
>>              uint32_t    l;
>>          };
>>      } u;
>>
>>      u.d = ld;
>>      printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, u.l);
>> }
>>
>> int main(void)
>> {
>>      long double runtime_mul = x * y;
>>
>>      dump_ld("x", x);
>>      dump_ld("y", y);
>>      dump_ld("build_mul", build_mul);
>>      dump_ld("runtime_mul", runtime_mul);
>>      return 0;
>> }
> 
> FYI, result of this program on a real hardware (q800/m68040) is:
> 
>             x:  0x8p+16380                 0x7ffe 0x80000000 0x00000000
>             y:  0x0.000000000000001p-16386 0x0000 0x00000000 0x00000001
>     build_mul:  0x8p-66                    0x3fc0 0x80000000 0x00000000
>   runtime_mul:  0x8p-66                    0x3fc0 0x80000000 0x00000000
> 

When I developped the FPU emulation I compared the result of QEMU and a real hardware using 
https://github.com/vivier/m68k-testfloat and https://github.com/vivier/m68k-softfloat

Thanks,
Laurent


