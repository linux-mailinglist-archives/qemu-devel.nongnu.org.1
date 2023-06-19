Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A47358E3
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFDK-0001s3-D1; Mon, 19 Jun 2023 09:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFDI-0001r8-HX
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:46:36 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFDG-0006IA-U6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:46:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b46773e427so30466881fa.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687182393; x=1689774393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RZAFf7a7CQepa6D+gIU51FI4q5YibaV1KpSK1tAnOSk=;
 b=kIrei8YLpsn2Cya3HB6gW+DFnTb3qQ5INGhMEdriy3TwpwRjHiGzcLqo9gTpnHetLv
 sY29UnIgZ+Ig2K+kjQnTgmcKK7eBpqIrixC0H2NLiOyVxHie0XoBa4cFnMuQjC4aDxJM
 CiMUdxDi+DpkYuNWyYkuwzwrOkyQ4BiLJaJO6LngkQLoL54lMzh0ZikSOZm/mtz+C7in
 JRulSNc8j2TNngbKqgWb9P8tjVvEFdU3Nj2FnY1QbZ8neKDfgukUdfwxpd4N3pYjPGM5
 tC0Jqw/rSoYdINzkWQYpvGVN9oGJOGueAVkxsjUIe/2Vz/c5VUmBroVatiuRwqdQaeRj
 LMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182393; x=1689774393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RZAFf7a7CQepa6D+gIU51FI4q5YibaV1KpSK1tAnOSk=;
 b=jGZMqtdM41GDHzV3esE5XqdF4q3fUtvMCkSVk+UBkmya7NXE4yhG+MfO04dR+srZPc
 rZMRu9jQ4OcPmxp4qwK/FqGXENe6hJHB21hPBOk2E+fiU1cM2pRPgnBjGZdCeS+5+dkC
 nXvecrRvF3IHstycaOUTYqDGPFRgGV0XFQNFbbxSrbzfXAvNpchUeB5R+ooHVQUMZPNj
 uzWRyEzfHEZ0227jgTbpcnIQisFKcoSpeU4e/ntzgGCROofBEzxFdHmdSjGugVKgmtM2
 8vyLPOPApcheldADW1gt55YPb0r8H8+h5cjR8XQKTPvs0z5uShsZyl+/0bMeFKyeGg1U
 ZfmQ==
X-Gm-Message-State: AC+VfDwUI0P9nrSabBIu+E1suZJnBL5XVcmOtze9q3louo/+HYD9v02x
 Dq1RNw9NOmKnNufBL7sjxzwZYg==
X-Google-Smtp-Source: ACHHUZ5JFE1GnE5mBt8DS0BGosQ1RMIwoD93ASbajwFvqHmHlIZTY80s6L+VPOL+NUZl4/kzjqCWkg==
X-Received: by 2002:a2e:9011:0:b0:2b4:5c50:f60a with SMTP id
 h17-20020a2e9011000000b002b45c50f60amr5081641ljg.7.1687182393057; 
 Mon, 19 Jun 2023 06:46:33 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 bk4-20020a170906b0c400b0096f675ce45csm14657406ejb.182.2023.06.19.06.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:46:32 -0700 (PDT)
Message-ID: <327c9d66-2adf-921f-50ca-e856d362a3c1@linaro.org>
Date: Mon, 19 Jun 2023 15:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 31/38] target/ppc: Use aesdec_ISB_ISR_AK_IMC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609022401.684157-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/6/23 04:23, Richard Henderson wrote:
> This implements the VNCIPHER instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/int_helper.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


