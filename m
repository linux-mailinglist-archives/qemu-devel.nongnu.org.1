Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE42754245
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNEa-0002GN-6B; Fri, 14 Jul 2023 14:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKNEX-0002FF-SP
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:09:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKNEV-00071X-T5
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:09:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so20340695e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689358173; x=1691950173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7hRX7yIRumaNqYIhrBSgFxeo9ia0Newp5mGl6sDwp+4=;
 b=MGxGM0A56xveukq80In9QSYxTLu0wGK4O/VzGhROAvvLQN7MPb3f/o7Bj4SzxMEN0p
 FPQybEZtZN/h7zm0Kn5nI5OBNlTn4HbavtWU0jp4PwJoi2ht4Z1rQuf/1/UahPfuxMCW
 B6fiWSfITaon9VPcOSluKYihbmt5kiZtaFive5MBFAaJLAaLc1OeZMwW5BteRNd5KdZA
 O9fpcrFkw++D6bL4EstUcms8ngt8VXudSpufmR28ehflYr//YqW789cUS5D/UAnB7By1
 AKp54BeNDL7Tv9qlAZTYmFcvxdLt2ZwjwWIa9W378XAspfbzB6nPWHILDFU3K81hCKRQ
 zHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689358173; x=1691950173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7hRX7yIRumaNqYIhrBSgFxeo9ia0Newp5mGl6sDwp+4=;
 b=ji/N7pYuPi72PXnRuQp0moyOvTJTWRVPGNKbR6S4LAkJotf5AcjZWa+TO6zeb3mfez
 JnqeOm37/2dCZb1zejC0lsIE3qUA96yZhIx1XrSibAsEBhOGDSGJ5YRAvxd93gdavGoa
 n/P2MH0RCQKXvACzWuq9eoUl0v0+rF5TsF+uutZieM8ASPZNJPnBLjH6rl1Y4JHvsvW7
 i5Xf91+ri+bCEnkmqHUEDcy6Udtxo3OGVEXaydNIaEXxK36BGlKkK64ZHIcwMDpPKdkA
 bSsQ9FFWUHczDgm9H2Ou/Fw+NZ7sY4i34vs5++d7m9IK2HRptf2zEP3WKOt+5Zn2oqby
 yZJA==
X-Gm-Message-State: ABy/qLY78nUEu4zWiSWQ+n7J/mpDASkMY8TEZHt/TOL3oRdWIEOMTXmb
 6FX0uDgiaaY8WAqyw5ux10lY3w==
X-Google-Smtp-Source: APBJJlGvQWiZcV3hRtc9vJXc0PkHDeTKgk7B0FN67z5etJ110ChUJHyWGIA4KUN7kaGcqFj4htvo1g==
X-Received: by 2002:adf:e583:0:b0:314:1a98:ebbb with SMTP id
 l3-20020adfe583000000b003141a98ebbbmr4636022wrm.21.1689358173476; 
 Fri, 14 Jul 2023 11:09:33 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d6752000000b0031434cebcd8sm11445988wrw.33.2023.07.14.11.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 11:09:33 -0700 (PDT)
Message-ID: <598f26c9-af6f-f289-e4a8-5a8f5f3a3db6@linaro.org>
Date: Fri, 14 Jul 2023 20:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] plugins: Set final instruction count in plugin_gen_tb_end
Content-Language: en-US
To: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CADc=-s4Ef9eBV7Z6FKYRT=-5c733ZHQRjvnumV5OwjJh8uFmmA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CADc=-s4Ef9eBV7Z6FKYRT=-5c733ZHQRjvnumV5OwjJh8uFmmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Matt,

On 14/7/23 06:18, Matt Borgerson wrote:
> Translation logic may partially decode an instruction, then abort and
> remove the instruction from the TB. This can happen for example when an
> instruction spans two pages. In this case, plugins may get an incorrect
> result when calling qemu_plugin_tb_n_insns to query for the number of
> instructions in the TB. This patch updates plugin_gen_tb_end to set the
> final instruction count.
> 
> Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> ---
>   accel/tcg/plugin-gen.c    | 5 ++++-
>   accel/tcg/translator.c    | 2 +-
>   include/exec/plugin-gen.h | 4 ++--
>   3 files changed, 7 insertions(+), 4 deletions(-)


> diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> index 52828781bc..4feaa47b08 100644
> --- a/include/exec/plugin-gen.h
> +++ b/include/exec/plugin-gen.h
> @@ -20,7 +20,7 @@ struct DisasContextBase;
> 
>   bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
>                            bool supress);
> -void plugin_gen_tb_end(CPUState *cpu);
> +void plugin_gen_tb_end(CPUState *cpu, int num_insns);

num_insns is a 'size_t'.

