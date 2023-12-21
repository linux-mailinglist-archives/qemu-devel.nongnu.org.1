Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955181B9DC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:53:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKOm-0004Gp-BR; Thu, 21 Dec 2023 09:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rGKOf-0004GT-1H
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:51:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rGKOb-0006Yx-B9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:51:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02C573DC7F;
 Thu, 21 Dec 2023 17:51:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5842250A2D;
 Thu, 21 Dec 2023 17:51:28 +0300 (MSK)
Message-ID: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
Date: Thu, 21 Dec 2023 17:51:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: chacha20-s390 broken in 8.2.0 in TCG on s390x
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

When running current kernel on s390x in tcg mode *on s390x hw*, the following
is generated when loading crypto selftest module (it gets loaded automatically):

[   10.546690] alg: skcipher: chacha20-s390 encryption test failed (wrong result) on test vector 1, cfg="in-place (one sglist)"
[   10.546914] alg: self-tests for chacha20 using chacha20-s390 failed (rc=-22)
[   10.546969] ------------[ cut here ]------------
[   10.546998] alg: self-tests for chacha20 using chacha20-s390 failed (rc=-22)
[   10.547182] WARNING: CPU: 1 PID: 109 at crypto/testmgr.c:5936 alg_test+0x55a/0x5b8
[   10.547510] Modules linked in: net_failover chacha_s390(+) libchacha virtio_blk(+) failover
[   10.547854] CPU: 1 PID: 109 Comm: cryptomgr_test Not tainted 6.5.0-5-s390x #1  Debian 6.5.13-1
[   10.548002] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[   10.548101] Krnl PSW : 0704c00180000000 00000000005df8fe (alg_test+0x55e/0x5b8)
[   10.548207]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[   10.548291] Krnl GPRS: 0000000000000000 0000000001286408 00000000005df8fa 0000000001286408
[   10.548337]            000000000014bf14 00000000001c6ba8 0000000001838b3c 0000000000000005
[   10.548475]            00000000025a4880 00000000025a4800 ffffffffffffffea 00000000ffffffea
[   10.548521]            000000003e649200 00000000ffffffff 00000000005df8fa 000003800016bcf8
[   10.549504] Krnl Code: 00000000005df8ee: c020003b5828	larl	%r2,0000000000d4a93e
[   10.549504]            00000000005df8f4: c0e5ffdb62d2	brasl	%r14,000000000014be98
[   10.549504]           #00000000005df8fa: af000000		mc	0,0
[   10.549504]           >00000000005df8fe: a7f4fee6		brc	15,00000000005df6ca
[   10.549504]            00000000005df902: b9040042		lgr	%r4,%r2
[   10.549504]            00000000005df906: b9040039		lgr	%r3,%r9
[   10.549504]            00000000005df90a: c020003b57df	larl	%r2,0000000000d4a8c8
[   10.549504]            00000000005df910: 18bd		lr	%r11,%r13
[   10.550004] Call Trace:
[   10.550375]  [<00000000005df8fe>] alg_test+0x55e/0x5b8
[   10.550467] ([<00000000005df8fa>] alg_test+0x55a/0x5b8)
[   10.550489]  [<00000000005d9fbc>] cryptomgr_test+0x34/0x60
[   10.550514]  [<000000000017d004>] kthread+0x124/0x130
[   10.550539]  [<0000000000103124>] __ret_from_fork+0x3c/0x50
[   10.550562]  [<0000000000b1dfca>] ret_from_fork+0xa/0x30
[   10.550611] Last Breaking-Event-Address:
[   10.550626]  [<000000000014bf20>] __warn_printk+0x88/0x110
[   10.550723] ---[ end trace 0000000000000000 ]---

git bisect points to this commit:

commit ab84dc398b3b702b0c692538b947ef65dbbdf52f
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed Aug 23 23:04:24 2023 -0700

     tcg/optimize: Optimize env memory operations

So far, this seems to work on amd64 host, but fails on s390x host -
where this has been observed so far.  Maybe it also fails in some
other combinations too, I don't yet know.  Just finished bisecting
it on s390x.

FWIW,

/mjt

