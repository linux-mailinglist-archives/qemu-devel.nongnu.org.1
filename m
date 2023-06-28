Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F87411E0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUmi-0004Fs-Ac; Wed, 28 Jun 2023 09:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEUmf-0004Fe-RV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:00:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEUmd-0004vW-CD
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:00:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7A0BF746335;
 Wed, 28 Jun 2023 15:00:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 45D3574632B; Wed, 28 Jun 2023 15:00:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4422C745720;
 Wed, 28 Jun 2023 15:00:14 +0200 (CEST)
Date: Wed, 28 Jun 2023 15:00:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PULL 02/10] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
In-Reply-To: <20230628114504.546265-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <813defa4-a833-2486-a89e-3a0f4e0b8d10@eik.bme.hu>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
 <20230628114504.546265-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-673249674-1687957214=:55442"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-673249674-1687957214=:55442
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 28 Jun 2023, Mark Cave-Ayland wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230628071202.230991-2-richard.henderson@linaro.org>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> target/sparc/translate.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index bad2ec90a0..28d4cdb8b4 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -318,10 +318,10 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
>         tcg_gen_movi_tl(cpu_npc, npc);
>         tcg_gen_exit_tb(s->base.tb, tb_num);
>     } else {
> -        /* jump to another page: currently not optimized */
> +        /* jump to another page: we can use an indirect jump */
>         tcg_gen_movi_tl(cpu_pc, pc);
>         tcg_gen_movi_tl(cpu_npc, npc);
> -        tcg_gen_exit_tb(NULL, 0);
> +        tcg_gen_lookup_and_goto_ptr();

Out of curiosity, did you test this is actually faster? The reason I ask 
is because I've tried to optimise similar case in target/ppc by using 
lookup_and_goto_ptr but found it was slower than without that. I think 
this may depend on the usage but I wonder if that could be a generic issue 
with lookup_and_goto_ptr or only specific for the case I've tried.

Regards,
BALATON Zoltan

>     }
> }
>
>
--3866299591-673249674-1687957214=:55442--

