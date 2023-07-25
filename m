Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24CE760E1B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 11:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOE6m-0000sP-8E; Tue, 25 Jul 2023 05:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOE6i-0000qt-LP
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:13:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOE6g-0002GV-RG
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:13:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA5DE16037;
 Tue, 25 Jul 2023 12:13:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB8C119376;
 Tue, 25 Jul 2023 12:13:22 +0300 (MSK)
Message-ID: <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
Date: Tue, 25 Jul 2023 12:13:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
Content-Language: en-US
To: dinglimin <dinglimin@cmss.chinamobile.com>, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

25.07.2023 12:00, dinglimin wrote:
> Replaced a call to malloc() and its respective call to free() with g_malloc() and g_free().
> 
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> 
> V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=NULL
> ---
>   semihosting/uaccess.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index 8018828069..2ac754cdb6 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -14,10 +14,10 @@
>   void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
>                           target_ulong len, bool copy)
>   {
> -    void *p = malloc(len);
> +    void *p = g_malloc(len);
>       if (p && copy) {
>           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> -            free(p);
> +            g_free(p);
>               p = NULL;
>           }
>       }

Ok, that was the obvious part.  Now a next one, also obvious.

You changed lock_user to use g_malloc(), but unlock_user
still uses free() instead of g_free().  At the very least
the other one needs to be changed too.  And I'd say the callers
should be analyzed to ensure they don't free() the result
(they should not, think it is a bug if they do).

lock_user/unlock_user (which #defines to softmmu_lock_user/
softmmu_unlock_user in softmmu mode) is used a *lot*.

/mjt

