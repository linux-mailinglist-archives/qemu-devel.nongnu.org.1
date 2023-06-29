Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D874279B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErv2-0001xn-W5; Thu, 29 Jun 2023 09:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErv0-0001p0-Cs
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:42:42 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEruy-0002ZW-Lj
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:42:42 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so1042622e87.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688046154; x=1690638154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPADWGwZmjUgnQmKWu0+eC9DtoXBCG6ZErOMiLFVLqU=;
 b=lM8dHHGsrUfx5Uqs3WzGtt9M5LcmD+1qC8hVgtSKrW067VJ8286HbZ80G4RIHkGrO7
 VpKp/tRzbKf3O2mHixeVVvA5d+MfTPGhT6ePt9WtCR9tmD+k3ipmVQN2B6eA9PtkNlLo
 CjvlAqYbbZTN9JA6RJvTPyNkPA6INKa2ee+DdVej0LuWpFjT3q4CHas4fSDH8CCS8pR+
 PpbUXRsGbWgGcIJDyE8IUgePeuCp1lgbK0cy3V3xLzM3ZG7hf9LFzloX3qFDRX1eQdSz
 NT3+JKApQ9jtNxKfrmVNGKLSzpFj7MOT24ALbTg8dbvTmmGxm9y3jJUDDph6OfuVU53a
 m6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688046154; x=1690638154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPADWGwZmjUgnQmKWu0+eC9DtoXBCG6ZErOMiLFVLqU=;
 b=WbJoq8yTde3EJQMQYqpi4AoSzimUqSvbdihHyFEPEyOvgXGytfP0tB/lx8GdSWiXWW
 SGT1iskvwFX/htij6BqTLtqJs57jzBqsTDUfZVmiJWmyRQzz39p2tgWhobgAPOdLgsra
 kvihZibK3VTPibEUl2z8Dx27rJkBa5n9R4MSYeP3FzeQoAYi7sqcCd5xSkC6MDZg1w/s
 8n5yya68BTculqElicCMyLXZSiVD2UhAijEYmcPbS5KZ44CrSBclQBmuouSKj2qVofSJ
 05uen3lzgthaeyq4F8bIeYwWXHhFIRxwDEkCM/MAk4SmLtyswdunqwO9YHKDhwLqC5Gf
 MjRw==
X-Gm-Message-State: AC+VfDyAbdFl2qjsIfoU6g2L2utzPMQqJJl2YEpNbp1h9XWoMrw/Br26
 7wz4vzUMCWe3/Y68XWHbGvgHcA==
X-Google-Smtp-Source: ACHHUZ7v7zJQmkwnzblu7B0J6h5DwWsQOGvbYnRpywTkNbJbRD08qPeXhiO9JiiizLRVosSoLTJ4Mw==
X-Received: by 2002:a05:6512:2117:b0:4fb:8966:5720 with SMTP id
 q23-20020a056512211700b004fb89665720mr5183778lfr.25.1688046154151; 
 Thu, 29 Jun 2023 06:42:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a7bc8cc000000b003fbbe41fd78sm1146471wml.10.2023.06.29.06.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:42:33 -0700 (PDT)
Message-ID: <6baa05eb-ab60-8bef-a57a-9e74088bac0f@linaro.org>
Date: Thu, 29 Jun 2023 15:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/36] docs/devel: remind developers to run CI
 container pipeline when updating images
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Ani Sinha <anisinha@redhat.com>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 27/6/23 18:09, Alex Bennée wrote:
> From: Ani Sinha <anisinha@redhat.com>
> 
> When new dependencies and packages are added to containers, its important to
> run CI container generation pipelines on gitlab to make sure that there are no
> obvious conflicts between packages that are being added and those that are
> already present. Running CI container pipelines will make sure that there are
> no such breakages before we commit the change updating the containers. Add a
> line in the documentation reminding developers to run the pipeline before
> submitting the change. It will also ease the life of the maintainers.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230506072012.10350-1-anisinha@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/testing.rst | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


