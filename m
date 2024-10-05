Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D5991851
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Oct 2024 18:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx7gL-0006Cr-Bm; Sat, 05 Oct 2024 12:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sx7gF-0006CZ-Il
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:30:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sx7gD-0006rv-Qw
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 12:30:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2C76958FE;
 Sat,  5 Oct 2024 19:30:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 868A714E017;
 Sat,  5 Oct 2024 19:30:52 +0300 (MSK)
Message-ID: <48c34f43-e63e-47e6-99b4-8b1b1842231b@tls.msk.ru>
Date: Sat, 5 Oct 2024 19:30:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
From: Michael Tokarev <mjt@tls.msk.ru>
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
 <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
 <1ede7823-8d4c-462a-8a80-c67c9dedd062@linaro.org>
 <a9a09776-e472-4321-af74-8d0dd0102654@tls.msk.ru>
Content-Language: en-US, ru-RU
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
In-Reply-To: <a9a09776-e472-4321-af74-8d0dd0102654@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

05.10.2024 19:22, Michael Tokarev wrote:
> 05.10.2024 19:20, Richard Henderson wrote:
>> No, it doesn't fail to link.  That's why it took so long to notice.
> 
> It does here quite often during bisection between 9.0 and 9.1.
> Lemme see..

So, it is just 2 steps:

$ git bisect start v9.0.0 v9.1.0   # at 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
$ configure --target-list=x86_64-softmmu
$ ninja qemu-system-x86_64   # this one will work
$ git bisect bad    # at 544595e73007c824b7435b52519cc578586783a6
$ ninja qemu-system-x86_64   # this breaks:

[2/2] Linking target qemu-system-x86_64
FAILED: qemu-system-x86_64
cc -m64 @qemu-system-x86_64.rsp
/usr/bin/ld: libqemu-x86_64-softmmu.fa.p/accel_tcg_cputlb.c.o: in function `atomic16_read_rw':
/build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:51: undefined reference to `__sync_val_compare_and_swap_16'
/usr/bin/ld: /build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:51: undefined reference to `__sync_val_compare_and_swap_16'
/usr/bin/ld: /build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:51: undefined reference to `__sync_val_compare_and_swap_16'
/usr/bin/ld: /build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:51: undefined reference to `__sync_val_compare_and_swap_16'
/usr/bin/ld: /build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:51: undefined reference to `__sync_val_compare_and_swap_16'
/usr/bin/ld: libqemu-x86_64-softmmu.fa.p/accel_tcg_cputlb.c.o: in function `atomic16_set':
/build/qemu/master/host/include/x86_64/host/atomic128-ldst.h:67: undefined reference to `__sync_bool_compare_and_swap_16'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.

So it requires second step.
configure is re-run at the second build. So we're holding
some data between rebuilds which we shouldn't.

/mjt


