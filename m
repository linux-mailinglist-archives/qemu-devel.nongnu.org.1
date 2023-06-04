Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A672166C
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 13:45:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5m9L-00006b-MT; Sun, 04 Jun 2023 07:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5m9H-0008VB-63
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 07:43:51 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5m9F-0004cH-A0
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 07:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Reply-To:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JFtnBxue6R0xv5LQs7o3e3e/1Y8Z8eLnEpe15lPJYms=; b=UgVaW2eCrSfi9Q5QxyYBysTdSM
 7hlLIunCBYcNfGzjfx6DzHfJIWyxmeF8U7nE/x3dvwxQLrB/Ac7HQ5YrlwGaY7LY3Xvj/EwcyLgsv
 nvhOrAArItnA2vsb1y3J1zBjxhmEWYhpN9wZVuGstoNtyAmatX+xt3klo8E3HCleVRtA=;
Message-ID: <1b54a532-c922-f34d-78a8-9bc8a52f7079@rev.ng>
Date: Sun, 4 Jun 2023 13:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 25/48] tcg: Add insn_start_words to TCGContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-26-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230531040330.8950-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 5/31/23 06:03, Richard Henderson wrote:
> This will enable replacement of TARGET_INSN_START_WORDS in tcg.c.
> Split out "tcg/insn-start-words.h" and use it in target/.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/insn-start-words.h | 17 +++++++++++++++++
>   include/tcg/tcg-op.h           |  8 ++++----
>   include/tcg/tcg-opc.h          |  6 +++---
>   include/tcg/tcg.h              |  9 ++-------
>   accel/tcg/perf.c               |  8 ++++++--
>   accel/tcg/translate-all.c      | 13 ++++++++-----
>   target/i386/helper.c           |  2 +-
>   target/openrisc/sys_helper.c   |  2 +-
>   tcg/tcg.c                      | 16 +++++++++++-----
>   9 files changed, 53 insertions(+), 28 deletions(-)
>   create mode 100644 include/tcg/insn-start-words.h
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 594f1db1a7..7cff2c5915 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -64,6 +64,7 @@
>   #include "tb-context.h"
>   #include "internal.h"
>   #include "perf.h"
> +#include "tcg/insn-start-words.h"
>   
>   /* Make sure all possible CPU event bits fit in tb->trace_vcpu_dstate */
>   QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
> @@ -132,19 +133,20 @@ static int64_t decode_sleb128(const uint8_t **pp)
>   static int encode_search(TranslationBlock *tb, uint8_t *block)
>   {
>       uint8_t *highwater = tcg_ctx->code_gen_highwater;
> +    uint64_t *insn_data = tcg_ctx->gen_insn_data;
>       uint8_t *p = block;
>       int i, j, n;
>   
>       for (i = 0, n = tb->icount; i < n; ++i) {
>           uint64_t prev;
>   
> -        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
> +        for (j = 0; j < TARGET_INSN_START_WORDS; ++j, ++insn_data) {
>               if (i == 0) {
>                   prev = (!(tb_cflags(tb) & CF_PCREL) && j == 0 ? tb->pc : 0);
>               } else {
> -                prev = tcg_ctx->gen_insn_data[i - 1][j];
> +                prev = insn_data[-TARGET_INSN_START_WORDS];
>               }
> -            p = encode_sleb128(p, tcg_ctx->gen_insn_data[i][j] - prev);
> +            p = encode_sleb128(p, *insn_data - prev);
>           }
Maybe just personal preference, but I would have written

     prev = tcg_ctx->gen_insn_data[(i-1)*TARGET_INSN_START_WORDS + j]

and similarly for encode_sleb128(...) as i think it's easier to see 
what's going on.
Not used to seeing negative array indices so had to do a double take :)

But I assume we get better asm using insn_data?

Otherwise:
Reviewed-by: Anton Johansson <anjo@rev.ng>

