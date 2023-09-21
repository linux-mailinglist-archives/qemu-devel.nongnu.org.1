Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF37A937B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 12:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGh2-0000u4-4j; Thu, 21 Sep 2023 06:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGgt-0000qE-P3
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:13:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGgr-0004jb-A5
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:13:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-532bf1943ebso907400a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695291223; x=1695896023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JVk6liT2e5o5msU4AJSAaszsi8TWq4Fo43OiSTrLXMM=;
 b=jVmHkvUqynOkVJpROya97olEpDAhIYD536mxvGm7PfFxpYmL97UbOt2n8CbhCDmUtM
 WiVBgqxvDhOGvC0Fa9fFrls0cdLPOvuzZgv/7qqmVk7y40JxsIoN4rslaeIm9wk5C0DO
 BnDur9AhggsVz5FK6AKbdRzDOv2cVA43MoldfamyLIMnHk3zKKu2KJf6GG0tyX9utTka
 HHE4GYJLxygdw4pT37Hqq56k5CWL/+2eGf+nN+TEEnvmaEG9/ZNqh4m1e/3/cxRh+6JV
 wN2zYOIVKBXQ1RTv2489+iHA0BRg11dLx7V6QYU1rRlALB1am7oG+MzJuw4Kl51pRZji
 kApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695291223; x=1695896023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVk6liT2e5o5msU4AJSAaszsi8TWq4Fo43OiSTrLXMM=;
 b=DthPm5J0WSzOwZg2csrAHhL5TvLv9nxV9IaGRD8QsMsCt766xTU6JPPt+J8i0uMOuP
 HPuh+7Q4wTwbH3DIAOo7bJGhBalwV5q6qnbjxOdOM8k7cFXNa4xHm1b4CYSq4+0IVPFv
 h55PwoPSam52KKt66VRdRb8ylwv+8kUqlsCaAOH7EJEmoZNp0Gf4OPHc/lZQtjQA5vw7
 m5KDRSbwo5p3PImC5LSrpFcg9J7RueToKW8pDMBw7VBBUEmFDpL5zipKRtlp6D1/IW8F
 w/gdXWU31zNPzphjfApb6dlw8N72mk+XdeXkb7r+UyzEEp/a/n1J8mm86dybcPll28XB
 T9Wg==
X-Gm-Message-State: AOJu0YyLx3teqXjKkKAt8GwJJHqFncHwDKFWYlMZY/vYlY467+LDITm2
 WhUDSKk3B5mdSlrlpOVlDARiQQ==
X-Google-Smtp-Source: AGHT+IHemFT05Lsyt1bPCI7dAYN7sADw+ssaGPNBsPCuMF5tPCwixS6QQS4v1QyGGe91VtcRi/aWEQ==
X-Received: by 2002:aa7:d954:0:b0:530:c34b:8277 with SMTP id
 l20-20020aa7d954000000b00530c34b8277mr3704814eds.6.1695291223359; 
 Thu, 21 Sep 2023 03:13:43 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 b22-20020aa7cd16000000b0052ffc2e82f1sm625907edw.4.2023.09.21.03.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:13:42 -0700 (PDT)
Message-ID: <76731e36-4379-ea64-d97b-5afcb21d1fb0@linaro.org>
Date: Thu, 21 Sep 2023 12:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] vl: Free machine list
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230722062641.18505-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230722062641.18505-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 22/7/23 08:26, Akihiko Odaki wrote:
> Free machine list and make LeakSanitizer happy.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   softmmu/vl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..802f728298 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1484,7 +1484,8 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>   
>   static void machine_help_func(const QDict *qdict)
>   {
> -    GSList *machines, *el;
> +    g_autoptr(GSList) machines = NULL;
> +    GSList *el;
>       const char *type = qdict_get_try_str(qdict, "type");
>   
>       machines = object_class_get_list(TYPE_MACHINE, false);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


