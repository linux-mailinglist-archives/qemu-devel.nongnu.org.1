Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E41734467
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 00:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAemi-0000OS-Qd; Sat, 17 Jun 2023 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAemh-0000OK-KI
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:52:43 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAemg-0005L0-0j
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:52:43 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so2596437e87.2
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687042360; x=1689634360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hvs/PhxDm6j6OerP1wbLJHvchFgnlQHhNRWbVDGNGcw=;
 b=lRxV4Ua1QMJOjC5v8TSjrPktd2uxyAUx/zc7wH8ZMdOq4G08s30PFnUBcL5a4B/tuy
 B5sHL6iPsB7uBj8k4sLlKpZH4PwhVxzSbeLWSNTyI87s9N4I2E2R7jE/sOS001z760/w
 gKtdP/y5auv9JobWQp+6rX3oFffObGoZSAjK2mjZ0bSyY0FrxsbK6X6wRKu4wtVpn8la
 dD/nEAX7r+NK726WQCc2NKbwr8w0QUwK3k25g3E1BsvtzzjA7U4rMjo+bxlshObVTsEW
 n4Z74Wpm7Zrj7n9QLiUZ+q5M5nhvmkIkMTJDatCdz/QEeO8Ym89Nqwi/5um93padNqVF
 37WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687042360; x=1689634360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvs/PhxDm6j6OerP1wbLJHvchFgnlQHhNRWbVDGNGcw=;
 b=fc5VF7X3pSkZ3/uhfMyHEh+nFSko5EtEPRG1dWhzeCYr+pPQY9eVliCLQ9MN3aYUsX
 to6imOaLJbXybTMFvQlPxZhArTEy1Cs498Mit7SSarqZCcd93TIc3Clx8fZPpQWlUFZG
 PmmH7aw4wED7WCiVO5UuMs7yvJ/KAOHyK4m6l8D75hPgYqXs3tVcT+oFeO/unUc85vaY
 K32+jKfLcjk0JbpVpww9R5neUkkNVs1QS0kKG9WbFnkzXj0BZ4C4i4inwNNjoz1v1vxu
 42UsmPek4Du9gEYFflYhDfME59XgX6wAq3USW5KOb3NjmzSwfVSvk6UYR3f538+XfWVm
 buww==
X-Gm-Message-State: AC+VfDzIKZlnenBsWjYpmcx+hBlfd9fisohHKF27KyhS43faeMog3gmJ
 gqvU2NnYpkkyg1tcVXkj/xjXUA==
X-Google-Smtp-Source: ACHHUZ6EUI4gG5ZVO89iDJ1gfz6Fk31r8toC0+6xpYQR2E6olDOpnUe16ZyTgkAohoXz2Hy5KXkHew==
X-Received: by 2002:ac2:5045:0:b0:4f8:4392:4ee6 with SMTP id
 a5-20020ac25045000000b004f843924ee6mr3760490lfm.10.1687042359926; 
 Sat, 17 Jun 2023 15:52:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 cr4-20020a05600004e400b003063a92bbf5sm27494367wrb.70.2023.06.17.15.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 15:52:39 -0700 (PDT)
Message-ID: <3021df26-c91b-7934-403e-7cd684c51081@linaro.org>
Date: Sun, 18 Jun 2023 00:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/6] tests/tcg/cris: Fix the coding style
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-2-bmeng@tinylab.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230617053621.50359-2-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 17/6/23 07:36, Bin Meng wrote:
> The code style does not conform with QEMU's. Correct it so that the
> upcoming commit does not trigger checkpatch warnings.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - new patch: "tests/tcg/cris: Fix the coding style"
> 
>   tests/tcg/cris/libc/check_openpf5.c | 57 ++++++++++++++---------------
>   1 file changed, 27 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


