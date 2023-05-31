Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92E718464
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MXx-0005AP-OY; Wed, 31 May 2023 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MXv-00059l-EB
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:11:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MXt-0008IS-Hf
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:11:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so2885474f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542283; x=1688134283;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KPM7UF69Bpxnm6HlVdZTyPbamZK6pm6O8caPpb3KExU=;
 b=eG3rmyazdZNGDlqAnZcxBE56o8Q3BfPJ/HsZde777yEcnqmAG4HvI4JK9pJaqxGwHi
 tlSNz3+CNXp322M8M7e4GEaVOoHU+QC6Gn3RNxzJPCEcMKIvrKtJMCqgn6bV9Kp7pN4e
 aBKOzKMR+lDFgqk0UA8dczqcpk34XunwziKQSZ/3qGjbQgMNQBDKlRXku8lDWaPZGhNx
 EEhXFWO6rZaBUspWxqORy1lpnZOn+0MkRBLye8zAzIocVuJawTKPcV4URzUKB1tNNOB3
 6dualrxPDkJBSO6+CqIhIaYTng0dsaail7jp/U1eSeHkGi9ciQ6kWBt4LiSxvGZTWBTe
 /T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542283; x=1688134283;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPM7UF69Bpxnm6HlVdZTyPbamZK6pm6O8caPpb3KExU=;
 b=c7+FlTs2a2fxPMp+pqT3a2kJmFq5OHlmt1OmzpobyZNi9PpW6zKKRR12QIGxgmcbS0
 WueqtGJ/Sx2X1xbmebsb/IIBuN6ePMbpCWjUP5kADD2Bfq4rfv9u0tuwEAhmC98MfClC
 pfrODRCxe+V9h9kgoeNyOwvNXfjhLCq7/eG9u3L96Vqp5WHx2+5I1So72pqKvPj7uvVE
 xYnJKaIXupXUd4gSzrV3E+dRIMsqEXUQndP/U1o2SIv34i8dn5kWZJkRLJFnzXKGIq7D
 a4+/GlygltbA6EFlTLJhODVC6R7rVta/TyQ/vLMCU0I+jS9AQMF9FgbXUIkZj1OSsT0O
 7UoA==
X-Gm-Message-State: AC+VfDy3gkyr8RXfMzqC+GGOORicwu2gWxt4oQBch/6NUuutgcCyha47
 4CbJ5/C0SDPgPOVC0q6A96YAVQ==
X-Google-Smtp-Source: ACHHUZ6AqiXiDFtqzFw++UMhBqDRC2NYNJzDaf7Y9hwVswJUgMQjzqHkXYTMdVQaUo4xHf9T0aTnvg==
X-Received: by 2002:a5d:50cc:0:b0:30a:e7ad:2b08 with SMTP id
 f12-20020a5d50cc000000b0030ae7ad2b08mr4146412wrt.29.1685542283338; 
 Wed, 31 May 2023 07:11:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n7-20020adfe347000000b00309382eb047sm6953879wrj.112.2023.05.31.07.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:11:22 -0700 (PDT)
Message-ID: <dbd43d8f-3ebf-578f-6535-893d279ea2f8@linaro.org>
Date: Wed, 31 May 2023 16:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/48] tcg/riscv: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 31/5/23 06:02, Richard Henderson wrote:
> All uses replaced with TCGContext.addr_type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target.c.inc | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


