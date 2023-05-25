Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD9710D17
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ar9-0007n3-G7; Thu, 25 May 2023 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Ar6-0007ZQ-Kc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:18:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Ar4-00028a-TV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:18:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso754812b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685020689; x=1687612689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N+p+ZJAQtDR8XfmnUBNYetcXF4C9Wm+xwp2UcFDR9hM=;
 b=DPPYSsgQlcEJHknO6C+jrzuQohw/DFTDG+jgwbsuQ7SfF68ua5ppomgfsfJQOpgg4O
 znDxKBflY46f6cUqGPwNg9+Lp/UEAvqY2QNEHcYzvdcOn9NR8evyJRa+jTWDltpyd7P9
 oUQPtWWzVcFwmtiOkWbfbgCNxo/f4oBovd+mvYIfd1R+eULiA58tnu1ndoSL/v0zhJHR
 NJa8X73F+dUILihh+3LvFdQeSeVnss+uCeDTphU8915cOD5gXP6+CqKCoBCKr9vvW6qA
 b6/BE7R0w5uDQubge2xZHa+BOteY8K8gduvlJsX6ovD48YjhKpeJctBbck7mP5IQ6Uyd
 8abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020689; x=1687612689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N+p+ZJAQtDR8XfmnUBNYetcXF4C9Wm+xwp2UcFDR9hM=;
 b=PcZP59S72THv6+9DmggxVJYCS1MZ/ehIgfwM4g8n1NzZq5GcszIbfim6Aw0qk2PBja
 5meOKcgi4FJ0YU4DZBincK5+Q2XTCqMaXS72l700PzPEVLH8KGruTutVMEFbb5kfX833
 hgjcQBn7uAaN4KO/tid8SXkVtfUAyEjFIj4Ee7aidO1+F+sQYW2US/86xiXLhfhb2MsZ
 7dyi9BFDi9vzZlBHba4Y5aLZLltKvSNliTBQHUei4o7sVHpPX8Eq1pb91ggFbRdm+S/M
 NcHIf5df6VGBMrSol+pB2RqX/PgikTlfsUNkS+jsm0dN9QLBM75a7Nrbpr+3JDGLg3Jf
 OAfg==
X-Gm-Message-State: AC+VfDwQgeL51ZojEn2tv5gMZvOPycw+kF4FFxpQalu2WiyCq5Sbg2qw
 hJlHqYdFQ/Ho5fGbLq94li1B7w==
X-Google-Smtp-Source: ACHHUZ6+KYqlASGhhNuvAir1jhv5by/nso75tR4q4T7Hf0PqIj/nY7Q9Ibuvfp7E65RTA30zt8Qvew==
X-Received: by 2002:a05:6a00:99a:b0:645:834c:f521 with SMTP id
 u26-20020a056a00099a00b00645834cf521mr3822890pfg.17.1685020689456; 
 Thu, 25 May 2023 06:18:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 v5-20020aa78505000000b0063a04905379sm1176395pfn.137.2023.05.25.06.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:18:09 -0700 (PDT)
Message-ID: <8cea8ba1-7a7b-1e2a-3b4b-0100f4a5b9a5@linaro.org>
Date: Thu, 25 May 2023 06:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] target/loongarch: Fix the vinsgr2vr/vpickve2gr
 instructions cause system coredump
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, alex.bennee@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230525120005.2223413-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230525120005.2223413-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/25/23 05:00, Song Gao wrote:
> The vinsgr2vr/vpickve2gr instructions need use get_src/get_dst to get
> gpr registers value, not cpu_gpr[]. The $zero register does not
> have cpu_gpr[0] allocated.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1662
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_lsx.c.inc | 39 ++++++++++++++-------
>   1 file changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

