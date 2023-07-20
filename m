Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348775B036
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTrU-0005w2-OO; Thu, 20 Jul 2023 09:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTrP-0005rv-DH
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:38:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTrN-0007OY-OL
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:38:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso6623015e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689860302; x=1690465102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FwJXtC43HTdKQOj1/DgtALKsBOiNOFU+5HbJKGdNxdU=;
 b=E0nzM0gFnO6RsJQn7AiWzT0g3ZXcluliRty1EU/Ad3d0gZlNwTDC7EWWS3XECPzxFj
 mZxcIfJhKlc5LNq4sPN4rQGEqwMudcvcsE0qJJsv+OO2zpBdHjuCUPMSYBrwpg5ee8op
 kKdR+MeV07g1v+u/yxAVmSeKRgUt65X+LFnD5u01nMoUaFeEaGVeY4WzGzeupFVY7GuK
 SkesWQpzXNi2frgR48CM2dZlRHLfduHje8As2e+59QflVWXugyb1oXEhSHJ1Jn3dFMq4
 eWvZivf9Z/LS8hRyf20tBxuVDaCRKwHipvdZU0j6cFxTm1T8WdKEkToGo7ZhFG2Rqfi1
 Y93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689860302; x=1690465102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwJXtC43HTdKQOj1/DgtALKsBOiNOFU+5HbJKGdNxdU=;
 b=Mf4g7Ekg/GcvCQtA9ougt0wWg1x3jygeDJa4dQY8LX1AKCIz1jg8aN3c+uuDlY4GVQ
 h/w3dVdN1g6qVlAyK447w/OnxcF/EBde/hrSRbsfamm+xy8n9hXjEM53fcajbPghh0m2
 yhVKZRndS01B/ADF3zBD25tzLPgB8o6S62AyxFwTX3EZyteZa/A/leG/S+A4IeAlX6x4
 CFl05YQ+uD3CaXMqA9gSkI2465ct+wGSpK7XQ3VGGE+G8gSKOArQLaD+3tADKVTJX4fs
 Xk7q6kFyv4lNqkV4zY9ehJEF7h+57dShl82Uk2I1BhbCKtRbW99iwV12pvcmAg0EcKuN
 LdGg==
X-Gm-Message-State: ABy/qLbOcVp8f4vMHLDmul9V2DMvJvKe9geGHbaSlB0xz7Zsq9M8lsLm
 +GM4LpPKZXQdS2BZEieMtU4p+w==
X-Google-Smtp-Source: APBJJlGbP6iaIVFu4R0wCoX/OmTL6ArR9jsmMuySyvrrSgUHBib/HA6v0UGvAcVQIGFnfOhBVKS0Bg==
X-Received: by 2002:a5d:618b:0:b0:314:182a:3d96 with SMTP id
 j11-20020a5d618b000000b00314182a3d96mr2040922wru.28.1689860302099; 
 Thu, 20 Jul 2023 06:38:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.214.178])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a5d5712000000b0030c4d8930b1sm1370380wrv.91.2023.07.20.06.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 06:38:21 -0700 (PDT)
Message-ID: <96da4078-d3c3-7c64-f681-7ebe1df50f85@linaro.org>
Date: Thu, 20 Jul 2023 15:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/decode: Suppress "error: " string for
 expected-failure tests
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20230720131521.1325905-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720131521.1325905-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 15:15, Peter Maydell wrote:
> The "expected failure" tests for decodetree result in the
> error messages from decodetree ending up in logs and in
> V=1 output:
> 
>>>> MALLOC_PERTURB_=226 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py --output-null --test-for-error /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode:5: error: duplicate argument "a"
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
>   1/44 qemu:decodetree / err_argset1                OK              0.05s
> 
> This then produces false positives when scanning the
> logfiles for strings like "error: ".
> 
> For the expected-failure tests, make decodetree print
> "detected:" instead of "error:".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> My initial thought was "just get meson to suppress stderr for these
> tests", but AFAICT meson has no way to do that, and we already have a
> command line option to decodetree to request specific behaviour for
> the tests that expect failure, so this seemed simplest.
> 
>   scripts/decodetree.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


