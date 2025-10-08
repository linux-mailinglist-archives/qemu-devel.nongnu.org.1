Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E711FBC43E6
	for <lists+qemu-devel@lfdr.de>; Wed, 08 Oct 2025 12:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6R2i-0006dL-Ez; Wed, 08 Oct 2025 06:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6R2f-0006bA-E3
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:05:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6R2d-000285-Sb
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=QhId4rSPP70yQvQmvA+92vGCgXazeeGH8WKlU3b2+QI=; b=vP2f7Oryhw0yI8A
 xRoHzrEmkqwPBI/VG1fQEX2A9mjR1ysvO/szoMi2zFLyrjx5O57qfAY1fJ5fYUlVLVPm2rs+YzsdC
 O1ygpQpJd5LWUlD+Q0uXqzDGR98pPMY2p+zt7lYJFsNrLcCAck93up5uQyElcsUpC3uCggYdlxxhn
 Yw=;
Date: Wed, 8 Oct 2025 12:07:44 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 3/5] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Message-ID: <lnpx2iwt2ubt55e7azssizl3mpbpaewdle4tkumytca4mjgmxv@3ovxxbceh6zq>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008060129.87579-4-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 08/10/25, Philippe Mathieu-Daudé wrote:
> translator_use_goto_tb() expects a vaddr type since commit
> b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
> translator_*()").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 5098a1db4dc..ff33e64a710 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -116,7 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
>      gen_raise_exception_sync(dc, EXCP_HW_EXCP);
>  }
>  
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
>  {
>      if (translator_use_goto_tb(&dc->base, dest)) {
>          tcg_gen_goto_tb(n);
> -- 
> 2.51.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

