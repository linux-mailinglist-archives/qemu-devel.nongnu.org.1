Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561873B3A4
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdAp-0007y3-4j; Fri, 23 Jun 2023 05:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCdAj-0007sf-FC; Fri, 23 Jun 2023 05:33:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCdAe-0000d5-HK; Fri, 23 Jun 2023 05:33:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX9V1D4Vz4x3k;
 Fri, 23 Jun 2023 19:33:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX9S3Zvbz4x0L;
 Fri, 23 Jun 2023 19:33:32 +1000 (AEST)
Message-ID: <16cc303a-ed98-4918-bdb1-6df78bf67bf7@kaod.org>
Date: Fri, 23 Jun 2023 11:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Fix sc instruction handling of LEV field
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230621110938.239066-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230621110938.239066-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/21/23 13:09, Nicholas Piggin wrote:
> The top bits of the LEV field of the sc instruction are to be treated as
> as a reserved field rather than a reserved value, meaning LEV is
> effectively the bottom bit. LEV=0xF should be treated as LEV=1 and be
> a hypercall, for example.
> 
> This changes the instruction execution to just set lev from the low bit
> of the field. Processors which don't support the LEV field will continue
> to ignore it.
> 
> ISA v3.1 defines LEV to be 2 bits, in order to add the 'sc 2' ultracall
> instruction. TCG does not support Ultravisor, so don't worry about
> that bit.
> 
> Suggested-by: "Harsh Prateek Bora" <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This should probably go ahead of the ISA 3.1 LEV in SRR1 patch. I
> don't think they need to be backported to stable though, have not
> caused any real problems.
> 
> Thanks to Harsh for spotting it.
> 
> Thanks,
> Nick
> 
>   target/ppc/translate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 15a00bd4fa..3c62f9188a 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4424,7 +4424,12 @@ static void gen_sc(DisasContext *ctx)
>   {
>       uint32_t lev;
>   
> -    lev = (ctx->opcode >> 5) & 0x7F;
> +    /*
> +     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
> +     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
> +     * for Ultravisor which TCG does not support, so just ignore the top 6.
> +     */
> +    lev = (ctx->opcode >> 5) & 0x1;
>       gen_exception_err(ctx, POWERPC_SYSCALL, lev);
>   }
>   

Applied to ppc-next.

Thanks,

C.



