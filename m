Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C57B535A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIBO-0000nX-8f; Mon, 02 Oct 2023 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIBK-0000nA-Go
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:37:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIBJ-0002HD-1E
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:37:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-406618d0992so25505005e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696250260; x=1696855060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0myayU/oFMugOSiUjoAEWWBJOwGqFCCQ73cvvI6SQ0=;
 b=m0wR+YvTcEajeAfJv1HiUT4iiKx6l5X9UapGNebRP29FvUtAzJCIfHqv89pqChz4c2
 XwNoVhiG7C83Zv9zZdUSel3r/kXPSafR4+WMdahez3nFMG8AMxAj/M6jdKp5sfS0qXsF
 AOWESl1hs90ICwTF/D2x6sHdxHiihGJZOyIHeWQasRFSKQ/GIc56VK2w5kZgGrwcWEzt
 qBunkAgHgFU4zVmfBt/jRPva9eiDTOmYxztaIgqG89YdaUUzaZV/N85ckHEXeFKDn3bn
 DEVFnKcTh3RjG4DHjsJWdnuQCh6njd9YpsO7u45+PLgjVJ5r99AUvSVrB4fF+W9pY/t4
 lvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250260; x=1696855060;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0myayU/oFMugOSiUjoAEWWBJOwGqFCCQ73cvvI6SQ0=;
 b=hqReVL2+JbWdcgiM8sxDr+pHqIhzzePKKoikjxetWYGlAkp2iVmJ05jnaqKb6bpq/N
 X8eythyJQTfUwZNCixTHbUKkeC6Bapa4AOCGc3FZLUN8LGjc+RBxOM9JKcNp4aYJBSnF
 7UVMnhs2ffUJA4KgV1h25fbJF5M9Oki6MAKWUuTQO8uE/2w/KtwJhcAlAP6SNG5ZUmsK
 JwYJjrHCjWEwFIEBv1BIRi0uoSRNgX4qXgQ3aynGyWKdicNHqu0rsb9gRz1ZcZWplk2O
 ONaDZyAKCK3+OC7ob2ckIncILnOEcFxrVJhYLkeT/DIzVgmsuZGrA4qMTuJzTxvo1LlV
 x6xw==
X-Gm-Message-State: AOJu0YzDAT81tcE6OnhWpynkn8ciSollz6K6qGzL2K54Ou84aogZ1wes
 EenV2oNtKRvdaECT8VV3y4ponaYoeV4N97IPz2oyNQ==
X-Google-Smtp-Source: AGHT+IG4Qr57odsUB/asBSevLO9K4YmHsOvxIyleY0Urua02vn5F8yD+cHPSjNdKyECMHWdnKGA2OA==
X-Received: by 2002:a05:600c:a007:b0:406:61c6:30b8 with SMTP id
 jg7-20020a05600ca00700b0040661c630b8mr6243889wmb.22.1696250260527; 
 Mon, 02 Oct 2023 05:37:40 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 az27-20020a05600c601b00b00406725f27e1sm2360824wmb.42.2023.10.02.05.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 05:37:40 -0700 (PDT)
Message-ID: <adc5ff44-5611-a567-9e9c-63c65494b5f8@linaro.org>
Date: Mon, 2 Oct 2023 14:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] tcg/optimize: Pipe OptContext into reset_ts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
 <20230831025729.1194388-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230831025729.1194388-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 31/8/23 04:57, Richard Henderson wrote:
> Will be needed in the next patch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


