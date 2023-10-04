Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96947B7EE3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0oZ-0004Co-22; Wed, 04 Oct 2023 08:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qo0no-00043t-VL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:16:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qo0nm-0000EO-Cy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:16:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D610127871;
 Wed,  4 Oct 2023 15:16:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C7FD42CDCD;
 Wed,  4 Oct 2023 15:16:23 +0300 (MSK)
Message-ID: <47ea2a99-12c8-4a65-06d9-c67cf233ccf7@tls.msk.ru>
Date: Wed, 4 Oct 2023 15:16:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] sysemu/xen: Remove unreachable xen_ram_alloc() code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230905122142.5939-1-philmd@linaro.org>
 <20230905122142.5939-3-philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230905122142.5939-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.528,
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

05.09.2023 15:21, Philippe Mathieu-Daudé wrote:
> The xen_ram_alloc() call in softmmu/physmem.c is guarded
> by checking for xen_enabled(), which evaluate to 'false'
> when XEN is not built in. The compiler elide the function
> call, and thus the inlined function is not used. Remove it.

I still don't think it is a good way to just eliminate the
function (stub) in a hope compiler will elide the call.  It's
definitely not guaranteed by any standard, and compiler itself
can produce varying results (eg building with -O0 to make gdb
debugging easier).

static inline function costs nothing but keeps whole thing
manageable. IMHO anyway.

/mjt

> Inspired-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/xen.h | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index 9b2d0b21ff..1f797a9abe 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -27,8 +27,6 @@ extern bool xen_allowed;
>   #define xen_enabled()           (xen_allowed)
>   
>   void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
> -void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> -                   struct MemoryRegion *mr, Error **errp);
>   
>   #else /* !CONFIG_XEN_IS_POSSIBLE */
>   
> @@ -38,12 +36,10 @@ static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>   {
>       /* nothing */
>   }
> -static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> -                                 MemoryRegion *mr, Error **errp)
> -{
> -    g_assert_not_reached();
> -}
>   
>   #endif /* CONFIG_XEN_IS_POSSIBLE */
>   
> +void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> +                   struct MemoryRegion *mr, Error **errp);
> +
>   #endif


