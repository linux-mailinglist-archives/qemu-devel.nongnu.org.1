Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C571FE82
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51cn-0004h3-HT; Fri, 02 Jun 2023 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51cg-0004gj-Iq
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:03:06 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51ce-0008Rj-7V
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:03:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so1839109f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685700182; x=1688292182;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgDMVkJdQsB/Lqw/BOaMVIiTBPLCQEKa7auwTuRpDiQ=;
 b=M+7IEynzVkR/CUTn0pv867mosbnitCvpWSblTa6e3dMj8hx8UbDAbruH9qHC1OqIdT
 omUZ6wh/nyNwuvLhnlsVI7KzdFH7fltPjn44lm4M4WvR81uUZsIVAGRpp2dlOKNV3wZj
 wKzPbOVFM2RoLAJLRKg4QgxyPoy4kOeB//f2dy/9jCKWp+LL6vgtuPu6tMujAXen/OIt
 PVAX/pJfIiRebYckF4e7uwirGGnMnWOchQGtyzfiOc0gOXYtdjDRQnfhHywSV+86YViC
 P0RuDi5KzbCxaAbDmh2z/foNBv6oUVitr8yz91+bcFNJLHm8+Gi5790tlwi/nqFnE5GC
 n+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685700182; x=1688292182;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgDMVkJdQsB/Lqw/BOaMVIiTBPLCQEKa7auwTuRpDiQ=;
 b=HHykljOkBckFvwUNcRV5kg4bNnXjB7bnK6H05rzXslOx22kapmIMWMUcxiHPcYtJ8j
 NL9WMdYhaeXSMIjJ3K/0JNwpAezt00ZvZpOA0p6bCOO22ysLsnqjg5Q5UwxEPKLi5C2X
 UswykyX2p8tJn3vCBbgCcqZcSzIf3at3rG7TT6wSzXF5NNPNiJ7XCyjqY3HWPn1XmOSN
 Wc9BSZ61b3L+/TEbQCjPvGzJwaP3OV6KGuEJmsuUyVfEJwkTXvB75yqUDWigu7ekBywH
 u4uct8vjJYFdSCNQ2lVnJh0rekVzCKOanB6CPXlaRVs/eegw2dnqBdRh1kPY0AaJbHCO
 iTQg==
X-Gm-Message-State: AC+VfDzJJfAXmBTGrDWzy7ERmyCirlC1pHKclPAF+Nl4WjHrrQ3MTayq
 PI+PCNkCa6pCcghMS0yQi5rDJQ==
X-Google-Smtp-Source: ACHHUZ5KqmJicZlxhA+WOJJRJn/YYJDCNnBvAntxNbd4+oNQOlOvadWFKoUo3wpHkus5dBCd6anIyg==
X-Received: by 2002:adf:ea89:0:b0:30a:e3d6:fcac with SMTP id
 s9-20020adfea89000000b0030ae3d6fcacmr3886423wrm.19.1685700182079; 
 Fri, 02 Jun 2023 03:03:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a5d574a000000b003047d5b8817sm1215116wrw.80.2023.06.02.03.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 03:03:01 -0700 (PDT)
Message-ID: <01ba1219-49f4-4eef-ad1b-226a7f647ffe@linaro.org>
Date: Fri, 2 Jun 2023 12:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 30/48] exec-all: Widen tb_page_addr_t for user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
In-Reply-To: <20230531040330.8950-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> This is a step toward making TranslationBlock agnostic
> to the address size of the guest.

My understanding is tb_page_addr_t is QEMU internal, not exposed
to the guest, thus abi_ulong isn't required. It was a tiny memory
optimization we could do when abi_ulong is 32-bit. Therefore we
can widen the type, unifying/simplifying TB management on the host.
Is that correct? The patch is fine/safe but I'd like to correctly
understand :) Meanwhile:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 4d2b151986..0d00541aca 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -31,8 +31,8 @@
>      addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
>      type.  */
>   #if defined(CONFIG_USER_ONLY)
> -typedef abi_ulong tb_page_addr_t;
> -#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
> +typedef vaddr tb_page_addr_t;
> +#define TB_PAGE_ADDR_FMT "%" VADDR_PRIx
>   #else
>   typedef ram_addr_t tb_page_addr_t;
>   #define TB_PAGE_ADDR_FMT RAM_ADDR_FMT


