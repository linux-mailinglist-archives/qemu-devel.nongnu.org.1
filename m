Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F657DD09B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:34:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqkd-0006bq-BG; Tue, 31 Oct 2023 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqkb-0006bJ-Da
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:33:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqkZ-0002dF-Up
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:33:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso44906475e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766430; x=1699371230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZkVb990c2uHYawsLtRTnBlt1hfWy9tZjcq9JDaZNum4=;
 b=KwUQzYpYiDesXxtS8uylhwVmGaBLdvntJ7Mx+8WOFDIymS0937cSJCThvLUP+6bprk
 0xuthnqOFlvoiDH3jGDi6MLiez0/IaDiBRmXOwIar36qfD4H/YoFNd0Yiia/qoMCFwLb
 hPRpuxXifYJ9U+7gIg4P6YniMEzCyUgsWopSTP2cyLvDYVThA7upKMt26YfEmONN029f
 uFIJDflbaqp08fUT6h+e73Eo/2v8d+tE8bPskrHK/7FswZIrCVRi30cGJ7OWUiWZ7xes
 W10/Y3suo1p2bdztCpZPn/X+X7umds6nG6jDaD++4aNjLtHfbz4I6MFS8a15qC0Ks2n7
 8c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766430; x=1699371230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkVb990c2uHYawsLtRTnBlt1hfWy9tZjcq9JDaZNum4=;
 b=nRdFZCokuU4em9m5AWsvEnUBJBBjsgUGDU41bPQzoU4+3l+dokwXSgJX7Nk+8eL7ZA
 7UZnLfzsqhL+tTKa5sZ5FPInDKs9M3GCo6ovAb3+0B4uoFeUlbfC640AbkE9Y+FRmHum
 aW518OT9J2T4vxpf7KxB7ANyNBDLbLuiQMRvg/bNfBeUyc3Dyx+e6Br6joSylbfU3wa9
 lU1wd3GdjwN98rfZMcBoRGtocDnMuyZKIiS1n+qY5lwqxNbWx74WYSa293lxD1bhXKzE
 GhwvEqMkoNdLdgjU4brAtYjWWafTZ1h2bD26LmSa0A/Z2eOjqoL+UwqVB3gyB0nKSKMa
 C5qg==
X-Gm-Message-State: AOJu0YwcpGTVgBG/wknlxbIrLirBBIgk68i9+t2kxvmhW3oCj9QljixK
 3RH7c+PhNctCixxZn26XjQOqhA==
X-Google-Smtp-Source: AGHT+IFFxRVRYVIpPVj6CW8LNHFwaoxaY4OdRHlmuOfy9LzUjwKjAQEm6uPLTHvnHrnXzxcWJ7bF5Q==
X-Received: by 2002:a5d:458e:0:b0:31f:ef77:67ee with SMTP id
 p14-20020a5d458e000000b0031fef7767eemr10134108wrq.40.1698766429978; 
 Tue, 31 Oct 2023 08:33:49 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 z6-20020adfec86000000b0032f7fab0712sm1778275wrn.52.2023.10.31.08.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:33:49 -0700 (PDT)
Message-ID: <bfb1b83c-53e2-73b2-bbc9-3cc0c448ab17@linaro.org>
Date: Tue, 31 Oct 2023 16:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/8] docs/specs/pvpanic: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/pvpanic.txt to rST format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/index.rst                    |  1 +
>   docs/specs/{pvpanic.txt => pvpanic.rst} | 41 ++++++++++++++++---------
>   2 files changed, 28 insertions(+), 14 deletions(-)
>   rename docs/specs/{pvpanic.txt => pvpanic.rst} (64%)

$ ./scripts/get_maintainer.pl -f hw/misc/pvpanic.c
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

$ ./scripts/get_maintainer.pl -f docs/specs/pvpanic.txt
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

No clue who should maintain that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


