Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB97BFB7D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBuU-000623-93; Tue, 10 Oct 2023 08:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBtm-0005xy-OR
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:31:45 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBti-0008Gi-Iw
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:31:40 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so1021399566b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696941096; x=1697545896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UJRG2/nXygBJomj7vxNPgHouTBSJNJpQptVOCZpwxHg=;
 b=zUwjyd9TcwzIdXa9Gg+zKbcV8MxD++PYBBJ6ykeZJdHcrMaanrCF3Fh4XPz9P+9DCO
 1S4WNXseUbxXCjEa/evjnbVeJVcE0BjjlNiztcKhFpFY3GiczdkbNju4wnvu7JaoPSWZ
 iX+v4AoSRKmEdg7jZLvFa9xvhj3tiNXLo/0zgcBDiGCPTW3vCzVslRrD48it1Tmi70lE
 BX99T5fqumhPJnT6emvjO6GgTPozEccLOTpAXXlwWhkJrhTZIFjoMfxN9gLLuOCG9uox
 gCcyjHLctG4BNEMP3VTH7+eqJl2IqHVJHkKoGLZyUBYg4/CChKYzSeEerdVPGp2103OP
 fi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941096; x=1697545896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJRG2/nXygBJomj7vxNPgHouTBSJNJpQptVOCZpwxHg=;
 b=ITIorD5yJN+hh/ldQ/u+eqY1HGz6JiRF4hS62ZLy3R3ADOjexR76sD0QNXr2NvVSn2
 MzRWtOQ2Mr3rR7XFOyLs5xDXs1XpKbkShj8lj7Qb3UEqgdZI2gd1DmMWkrrhesL8xWYT
 tSsqYx9qXSsHpz0q+DT+IqlKEiWkXeFsao0R1ZNzW4mDiK8JW48vhxRXmiKm98o1k2Gg
 M6wPsDmy3EWKLFk3qhCeBmuSd/Cg2iu/Hb7awL/V81I9Lx94KLtCd+rvscQgGCJAKF4K
 t2r0o14yNdLAAJkDHK/PalUYVK/HW2obPq1kkPuiAQiAtSI0r6EUtzTIjk3MS1NMWj0q
 rF3A==
X-Gm-Message-State: AOJu0Yz4ZfPAAaAiZeobIWJiZA+hznl8X5CIMKp6G3Yhu1wmF7w6GuRQ
 nBKMESZiy7vap4f3q5IhryWDBg==
X-Google-Smtp-Source: AGHT+IHuuC0nRVWsl79Nl8Jdihcmr9IUOkYh2Q/P4blHvwTt5hIOhcscrT5yFmzRwbnJ+VW+5u/C6Q==
X-Received: by 2002:a17:906:24d:b0:9a5:ca42:f3a9 with SMTP id
 13-20020a170906024d00b009a5ca42f3a9mr17966681ejl.2.1696941096663; 
 Tue, 10 Oct 2023 05:31:36 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a170906415100b009a1dbf55665sm8256466ejk.161.2023.10.10.05.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:31:36 -0700 (PDT)
Message-ID: <d974a344-5d33-734d-26c4-aff921bd92d6@linaro.org>
Date: Tue, 10 Oct 2023 14:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 12/16] softmmu: Export qemu_ram_ptr_length
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/10/23 20:30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memory.h | 2 ++
>   softmmu/physmem.c     | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ef23d65afc..ebdecf64a6 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2874,6 +2874,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>                                      hwaddr len, hwaddr addr1, hwaddr l,
>                                      MemoryRegion *mr);
>   void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
> +void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> +                          hwaddr *size, bool lock);
>   
>   /* Internal functions, part of the implementation of address_space_read_cached
>    * and address_space_write_cached.  */
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 309653c722..69a853c27a 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2182,8 +2182,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
>    *
>    * Called within RCU critical section.
>    */
> -static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> -                                 hwaddr *size, bool lock)
> +void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> +                          hwaddr *size, bool lock)
>   {
>       RAMBlock *block = ram_block;
>       if (*size == 0) {

Pre-existing, function named with '_length' suffix but takes a 'size'
parameter.

Preferably moving the docstring along with the public declaration:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


