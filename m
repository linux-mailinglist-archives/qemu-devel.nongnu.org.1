Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B778FCAA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2gN-0000yQ-8o; Fri, 01 Sep 2023 07:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc2gL-0000cn-3Q; Fri, 01 Sep 2023 07:51:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=SnXb=ER=kaod.org=clg@ozlabs.org>)
 id 1qc2gI-0008Ed-JO; Fri, 01 Sep 2023 07:51:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rcbw05XPwz4wb5;
 Fri,  1 Sep 2023 21:51:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rcbvx0mv5z4wZw;
 Fri,  1 Sep 2023 21:51:08 +1000 (AEST)
Message-ID: <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
Date: Fri, 1 Sep 2023 13:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230808042001.411094-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=SnXb=ER=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.478, SPF_HELO_PASS=-0.001,
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

Adding more reviewers since this patch is modifying a common service.

Thanks,

C.


On 8/8/23 06:19, Nicholas Piggin wrote:
> This will be used for converting time intervals in different base units
> to host units, for the purpose of scheduling timers to emulate target
> timers. Timers typically must not fire before their requested expiry
> time but may fire some time afterward, so rounding up is the right way
> to implement these.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/qemu/host-utils.h | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 011618373e..e2a50a567f 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -56,6 +56,11 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>       return (__int128_t)a * b / c;
>   }
>   
> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
> +{
> +    return ((__int128_t)a * b + c - 1) / c;
> +}
> +
>   static inline uint64_t divu128(uint64_t *plow, uint64_t *phigh,
>                                  uint64_t divisor)
>   {
> @@ -83,7 +88,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
>   uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
>   int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divisor);
>   
> -static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> +static inline uint64_t __muldiv64(uint64_t a, uint32_t b, uint32_t c,
> +                                  bool round_up)
>   {
>       union {
>           uint64_t ll;
> @@ -99,12 +105,25 @@ static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
>   
>       u.ll = a;
>       rl = (uint64_t)u.l.low * (uint64_t)b;
> +    if (round_up) {
> +        rl += c - 1;
> +    }
>       rh = (uint64_t)u.l.high * (uint64_t)b;
>       rh += (rl >> 32);
>       res.l.high = rh / c;
>       res.l.low = (((rh % c) << 32) + (rl & 0xffffffff)) / c;
>       return res.ll;
>   }
> +
> +static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> +{
> +    return __muldiv64(a, b, c, false);
> +}
> +
> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint32_t c)
> +{
> +    return __muldiv64(a, b, c, true);
> +}
>   #endif
>   
>   /**


