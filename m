Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB26723293
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IBv-0008HB-8s; Mon, 05 Jun 2023 17:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6IBr-0008Gv-1c
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:56:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6IBp-0007wX-ER
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:56:38 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BB6EF746335;
 Mon,  5 Jun 2023 23:56:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4626E74632B; Mon,  5 Jun 2023 23:56:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 446E3745720;
 Mon,  5 Jun 2023 23:56:35 +0200 (CEST)
Date: Mon, 5 Jun 2023 23:56:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] util/cacheflush: Avoid flushing dcache twice when not
 necessary
In-Reply-To: <20230605195911.96033-1-philmd@linaro.org>
Message-ID: <4aee6249-c5b2-5d21-c6e5-e995734ae518@eik.bme.hu>
References: <20230605195911.96033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1712765879-1686002195=:78702"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1712765879-1686002195=:78702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 5 Jun 2023, Philippe Mathieu-Daudé wrote:
> <libkern/OSCacheControl.h> describes sys_icache_invalidate() as
> "equivalent to sys_cache_control(kCacheFunctionPrepareForExecution)",
> having kCacheFunctionPrepareForExecution defined as:
>
>  /* Prepare memory for execution.  This should be called
>   * after writing machine instructions to memory, before
>   * executing them.  It syncs the dcache and icache. [...]
>   */
>
> Since the dcache is also sync'd, we can avoid the sys_dcache_flush()
> call when both rx/rw pointers are equal.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20230605175647.88395-2-philmd@linaro.org>
> ---
> util/cacheflush.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index de35616718..a08906155a 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -241,7 +241,14 @@ static void __attribute__((constructor)) init_cache_info(void)
>
> void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
> {
> -    sys_dcache_flush((void *)rw, len);
> +    if (rx == rw) {

Isn't it more straight forward to use rx != rw and drop the else branch 
than having an empty if branch? You can still keep the comment above the 
if to explain it if needed.

Regards,
BALATON Zoltan

> +        /*
> +         * sys_icache_invalidate() syncs the dcache and icache,
> +         * so no need to call sys_dcache_flush().
> +         */
> +    } else {
> +        sys_dcache_flush((void *)rw, len);
> +    }
>     sys_icache_invalidate((void *)rx, len);
> }
> #else
>
--3866299591-1712765879-1686002195=:78702--

