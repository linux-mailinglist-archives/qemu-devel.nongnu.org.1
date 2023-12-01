Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EBF800947
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 12:05:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r91K8-0005fA-4C; Fri, 01 Dec 2023 06:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91Jn-0005eo-0I
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 06:04:23 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91Jl-00005F-5X
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 06:04:22 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so570718a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701428659; x=1702033459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SlNRyPJsGCp7M905mCgHtAJMvP3M5offoq9alUJJ/vI=;
 b=msyWZE2SX9DG7fqrEUPyFq8q3zHPY3PuoxNcEQx+XL9ILQUV1ro1S6+Xt5+6k9nTxt
 WX0ONLVt0bzf+G5Ipz8SEYl4r3AQHkzeUYNkJU9S9eS1djyv/lvYpvH4eRjBEDggn+2k
 bIHD2oI0hgga38XTEu4LddGkL9IQ7y6BXsakZaKlpguZc1rqmBK9vGiQJc/qDuGbQj8Z
 zvJscwW19Ahmgy92E1FGqzyGT0IUWnm5yfb++4qm0eRG+OTT0m6uHX9coV5IipsoiMLr
 sYQW9KycR89I1efeD1L2RFrtROIvZo0/DQQWtpEEl3BjwZujr2m8yhRqQPB8mXx8GLWy
 FvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701428659; x=1702033459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SlNRyPJsGCp7M905mCgHtAJMvP3M5offoq9alUJJ/vI=;
 b=gURVcTD4F6rlPpyaVgGhEwaPyoWesXibhdj3NyipDw01t5g7dAI7ZjK4lOZEDj7SRW
 Kx9edS9FeuUek6nb6ABEtHpPbhlSznkFiP/7b2mWXiTNeOnmxwbtZc+SbiBvJURUrqpr
 rj8834SHY953aVE0nJmxTkozzfnt1tvATffpt+ooLoQGAiQTesJ3yDl/jmh4hSr2c8QG
 M1EHtpKYDfkLLbfyeQOYm6fl/GTn/aNGvKzRFIPLoa/Yp8Ohcpu/hOC/HCwsNepToxs3
 GqtdSH4Fxceq0jO8G2cPviB66xfbgyoqCAHVFYYS4CjIgTwC4uozMd6mrstL6MWfUeE0
 K4MA==
X-Gm-Message-State: AOJu0Ywek/ctTE0IZo8MV+5VA1uMpcxs71y6SfWLJsciNxZvNlCClDI4
 EVsiV11DeJtzOUXaWsnZB6akrA==
X-Google-Smtp-Source: AGHT+IELL3vwStq9nIrAn38wfCFGN++ei5d6IFXK4Z6vjEODUx6nJkxQJN1KFeo6xgwILaptQ0fKBw==
X-Received: by 2002:a50:c201:0:b0:54c:4fec:106 with SMTP id
 n1-20020a50c201000000b0054c4fec0106mr324525edf.149.1701428659156; 
 Fri, 01 Dec 2023 03:04:19 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a056402065200b0054be081df40sm1538529edx.49.2023.12.01.03.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 03:04:18 -0800 (PST)
Message-ID: <6efb4ba0-e137-4869-b0a9-05f53c278737@linaro.org>
Date: Fri, 1 Dec 2023 12:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] compare machine type compat_props
Content-Language: en-US
To: Maksim Davydov <davydov-max@yandex-team.ru>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, jsnow@redhat.com,
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, thuth@redhat.com, darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com, lvivier@redhat.com
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108153827.39692-1-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Maksim,

On 8/11/23 16:38, Maksim Davydov wrote:
> This script can be used to choose the best machine type in the
> appropriate cases. Also we have to check compat_props of the old MT
> after changes to be sure that they haven't broken old the MT. For
> example, pc_compat_3_1 of pc-q35-3.1 has Icelake-Client which was
> removed.

> Maksim Davydov (4):
>    qom: add default value
>    qmp: add dump machine type compatible properties
>    python: add binary
>    scripts: add script to compare compatible properties
> 
>   hw/core/machine-qmp-cmds.c     |  23 +-
>   python/qemu/machine/machine.py |   5 +
>   qapi/machine.json              |  54 +++-
>   qom/qom-qmp-cmds.c             |   1 +
>   scripts/compare_mt.py          | 484 +++++++++++++++++++++++++++++++++

"compare_machine_types.py" name is more meaningful.

>   tests/qtest/fuzz/qos_fuzz.c    |   2 +-
>   6 files changed, 565 insertions(+), 4 deletions(-)
>   create mode 100755 scripts/compare_mt.py
> 


