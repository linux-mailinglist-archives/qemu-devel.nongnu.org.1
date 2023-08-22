Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF26784819
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUjI-000673-Uq; Tue, 22 Aug 2023 12:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUjG-00065C-NV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:59:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUjE-0001gk-Ht
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:59:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso1555272f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723579; x=1693328379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5EiyOtjkFWhEXmiGZr2TZhRa6ZUbgBpd7EpYLC+TAA=;
 b=VPzUTKNfBWfGS0WRi8vhpOFf3PfpG3maRNIc8zfMJ+kyJBj1v7mM9DaUVgXIgoQVJ1
 CXZ2LzxGS+Ho5+NljxydLuls+lWFciKeBWpldLMkUr86Nb8kBqYgQsLHsjUppHPIG48C
 stcNY+z2Tv/grtOWmY8udHV0UWlQEcX6S2x9l+4bV7GXwkPLsWwh0eHZuAjejDvXm5NC
 W36kMCflXLz4FSzu3aX6kMiFhlQ26X/jxz5IONJZ53mfkCFrelTG1SX+McFVwbSzppTI
 l052QfqFYQ/7upTBiYZVM04QafY2j3+9r6Wr3A37NMK2aoPkpMR2MT6cgwfap61YaOzH
 CLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723579; x=1693328379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5EiyOtjkFWhEXmiGZr2TZhRa6ZUbgBpd7EpYLC+TAA=;
 b=SlKWSV2yvAcolYTwGwN7X6UhhZzTbdZ2DO05xgFP1OvyGltMAbWlORPH89UT+DeXXN
 n0sGSUcmkG3oBpf1YZ1NotbVZmpQIj8Nm0VSM+xcbUZBLsQJvcYOX8DwbrA+RKlWmrJX
 0g7IMTVLmukx3CKrMymTU1NQLbvd9UiaUm4Cu4f1ylbirooNwQcUvTRd3YO548ZF1ZPQ
 iZWWNn058PAOIMZ1kCIChhLXew2It8m6QYkhEXWsShEYRurG8Ts2rFSZjm7gMa0zTtW5
 kdmd36fzKbDazNmVCrsXgr0yfFtDl2TWmQUPpaSvjkdOnrDG3Yia5TxuH9DO5iz98GO/
 dcCg==
X-Gm-Message-State: AOJu0YyJujQNglpH9YOGgbtNazRnAl0msJccKKhSC7gSr1foiw5pLNe1
 ykmXBayLDNpnI6CaV/myzaoOcQ==
X-Google-Smtp-Source: AGHT+IFIBIXniLz9pzUy76vtENudHK/ZEFICtWjl1orQD680RNu0Mn9U0TKHaQZaulLeXj5ZjZdBiQ==
X-Received: by 2002:a5d:65c5:0:b0:319:7c07:87bf with SMTP id
 e5-20020a5d65c5000000b003197c0787bfmr8333644wrw.53.1692723578856; 
 Tue, 22 Aug 2023 09:59:38 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0031773a8e5c4sm16353831wrm.37.2023.08.22.09.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:59:38 -0700 (PDT)
Message-ID: <0e9b1e40-801f-c7cb-97f6-e75a98bd9545@linaro.org>
Date: Tue, 22 Aug 2023 18:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 12/12] target/mips: Use generic hrev32_tl() in WSBH opcode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Greg Kurz <groug@kaod.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125752.55328-2-philmd@linaro.org>
 <14386aa6-8e00-8792-ba7d-9d93c3c35baf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <14386aa6-8e00-8792-ba7d-9d93c3c35baf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 17:42, Richard Henderson wrote:
> On 8/22/23 05:57, Philippe Mathieu-Daudé wrote:
>> -        {
>> -            TCGv t1 = tcg_temp_new();
>> -            TCGv t2 = tcg_constant_tl(0x00FF00FF);
>> -
>> -            tcg_gen_shri_tl(t1, t0, 8);
>> -            tcg_gen_and_tl(t1, t1, t2);
>> -            tcg_gen_and_tl(t0, t0, t2);
>> -            tcg_gen_shli_tl(t0, t0, 8);
>> -            tcg_gen_or_tl(t0, t0, t1);
>> -            tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
>> -        }
>> +        tcg_gen_hrev32_tl(t0, t0);
>> +        tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
> 
> Ah, you did want tcg_gen_bswap16x2_tl(dst, src, TCG_BSWAP_OS).

Got it (per your reply to the cover).

> 
> 
> r~


