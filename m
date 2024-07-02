Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8191EF66
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 08:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOXJg-0007PU-NB; Tue, 02 Jul 2024 02:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sOXJd-0007P9-Aq; Tue, 02 Jul 2024 02:48:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sOXJZ-0007R1-Qb; Tue, 02 Jul 2024 02:48:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1E57976094;
 Tue,  2 Jul 2024 09:48:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 44B53FBB4C;
 Tue,  2 Jul 2024 09:48:22 +0300 (MSK)
Message-ID: <f65e6448-cfd2-425c-853a-5a4ae5cf2a8c@tls.msk.ru>
Date: Tue, 2 Jul 2024 09:48:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] target/arm: Fix SQDMULH (by element) with Q=0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
 <20240625183536.1672454-3-richard.henderson@linaro.org>
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
In-Reply-To: <20240625183536.1672454-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

25.06.2024 21:35, Richard Henderson wrote:
> The inner loop, bounded by eltspersegment, must not be
> larger than the outer loop, bounded by elements.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

If my understanding is correct, this one

Fixes: f80701cb44d3 ("target/arm: Convert SQDMULH, SQRDMULH to decodetree")

and before this commit, there was no issue.

Is my understanding correct?

Thanks,

/mjt

> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 7b34cc98af..d477479bb1 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -317,10 +317,12 @@ void HELPER(neon_sqdmulh_idx_h)(void *vd, void *vn, void *vm,
>       intptr_t i, j, opr_sz = simd_oprsz(desc);
>       int idx = simd_data(desc);
>       int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
> +    intptr_t elements = opr_sz / 2;
> +    intptr_t eltspersegment = MIN(16 / 2, elements);
>   
> -    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
> +    for (i = 0; i < elements; i += 16 / 2) {
>           int16_t mm = m[i];
> -        for (j = 0; j < 16 / 2; ++j) {
> +        for (j = 0; j < eltspersegment; ++j) {
>               d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, false, vq);
>           }
>       }
> @@ -333,10 +335,12 @@ void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
>       intptr_t i, j, opr_sz = simd_oprsz(desc);
>       int idx = simd_data(desc);
>       int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
> +    intptr_t elements = opr_sz / 2;
> +    intptr_t eltspersegment = MIN(16 / 2, elements);
>   
> -    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
> +    for (i = 0; i < elements; i += 16 / 2) {
>           int16_t mm = m[i];
> -        for (j = 0; j < 16 / 2; ++j) {
> +        for (j = 0; j < eltspersegment; ++j) {
>               d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, true, vq);
>           }
>       }
> @@ -512,10 +516,12 @@ void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
>       intptr_t i, j, opr_sz = simd_oprsz(desc);
>       int idx = simd_data(desc);
>       int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
> +    intptr_t elements = opr_sz / 4;
> +    intptr_t eltspersegment = MIN(16 / 4, elements);
>   
> -    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
> +    for (i = 0; i < elements; i += 16 / 4) {
>           int32_t mm = m[i];
> -        for (j = 0; j < 16 / 4; ++j) {
> +        for (j = 0; j < eltspersegment; ++j) {
>               d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
>           }
>       }
> @@ -528,10 +534,12 @@ void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
>       intptr_t i, j, opr_sz = simd_oprsz(desc);
>       int idx = simd_data(desc);
>       int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
> +    intptr_t elements = opr_sz / 4;
> +    intptr_t eltspersegment = MIN(16 / 4, elements);
>   
> -    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
> +    for (i = 0; i < elements; i += 16 / 4) {
>           int32_t mm = m[i];
> -        for (j = 0; j < 16 / 4; ++j) {
> +        for (j = 0; j < eltspersegment; ++j) {
>               d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
>           }
>       }

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


