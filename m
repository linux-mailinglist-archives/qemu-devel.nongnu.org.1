Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA457358DF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFCh-0001JF-H3; Mon, 19 Jun 2023 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFCb-0001Es-6j
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:45:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBFCY-00069B-9L
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:45:51 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so4571482e87.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687182345; x=1689774345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E5wJmBO5+DR2SHTj2u5rPzmt7ogdWieraXdORYTOYSo=;
 b=CgEQJwT63BL5caiK9PtE/5P7NaObTVFuNvaNlwPPxdB66vZKaWObAU8DwRjdKWIL9k
 3H2KHIE0JS+12jljCWgyJokEoVo9MJhDQkbcFPzxXS4Z/94bhCjFLLOZVsdzKzRJz7WC
 aXpUytZ7xM7w0ieAK2xqZe/Rg+KxdjXlqpjV/aE4G0+lf5+r3JjVbMe1+k9+cV+6NzkY
 aMF+49bsI8XrNeMGtDBFayI3ep9yrt+x27P5dtTezePTICu2GNiJDE8Eip9REwjpFO0o
 zejS2NkApYmAHjKQ/SCqj+/rBH5J9tuXdZaLe0soexRXo0e5z/0JguM0PCEG7OW0di6w
 iA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182345; x=1689774345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E5wJmBO5+DR2SHTj2u5rPzmt7ogdWieraXdORYTOYSo=;
 b=FHaflXQrFmzHCaCSR+Jczv5e08thXlVbbOLjexhz5mRd1K9Mgg7dhx58Q2xcaEdHFR
 HrPA0EsSOzEJ/IP8n8fX6k+FNLSx60JVpiqXmEew/w6gTxOY92fpSX8WhVbwM3eAFAFz
 /ClzrDDzklG4vkDH0mNP2I6KjozzRrFuZA0fBMit8Nujpq87z3iSVEzrgDf4HzoZFcKg
 IkxHVPh+OYeui/51s7GPFPqKFdwJgV9zh1sUhgwwZpddoGfvbXjCzbXfdFjNUGIAAvn2
 CXdWPCMeKXLTkAbCmcO6OY585J8Dreh8j68EaIMWscp8HE8tHhhpf6zPRDb1abJFp97k
 7BmQ==
X-Gm-Message-State: AC+VfDwpT8IwpsWost7iGJAhzCCL/ko3Q2brzyc4RLW1/GGqfMhA3/gO
 e0dbjNTPSYkWYMyEHdUQbmDivQ==
X-Google-Smtp-Source: ACHHUZ6lGEMCwVh518g627Y9EsheA+h5EI1c1ZPGWlcuKWrshZFl/Q33qMqroaOIZ0GKAsCQPcF0cg==
X-Received: by 2002:a19:d611:0:b0:4f8:42a9:70b3 with SMTP id
 n17-20020a19d611000000b004f842a970b3mr5202513lfg.58.1687182344940; 
 Mon, 19 Jun 2023 06:45:44 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 j10-20020aa7c40a000000b0051a315d6e1bsm4114446edq.70.2023.06.19.06.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:45:44 -0700 (PDT)
Message-ID: <84c0f59c-659a-25b5-d2f1-4309be445743@linaro.org>
Date: Mon, 19 Jun 2023 15:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 32/38] crypto: Remove AES_shifts, AES_ishifts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609022401.684157-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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
> These arrays are no longer used, replaced by AES_SH_*, AES_ISH_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/crypto/aes.h |  4 ----
>   crypto/aes.c         | 14 --------------
>   2 files changed, 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


