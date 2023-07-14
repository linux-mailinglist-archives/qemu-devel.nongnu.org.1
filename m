Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CCB75327D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCqI-0003Tg-Qf; Fri, 14 Jul 2023 03:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCqF-0003My-0u
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:03:51 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCqA-0001uD-8T
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:03:50 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-51452556acdso970326a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689318224; x=1691910224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vn6i0sOk4SopbFnYPoexXUbZ0GTL9sUbPNgqCBEmX2k=;
 b=ckWcJ1G63YnqLE77HTTYuJA7nBjzKJIJAuN77QO8Fb/b5VdVevphOsJtRG+V3A2Wpo
 sx0qheQST/HPAKvq3UTtxOtNEGTUf6ZEbIO/UhBpaEoHcjLIRAz6B6PAEWbDTj4Zj/QE
 uiY2MW9/mMABCqCq/guFAa5soCqjV86o9s1iBgcOEqJbFSr+rxJTJqE3OJ3T23W63a3Y
 b6VONnuo6R2uyKQHLwg9WQda8wkuxCoLapqUnrjAl1p5SwaUXGJXSqOI5SmERxbukBMi
 H05kiCtUirby7LgFkc0L2WN+T5JJj52YRehugLOdyb9QODOGfkYCk1zYuQnx5WffU66y
 vK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318224; x=1691910224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vn6i0sOk4SopbFnYPoexXUbZ0GTL9sUbPNgqCBEmX2k=;
 b=HHggzfdE++ztAvslow/bQO1E1r5nIl6cb3cmbFFEKMVjZXM9yhdiOJSCU+5sNtFzhg
 +gn54j07KjWyrN9cfdxDMSv2f4X2MY0hD1A+77IN/sNyHVVhSC6ULSvAM93GAczM80C0
 xzaIznmyeJr2w69KnCJTSOMZA+aQKFdjHmV1pFdh8AOkP0MOdON9NL74apC+K/c+sftE
 9jOR9IVMtVYv6C6SBta6R2mYC7yp2IoF8dUkRFrFFuideNxlot/id3bhDv557XaqFEpZ
 XgP3FsRnfzaP1tMog48cDzsMrA4ltO66heMF1cvaReDdcQ90Bd7FFTzH1Z2unMINCUWQ
 wKYQ==
X-Gm-Message-State: ABy/qLbiewkHXVqFbYT6mwu4JmYSHCQvl0gUd4igmgU9qtMkki/E3MXD
 jrJ/IVcc7p/pu05Runo/vRt2gQ==
X-Google-Smtp-Source: APBJJlFwywz4IS5/06FZvOa7SlUO8H3NDHeb8EOlSBMMR4kUvwYC+4JpEWSXamMw+QygYLDKqzBzfg==
X-Received: by 2002:a17:90a:9b0b:b0:25c:571:44bc with SMTP id
 f11-20020a17090a9b0b00b0025c057144bcmr2665250pjp.28.1689318224367; 
 Fri, 14 Jul 2023 00:03:44 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a17090a2a0f00b002676e95cd3bsm101744pjd.0.2023.07.14.00.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 00:03:43 -0700 (PDT)
Message-ID: <968d3032-d4f8-a580-c808-57a8a6341081@linaro.org>
Date: Fri, 14 Jul 2023 08:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/11] hw/char/pl011: Check if receiver is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/23 18:51, Philippe Mathieu-Daudé wrote:
> Do not receive characters when UART or receiver are disabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/char/pl011.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

I guess this doesn't fall under "my first assembly program" because it isn't part of 
"Hello, World"?

Anyway, for real stuffz:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

