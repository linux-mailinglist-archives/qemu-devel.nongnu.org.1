Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E77A03E1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglTn-00045K-LZ; Thu, 14 Sep 2023 08:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglTj-00040K-F5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:29:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglTh-00071h-Hh
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:29:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so121040366b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694694587; x=1695299387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jw4Hfo8TH8sgjRLsFOGJsKNdsCAQUPtxKM5/nbg9gN4=;
 b=EyzGvgHLluT3mJ9KRNHPoT0ZMkIO6jc7I4VSYBjUlshaws7StqtuLHDNjg3ztbm+jY
 5geOiwMos6Pn1ZhHm5W6lOHVsxlpTVoTbYz03wSLxdIFf5ZQ/nn8Rn3mFdd+dNErr2Dy
 /s6jFqu6KNWMeVJknXWjSehWJyP8rvCDcT6xyqwew4yniMIfSB4j8ODtoC4Er3pQZIlf
 skRcA4+fANfqqKQXfqj5MS1oaO4G51Ji50cXPl6k4uIenehWmABRYQ3PYgezSruOgygb
 EINpaZ/0wd9sAn+mHwddhouEbt2EWfKFDSxoBi0mJ54L7fMrwEdOTW4JUdTlUom+bFN3
 DjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694587; x=1695299387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jw4Hfo8TH8sgjRLsFOGJsKNdsCAQUPtxKM5/nbg9gN4=;
 b=td41av3STP/+a7bltdJNs3/ZYbXvewxctV7qKvjEsOrXD+xb2oQjdZHPsURE94/R3J
 jMny79rndf+m65VpTUgTuiZXKXhNkPcCTmdvddJQ2Xa9dXrqazZxPtiFhShA0ZB7ub54
 hYxw7WZPr7i+K17rOuEFa4YWH1Qi/MmalrSXwPljbv8OjIKDnpfKFfXd5JcSh6MTFb8V
 IxV3fwUeIov3f2pJe1Motv9Y2PmPvb2p3z28gd+P1BXEb52HOfEKHI5eCSHrQzdeOGLK
 RI9WJyEopr7WU9gbS8qpjKgrplZ3Xl0RUOw/NJ7yFnOz6bpCHwIlxIRku1tOYe/xW23F
 a28Q==
X-Gm-Message-State: AOJu0Ywb7mCNZWqbQC279KJyoj0V7DDeUjbSWtKB7HawwJ/BJlwwiT/G
 3QQ440IuU2BEVoicCLucS1gyiDXjNKtrQWMnn4U=
X-Google-Smtp-Source: AGHT+IFL2p+Y2pAchcmQ38M5PXXfA7wNRL8pT4Ja2y4nEPAKMDd4BijI1/bIHNQ38783UOVja+GgZw==
X-Received: by 2002:a17:907:75e5:b0:9a9:ef41:e5c7 with SMTP id
 jz5-20020a17090775e500b009a9ef41e5c7mr4159453ejc.8.1694694587638; 
 Thu, 14 Sep 2023 05:29:47 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 cf20-20020a170906b2d400b0099bd453357esm945557ejb.41.2023.09.14.05.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 05:29:47 -0700 (PDT)
Message-ID: <703f0e35-128b-0c0c-4c8f-0fd182095d18@linaro.org>
Date: Thu, 14 Sep 2023 14:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 01/12] gdbstub: Fix target_xml initialization
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin <n.shubin@yadro.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
 <20230912224107.29669-2-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912224107.29669-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 13/9/23 00:40, Akihiko Odaki wrote:
> target_xml is no longer a fixed-length array but a pointer to a
> variable-length memory.
> 
> Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   gdbstub/softmmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
> index 9f0b8b5497..42645d2220 100644
> --- a/gdbstub/softmmu.c
> +++ b/gdbstub/softmmu.c
> @@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
>           assert(cluster->cluster_id != UINT32_MAX);
>           process->pid = cluster->cluster_id + 1;
>           process->attached = false;
> -        process->target_xml[0] = '\0';
> +        process->target_xml = NULL;
>   
>           return 0;
>       }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


