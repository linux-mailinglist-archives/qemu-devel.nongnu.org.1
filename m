Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37C77388B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 09:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTH0p-0005jS-0I; Tue, 08 Aug 2023 03:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTH0Y-0005ib-9m
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 03:19:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTH0W-000398-D0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 03:19:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8CDC18DA8;
 Tue,  8 Aug 2023 10:19:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 011081C2ED;
 Tue,  8 Aug 2023 10:19:49 +0300 (MSK)
Message-ID: <80902fba-50f0-0757-b5c5-d3a34cdf4a40@tls.msk.ru>
Date: Tue, 8 Aug 2023 10:19:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 15/47] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 nios2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-16-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230715135317.7219-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

15.07.2023 16:52, Richard Henderson wrote:
> Based on gcc's nios2.h setting BIGGEST_ALIGNMENT to 32 bits.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/user/abitypes.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
> index beba0a48c7..6191ce9f74 100644
> --- a/include/exec/user/abitypes.h
> +++ b/include/exec/user/abitypes.h
> @@ -17,7 +17,8 @@
>   
>   #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
>       || defined(TARGET_SH4) \
> -    || defined(TARGET_MICROBLAZE)
> +    || defined(TARGET_MICROBLAZE) \
> +    || defined(TARGET_NIOS2)
>   #define ABI_LLONG_ALIGNMENT 4
>   #endif

Hi!

It smells like we should pick a few of these changes for -stable too, no?

6ee960823d Fixed incorrect LLONG alignment for openrisc and cris
ea9812d93f include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
e73f27003e include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze

Thanks,

/mjt

