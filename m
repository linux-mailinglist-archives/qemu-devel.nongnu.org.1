Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E779D128
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2ZT-0005Uk-6R; Tue, 12 Sep 2023 08:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg2ZJ-0005SZ-53; Tue, 12 Sep 2023 08:32:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg2ZG-00060k-DT; Tue, 12 Sep 2023 08:32:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 759B6211E4;
 Tue, 12 Sep 2023 15:32:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 603DF2783E;
 Tue, 12 Sep 2023 15:32:30 +0300 (MSK)
Message-ID: <b49e350d-089d-62f7-3e5b-dcc885547912@tls.msk.ru>
Date: Tue, 12 Sep 2023 15:32:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] sysemu/kvm: Restrict kvmppc_get_radix_page_info() to
 ppc targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Greg Kurz <groug@kaod.org>
References: <20230912113027.63941-1-philmd@linaro.org>
 <20230912113027.63941-2-philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230912113027.63941-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

12.09.2023 14:30, Philippe Mathieu-Daudé:
> kvm_get_radix_page_info() is only defined for ppc targets (in
> target/ppc/kvm.c). The declaration is not useful in other targets.
> Rename using the 'kvmppc_' prefix following other declarations
> from target/ppc/kvm_ppc.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/kvm.h | 1 -
>   target/ppc/kvm_ppc.h | 2 ++
>   target/ppc/kvm.c     | 4 ++--
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..3bcd8f45be 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -551,7 +551,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
>    * Returns: 0 on success, or a negative errno on failure.
>    */
>   int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
> -struct ppc_radix_page_info *kvm_get_radix_page_info(void);
>   int kvm_get_max_memslots(void);
>   
>   /* Notify resamplefd for EOI of specific interrupts. */
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 6a4dd9c560..440e93f923 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -89,6 +89,8 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
>   
>   int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
>   
> +struct ppc_radix_page_info *kvmppc_get_radix_page_info(void);
> +
>   #define kvmppc_eieio() \
>       do {                                          \
>           if (kvm_enabled()) {                          \
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51112bd367..a58708cdfc 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -268,7 +268,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
>                        "KVM failed to provide the MMU features it supports");
>   }
>   
> -struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> +struct ppc_radix_page_info *kvmppc_get_radix_page_info(void)
>   {
>       KVMState *s = KVM_STATE(current_accel());
>       struct ppc_radix_page_info *radix_page_info;
> @@ -2372,7 +2372,7 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>       }
>   
>   #if defined(TARGET_PPC64)
> -    pcc->radix_page_info = kvm_get_radix_page_info();
> +    pcc->radix_page_info = kvmppc_get_radix_page_info();
>   
>       if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
>           /*

I wonder, if it's defined and used in target/ppc/kvm.c only,
why it needs to be in an .h file to begin with, instead of being static?

/mjt

