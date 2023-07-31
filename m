Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B721769277
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPcz-00014Q-49; Mon, 31 Jul 2023 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPcx-000142-Rf
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:55:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPcw-0001bo-0A
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:55:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so39858725e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690797344; x=1691402144;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aoMXw4h4TvqRmrl3qibfZ+jp6kVWk/NOhy2XayxgZXk=;
 b=ijeFLCV8ZcNir5smpuNRrTdIJTn665gMusQqnd5T38ot5RoeT9lTAGnPrOKMi/PhqS
 Lj7/LjxFWSdxwzCQtOZNdNq66zMYHhhE5NBwZ7ic+VgxXPGk6LDiKFaq9nGb81sINc0K
 0+b0rMKBJSv9BkVAGQX5Y8+x+6nWOXJv9FST8RJ9rGE9Ia5wmOLIlQgcRHnaQ0l8DSC5
 DcUbNz3/vsrpGAR+mIT4TpZP54bDkUMV9r7wJoTiYJ47CWJGgXr58BXiR3LuXQh5mUrT
 wBe83bJZA8vz5Ip0Xghzs+6zBvqZxPw4Mf8u1Z1SI5qdGBXICKTLgfkuDOYnCrtu7NSz
 zqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690797344; x=1691402144;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aoMXw4h4TvqRmrl3qibfZ+jp6kVWk/NOhy2XayxgZXk=;
 b=IRopBQxYqnvzx7Lgf4DOa8a8yOOcNWIV6sKkAXfqg8MPNgVWuHKchHu48lbLBdKKog
 TSo4FqnqjlMf5zhIAozkRU8XHoL26N4eucqMv/ve1P6vaGJsX6/oJsWZLzT/wmTvh1k5
 cTreJDqPgLWbee9FauggH/2zjQBg/QCpHC12wFQerwvaR+5uCasXAKvVBJ6Vut3UMUQQ
 3XAHwNUYPYMLNRdHZF6gnSsfFIf9Slqx462sHnBYK9EpTm/jzPwth+vcy9KiYCqxASpp
 B7fklv2GH9OVEwSD/RebQkRVzgupTKSoxtwf7+lIy2B4CqaOvcpCe29tEbpSWbNpaQVA
 AMNA==
X-Gm-Message-State: ABy/qLbcfhjY1L0Iw+jMchWTiaFWQ7Os/gjeQFDjVAIe2MfMgY6FyDL5
 6/87YqPSBosidRu9wR9rndglEA==
X-Google-Smtp-Source: APBJJlEI5lozSFmPB3QBgulj3hQwo0d3sF7wmg9wG1dlRvNByA1ABzAw45LTzyyQ1vRItErAV4SP3w==
X-Received: by 2002:a05:600c:28b:b0:3fe:15f0:dfbc with SMTP id
 11-20020a05600c028b00b003fe15f0dfbcmr4135470wmk.12.1690797344340; 
 Mon, 31 Jul 2023 02:55:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a7bc5c5000000b003fbe4cecc3bsm13858143wmk.16.2023.07.31.02.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:55:43 -0700 (PDT)
Message-ID: <4e6c4a62-7533-56ba-f51f-691f71e4aa32@linaro.org>
Date: Mon, 31 Jul 2023 11:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: Move iaoq registers and thus reduce
 generated code size
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <ZMaQGwK1Ikj27ZPk@p100>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMaQGwK1Ikj27ZPk@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 30/7/23 18:30, Helge Deller wrote:
> On hppa the Instruction Address Offset Queue (IAOQ) registers specifies
> the next to-be-executed instructions addresses. Each generated TB writes those
> registers at least once, so those registers are used heavily in generated
> code.
> 
> Looking at the generated assembly, for a x86-64 host this code
> to write the address $0x7ffe826f into iaoq_f is generated:
> 0x7f73e8000184:  c7 85 d4 01 00 00 6f 82  movl     $0x7ffe826f, 0x1d4(%rbp)
> 0x7f73e800018c:  fe 7f
> 0x7f73e800018e:  c7 85 d8 01 00 00 73 82  movl     $0x7ffe8273, 0x1d8(%rbp)
> 0x7f73e8000196:  fe 7f
> 
> With the trivial change, by moving the variables iaoq_f and iaoq_b to
> the top of struct CPUArchState, the offset to %rbp is reduced (from
> 0x1d4 to 0), which allows the x86-64 tcg to generate 3 bytes less of
> generated code per move instruction:
> 0x7fc1e800018c:  c7 45 00 6f 82 fe 7f     movl     $0x7ffe826f, (%rbp)
> 0x7fc1e8000193:  c7 45 04 73 82 fe 7f     movl     $0x7ffe8273, 4(%rbp)
> 
> Overall this is a reduction of generated code (not a reduction of
> number of instructions).
> A test run with checks the generated code size by running "/bin/ls"
> with qemu-user shows that the code size shrinks from 1616767 to 1569273
> bytes, which is ~97% of the former size.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


