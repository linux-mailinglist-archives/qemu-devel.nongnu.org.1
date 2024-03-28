Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE98887D6B
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 16:09:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roPRz-0001vc-RS; Sun, 24 Mar 2024 11:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1roPRx-0001vM-VB; Sun, 24 Mar 2024 11:07:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1roPRt-0002yr-2Q; Sun, 24 Mar 2024 11:07:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6702C5873E;
 Sun, 24 Mar 2024 18:09:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD3AAA1AA0;
 Sun, 24 Mar 2024 18:07:30 +0300 (MSK)
Message-ID: <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
Date: Sun, 24 Mar 2024 18:07:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
Content-Language: en-US
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
In-Reply-To: <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

22.03.2024 22:46, Daniel Henrique Barboza :
> 
> 
> On 3/22/24 14:16, Michael Tokarev wrote:
>> 22.03.2024 11:53, Alistair Francis :
>>
>>> RISC-V PR for 9.0
>>>
>>> * Do not enable all named features by default
>>> * A range of Vector fixes
>>> * Update APLIC IDC after claiming iforce register
>>> * Remove the dependency of Zvfbfmin to Zfbfmin
>>> * Fix mode in riscv_tlb_fill
>>> * Fix timebase-frequency when using KVM acceleration
>>
>> Should something from there be picked up for stable (8.2 and probably 7.2)?
> 
> Ignore the "Do not enable all named features by default" since it's fixing something
> that were added in 9.0.
> 
> The rest you can pick it up to 8.2 at least. Thanks,

Unfortunately this doesn't quite work, the following changes
fail to apply to 8.2:

929e521a47 target/riscv: always clear vstart for ldst_whole insns
b46631f122 target/riscv: remove 'over' brconds from vector trans
d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration

I tried to back-port at least the first one but it turned out to be
another failure.  Didn't try looking at the rest.

If these really should be in 8.2 (it's your guys to decide, not me),
I need help with back-porting these to 8.2 (and/or cherry-picking
additional patches from master).

Thanks,

/mjt

>>> ----------------------------------------------------------------
>>> Daniel Henrique Barboza (10):
>>>        target/riscv: do not enable all named features by default
>>>        target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
>>>        trans_rvv.c.inc: set vstart = 0 in int scalar move insns
>>>        target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
>>>        target/riscv: always clear vstart in whole vec move insns
>>>        target/riscv: always clear vstart for ldst_whole insns
>>>        target/riscv/vector_helpers: do early exit when vstart >= vl
>>>        target/riscv: remove 'over' brconds from vector trans
>>>        trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>>>        target/riscv/vector_helper.c: optimize loops in ldst helpers
>>>
>>> Frank Chang (1):
>>>        hw/intc: Update APLIC IDC after claiming iforce register
>>>
>>> Irina Ryapolova (1):
>>>        target/riscv: Fix mode in riscv_tlb_fill
>>>
>>> Ivan Klokov (1):
>>>        target/riscv: enable 'vstart_eq_zero' in the end of insns
>>>
>>> Max Chou (1):
>>>        target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin
>>>
>>> Yong-Xuan Wang (1):
>>>        target/riscv/kvm: fix timebase-frequency when using KVM acceleration
>>
> 


