Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927F7B32D4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmCz1-00078W-Qf; Fri, 29 Sep 2023 08:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qmCyu-000786-Bn; Fri, 29 Sep 2023 08:52:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qmCym-0008Pk-S1; Fri, 29 Sep 2023 08:52:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8C962646C;
 Fri, 29 Sep 2023 15:52:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 967992BB94;
 Fri, 29 Sep 2023 15:52:12 +0300 (MSK)
Message-ID: <7822f8af-d6b6-fa62-6539-784d73abdeca@tls.msk.ru>
Date: Fri, 29 Sep 2023 15:52:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] target/ppc: Rename variables to avoid local variable
 shadowing in VUPKPX
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230929083143.234553-1-clg@kaod.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230929083143.234553-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -101
X-Spam_score: -10.2
X-Spam_bar: ----------
X-Spam_report: (-10.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.295,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

29.09.2023 11:31, Cédric Le Goater пишет:
> and fix such warnings :
> 
>    ../target/ppc/int_helper.c: In function ‘helper_vupklpx’:
>    ../target/ppc/int_helper.c:2025:21: warning: declaration of ‘r’ shadows a parameter [-Wshadow=local]
>     2025 |             uint8_t r = (e >> 10) & 0x1f;                               \
>          |                     ^
>    ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
>     2033 | VUPKPX(lpx, UPKLO)
>          | ^~~~~~
>    ../target/ppc/int_helper.c:2017:41: note: shadowed declaration is here
>     2017 |     void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
>          |                              ~~~~~~~~~~~^
>    ../target/ppc/int_helper.c:2033:1: note: in expansion of macro ‘VUPKPX’
>     2033 | VUPKPX(lpx, UPKLO)
>          | ^~~~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>   v2: changed all locals to start with '_' (Michael)
> 
>   target/ppc/int_helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 6fd00684a5b9..0a5c3e78a413 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2020,13 +2020,13 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>           ppc_avr_t result;                                               \
>                                                                           \
>           for (i = 0; i < ARRAY_SIZE(r->u32); i++) {                      \
> -            uint16_t e = b->u16[hi ? i : i + 4];                        \
> -            uint8_t a = (e >> 15) ? 0xff : 0;                           \
> -            uint8_t r = (e >> 10) & 0x1f;                               \
> -            uint8_t g = (e >> 5) & 0x1f;                                \
> -            uint8_t b = e & 0x1f;                                       \
> +            uint16_t _e = b->u16[hi ? i : i + 4];                       \
> +            uint8_t _a = (_e >> 15) ? 0xff : 0;                         \
> +            uint8_t _r = (_e >> 10) & 0x1f;                             \
> +            uint8_t _g = (_e >> 5) & 0x1f;                              \
> +            uint8_t _b = _e & 0x1f;                                     \
>                                                                           \
> -            result.u32[i] = (a << 24) | (r << 16) | (g << 8) | b;       \
> +            result.u32[i] = (_a << 24) | (_r << 16) | (_g << 8) | _b;   \
>           }                                                               \
>           *r = result;                                                    \
>       }

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

