Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6EA756F96
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 00:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLWJ3-0007az-Hn; Mon, 17 Jul 2023 18:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLWJ1-0007aq-Pw
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 18:02:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLWIz-0006V0-Ol
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 18:02:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so52815295e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689631376; x=1692223376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kfZFhr5N5BNs/S/Ku32UVLK9QrfSNsM8fYDTtgogmE=;
 b=a+gDeQ92Wzoh/gEUuimzNkxhh78U1aK0uVh80a60K3jab0Gyo1Zq+Ry8C5nig43o5F
 waSoefQmgrX7AiNgnxXhJs7uqcqY9o2I2NTkwzyU4D+5fOXdHe7UDV5B+NM9CURgTbVE
 v6I/8uOUlsQyUuFdUaOuRKAcx6zuBHl6ncA+kpIBMTk4oycFIVk6sBb3J4qg2DTH2CzO
 lCmZKmhBRMrJ5QAB8Poz0HUNQ/RfatrzXp+oJiU8yFEc09qv9/0tQSX2BrTtCpVPJ1t/
 yeYugYLjRXe4rW4Zw2rhlvkzZbIOKsXfOIoSh7J52wJUi+smkT9IWX7F6eKyW5R2slWN
 REjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689631376; x=1692223376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kfZFhr5N5BNs/S/Ku32UVLK9QrfSNsM8fYDTtgogmE=;
 b=YsGZD4YmBgYXBUjkWPtGTJvdca8Bfo2kOW5RnyhxubbTHQXhaYLMixtXLCl1zEzZn/
 6LZCO1k+G/5HXJYltTlpzQk2huFVqpRh2RBzXLMwOe+Vvv2/mpksy7Qad8stENEF1n+P
 WztKUN6Sx/keR7NmijeTqenydv86/6oIpXhXbLUfpvj8jrS7/qIaaN5ya1tqj1B3V6oF
 Evrl6MZpHctmZEPLasok4KB3MW75ufimn5RFCGp59UArhxCXdLU2hLKK2n/nvJvKJrd1
 8Rxujvpz3V/Tc5pUqkI/jLsafracTyU9UkIlUd27uXTxm1BXwX4aIEfKj+TB/BWidfH3
 hclQ==
X-Gm-Message-State: ABy/qLb4+MRbeLWadd4KpqL+kZ6KHijhBVN0yEyexuR+Dk/K1I4K+Vol
 357nBghw21GOtFfH4YAdpGUOQwEdKaIArb9BVP4=
X-Google-Smtp-Source: APBJJlE+RfBZKhGN6K34JHsT95zaZwnQjQ2kuLUPRRbm7UrXpee6ioDStIiB/EZ+qsFcc3juWfuDZA==
X-Received: by 2002:a05:600c:2a53:b0:3fb:b3f8:506b with SMTP id
 x19-20020a05600c2a5300b003fbb3f8506bmr450751wme.24.1689631375691; 
 Mon, 17 Jul 2023 15:02:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1c7917000000b003fbcdba1a63sm690571wme.12.2023.07.17.15.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 15:02:55 -0700 (PDT)
Message-ID: <238b4fcf-b7ff-f89f-187e-7c52dd6b782f@linaro.org>
Date: Tue, 18 Jul 2023 00:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] linux-user: Fix signed math overflow in brk() syscall
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230717213545.142598-1-deller@gmx.de>
 <20230717213545.142598-5-deller@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717213545.142598-5-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 17/7/23 23:35, Helge Deller wrote:
> Fix the math overflow when calculating the new_malloc_size.
> 
> new_host_brk_page and brk_page are unsigned integers. If userspace
> reduces the heap, new_host_brk_page is lower than brk_page which results
> in a huge positive number (but should actually be negative).
> 
> Fix it by adding a proper check and as such make the code more readable.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>

Tested-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>

> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")

Hmm isn't it:

Fixes: ef4330c23b ("linux-user: Handle brk() attempts with very large 
sizes")

?

> Buglink: https://github.com/upx/upx/issues/683

Also:

Cc: qemu-stable@nongnu.org

> ---
>   linux-user/syscall.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 92d146f8fb..aa906bedcc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -860,12 +860,13 @@ abi_long do_brk(abi_ulong brk_val)
>        * itself); instead we treat "mapped but at wrong address" as
>        * a failure and unmap again.
>        */
> -    new_alloc_size = new_host_brk_page - brk_page;
> -    if (new_alloc_size) {
> +    if (new_host_brk_page > brk_page) {
> +        new_alloc_size = new_host_brk_page - brk_page;
>           mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
>                                           PROT_READ|PROT_WRITE,
>                                           MAP_ANON|MAP_PRIVATE, 0, 0));
>       } else {
> +        new_alloc_size = 0;
>           mapped_addr = brk_page;
>       }
> 
> --
> 2.41.0

Alternatively:

-- >8 --
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1464151826..aafb13f3b4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -814,7 +814,7 @@ void target_set_brk(abi_ulong new_brk)
  abi_long do_brk(abi_ulong brk_val)
  {
      abi_long mapped_addr;
-    abi_ulong new_alloc_size;
+    abi_long new_alloc_size;
      abi_ulong new_brk, new_host_brk_page;

      /* brk pointers are always untagged */
@@ -857,8 +857,8 @@ abi_long do_brk(abi_ulong brk_val)
       * a failure and unmap again.
       */
      new_alloc_size = new_host_brk_page - brk_page;
-    if (new_alloc_size) {
-        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
+    if (new_alloc_size > 0) {
+        mapped_addr = get_errno(target_mmap(brk_page, 
(abi_ulong)new_alloc_size,
                                          PROT_READ|PROT_WRITE,
                                          MAP_ANON|MAP_PRIVATE, 0, 0));
      } else {
---

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

Phil.


