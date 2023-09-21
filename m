Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCE7A9577
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLO3-0002nq-LA; Thu, 21 Sep 2023 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLO1-0002ln-1U
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:14:37 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLNz-0005Xq-6R
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:14:36 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bff7d81b5eso18515641fa.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695309273; x=1695914073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LTkT6MJgSe8XK1jxPttFg6x9XlObEk+2fLAgBAsEyCo=;
 b=CBFUDIDaUQ/li2mTh+4pbiL+B6CFEYxbE62KlyfI67Oe7x+0/wsrX/vXZVCJxZor92
 /HdrLzjFaxsv4/cHuZtcZhKBYPkj7Sk0i1BuSxcBXzrgEEdFVB1mp4ZKxjFZDbT3CRX+
 Bmyt/p9iYc5Ubum6MNNcuLYrUL3Fhl9rYj7PAkArlyMJmk0o9q4OMZ1RRB29XVw5ZgoQ
 gX5R3JvGhi4wjU5xmcDpheFHXd7gqKsXnlC7TAYuf4EkNz5LxBddA9qJHBquv2f/yzaI
 ql1DB8AmwYtCeYngH8mZAezWqTMjHT4UloaVJLl10tofKXyzllXp6geZY65MyWCyt9HU
 xIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695309273; x=1695914073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTkT6MJgSe8XK1jxPttFg6x9XlObEk+2fLAgBAsEyCo=;
 b=n61TiBWfzq7tAyI0M9XX3uZ4njMChFpgJz2Z10HGyBN9a2YHq4iG54im8yYurxIbqt
 NFGxHFXeIFCZv8rOFwKuiXzG89w1xAuSFPdno0asGvqaHU2En6+yxuP1rNFBTDla/JKw
 v5wStzPJNUTiy/x3J/Nmz0eD1N7JCUYUe5mkHpPCcNxKZwJPGyocyQpcu+kOBzdJyUID
 /iEqKvne1pdSLnNqoOCfaZ2i/63Wu2e3eB0rPkKjSJDDmhYiEs0JM12BYM5pmcBXiz3L
 BEPWZTAJAQJcFkB82CVY5E+IKXGtbMtTWbk0AX8NP3OVYdOo+BYoOQRA86DONrbWjWck
 b3jw==
X-Gm-Message-State: AOJu0Yzbbr2W3kk49xCf6PYJLmWJD2Ahh4BhYILorgG6ihKRBLoq8+lB
 1cIKy4HsdUSOjkiaY7MrFlfKVS2aV9Z/aS595BSNwQ==
X-Google-Smtp-Source: AGHT+IHx4e4SGIGDn6QFAM6Ohl1Zju1Hy1Hp6vJv/sLb/nk+4VohoU1X4bgPFT1aAsx4kurzI513wChbj8u2nouS9So=
X-Received: by 2002:a19:6745:0:b0:500:98ff:4162 with SMTP id
 e5-20020a196745000000b0050098ff4162mr5089887lfj.40.1695309272908; Thu, 21 Sep
 2023 08:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170153.10959-1-viktor@daynix.com>
 <20230915170153.10959-4-viktor@daynix.com>
In-Reply-To: <20230915170153.10959-4-viktor@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2023 16:14:14 +0100
Message-ID: <CAFEAcA9mGj4xRj_pC9qDUPofnfZah8ejt7zZtLaMyYR+kytpJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] elf2dmp: introduce merging of physical memory runs
To: Viktor Prutyanov <viktor@daynix.com>
Cc: annie.li@oracle.com, akihiko.odaki@daynix.com, kkostiuk@redhat.com, 
 qemu-devel@nongnu.org, yan@daynix.com, viktor.prutyanov@phystech.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 15 Sept 2023 at 18:02, Viktor Prutyanov <viktor@daynix.com> wrote:
>
> DMP supports 42 physical memory runs at most. So, merge adjacent
> physical memory ranges from QEMU ELF when possible to minimize total
> number of runs.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>  contrib/elf2dmp/main.c | 56 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index b7e3930164..b4683575fd 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -20,6 +20,7 @@
>  #define PE_NAME     "ntoskrnl.exe"
>
>  #define INITIAL_MXCSR   0x1f80
> +#define MAX_NUMBER_OF_RUNS  42
>
>  typedef struct idt_desc {
>      uint16_t offset1;   /* offset bits 0..15 */
> @@ -234,6 +235,42 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>      return 1;
>  }
>
> +static void try_merge_runs(struct pa_space *ps,
> +        WinDumpPhyMemDesc64 *PhysicalMemoryBlock)
> +{
> +    unsigned int merge_cnt = 0, run_idx = 0;
> +
> +    PhysicalMemoryBlock->NumberOfRuns = 0;
> +
> +    for (size_t idx = 0; idx < ps->block_nr; idx++) {
> +        struct pa_block *blk = ps->block + idx;
> +        struct pa_block *next = blk + 1;
> +
> +        PhysicalMemoryBlock->NumberOfPages += blk->size / ELF2DMP_PAGE_SIZE;
> +
> +        if (idx + 1 != ps->block_nr && blk->paddr + blk->size == next->paddr) {
> +            printf("Block #%lu 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be"
> +                    " merged\n", idx, blk->paddr, blk->size, merge_cnt);
> +            merge_cnt++;
> +        } else {
> +            struct pa_block *first_merged = blk - merge_cnt;
> +
> +            printf("Block #%lu 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be"
> +                    " merged to 0x%"PRIx64"+:0x%"PRIx64" (run #%u)\n",
> +                    idx, blk->paddr, blk->size, merge_cnt, first_merged->paddr,
> +                    blk->paddr + blk->size - first_merged->paddr, run_idx);
> +            PhysicalMemoryBlock->Run[run_idx] = (WinDumpPhyMemRun64) {
> +                .BasePage = first_merged->paddr / ELF2DMP_PAGE_SIZE,
> +                .PageCount = (blk->paddr + blk->size - first_merged->paddr) /
> +                        ELF2DMP_PAGE_SIZE,
> +            };

Hi; this fails to build on 32-bit hosts because in both these printf()
statements the format string uses "%lu" to print a size_t. This
doesn't work if size_t is not a 'long'. The right format operator is "%zu".

I have squashed in the relevant change to this patch in target-arm.next.

thanks
-- PMM

