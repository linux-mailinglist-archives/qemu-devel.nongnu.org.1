Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05E79FD6D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgh2z-0004cy-UZ; Thu, 14 Sep 2023 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgh2p-0004YF-7T
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:45:50 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgh2i-0008U0-Ai
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:45:45 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3aca1543608so404876b6e.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694677539; x=1695282339;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAIGhiYeDq7Tx6oY+POG21xoISs/YYbSyeHtj9qf2S8=;
 b=jhbLfrI9le3ZPkuKlPHb7q+GUCS3QFOyrxghkYjk/ntNTieNuz1ZAM/352yCXhGeEA
 2ePCO9mUYzvQlWiZDsz0+AOiG3GSA/DclWRsn6Z+ksMGjisOD7u6ypdZ0KDu9bo7UlU7
 n/dleosfYgGEHO+0e1SV5+EJu4BwMJMbEoDriv/5MVzc8Ryta0bdJhlngQw9xuyPBwos
 5IWwe8Ws4YFmT62Vmh+Tp21dlgwr6CdpbkUyYH7np5sUe9Khw9p0V/IAHf340KXte2Kc
 E0RkjXMLCjj+IuNrBD3Hmw5jtrTo0Kd0GeWilrPv/JxaR2TKzxykgK/DZJ7PhcL+ZCH3
 4noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677539; x=1695282339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAIGhiYeDq7Tx6oY+POG21xoISs/YYbSyeHtj9qf2S8=;
 b=DpX1UGrskRdqNUsMDRjf/FJZmzbOO6hPFXT10Zubpg9oCz6vWtktW2utRySI7YXxkv
 +cz1nJfgpXZqoqlzg0X7SjTZCrXoYHDB0JgPmkkBOqYjZ0pgGedAyVP7AWmwazO/URId
 DbnlrLoJGjjUJYNcw9shYHL5XioBe8/woWew9+uK5gj6BI1iUORulggHLEFJoAoyJHq9
 VXmBySE1MN1k470nD5PA0t+vRW4SbAH2agBwlsohtQWPQ0a1bOwYsFmVfpjQ7VjAkFfS
 v97VNhE6TdGF9AoJNGp8SICpFWW8LdkWlv64L8DCmgakaxjYZH6bSax/87pFCmnAUaWH
 wOyw==
X-Gm-Message-State: AOJu0YyV/9OikbuhN66OGPe1lgCs6/9SAUdbTMYB699HUoK02jWF0nES
 qxWYCJxcXE+9zDHLJNvUt5rwmw==
X-Google-Smtp-Source: AGHT+IHCOnpucJB+/RnRLK181dIaox+R3kPDRuQPb/nI5yWCk0wT5gQZNktYFBztaIM6FArvVMmeEw==
X-Received: by 2002:a05:6808:2002:b0:3a7:5d6e:dce9 with SMTP id
 q2-20020a056808200200b003a75d6edce9mr6085172oiw.23.1694677539053; 
 Thu, 14 Sep 2023 00:45:39 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z16-20020aa785d0000000b0068fb4f5f38fsm737296pfn.30.2023.09.14.00.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:45:38 -0700 (PDT)
Message-ID: <41679582-37d7-4753-a173-9ae64ad18f45@daynix.com>
Date: Thu, 14 Sep 2023 16:45:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] elf2dmp: introduce merging of physical memory runs
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor.prutyanov@phystech.edu
References: <20230913224657.11606-1-viktor@daynix.com>
 <20230913224657.11606-4-viktor@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230913224657.11606-4-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/14 7:46, Viktor Prutyanov wrote:
> DMP supports 42 physical memory runs at most. So, merge adjacent
> physical memory ranges from QEMU ELF when possible to minimize total
> number of runs.
> 
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>   contrib/elf2dmp/main.c | 56 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index b7e3930164..9ef5cfcd23 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -20,6 +20,7 @@
>   #define PE_NAME     "ntoskrnl.exe"
>   
>   #define INITIAL_MXCSR   0x1f80
> +#define MAX_NUMBER_OF_RUNS  42
>   
>   typedef struct idt_desc {
>       uint16_t offset1;   /* offset bits 0..15 */
> @@ -234,6 +235,42 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>       return 1;
>   }
>   
> +static void try_merge_runs(struct pa_space *ps,
> +        WinDumpPhyMemDesc64 *PhysicalMemoryBlock)
> +{
> +    unsigned int merge_cnt = 0, run_idx = 0;
> +
> +    PhysicalMemoryBlock->NumberOfRuns = 0;
> +
> +    for (unsigned int idx = 0; idx < ps->block_nr; idx++) {
> +        struct pa_block *blk = ps->block + idx;
> +        struct pa_block *next = blk + 1;
> +
> +        PhysicalMemoryBlock->NumberOfPages += blk->size / ELF2DMP_PAGE_SIZE;
> +
> +        if (idx + 1 != ps->block_nr && blk->paddr + blk->size == next->paddr) {
> +            printf("Block #%u 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be "
> +                    "merged\n", idx, blk->paddr, blk->size, merge_cnt);
> +            merge_cnt++;
> +        } else {
> +            struct pa_block *first_merged = blk - merge_cnt;
> +
> +            printf("Block #%u 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be "
> +                    "merged to 0x%"PRIx64"+:0x%"PRIx64" and saved as run #%u\n",
> +                    idx, blk->paddr, blk->size, merge_cnt, first_merged->paddr,
> +                    blk->paddr + blk->size - first_merged->paddr, run_idx);
> +            PhysicalMemoryBlock->Run[run_idx] = (WinDumpPhyMemRun64) {
> +                .BasePage = first_merged->paddr / ELF2DMP_PAGE_SIZE,
> +                .PageCount = (blk->paddr + blk->size - first_merged->paddr) /
> +                        ELF2DMP_PAGE_SIZE,
> +            };
> +            PhysicalMemoryBlock->NumberOfRuns++;
> +            run_idx++;
> +            merge_cnt = 0;
> +        }
> +    }
> +}
> +
>   static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
>           struct va_space *vs, uint64_t KdDebuggerDataBlock,
>           KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock, int nr_cpus)
> @@ -244,7 +281,6 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
>               KUSD_OFFSET_PRODUCT_TYPE);
>       DBGKD_GET_VERSION64 kvb;
>       WinDumpHeader64 h;
> -    size_t i;
>   
>       QEMU_BUILD_BUG_ON(KUSD_OFFSET_SUITE_MASK >= ELF2DMP_PAGE_SIZE);
>       QEMU_BUILD_BUG_ON(KUSD_OFFSET_PRODUCT_TYPE >= ELF2DMP_PAGE_SIZE);
> @@ -282,13 +318,17 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
>           .RequiredDumpSpace = sizeof(h),
>       };
>   
> -    for (i = 0; i < ps->block_nr; i++) {
> -        h.PhysicalMemoryBlock.NumberOfPages +=
> -                ps->block[i].size / ELF2DMP_PAGE_SIZE;
> -        h.PhysicalMemoryBlock.Run[i] = (WinDumpPhyMemRun64) {
> -            .BasePage = ps->block[i].paddr / ELF2DMP_PAGE_SIZE,
> -            .PageCount = ps->block[i].size / ELF2DMP_PAGE_SIZE,
> -        };
> +    if (h.PhysicalMemoryBlock.NumberOfRuns <= MAX_NUMBER_OF_RUNS) {
> +        for (unsigned int idx = 0; idx < ps->block_nr; idx++) {

I suggest keep it size_t since that's the type of ps->block_nr. It's 
somewhat annoying typing something long like "unsigned int" too.

