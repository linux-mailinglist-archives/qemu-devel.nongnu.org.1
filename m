Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C97C83705C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:44:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzG5-0005r7-Tf; Mon, 22 Jan 2024 13:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRzG2-0005qz-FS
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:42:54 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRzFy-0006lO-LJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:42:53 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55a349cf29cso3997367a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705948968; x=1706553768; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P/MqoP5uP96UGBIc53wscvaBiG6AgEHe2FhRhTvSoaQ=;
 b=U3qijrcHKhvZxw182E0F68FoQPbEEmxAMkyWF71WewvqrvxVttHJsu5jt3DDi0nDfZ
 7OVWUT5a5nwoCFu9crgWTk8+7gVDOi4sMTFvnHnBNE68CSAF8thDNMZ2VFaHX8R3bYe6
 sARxr6digaZ3GewCwzdr+pT4oDWRkb/YMbON/+E/IxZRn9IIKJMjIm+kuJNoRKnll7xf
 iv1RMd0VO1hgnhfBHbHwdyo6zgmbkR83G34ah4J6clTlmvIHnXuuh2/IvNlGbWaVvYFk
 3ggNVBZ82ooh51PCdpmGfATEbo3JLh0RRyy+iYuYb/VIvcJLKjY0yNCZWse7/rLOuYlN
 8bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705948968; x=1706553768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/MqoP5uP96UGBIc53wscvaBiG6AgEHe2FhRhTvSoaQ=;
 b=tJ6xjnrxsg4TO/TbwHpE4hKVsmiHibXGc9+IEt67sV8LKKMGUFVpWqeDISlTZos402
 Jfqz8/INqsdFelfQSe/9s4sa7FueQXeFz5JYK8oIbFizTvYWqN+3j2VylIFL2s6M+P+F
 UNGeb+iJlvwGJYO4OdvhYAV3oP6lW9eWDMMvS2u8aOrzd+Tp0xEYm/4c9Yx743eMDMDr
 +DLoLVIGPlEOYNpoGvRP4FCAYmMSHpXp8203jV5ZPzV2nuGqCy96tjLLTFjzqzWkAv2k
 JUojjema11rralFcBEz1SAeH0C40zST/1co6+J4uLSdmSHw+6mfuo2qz1Mkk3bHkTn+f
 BJ0g==
X-Gm-Message-State: AOJu0YzqEgEfwbrAsjvE5HPBZTgdFhQ/BrQd1PVUKNtTjkYHAClP+d7D
 np92D0P9nhHXGcVloJEhxdSibydzGBzQciMsORvCOj9nLU7NuNDXLxvNCu/dh4dK2AsI/thILtt
 xVoVTv3zkzXUyk4mn5p0qlS7LdF5Ke+bgoyTPUA==
X-Google-Smtp-Source: AGHT+IGLNi2MV2OsedboThZTmfwG+Sc9Icr5OtdITxTEUvAU06DUaaq0ta/YUmtg4lLpRsNrPat2KzXu+71fqEKAmbI=
X-Received: by 2002:aa7:c60e:0:b0:55a:4959:a2e4 with SMTP id
 h14-20020aa7c60e000000b0055a4959a2e4mr200573edq.52.1705948968508; Mon, 22 Jan
 2024 10:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
 <20240119204608.779541-3-jcmvbkbc@gmail.com>
In-Reply-To: <20240119204608.779541-3-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 18:42:37 +0000
Message-ID: <CAFEAcA_OvQzJV5knmS6qyK=XoZYBcqWNu29nSqBcgzy4G2ebBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/xtensa: tidy TLB way variability logic
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 19 Jan 2024 at 20:47, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Whether TLB ways 5 and 6 are variable is not a property of the TLB
> instance or a TLB entry instance, it's a property of the xtensa core
> configuration.
> Remove 'varway56' field from the xtensa_tlb structure and remove
> 'variable' field from the xtensa_tlb_entry structure. Add
> 'tlb_variable_way' array to the XtensaConfig and use it instead of
> removed fields.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/cpu.h          |  3 +--
>  target/xtensa/mmu_helper.c   | 38 ++++++++++--------------------------
>  target/xtensa/overlay_tool.h | 15 ++++++++++++--
>  3 files changed, 24 insertions(+), 32 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 497325466397..24d3f15ea1bf 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -316,13 +316,11 @@ typedef struct xtensa_tlb_entry {
>      uint32_t paddr;
>      uint8_t asid;
>      uint8_t attr;
> -    bool variable;
>  } xtensa_tlb_entry;
>
>  typedef struct xtensa_tlb {
>      unsigned nways;
>      const unsigned way_size[10];
> -    bool varway56;
>      unsigned nrefillentries;
>  } xtensa_tlb;
>
> @@ -493,6 +491,7 @@ typedef struct XtensaConfig {
>
>      xtensa_tlb itlb;
>      xtensa_tlb dtlb;
> +    bool tlb_variable_way[16];
>
>      uint32_t mpu_align;
>      unsigned n_mpu_fg_segments;
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index d9f845e7fb6f..414c2f5ef669 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -105,23 +105,19 @@ static uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
>                                           bool dtlb, uint32_t way)
>  {
>      if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
> -        bool varway56 = dtlb ?
> -            env->config->dtlb.varway56 :
> -            env->config->itlb.varway56;
> -
>          switch (way) {
>          case 4:
>              return 0xfff00000 << get_page_size(env, dtlb, way) * 2;
>
>          case 5:
> -            if (varway56) {
> +            if (env->config->tlb_variable_way[5]) {
>                  return 0xf8000000 << get_page_size(env, dtlb, way);
>              } else {
>                  return 0xf8000000;
>              }
>
>          case 6:
> -            if (varway56) {
> +            if (env->config->tlb_variable_way[6]) {
>                  return 0xf0000000 << (1 - get_page_size(env, dtlb, way));
>              } else {
>                  return 0xf0000000;

So we now have a tlb_variable_way bool for all 16 possible
ways, but the code actually only checks it for ways 5 and 6.
Should we have an assertion somewhere that the config
doesn't try to set it on ways where it has no effect ?
Or is there actually a generic behaviour that would make
sense for eg "way 3 is variable-way" that we just don't
currently implement?

> @@ -150,11 +146,8 @@ static uint32_t get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
>          return xtensa_tlb_get_addr_mask(env, dtlb, way) << 2;
>      } else if (way <= 6) {
>          uint32_t mask = xtensa_tlb_get_addr_mask(env, dtlb, way);
> -        bool varway56 = dtlb ?
> -            env->config->dtlb.varway56 :
> -            env->config->itlb.varway56;
>
> -        if (varway56) {
> +        if (env->config->tlb_variable_way[5]) {
>              return mask << (way == 5 ? 2 : 3);
>          } else {
>              return mask << 1;

This doesn't look right -- this branch of the if-else deals
with way == 5 and way == 6, but we're only looking at
tlb_variable_way[5].

> @@ -172,10 +165,6 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
>                                       bool dtlb, uint32_t *vpn,
>                                       uint32_t wi, uint32_t *ei)
>  {
> -    bool varway56 = dtlb ?
> -        env->config->dtlb.varway56 :
> -        env->config->itlb.varway56;
> -
>      if (!dtlb) {
>          wi &= 7;
>      }
> @@ -195,7 +184,7 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
>              break;
>
>          case 5:
> -            if (varway56) {
> +            if (env->config->tlb_variable_way[5]) {
>                  uint32_t eibase = 27 + get_page_size(env, dtlb, wi);
>                  *ei = (v >> eibase) & 0x3;
>              } else {
> @@ -204,7 +193,7 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
>              break;
>
>          case 6:
> -            if (varway56) {
> +            if (env->config->tlb_variable_way[6]) {
>                  uint32_t eibase = 29 - get_page_size(env, dtlb, wi);
>                  *ei = (v >> eibase) & 0x7;
>              } else {

There's no direct code duplication, but it definitely feels like
the logic for "figure out how many bits we're dealing with" is
duplicated across these three functions.

I think it ought to be possible to have a function (or maybe two)
which take account of both the way number and tlb_get_variable_way[]
such that all of these three functions then don't need to have
a switch on the way or look at tlb_variable_way[] themselves...

thanks
-- PMM

