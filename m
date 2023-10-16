Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C887C9FFA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHSf-0002x4-Ev; Mon, 16 Oct 2023 02:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHSd-0002ws-Ag
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:52:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHSb-0000Ag-Q9
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:52:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso2624781a12.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697439136; x=1698043936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1133wq1tayYaTghjZ5dkVVaMxlPoezIw+IZKh964zw=;
 b=HOgqUJbcsv+XEVMg5YT4mzxNYCvzCFptNmAxOiaotY2iyARGSlt92n7bBO6a/Aesq1
 HsgFYkNcLZCO9xgTolAgR8wQA0wmuudH2D4B18lulHq6B5JDKUeFXISH2q/R5knj2Jll
 2HM+mC3Iha5ug9Gkxd+21do6chsKPEiPrj9EWol3Qmm4ZvziR2qn5P34J3FktTZCVyKo
 RtWPBYruqJ5I1GtxHhBRLgsJ2IY5nxBLB7IHaHvpPKO2pwf7o329HbwVVgZvUx+c8KSu
 THrNH8Sb3xwP4DjPUu6nh2GAZsRwGAy9naJIc3wlNzeJyqloALxac/rMeh16VD9IwbCz
 IBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697439136; x=1698043936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+1133wq1tayYaTghjZ5dkVVaMxlPoezIw+IZKh964zw=;
 b=dbw1wqDirDPklpcSHvnIEns59Cjtr0kNc+pIGJVyTy0Wasgv9DAPa8kj3fU5EUzsgz
 3zAVlABiprRZ6Mb+a1CIsFFqpQT42gQkVVvCIktQpfe+dzuJc1TfuJDh1F9tm03Gx5mS
 LN3cGJOxFkJSISV/SG2oot+VkvejAkZgMAfJ8Tv4bQiF3jgu+0ryjso2HlIMuB+3aaZv
 6p3vgEV7YFhOenmG5girD3XNJWEE37JsL1Iq7N8FYajYL5n7RujnDVz/yM2KHnKemDD9
 bWXR1isU4F0rwE1bT/dLS2QroYaQYvDbBKt0jZqV7Va3n8YyVokurCwVp2lErlMbTmBN
 PwNQ==
X-Gm-Message-State: AOJu0YxDLqh9GVDf8Vq32ggtz3wQkZwUXf+Z5my5G/b+AYksxmZ+C/Z+
 s5qlWj6MRqB+g+rQlTV9u7ZVg1FKCgd+siw+UxQ=
X-Google-Smtp-Source: AGHT+IHYyP5OWBdKn2nlLgu4RbNEbzxIgpXFlGWusbM9ep0qIQbE7ZzpMKG6pDdExcZIqCGOmmbXGw==
X-Received: by 2002:a17:907:928e:b0:9bd:a73a:7a0a with SMTP id
 bw14-20020a170907928e00b009bda73a7a0amr7319260ejc.58.1697439136072; 
 Sun, 15 Oct 2023 23:52:16 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a170906c41400b009b9720a85e5sm3413802ejz.38.2023.10.15.23.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 23:52:15 -0700 (PDT)
Message-ID: <7f5125f7-c5a1-84ba-f26d-ddec39482626@linaro.org>
Date: Mon, 16 Oct 2023 08:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 10/85] target/sparc: Merge gen_cond with only caller
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013212846.165724-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/10/23 23:27, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


