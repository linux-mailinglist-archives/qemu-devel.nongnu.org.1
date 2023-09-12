Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0C79D1B7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg32v-0006yK-Do; Tue, 12 Sep 2023 09:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg32r-0006sT-Lz; Tue, 12 Sep 2023 09:03:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg32o-0000PI-Gb; Tue, 12 Sep 2023 09:03:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD93721218;
 Tue, 12 Sep 2023 16:03:05 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8303327867;
 Tue, 12 Sep 2023 16:03:01 +0300 (MSK)
Message-ID: <90ab0eef-1ac7-36df-dcba-67d1f772b1a5@tls.msk.ru>
Date: Tue, 12 Sep 2023 16:03:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] target/ppc: Restrict KVM objects to system emulation
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
 <20230912113027.63941-3-philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230912113027.63941-3-philmd@linaro.org>
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
> kvm-stub.c only defines kvm_openpic_connect_vcpu(),
> which is clearly not used by user emulation.

Yes, kvm-stub only defines this function.  But you also move kvm.c
from ppc_ss to ppc_system_ss, and the commit message does not say
a word about this.  Hopefully there's no usage of symbols in kvm.c
in other configurations (or else it wont link).

I think commit message might be just a bit more verbose.  Right now
it is misleading/confusing, which is worse than no commit message
at all :)

For the changes,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

I even tried to build some targets (ppc user and system on x86)
with this change, but I can't say I verified every configuration.

/mjt

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


> ---
>   target/ppc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/meson.build b/target/ppc/meson.build
> index 4c2635039e..bf1c9319fa 100644
> --- a/target/ppc/meson.build
> +++ b/target/ppc/meson.build
> @@ -30,7 +30,6 @@ gen = [
>   ]
>   ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
>   
> -ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
>   ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
>   
>   ppc_system_ss = ss.source_set()
> @@ -46,6 +45,7 @@ ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
>   ), if_false: files(
>     'tcg-stub.c',
>   ))
> +ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
>   
>   ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
>     'compat.c',


