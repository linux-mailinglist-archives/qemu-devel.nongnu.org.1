Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6EF75B4C2
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWk2-0001rM-J4; Thu, 20 Jul 2023 12:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2hVk=DG=kaod.org=clg@ozlabs.org>)
 id 1qMWk1-0001r7-C7
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:43:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=2hVk=DG=kaod.org=clg@ozlabs.org>)
 id 1qMWjz-0000WR-FX
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:43:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R6JQJ2KZrz4wy9;
 Fri, 21 Jul 2023 02:42:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6JQF5ftNz4wxx;
 Fri, 21 Jul 2023 02:42:45 +1000 (AEST)
Message-ID: <e15250a2-3d21-d70b-980f-38d8165f0e30@kaod.org>
Date: Thu, 20 Jul 2023 18:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 3/4] hw/rtc/aspeed_rtc: Use 64-bit offset for
 holding time_t difference
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230720155902.1590362-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=2hVk=DG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.096,
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

On 7/20/23 17:59, Peter Maydell wrote:
> In the aspeed_rtc device we store a difference between two time_t
> values in an 'int'. This is not really correct when time_t could
> be 64 bits. Enlarge the field to 'int64_t'.
> 
> This is a migration compatibility break for the aspeed boards.
> While we are changing the vmstate, remove the accidental
> duplicate of the offset field.

Ah yes. Thanks.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
> I took "bump the migration version" as the simplest approach
> here, because I don't think we care about migration compat
> in this case. If we do I can write the alternate version of
> the patch...


I don't think we care much about migration compat and fyi, migration
of aspeed machines broke a while ago. It still migrates if done before
Linux is loaded.


C.


> ---
>   include/hw/rtc/aspeed_rtc.h | 2 +-
>   hw/rtc/aspeed_rtc.c         | 5 ++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/rtc/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.h
> index df61e46059e..596dfebb46c 100644
> --- a/include/hw/rtc/aspeed_rtc.h
> +++ b/include/hw/rtc/aspeed_rtc.h
> @@ -18,7 +18,7 @@ struct AspeedRtcState {
>       qemu_irq irq;
>   
>       uint32_t reg[0x18];
> -    int offset;
> +    int64_t offset;
>   
>   };
>   
> diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
> index f6da7b666d6..fa861e2d494 100644
> --- a/hw/rtc/aspeed_rtc.c
> +++ b/hw/rtc/aspeed_rtc.c
> @@ -136,11 +136,10 @@ static const MemoryRegionOps aspeed_rtc_ops = {
>   
>   static const VMStateDescription vmstate_aspeed_rtc = {
>       .name = TYPE_ASPEED_RTC,
> -    .version_id = 1,
> +    .version_id = 2,
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(reg, AspeedRtcState, 0x18),
> -        VMSTATE_INT32(offset, AspeedRtcState),
> -        VMSTATE_INT32(offset, AspeedRtcState),
> +        VMSTATE_INT64(offset, AspeedRtcState),
>           VMSTATE_END_OF_LIST()
>       }
>   };


