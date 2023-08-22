Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FF7845B6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTRj-0000DB-EI; Tue, 22 Aug 2023 11:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTRh-0000CX-9Z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:37:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTRd-0007hJ-Eq
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:37:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a3cae6d94so2448076b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692718643; x=1693323443;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M534qQaEc9m5jA3K9/U30AvUN+6T2Qs53I2CCwZsWbk=;
 b=rVURhJnt1xL48uxnRHIXVc5vvPMg6PbNYzWMmUwXltThuQjV1mo+v/wLzHDM9uFCjC
 yOA23fQFjpDr0z9FdeDJwXdVDUHSCNXIraXl20TBIL/ebabZh39E2ZYGx/7HTH2Lcclq
 VsgZBiuEFwU3NQhdc9cvZA+ezAt7K6IYWw9nxStlLU6Kr880mVAp3dnYfMtjWoRTQo34
 MFsnJKmRCvFb+5XtAVlwCmMHSBG6nu0JbziEQ90Qq36MASwXSekr62WEjkv3WN84h+Cm
 Y580L+kKJdgffzyQLBfbEPpdpSOP3Rz4Jmxc5+Rb1qA7+5dN9+1tTZC0jzaijLk25RE+
 puhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692718643; x=1693323443;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M534qQaEc9m5jA3K9/U30AvUN+6T2Qs53I2CCwZsWbk=;
 b=PTmJEk9m7+bjI5EvPb/dN8IR3qBNbfhcyIX8dIajedmkWIGbozNs0socKbvPy5cSMy
 nLhDFBKcCDHK6mX7BkyEFjeJPyeJMzOQfha5LZnPIeHCexYIiQwEYQYJ0NPI2mzuJAWC
 QAhJamQIaBZyH3ocxImVW3A8ceZPMAg+/ci3kCDaEv2dEsQKRkwwiUKqiGnGqkEBJwrg
 gNaFlMN+stODfAI5Gq8ZEwpzHKr27cEuZ4iZyi+jsi1PLXhEHG4sgsqfj0DDuUxmTjis
 XydaetVKOSd9gCRSe2fM+rNyfTc4/wLgKyBQxQokWl2EICKSNMys8XPknVllTolxk5jA
 wNJA==
X-Gm-Message-State: AOJu0YxWvvEXOPfFPjwE9JSg5BDyfbk+mwOboiJOAyBK3S9JMjxynwB9
 eoAUW/f4uZDQdY+QnBKM1j1NDA==
X-Google-Smtp-Source: AGHT+IF5CxcgQw8RA2OVCMID+iIhfqfXHL1jFaK49zuTAkJ6VWFZ5l2wMVTr63L/Rya4OBdEoq+eQg==
X-Received: by 2002:a05:6a00:150a:b0:68a:6d1a:b812 with SMTP id
 q10-20020a056a00150a00b0068a6d1ab812mr2592100pfu.9.1692718643291; 
 Tue, 22 Aug 2023 08:37:23 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 y4-20020aa78544000000b006862b2a6b0dsm8153833pfn.15.2023.08.22.08.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 08:37:22 -0700 (PDT)
Message-ID: <6b2a9e7c-0a79-4a05-fdbd-0a6d4e23d454@linaro.org>
Date: Tue, 22 Aug 2023 08:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/12] tcg: Factor hrev{32,64}_{i32,i64,tl} out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/22/23 05:40, Philippe Mathieu-Daudé wrote:
> This series factor the "byteswap each halfword within a
> 32/64-bit value" code duplication as generic helpers.
> 
> Modulo the documentation added, there is a good negative
> diff-stat, so I believe this is a win from a maintainance
> point of view.
> 
> I used "hrev" to follow the other bswap/hswap/rev helpers
> but it isn't very descriptive, so any better name suggestion
> is welcomed.
> (In particular because there are other patterns I'd like to
> factor out and then naming is getting worse, such 'wrev').'

I applaud the code factor, but the names are poor.

The "h" does not match the size of the elements being swapped, which is "b".  The "32" 
is... what, the total count of bits modified?

Naming is hard, and I'm not sure what's best.

We have bswap32_i32, bswap32_i64, bswap64_i64.

Perhaps bswap16x2_i32, bswap16x4_i64, bswap16xN_tl, to indicate that we're bswaping 16-bit 
quantities, and "xN" to indicate that multiple 16-bit quantities are being swapped.

 From your subjects, it would appear we don't need bswap16x2_i64, with the upper 32-bits 
zero/signed/undefined.  But if we did, we should provide a flags argument of TCG_BSWAP_*.

That then extends to hswap32x2_i64 to swap halfwords within multiple words for mips DSHW 
et al.


r~

