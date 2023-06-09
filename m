Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56482729EEB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZzY-0006i4-Cf; Fri, 09 Jun 2023 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZzR-0006g9-Pc
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:09:12 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZzP-0006zq-L4
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:09:09 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f619c2ba18so1977958e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686308945; x=1688900945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdoSKogVQ1XOoeFoTQtaWTQ6TXfifc8d0OLtiPzVbF0=;
 b=FDxLWSct2+2kbRvfcTVQYri8IB0UfTRYFFciF+3RveL0bZh/zp6yI5lAzWv7d5g050
 i8RlEeu1bQVU9j29gXl/3C76P8XadmQYwN2qdooirCEFgo2n/1p/zJ+k9u8+XejAQ/IS
 M3rc9aZWllBWehh5BP0CLRSaUxJPvE8+3W8uox4kl6fBHfQ0t83prF4afhI4UOiQWbrd
 kOFwYjYfAk4TGTWGnG2ynOnH5LjGS6j1WcDz+q8cS4oLJovsAyMoIIEhBI3nwzgwjAsR
 lTq6pLoGBfKNtMiutbB+hioAsJMZHybD2LA9sdck5aus9IQrXsWR4k2ThF1NbodODJeI
 J+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686308945; x=1688900945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdoSKogVQ1XOoeFoTQtaWTQ6TXfifc8d0OLtiPzVbF0=;
 b=WutW3yy/PWLQkODj84yQCK8aQkdiAS3Zl8MZQ6MiLNZo9GR8+PbPaXMvb0ltdOqIVU
 GCQQkjWOor17bcz/FoFCgzdRBTOU4JpedNvC7sAz+b4D94bikU9P844mlrWAGZaGc6GM
 tGwaI54fqsQO8/8xEcnLwSxiBswcdOpQP29bxfUJDYvogyDQT+BfSI/p4tg92DgtrkE1
 dwGphW4vlPS3pd6Krjea1O6+me3gQMN4AjbWs+sH2JPLGNJXZTcjVsfoueDEy78eOYOR
 J7NrLCog23HuY7FGtwlUxVaQQBAiTt/AOAdWx2tz9yKvCxKENDtsuzKeX3+QybiQnZKM
 89mA==
X-Gm-Message-State: AC+VfDzXd8babUtWQ04Lvh1WPZkKXICDUaxgBH7sihBmAf9isARbyjYP
 ZOsyj6k7nT968lN/Z7JZ4lG90k5V3mS46riZUkL6Eg==
X-Google-Smtp-Source: ACHHUZ6MmvCLJWtyPugsATEZ4HYvS6bpfHKFMp1O/9OOp5t2fHNC8Dosfg1W+9oj7qODAqvWw/cXbA==
X-Received: by 2002:ac2:5bd1:0:b0:4f4:b47d:5c07 with SMTP id
 u17-20020ac25bd1000000b004f4b47d5c07mr629311lfn.46.1686308945478; 
 Fri, 09 Jun 2023 04:09:05 -0700 (PDT)
Received: from [192.168.192.175] (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c22ca00b003f427687ba7sm2311838wmg.41.2023.06.09.04.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 04:09:05 -0700 (PDT)
Message-ID: <767f5518-7bdb-1336-2c5a-51aa829c6e91@linaro.org>
Date: Fri, 9 Jun 2023 13:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 00/22] target/arm/tcg: Remove inclusions of
 'exec/helper-[proto/gen].h'
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230609104717.95555-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 9/6/23 12:46, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series tries to do what Richard suggested in [*]:
> 
>    Targets that have a tcg/ subdir should have helper.h.inc
>    moved into there.  At the end, include/exec/helper-gen.h
>    and include/exec/helper-proto.h become unused and go away.
> 
> but only for the ARM target, to first see if this is heading
> in the correct direction.
> 
> Instead of having TCG generated helpers included by all
> translate/helper units, they are reduced to the few places
> really needing them. I expect the build step to be slighly
> improved, since the compiler doesn't have to compile and
> track unused helpers definitions.


>   42 files changed, 2100 insertions(+), 1804 deletions(-)
>   create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc
>   create mode 100644 target/arm/tcg/helper-neon.h.inc
>   create mode 100644 target/arm/tcg/helper-vfp.h.inc
>   create mode 100644 target/arm/tcg/translate-iwmmxt.c

Note to myself, these new files miss a license.

Perhaps we could have a check for SPDX in checkpatch.pl, along with
"added, moved or deleted file(s), does MAINTAINERS need updating?".

