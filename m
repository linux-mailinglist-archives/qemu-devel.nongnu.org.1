Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDEA9620DB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Aug 2024 09:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjD1G-00078l-OG; Wed, 28 Aug 2024 03:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sjD1D-00074K-SO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:23:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sjD1A-0002cX-VT
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:23:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8318889527;
 Wed, 28 Aug 2024 10:21:53 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6AEDA12E48E;
 Wed, 28 Aug 2024 10:22:57 +0300 (MSK)
Message-ID: <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
Date: Wed, 28 Aug 2024 10:22:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240305135237.3111642-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

05.03.2024 16:52, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> If translation is disabled, the default memory type is Device, which
> requires alignment checking.  This is more optimally done early via
> the MemOp given to the TCG memory operation.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi!

Apparently this change also breaks picolibc testsuite (between
8.2 and 9.0, bisect points to this commit).

For example:

./qemu-system-arm \
   -m 1G \
   -chardev stdio,mux=on,id=stdio0 \
   -semihosting-config enable=on,chardev=stdio0,arg=program-name \
   -monitor none \
   -serial none \
   -machine none,accel=tcg \
   -cpu cortex-a8 \
   -device loader,file=/tmp/picolibc-1.8.6/arm-none-eabi/test/printf_scanf_thumb_v7_fp_softfp,cpu-num=0 \
   -nographic

(yes, this testsuite uses qemu-system as a substitute of
qemu-user, sort of, (ab)using -device loader)

Before this change:

hello world 1
checking floating point
checking pos args
checking long long
checking c99 formats

(exit code = 0)

After this change:

hello world 1
checking floating point
checking pos args
ARM fault: undef
	R0:   0x00000002
	R1:   0x00005c90
	R2:   0x201ffeac
	R3:   0x20200000
	R4:   0x00000000
	R5:   0x20000004
	R6:   0x201ffec4
	PC:   0x00000364



Another test from the same picolibc:

timeout 1s ./qemu-system-arm \
   -m 1G \
   -chardev stdio,mux=on,id=stdio0 \
   -semihosting-config enable=on,chardev=stdio0,arg=program-name \
   -monitor none \
   -serial none \
   -machine none,accel=tcg \
   -cpu cortex-a7 \
   -device loader,file=/tmp/picolibc-1.8.6/arm-none-eabi/newlib/testsuite/newlib.string/tstring_thumb_v7_nofp,cpu-num=0 \
   -nographic

This one succeeds immediately before this change, and
just times out (qemu is basically doing nothing, according to
strace) after this commit.



Exactly the same happens up to current qemu master (ie, 9.1-tobe).
So is not https://gitlab.com/qemu-project/qemu/-/issues/2326
and is not fixed by 4c2c0474693229c1f533239bb983495c5427784d
"target/arm: Fix usage of MMU indexes when EL3 is AArch32".



picolibc is built this way:

picolibc-1.8.6$ meson setup . arm-none-eabi \
   --prefix=/usr \
   -Dc_args='-Wdate-time' \
   -Dtests=true \
   --cross-file scripts/cross-arm-none-eabi.txt \
   -Dspecsdir=/usr/lib/picolibc/arm-none-eabi \
   -Dincludedir=lib/picolibc/arm-none-eabi/include \
   -Dlibdir=lib/picolibc/arm-none-eabi/lib


Thanks,

/mjt

