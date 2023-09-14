Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD479FB76
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:02:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfQJ-0008Fn-5s; Thu, 14 Sep 2023 02:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfQF-0008FQ-50
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:01:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfQD-0004rH-LU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:01:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso3557345e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671306; x=1695276106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=617ERx8Wj4YGI9KkWW6XBtrnPnavitza20LuEE/vzd4=;
 b=FZ8eeV748fIfxzn+q9V37h6HjNeX5/hpp6jbSpY4dlwzigQirsD3a1sRj9LmeSipfi
 k7Rfz7tz59CQMDO/qUAO5z7uGZOGlfhRY2IfnqmMJzw576EDFSV6plAPmf9uXW77oVMP
 97hh2bcQtzeWBdz+h8xvARoE+B8OG4axAcCvT90/pZ3Q004JtT8fmyTX2aQt0+ouxj2h
 DL0nEVgUhtM96Ey8nY3UHZUzNe6nLmn+MZJMrgYNSDrRWlXMk6ZmEXT9Cwl0QjzjsYIe
 BZFVVeGvw7lJRlcyhhj6HYxaaGu2vHP0DpUwnzoAQuPESgoDeI0Dc7OLH4GzraJ1l8vI
 Jvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671306; x=1695276106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=617ERx8Wj4YGI9KkWW6XBtrnPnavitza20LuEE/vzd4=;
 b=jbydRLJbeAVDZE5nHh4sMSvFSk5fG2MnX35ayn/IT9ymuyku+afoAHUJlS11nqnZCu
 tFgBIoH9zJLbJTA0uqs3XjQmm9WYM5l54u2uHWYlItkO57O2C6MBmnNvOxsV9YRQz7Ty
 Ms+5V471usfXG1SjwcoyEE8tHpIPJQD5Q3GFFRStheJrCarLqmt2Tmmm6IwbIGO5uc6C
 zxpAw14qu7YZamIXitLSBgRcwvOK81UnLoJR5/FejApvaHlPlEfZU0/G1ZKDHP+IXiOj
 fGpGdgiH9t7Kc8pURMjjPMWbSX6w9PEic2sapRleIhc8yqcIzFIMxX01RmdLdoamdKMm
 ZPcg==
X-Gm-Message-State: AOJu0Ywxy4UxllpJHp76i5dt3g07V84JjRg7ilPlIXCBNm4fWWlbveXk
 +N2CdMSCznWx/BsZKG0C55hAxw==
X-Google-Smtp-Source: AGHT+IF/xUVHQxVbDZg2vyk2OVzmv+g1H5X/PnsANW68+O5qoj3/gBDwdtg+hPITDI+/L2VT1wjxNg==
X-Received: by 2002:a05:600c:3b11:b0:3fe:4c29:e626 with SMTP id
 m17-20020a05600c3b1100b003fe4c29e626mr500295wms.13.1694671306197; 
 Wed, 13 Sep 2023 23:01:46 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 4-20020a05600c22c400b00403b63e87f2sm968947wmg.32.2023.09.13.23.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:01:45 -0700 (PDT)
Message-ID: <7fb84b29-32c7-7cf3-522c-6df3376d7ef0@linaro.org>
Date: Thu, 14 Sep 2023 08:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 04/24] target/*: Use __alignof not __alignof__
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> No functional change, just using a common spelling.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c      | 2 +-
>   target/ppc/cpu_init.c | 2 +-
>   target/s390x/cpu.c    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Why this one and not the other?

$ git grep -w __alignof__ | wc -l
       21
$ git grep -w __alignof | wc -l
        5

In particular:

include/qom/object.h:298:        .instance_align = 
__alignof__(ModuleObjName), \

If we have a preference, we should clean tree-wide.

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


