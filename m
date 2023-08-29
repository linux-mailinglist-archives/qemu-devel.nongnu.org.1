Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3778C705
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazSu-0005sq-7I; Tue, 29 Aug 2023 10:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazSm-0005qg-Vw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:13:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazSj-0007r7-KK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:13:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c136ee106so577159866b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693318376; x=1693923176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRuLKUNlGtkSQF4NE5/TZbkFTHKARbTa8B9uwoWHMBc=;
 b=Gyfu6Jz+x5wN3/yNwsNLjEyuPJOmXE/HvyXPg88y9jCAW9XYAtFkAitIudO8kg/3oH
 cjfX7mYQsfDqLCUbLTyvu2FAFC+YAGJ3juJCAUrrOgbwLF97hqpYHJI/YwJ4XYnQMF0T
 7CokCn9QmOFnaHzOLDgUIf6knV2yCU0tSPk798E8cBJ7cDjtk302Uoevyjs6bEq4F0fQ
 xIveDfzbgQgWuvufdjP/K039vRkJHlJa/MJYJM0pXNLO2OJ0yaAYc8tvYJ6rCfvSoz+G
 UkrthQ3isvKov7SjPPGGoAqP8wSdbwcrSi4XczDvlbkgEN8fpO8LcVdW67CIO4qZgDD5
 HElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318376; x=1693923176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YRuLKUNlGtkSQF4NE5/TZbkFTHKARbTa8B9uwoWHMBc=;
 b=kDz00uVcRLs3MZwbw9ifbsnXNYDOiltMjwlhPC8R+OagmWsqkbea+icMyZlt8Iaa+a
 t6QCowCz9I5zWeugFNS7TVrbaUNi9oH8c+QPAqlQ/MizRYZEhY+Gh74yHGTlVskQxFnW
 UKDRsHdGP00Ru5tAnqGZQmRWHcvinECc2cJHbfbSeUiCxNCl8z02kQS8ywHr4C8SyeqH
 mWvoXog0worfD5LCI7OG5OdOEXEkjMxXJzt/5DD73cil2YqaBzw8cYF91trGcSMUgZ1k
 P/iyKTnMJzyXigsOamNf6VZZicikb9Rb0P0rUuouvthsnaUNjcZ51NZN3Dx7MZfm4Zo+
 OigA==
X-Gm-Message-State: AOJu0YxnRFpDSOdmyLFWV6MzrvQhgBXCscK/Cm1yHGdsKldY46YKC5bN
 BBqTTFlT6RtG1HjuSW9KtKu5OA==
X-Google-Smtp-Source: AGHT+IFNwpXMFrAcCRydyTNMhH9OHkZvwMRdwANtEHk5EtILgoJ9BFdCGfmS1pasL2mueFCguWmJDQ==
X-Received: by 2002:a17:907:1dd7:b0:9a1:b85d:c95a with SMTP id
 og23-20020a1709071dd700b009a1b85dc95amr16033797ejc.62.1693318376152; 
 Tue, 29 Aug 2023 07:12:56 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5987916eju.162.2023.08.29.07.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:12:55 -0700 (PDT)
Message-ID: <955a1ba3-e95f-3a83-c6ce-1794855ef7c9@linaro.org>
Date: Tue, 29 Aug 2023 16:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/4] tests/migration-test: Add a test for null
 parameter setups
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230825171517.1215317-1-peterx@redhat.com>
 <20230825171517.1215317-3-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825171517.1215317-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 25/8/23 19:15, Peter Xu wrote:
> Add a test for StrOrNull parameters (tls-*).
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qtest/migration-test.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 62d3f37021..64efee8b04 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1471,6 +1471,26 @@ static void test_postcopy_preempt_all(void)
>   
>   #endif
>   
> +/*
> + * We have a few parameters that allows null as input, test them to make
> + * sure they won't crash (where some used to).
> + */
> +static void test_null_parameters(void)
> +{
> +    const char *allow_null_params[] = {

static

> +        "tls-authz", "tls-hostname", "tls-creds"};

With Thomas comment addressed:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


