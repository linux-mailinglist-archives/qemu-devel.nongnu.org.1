Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F88014B2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 21:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9AJE-0000ss-KA; Fri, 01 Dec 2023 15:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9AJ8-0000ru-54
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:40:18 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9AJ6-0005lI-GZ
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:40:17 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so369793866b.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701463214; x=1702068014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=omWx0ivN1JbHTna1zIfu5jObd2Eaa29yPeazVzr4Zv0=;
 b=WC/ag1ES3/WlxHAqmCnW4kvCi+UEhUcOHVSo3eZYYEOZmRuHF472eV4II7/NZ1sd3p
 2BPgQ4T0Rbz33zo0pFuejv5EgbhiqtdGFOeAGBb6pKPCKkpfpEk2ak1G5N2bFmqeljrH
 /GeYRQWy4zlBo0HGybetztQjS+h8hc+15bG5rAsWUtGk2QBOGB0YDrqAMhASdP8hKvyO
 ius/vsmSqMpop0roHIzA7v5J67gZBWwxB+23Z0w68n7ioimHue+gSBm1c1D+uPiAtl26
 0L8z1ilJQnYeu90WEdefSHR1d6d+MXoxKU9xRqDREZFT+ggsSdshL962Y/bujRJGukOO
 oVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701463214; x=1702068014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omWx0ivN1JbHTna1zIfu5jObd2Eaa29yPeazVzr4Zv0=;
 b=Br9Yt6OlfNPKpCttT38I2Yku5GENAfNFqa0BzZPvX+7Ox3oU1A5nV5/xVJ8UNDrvkU
 faj68Zv0KT8IXSZyQDofgyswBMSRu1I01XHwExdIKfayU5oRFrpUqUuNtH4Y4rAf/LFR
 fdhwjmf2KtM2FEkyIHzY3uEi6eJdtVBlk56oiAOxSB3FDO07I+oreJ5KGTpPyKd8HQ4i
 KwPspmDp+CNcT5A8LO1/kjTXIwSoXSSBBgbn47F98r39i8c+lhW4daBx/E2TBKzbKAVx
 wqcD9Bxtk0Qt8/ikymqFkPgrP18eCHO5OzjTxbgrWx3tSOVUmcMEeou4Hc66Ea7yGwb2
 23ig==
X-Gm-Message-State: AOJu0YzG0/UXN2X9CHuWA9JYDbOlh1ejjYnNs9RB5tEa/+MBlumWiQce
 sYKlwrsvW40/rYERXRD+NOp8Yg==
X-Google-Smtp-Source: AGHT+IEtzaOHNa722Uzn9Rr2cprb9eGvXiFfnLl3C+NSyMNcu8OD+5fPdiAs25ovVSjFzqzCykDAlQ==
X-Received: by 2002:a17:906:6606:b0:a18:c1d8:34ec with SMTP id
 b6-20020a170906660600b00a18c1d834ecmr2197406ejp.67.1701463213857; 
 Fri, 01 Dec 2023 12:40:13 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a1709063b0900b009ca522853ecsm2270809ejf.58.2023.12.01.12.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 12:40:13 -0800 (PST)
Message-ID: <fed51ed3-f1b2-4340-ab61-e18ab7c097e3@linaro.org>
Date: Fri, 1 Dec 2023 21:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/avocado: mark
 ReplayKernelNormal.test_mips64el_malta as flaky
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231201201027.2689404-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201201027.2689404-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 1/12/23 21:10, Alex Bennée wrote:
> I missed this when going through the recent failure logs. I can run
> the test 30 times without failure locally but it seems to hang pretty
> reliably on GitLab's CI infra-structure.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/avocado/replay_kernel.py | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



