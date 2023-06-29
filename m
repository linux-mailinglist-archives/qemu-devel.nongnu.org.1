Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8C741F8D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 07:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEjvg-0003yZ-Pr; Thu, 29 Jun 2023 01:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEjvb-0003x7-Vs; Thu, 29 Jun 2023 01:10:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEjva-0006gL-9s; Thu, 29 Jun 2023 01:10:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qs63R1jwjz4wp4;
 Thu, 29 Jun 2023 15:10:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qs63N3SNlz4wp2;
 Thu, 29 Jun 2023 15:10:40 +1000 (AEST)
Message-ID: <ab48582d-1f29-3c86-7500-a8a0eeff85ed@kaod.org>
Date: Thu, 29 Jun 2023 07:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 6/6] target/ppc: Remove pointless checks of
 CONFIG_USER_ONLY in 'kvm_ppc.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230627115124.19632-1-philmd@linaro.org>
 <20230627115124.19632-7-philmd@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230627115124.19632-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/27/23 13:51, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


I guess the MemoryRegion code has sufficiently changed since commit
98efaf75282a ("ppc: Fix up usermode only builds") ?

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.




> ---
>   target/ppc/kvm_ppc.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 901e188c9a..6a4dd9c560 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -42,7 +42,6 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>   target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                        bool radix, bool gtse,
>                                        uint64_t proc_tbl);
> -#ifndef CONFIG_USER_ONLY
>   bool kvmppc_spapr_use_multitce(void);
>   int kvmppc_spapr_enable_inkernel_multitce(void);
>   void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> @@ -52,7 +51,6 @@ int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
>   int kvmppc_reset_htab(int shift_hint);
>   uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
>   bool kvmppc_has_cap_spapr_vfio(void);
> -#endif /* !CONFIG_USER_ONLY */
>   bool kvmppc_has_cap_epr(void);
>   int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
>   int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
> @@ -262,7 +260,6 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>   {
>   }
>   
> -#ifndef CONFIG_USER_ONLY
>   static inline bool kvmppc_spapr_use_multitce(void)
>   {
>       return false;
> @@ -322,8 +319,6 @@ static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
>       abort();
>   }
>   
> -#endif /* !CONFIG_USER_ONLY */
> -
>   static inline bool kvmppc_has_cap_epr(void)
>   {
>       return false;


