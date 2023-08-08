Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D3774544
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRbk-0008Gc-7W; Tue, 08 Aug 2023 14:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRbb-0008G1-49
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:38:56 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRbZ-0002O8-5O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:38:54 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564af0ac494so3162486a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691519931; x=1692124731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vtktZB13xoKrlStN8iJCJzK3lfp0Pe1SkT9ZNhwBTSs=;
 b=xdqAPyqlTOWlKa8fZq9InF1EdZ8drktB2o/7z5oJodiG0DHTAJlhCqraR7e+oOqiTN
 0euJK/kYs1yA9mMj8RbHFkrsDuc1V2MfsGL93rqgi6WxAx5dtAttXV/9GK7Sgwq+bsEr
 +xAafDFiG4AXW7GFhpL/yN17js4JqwW5fq0NWLtxIMHdC+QqRVkk8Z+p0btAmYi4gznA
 g3RNudw/yNYcsTPf97XS9iHO8htFJUsvzdo7O7gM4caCu32ocBEt+SD6aiU9EdCnA0oK
 D4uowLvGFHl/YqIXKTlIJN/4rVUBdF4/BNjNUGOC2oQofzwSkjVZWgw3COYVEPrwcEow
 8uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519931; x=1692124731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vtktZB13xoKrlStN8iJCJzK3lfp0Pe1SkT9ZNhwBTSs=;
 b=RBTJ6QC+tZ13cwihdUHNeuGpr43lSd9ICYhyg4BXs85VB6HSAbkHQZ5L8UabAhA6tY
 8FiCiMuPkNv1PgMigDGFkU1MHckiFEmr927AOQJp4zUwmpdeSr3moXJZi7bWOwZKBzYs
 6mGtftg0TJhxFfSONkelEbzKys+NEIhH9scMtL3VDL7YFyycOGjBKThQLb01K0sordGT
 9v2nylDLq1k7UNzooQpKn2unKrRxUkutAAUsjnAhU4itybmGqXrvaC4BM01dSLCYaVZf
 Wlkwt4ET+V1Qs7JLj8QnoV7Pr9agMuX0IMfqVKixdp/h7sdS3QJLSLxRhho/HfdBPHba
 nifg==
X-Gm-Message-State: AOJu0Yyq4ICRA2tFaGntDuXtOEoJIS0rNg7h0tWmLAgP+T269HfzrzLX
 njxOo4NvOVt/y8GE0M+qKETB3F4u8IoumRbTpz0=
X-Google-Smtp-Source: AGHT+IEyVwq/fNrgcEctzTmbb750FmMyflcHlzOf43JzbCsl8mTIlODBWZtz4KlecdAmpQWFI4rRKQ==
X-Received: by 2002:a05:6a00:a88:b0:668:753a:b150 with SMTP id
 b8-20020a056a000a8800b00668753ab150mr350116pfl.21.1691519931584; 
 Tue, 08 Aug 2023 11:38:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 s8-20020aa78d48000000b006873aa079aasm8722983pfe.171.2023.08.08.11.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:38:51 -0700 (PDT)
Message-ID: <99d63fb7-13de-3484-26c0-7aeed48199ab@linaro.org>
Date: Tue, 8 Aug 2023 11:38:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/11] target/loongarch: Support LoongArch32 VPPN
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-7-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-7-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> VPPN of TLBEHI/TLBREHI is limited to 19 bits in LA32.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  6 ++++--
>   target/loongarch/tlb_helper.c | 23 ++++++++++++++++++-----
>   2 files changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

