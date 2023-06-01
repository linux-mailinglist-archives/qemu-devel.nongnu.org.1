Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB09719ABD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gEZ-0005f4-Qu; Thu, 01 Jun 2023 07:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gEU-0005ce-Ga
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:12:42 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gES-0007js-3n
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:12:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so700597f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685617958; x=1688209958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1L8k3gPdtIeZq1Q7/C16XE3JMs4EZx8IfFBM26ZZJ58=;
 b=Qadg+fKzukDUIsqQ4oAFEycYP36Io560Kqsjl7heY0uLr/qlJRNkqsLGWYwaD1so8F
 4NcC/xrwyBFIiE4XLDBXZwInahLxWUZdbpwLPMRyjKTl1jaXZrKcdAvo/PyKyqj1V2WN
 AfRPp89l/FmKO26OwMDh8Or/A87otigfzUO+XbKZ5/p3EVtBy/aL/Wv6yC+OFdLbdDdh
 JNwGwveYberAyNrEjOhYtEzXn0xn0JMXz7ObdFNlPlEGqF5dbVaMGIRdaokQYFPeeGR7
 A3FXHoQobR88byZgTzPnNZfOGZy91wi0uuw3+pTCPJ8v9pTK9LBbRi8THEsInnVJGs4J
 DUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685617958; x=1688209958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1L8k3gPdtIeZq1Q7/C16XE3JMs4EZx8IfFBM26ZZJ58=;
 b=l9gGijwChZnTNsdLlAwn/7wn6JYwzeF6pxOhhYu0/ik714f53z98kZ92rvpiQsrsLa
 E2A+Rb7o1EWQ2LglF8r9dS4ei8T+LkDPm/t0MeO2qJqP/+jrSXoKinbdg2/+/QFQWFG+
 EkSIUO6U5xqAHwO1qRbIx80TDqQsnigVbYSBS44F+a4ldFNxavounCHoMPEkI0H0N2nY
 UonCbO/cp18I/1Mkcv6Gkcg2nvjdO5ijcJp2ODOwRmEd8L5oiD/II+K4TNG3whReCCaq
 bBZ93Wl3i3pxnGrSNcPZPkZNs20mjifw9MMpYGrlCbVDXf9AUlF4gv6HKSgJ9wwl/1sk
 SNAw==
X-Gm-Message-State: AC+VfDweTE+mOODOWyJR3DIu+o+9YrMvd/gBXys4MIpCqTjQsMK/UtzM
 cweuZ2I4JOdqiqkVLLehnhZVyw==
X-Google-Smtp-Source: ACHHUZ5DEdawsUEVHKCR3UJ4Ako4X+9eqE8X5FjR28S/aBTwo9EDFt3XOM4qhZ4OdxsjVNfvuB33KQ==
X-Received: by 2002:a05:6000:46:b0:30a:ee36:2840 with SMTP id
 k6-20020a056000004600b0030aee362840mr2062601wrx.39.1685617957698; 
 Thu, 01 Jun 2023 04:12:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0030aeb3731d0sm9843969wrq.98.2023.06.01.04.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 04:12:37 -0700 (PDT)
Message-ID: <9cdd5446-ed3e-0e63-8d57-fee5a94a6d2c@linaro.org>
Date: Thu, 1 Jun 2023 13:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/48] *: Add missing includes of qemu/error-report.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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
> This had been pulled in from tcg/tcg.h, via exec/cpu_ldst.h,
> via exec/exec-all.h, but the include of tcg.h will be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 156dde4e92..2bad242a66 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -20,6 +20,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> +#include "qemu/error-report.h"
>   #include "cpu.h"
>   #include "hw/core/tcg-cpu-ops.h"
>   #include "exec/exec-all.h"

"*" -> "target/avr" in subject, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


