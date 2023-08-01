Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C20B76BEFE
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQwcR-00080U-SU; Tue, 01 Aug 2023 17:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwcQ-00080J-BX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:09:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwcO-0005OF-QT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:09:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe110de46dso40065595e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690924163; x=1691528963;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MjzssSP93YPtxzBEAuT8h1ekerGoZ8+bhrlr6qJAWNA=;
 b=gmipbj0FkxO4t4Jj8UDcY7H9n/9d9co1Vn7UJhDjt6SQE5kuLqbJXyDS5kwoWiBMgT
 vmjbpSFJDkO1r7RjsxhME7hgIHwOoCkTS1ehTO2eQQzf2AAquRNhw1/11KUkx2n38QPy
 /WAfaUJHGyiLEs8ryNJK/WhVpR6Ysp54AuKN6HaCkkcYtgx2a7KYwC41FwE5P12H6M8k
 cIQYoQBAcUtXiGV1n6vDn7AQzBuAOAofInF1B7L+ewd3s3ewXGOjzeye/g3U+/L9OqjK
 D+aTkf3Z8hQ381KEUW+5TNQnwLBBo3BTuRG02RzK3M0zn2n0unNhpiVhR2C/8lF8kPeI
 cKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690924163; x=1691528963;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjzssSP93YPtxzBEAuT8h1ekerGoZ8+bhrlr6qJAWNA=;
 b=YNOkyWYrvQ1QNRyv5+qyIQ/BoEv6d2vUFudLbk6H6H8Hg7isS3DUDnmpc2WiB1gSTq
 ZJsN2DOIn8rAMax1vngrNmoKOZUFRF5wZtX0D4Y7nfXEtSLvjUa3q0NnH+t2KSJwLI8b
 WSDQ2bSWeQyC5pu0riansBSihDC5NJVFlCsMN44ZV+iNQzgtim7PtrAk6yRal0E2dgnr
 HtW6g4xWz8R3xvgM3BYJrfuZ9hDGF+AtBH9hWOK7j4YK4GTQ9qI+bQ+narnzPyuMgVJO
 8OZbHeeAP2i/KS3KniLeZv9fC/POAlJMF6YHRrJ8+O35/GBoxEwBdiAwF1nU9pMkNadF
 6Etw==
X-Gm-Message-State: ABy/qLaPwDP9ajELSnbGLuKgV3MGYv0oaet3IFoBLen0wV8p7mnZtrBG
 RmZI24jD5P6SvY7FmBU4u4EOa2SkWtWIWT9wTP8=
X-Google-Smtp-Source: APBJJlHBykCaRSlz5VIJ2HcHGqy/mvB9ZnB5ogCfZCM+kaWDNLSOJuWqFcBdvsLtPpAXjk1AM6uOlw==
X-Received: by 2002:a05:600c:2346:b0:3fc:e00:5275 with SMTP id
 6-20020a05600c234600b003fc0e005275mr3249461wmq.2.1690924162928; 
 Tue, 01 Aug 2023 14:09:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a5d4407000000b0031766e99429sm16934847wrq.115.2023.08.01.14.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:09:22 -0700 (PDT)
Message-ID: <06b6bf37-5ce9-41a8-eb7b-34f3b2fa92db@linaro.org>
Date: Tue, 1 Aug 2023 23:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] accel/tcg: Adjust parameters and locking with do_{ld, 
 st}_mmio_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230801184220.75224-1-richard.henderson@linaro.org>
 <20230801184220.75224-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801184220.75224-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

Hi Richard,

On 1/8/23 20:42, Richard Henderson wrote:
> Replace MMULookupPageData* with CPUTLBEntryFull, addr, size.
> Move QEMU_IOTHREAD_LOCK_GUARD to the caller.
> 
> This simplifies the usage from do_ld16_beN and do_st16_leN, where
> we weren't locking the entire operation, and required hoop jumping
> for passing addr and size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 65 +++++++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ba44501a7c..d28606b93e 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2066,24 +2066,21 @@ static void *atomic_mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
>   /**
>    * do_ld_mmio_beN:
>    * @env: cpu context
> - * @p: translation parameters
> + * @full: page parameters
>    * @ret_be: accumulated data
> + * @addr: virtual address
> + * @size: number of bytes
>    * @mmu_idx: virtual address context
>    * @ra: return address into tcg generated code, or 0
>    *
> - * Load @p->size bytes from @p->addr, which is memory-mapped i/o.
> + * Load @size bytes from @addr, which is memory-mapped i/o.
>    * The bytes are concatenated in big-endian order with @ret_be.

Do you mind adding:

      * Called with iothread lock held.

here and in do_st_mmio_leN()?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>    */


