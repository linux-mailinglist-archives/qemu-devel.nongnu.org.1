Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E47823D1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXydG-0001cI-0i; Mon, 21 Aug 2023 02:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXydA-0001c5-TZ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:43:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyd8-0002ln-O7
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:43:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fef3c3277bso1306755e9.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692600193; x=1693204993;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=392Ulf7HjwGGU49foZT9yC4BjBtlnXweGfQ63jcE12w=;
 b=Ch6vq7ncglmQ2Gf9fxlVV/vkdaSRjMQNp4oVfkDOYoDVde9LR+03kLyitIalw5HQs3
 nvrvfaQ9S9yEwxW5SpDtdxtSmZYSadP2h/kkPbgfCtl9CbVGmQphVFI23Pc4bcGF7+Qm
 r20eb4fsQVyZThGJJnoRIPPikAZITbWTQiwCdeNHtoY1N562jJQVCKVFDfxPPhLhZRHH
 gA4DujjMdu/cESZ+xndHTnHOIV6SKTs5MJQVZos4IjWvRjnGVXNarPajlqjuhSSr092Z
 LkKI3yTs5dcWAThAcScBQtdYErwu4yFx6tb3lmI7M24OWQ7cjx8s7JekGF3IQXfw3Igi
 zPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692600193; x=1693204993;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=392Ulf7HjwGGU49foZT9yC4BjBtlnXweGfQ63jcE12w=;
 b=lTQFph21sgTuwgIagCrn4qP1KSoiXdfrGbovK84ZZ1HUPqJWwpsyBc4WLYqWM+0ycF
 MuciDqnvJqcogbjsZXFME08B8RL41ugkJXHSUmzjTpPqkMujhThFCLwlS6c99l/lQ3I2
 6Wiqb5xjtK+GGbr3rFm76ThAzwJbtDsW1qmniQFzW/WJA6/TDMQNeGVH4O9odI5UoMAE
 u0mMhANZ83bhJ2ZCtnaP45zJt6JoDxhGiTIHBzNGYPs8uudeCONgkntf3OtTWNyqs5NF
 RRUwOYElctuH2L8ok2wVauVicbygNmTHBzYJsk0ohz/7FTuYm15jQErNxmCGppT7b/hU
 V4HQ==
X-Gm-Message-State: AOJu0Yz+uRFHogHVUmKNg3PJwIfAtRy92XoU/yNITd+HiW7zUzY7Cgjq
 WMOcXpUQwGQxrjvJ7QpMeflVHA==
X-Google-Smtp-Source: AGHT+IGtvIZNvlb9ZbbXw3L4AqI58iZ+J7b2lfWbonm1Scstp82dqPhWaPcra7EIJGgOSaPWejcJRw==
X-Received: by 2002:a7b:c8d0:0:b0:3fc:7d2:e0c0 with SMTP id
 f16-20020a7bc8d0000000b003fc07d2e0c0mr4156725wml.27.1692600193055; 
 Sun, 20 Aug 2023 23:43:13 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 l9-20020a5d6749000000b003143867d2ebsm11442793wrw.63.2023.08.20.23.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:43:12 -0700 (PDT)
Message-ID: <434735ee-aced-af3d-3d9e-25515c175f4b@linaro.org>
Date: Mon, 21 Aug 2023 08:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 16/33] linux-user: Split out target_mmap__locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> All "goto fail" may be transformed to "return -1".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 62 ++++++++++++++++++++++++++---------------------
>   1 file changed, 35 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


