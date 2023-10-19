Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6597D0379
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaCw-0005M5-AK; Thu, 19 Oct 2023 17:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaCu-0005Kw-Lm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:05:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaCs-0001lR-0x
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:05:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so929625e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697749524; x=1698354324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFl2ji8+//0+81DwhPVsjK2/39szvGMxC3Hhtp31NgM=;
 b=SuiFlYM0gD0N7+G3elVz2vTIXCN6n82Qk8hdxpVS9kqMSwhXXnVGThQldFhrmM7be1
 EbeZmkPZvrE1RQe2EB8bpfgznCGu9G733T0v+dyg6SFIoxFNCLmuJCm5YeFQqUrS72yG
 hbH1lm8u1H1g2Spfkgz1G3CKk7KGz7VVHWtSg5PYX9kb2sytmx9c4l9YNhkiueRsXmaO
 J02iL6bLaGkYpQ8S1ANIEMsnsBO22BCTiIRXD0IEsEcnGb0N+XkOB2sNDYVU1sL1zXAz
 9XoCn/LmHYa6Es2I+AzQAaqCl5ypapkzxwrJBLWTTGRe1qHSMu+VPnOx1HlX2BYelEZK
 qnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697749524; x=1698354324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFl2ji8+//0+81DwhPVsjK2/39szvGMxC3Hhtp31NgM=;
 b=QXcBdhJZPmgcVRnRO4gW2DmgBUutjq6KNbXt8jQ4J5Yd1IN7YGNkUd+qqFNWhbaIcb
 rNnQwLjR+ZM35208yO0ZEWlP4eeg7D4OvCWxb3O6AKg6iNUkNq+xrRaDTj3QyA0VLK8E
 GxPrkPlAgoxRkeU12h3/QSveqkoaY+FHXdhldFddbSuH67ld002Z+KPcbZCMTj4dM/jM
 xJ6MKx4Ek/LguNSHegtabe4NVitSrqQmAVdtKS9ioEA3+Apwmrcc5+tVrgWUjjDkwq0T
 d/IVWeY9+tdGbomHhqsdSiStpe01AUcGakUSPixADF3QjYm5zRw/yhF2Ol/QrwMu0otG
 7c2A==
X-Gm-Message-State: AOJu0Yy6eYa9GxSwVcNvOKl/cbETtkZ1U81tHA+S9gc1oB3AguTjvAKS
 BY2/jEXf95MYgOcN8RZTz5vOnOy0AfOnINbmRNvheg==
X-Google-Smtp-Source: AGHT+IHnTBHbkAra7LUivzWxIbnQLba1h5TAalAD5eZInlbSwcTbFqqu2lHhmVn4Osx0daFML/Mjsg==
X-Received: by 2002:a05:600c:350f:b0:405:75f0:fd31 with SMTP id
 h15-20020a05600c350f00b0040575f0fd31mr32970wmq.31.1697749523959; 
 Thu, 19 Oct 2023 14:05:23 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 o15-20020adfcf0f000000b00327de0173f6sm188210wrj.115.2023.10.19.14.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:05:23 -0700 (PDT)
Message-ID: <dd245160-3921-ff85-dc40-b2a9e01a26a9@linaro.org>
Date: Thu, 19 Oct 2023 23:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] semihosting: fix memleak at semihosting_arg_fallback
Content-Language: en-US
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, alex.bennee@linaro.org, qemu-trivial@nongnu.org
References: <ebb2ec1150da633507c2b735ca8ea1cab05ec92a.1697740364.git.quic_mathbern@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ebb2ec1150da633507c2b735ca8ea1cab05ec92a.1697740364.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/10/23 20:32, Matheus Tavares Bernardino wrote:
> We duplicate "cmd" as strtok may modify its argument, but we forgot
> to free it later. Furthermore, add_semihosting_arg doesn't take
> responsibility for this memory either (it strdup's the argument).
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>   semihosting/config.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/semihosting/config.c b/semihosting/config.c
> index 249a377ae8..32aa210460 100644
> --- a/semihosting/config.c
> +++ b/semihosting/config.c
> @@ -112,17 +112,19 @@ static int add_semihosting_arg(void *opaque,
>   /* Use strings passed via -kernel/-append to initialize semihosting.argv[] */
>   void semihosting_arg_fallback(const char *file, const char *cmd)
>   {
> -    char *cmd_token;

Preferably using g_autofree:

        g_autofree char *cmd_dup = g_strdup(cmd);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    char *cmd_token, *cmd_dup;
>   
>       /* argv[0] */
>       add_semihosting_arg(&semihosting, "arg", file, NULL);
>   
>       /* split -append and initialize argv[1..n] */
> -    cmd_token = strtok(g_strdup(cmd), " ");
> +    cmd_dup = g_strdup(cmd);
> +    cmd_token = strtok(cmd_dup, " ");
>       while (cmd_token) {
>           add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
>           cmd_token = strtok(NULL, " ");
>       }
> +    g_free(cmd_dup);
>   }
>   
>   void qemu_semihosting_enable(void)


