Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1824724D25
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cSx-0006uV-MT; Tue, 06 Jun 2023 15:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6cSu-0006s9-Ec
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:35:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6cSs-0004la-J8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:35:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so56427075e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686080132; x=1688672132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1hAgplsaNg7l6qHOOxn0T/+YQYa532KUjang2oMLeg=;
 b=B5wq7QmtRCO+802Nd18ud94XIIFGgs2fECozQaHjzlsOHeUbuc+QoSvnA032oqyCHt
 jEKoNIR92K/TX+hqI2eK6Jeb6mCU5HmLldu3w3FDnH1eFDb1pMEJXgNQ6vN1TvupVYS2
 qTfIY7kGqRP/L4NiUI6ONseDjydMbDrnxHmuixU6ga8upNro/W3Nn8PyrPC75CskXhkK
 LvSXWsv7ctnqeztFTRglqH4i2+JwK9LtuNVp745TwaBjOK6aIUsJv3Um62AIf5wIztPH
 Nb+d8Beoupa1d4iQQIBYYjj2TS12us6YPab6EhzfYFM4ice3rwb1WGUBYPRH3eMo6eYm
 VdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686080132; x=1688672132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1hAgplsaNg7l6qHOOxn0T/+YQYa532KUjang2oMLeg=;
 b=Ogof2T8RBMKwGACuGFA3BS6a9ezEQx9vMSBtqo+pF+uJ3SveyuzqwzTPSqQJe4uabI
 Ieka1+TsT+rWNb8BXi4f995tDL885ixs2donImpq1Ln+uC95UrNypMzEdHEj4tgxdMMm
 j/At34BPimLkWhjJAEz24pDbeKfllqnV3tK4J+bzYYoWr8vF0t09KZNX2JnlY2l6Tx57
 BqMsUo5ZTq4FgASrDC3hVkKqSmyk7vfGDLncLmqzbkTYZp4khw/Ezy23CLEEtqDOBkZ5
 tY72LYoaWS1kD0ywrRATplfHcHkW6XAS7lJizxA+l7lz6Fru6wO/Ur+YSWXKg2S0DG1x
 zdpw==
X-Gm-Message-State: AC+VfDxOR3KBlC5ln6b5xX7Kb8I9PqVmBiT6IUmSsy5dD6wT3uo0B+Vz
 /5ULkRV14aB1acrmN0PNGQsxfQ==
X-Google-Smtp-Source: ACHHUZ5h55Vnf5YJZQhYT+6TPJi2HUZyMmdLHr1F7aotSvZpUENwA7wVRH49rk0pGEJBgvlpYnCHJQ==
X-Received: by 2002:a1c:f703:0:b0:3f7:2e89:f306 with SMTP id
 v3-20020a1cf703000000b003f72e89f306mr2809575wmh.21.1686080132615; 
 Tue, 06 Jun 2023 12:35:32 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003f195d540d9sm18345351wmr.14.2023.06.06.12.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:35:32 -0700 (PDT)
Message-ID: <ee20d8af-07c7-875f-c61a-6eb054efad25@linaro.org>
Date: Tue, 6 Jun 2023 21:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kautuk Consul <kconsul@linux.vnet.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230606192802.666000-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606192802.666000-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 21:28, Thomas Huth wrote:
> The ppc64 tuxrun tests are currently failing if "slirp" has been
> disabled in the binary since they are using "-netdev user" now.
> We have to skip the test if this network backend is missing.
> 
> Fixes: 6ee3624236 ("improve code coverage for ppc64")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/tuxrun_baselines.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


