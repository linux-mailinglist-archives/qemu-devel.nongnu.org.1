Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2B73715D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBe8q-00042a-Kj; Tue, 20 Jun 2023 12:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe8j-0003xa-I0
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:23:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe8h-0005sH-WB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:23:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-987a977f62aso411954266b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687278210; x=1689870210;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZf2w4zPBm/71PtT9kF8KKEBfpzFYq1o7d1hzUFiy5A=;
 b=mxLKcw9Z2/6tBtapC6l7DEk9gT0wcbpvm6fZT+8jNw5iKItf5oQw+1v+vqgU029g+4
 uBV7FxWUeMDwS3xieL6/Mzfs9oxhAJTvkatUBli2zisMmF8luGjgzj8bZCGIYMSOVxR7
 DAiU2wK2FwofpVsAJdJ554x8r/l0yUsCop5tqyjlSQuJQYDoZSh59sASWgoE+ezuTVWk
 n8M2toz83X1OcGr8UK8qaK1PNiaLGkpa3g/lzeQcbKRkdmEWv+nqeOXbcefMbPyhNlZa
 kLOqCzfsG9u5GY0taxvmoQtw8nVkM9Cn9OWzC7q8l9hmFscl2t9TPIerqhiIlSqt20JX
 qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278210; x=1689870210;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZf2w4zPBm/71PtT9kF8KKEBfpzFYq1o7d1hzUFiy5A=;
 b=eA2lWMEOv6nnnhAWcegdD2CNxYXwb2Gn+K36XZ50DtQf6xkq9ije/JXefYuVOeHhlV
 KBk0E4mIK+dv6ncfIHQu1O9pGwWdXD/RQKqwgfcEf5j2oM/8s9xdFQL0OkxkUYae6jWA
 +dJQA0spAyHNyFalUn8E4CxevZ6q4BLBoaFD94tdqXZo0EdTMSJNIM/wzW/IanfJqB3n
 rgDo+L0G5yNpanYCaJRClYJtfH5aPB01reUHGjVZ/XRdj2Vpp0zS4M33QOx2JDHTxEq/
 teGy0a9LY2howEmgb05nCLn/bx6NQU03xZq38n+TqUQGzO25iqw01hsNaXpJr9y17uwN
 f1zw==
X-Gm-Message-State: AC+VfDw7MZVxWpYomdrJA1zv+O0CgIPHVEY0gV0KlfcU1GHKACowjYe5
 WOUYTbkgOg3L81NbCJC05VPJvQ==
X-Google-Smtp-Source: ACHHUZ6HlWKrWiBXqS3dVb9pRqimOMV8nwsQC951YdlZExlxEaRiq4jkuwaHWu9CSZNPm2/eekHWZA==
X-Received: by 2002:a17:906:7943:b0:988:7d1:f5a5 with SMTP id
 l3-20020a170906794300b0098807d1f5a5mr6727045ejo.28.1687278210500; 
 Tue, 20 Jun 2023 09:23:30 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170906669100b009887f4e0291sm1658577ejo.27.2023.06.20.09.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:23:30 -0700 (PDT)
Message-ID: <ee1239e3-7c2a-9f07-b15e-c9d9f3541bc3@linaro.org>
Date: Tue, 20 Jun 2023 18:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/10] target/i386: implement RDPID in TCG
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> RDPID corresponds to a RDMSR(TSC_AUX); however, it is unprivileged
> so for user-mode emulation we must provide the value that the kernel
> places in the MSR.  For Linux, it is a combination of the current CPU
> and the current NUMA node, both of which can be retrieved with getcpu(2).
> For BSD, just return 0.
> 
> RDTSCP is reimplemented as RDTSC + RDPID ECX; the differences in terms
> of serializability are not relevant to QEMU.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build                   |  1 +
>   target/i386/cpu.c             | 10 +++++++++-
>   target/i386/helper.h          |  2 +-
>   target/i386/tcg/misc_helper.c | 23 +++++++++++++++++------
>   target/i386/tcg/translate.c   | 15 +++++++++++++--
>   5 files changed, 41 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

