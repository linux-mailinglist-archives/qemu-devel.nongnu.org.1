Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFD739851
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEye-0000ou-Mm; Thu, 22 Jun 2023 03:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qCEya-0000o8-V9
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:43:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qCEyY-0006Gw-Ki
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:43:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 76204E0EB;
 Thu, 22 Jun 2023 10:43:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EF452EB9D;
 Thu, 22 Jun 2023 10:43:16 +0300 (MSK)
Message-ID: <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
Date: Thu, 22 Jun 2023 10:43:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: Siqi Chen <coc.cyqh@gmail.com>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
 <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

21.06.2023 19:14, Bastian Koppelmann wrote:
> From: Siqi Chen <coc.cyqh@gmail.com>
> 
> When translating  "imask" instruction of Tricore architecture, QEMU did not check whether the register index was out of bounds, resulting in a global-buffer-overflow.
> 
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1698
> Reported-by: Siqi Chen <coc.cyqh@gmail.com>
> Signed-off-by: Siqi Chen <coc.cyqh@gmail.com>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Message-Id: <20230612065633.149152-1-coc.cyqh@gmail.com>
> Message-Id: <20230612113245.56667-2-kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 6712d98f6e..74faad4794 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -5339,6 +5339,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
>   
>       switch (op2) {
>       case OPC2_32_RCRW_IMASK:
> +        CHECK_REG_PAIR(r4);
>           tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
>           tcg_gen_movi_tl(temp2, (1 << width) - 1);
>           tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);

Is it a -stable material?

Thanks,

/mjt

