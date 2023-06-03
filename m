Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE17213C1
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5aS5-0000RJ-4G; Sat, 03 Jun 2023 19:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aS2-0000Qv-G2
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:14:26 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aS1-0006lS-0Y
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:14:26 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b15f091949so267885a34.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685834063; x=1688426063;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2sPuJmHWUCHXEUBfCR4AWvKsVc0ayOO1XNPtTFToBUk=;
 b=zNiVpZSVgTbLu+SFup9EV0jPxGwAdSshIoWznB0s/Pp70Ses5fbzGwXB1qtFxFx6oo
 vh/e6IgDhQ4hd9PFhFi140jdK2EIem1jKrm0U5oiDWWuTcERPJRKf871C+2aEuGd37Dk
 Yqn/CE9zgwGpgyGNudyyTJUWSbL8e0YazO6xdNI7lgFrkxYpDGDMMYgtpwMJSexGnixN
 zcWLBROFdjw7AQfI2rrykGYTVpVz/z2lX4dgqBAc0dbEKGQazdYNESz36PGKNSdcfH6V
 TQSz4CNIqQNphKLzMYkumJUS2ZTxTnf5OSG56s7m2TPTfg5cEzyLyFAQJo+gesKHDKg/
 Etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685834063; x=1688426063;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2sPuJmHWUCHXEUBfCR4AWvKsVc0ayOO1XNPtTFToBUk=;
 b=YbxATP1alAlLRxOqj/9CNYJNpY7B1LB9mAvh/23B6VEqnJ7b7ehC1lZqFkADTjAGsu
 BRZ2fODIW1MbFzAzrbZgvjQVAfXOfNo6RTpj+HY3P0jhg0YfES90WiFreK+AYDv0Z5rP
 DQz6p7zw/M9KyAdT+ZJWxuwlQFE8oSSLc6ZXdl32ILrqgaKIFxA5lVR2pf8KmNMbtCjt
 85KBahUgkWkBiOv4tgz1YEesDlG3ZWlB2OGKuic28nqSrQ/KLLP7rxNeyJQlBqPN054g
 Ly4/XwD4L/gztylTTzttkGr56u4HkcxKG0O45iWSXfx/VEvqN/hW25h5Z6QIfoTU9xju
 0bEQ==
X-Gm-Message-State: AC+VfDzZN39pKAf3y4HFc7yvIDei/jtm2i6IcjCDMZdBSHoeQnDxvKjs
 iK6lsCIrpfKXLCxK/MZ4elZ3Ow==
X-Google-Smtp-Source: ACHHUZ7tEiuG337/QW3+mRRvqxKE1QvnH0K4BMLM3vBzRXANooSiFTjPSB5F+vnJEt67GxSr+r363Q==
X-Received: by 2002:a9d:7e96:0:b0:6af:8f03:c22e with SMTP id
 m22-20020a9d7e96000000b006af8f03c22emr6546545otp.16.1685834063619; 
 Sat, 03 Jun 2023 16:14:23 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 z5-20020aa791c5000000b0063b5776b073sm2863601pfa.117.2023.06.03.16.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:14:23 -0700 (PDT)
Message-ID: <551cfa44-849f-eb06-b415-688c02dd72ae@linaro.org>
Date: Sat, 3 Jun 2023 16:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/20] target/arm: Convert ld/st reg+imm9 insns to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the load and store instructions which use a 9-bit
> immediate offset to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  69 ++++++++++++
>   target/arm/tcg/translate-a64.c | 198 +++++++++++++--------------------
>   2 files changed, 148 insertions(+), 119 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

