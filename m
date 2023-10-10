Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048AA7BFF0B
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDbe-0007Jl-2c; Tue, 10 Oct 2023 10:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqDbW-0007Ie-BW; Tue, 10 Oct 2023 10:20:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqDbN-0007gN-Tq; Tue, 10 Oct 2023 10:20:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B55128F93;
 Tue, 10 Oct 2023 17:20:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A94722E1E4;
 Tue, 10 Oct 2023 17:20:45 +0300 (MSK)
Message-ID: <e52cd038-e0e4-4049-a374-70c6b8926f24@tls.msk.ru>
Date: Tue, 10 Oct 2023 17:20:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpus: Remove unused smp_cores/smp_threads declarations
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Like Xu <like.xu@linux.intel.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231009090952.48207-1-philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231009090952.48207-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

09.10.2023 12:09, Philippe Mathieu-Daudé:
> Commit a5e0b33119 ("vl.c: Replace smp global variables
> with smp machine properties") removed the last uses of
> the smp_cores / smp_threads variables but forgot to
> remove their declarations. Do it now.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Applied to my trivial-patches branch.

/mjt

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/cpus.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 0535a4c68a..b4a566cfe7 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -50,11 +50,4 @@ void cpu_synchronize_all_post_reset(void);
>   void cpu_synchronize_all_post_init(void);
>   void cpu_synchronize_all_pre_loadvm(void);
>   
> -#ifndef CONFIG_USER_ONLY
> -/* vl.c */
> -/* *-user doesn't have configurable SMP topology */
> -extern int smp_cores;
> -extern int smp_threads;
> -#endif
> -
>   #endif


