Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C203273691C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYVO-0007P1-AV; Tue, 20 Jun 2023 06:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYVM-0007Oo-Cv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:22:32 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBYVK-0000JD-P6
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:22:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-987341238aeso536623466b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256549; x=1689848549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2SmjTR0hAzNg8VZUIpbo4cQH4qXEMAdBYJRxqY4FbQ=;
 b=XOupAi4TUZpQsopxhXw1nyFHpcshZ9E8WDUdKb8fRA0FuynyaCnClsagfFPKMWjVQT
 uIlJKelHkmxjtRyg+PeRU9+X3qijGfPEjZIeRmuq3Rhvcy7vTHG55xI5go9F6iZ28XKU
 B4S9R7fdHy6kZMO1BWQdUNDOQwOvF61vQIceaiL6Fgv8nqM+XygpENNLG7rOCk7aia6n
 BxtWgMkmcRZfjyVuH9YHdFY7dgriVfBFQgbWqadqNyYCKHNUckbHiLqC/60VaJlIASTT
 fcU0FzKrXxcKXXZF64niojlKkViQPw8k9KwkTTqX8NQSMZEM3FOdUX39BKSwxw9JftDY
 eaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256549; x=1689848549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2SmjTR0hAzNg8VZUIpbo4cQH4qXEMAdBYJRxqY4FbQ=;
 b=KCL1/vNNdG+BfudCPy8BAt8jyTwnwnkiG78J+5QCpUlM+V+N1I1CleFmpkssvJstht
 wGQ3f71G4/wMMCoU2cKnjEDofi7ugT24fWXy87th1SrD88+T64U7Qdc/lwwtAE7TrfW0
 nbrvPUWXZ/W4yBSGBgrWIDh1eh2elMUaRBEvAibr898eQcjRD23USdjtUeXGL6qcvcgc
 EYCT4tva8Ll3aKiKV5cLtf5XbA4rFngzcDRJz8F7+rbTlKxt9Hx7xE33qXbFdG7ZYl93
 u4SA1nhaiI4yPs439ksz3FqExQxiLlumts4ECbpGm2YyEZpdf+FehM/hBLuXHAfLQYik
 ua0A==
X-Gm-Message-State: AC+VfDyJA6STIK3e5h/oVaoQCj7PwmHgyMldLuttQbR5KpPov1HInL1B
 /jQRDtLRtK64Kxr/Pyf6KUvZAQ==
X-Google-Smtp-Source: ACHHUZ6XEp/exgrIaX/Kci6e9ina1+d2YcGC9MImfNAmPJRlWg9jtRpx1UPise2f/DBmrekVd9s2ig==
X-Received: by 2002:a17:907:2d91:b0:977:cbaf:bc56 with SMTP id
 gt17-20020a1709072d9100b00977cbafbc56mr12369903ejc.43.1687256549213; 
 Tue, 20 Jun 2023 03:22:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a1709060c5300b00988d0ad4477sm1127354ejf.29.2023.06.20.03.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:22:28 -0700 (PDT)
Message-ID: <cee2c931-740c-37bf-3df8-1d1528bc9ef3@linaro.org>
Date: Tue, 20 Jun 2023 12:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] docs/devel: split qom-api reference into new file
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-5-alex.bennee@linaro.org>
 <ab98c168-2ba0-111f-a3aa-f277dff6ed53@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ab98c168-2ba0-111f-a3aa-f277dff6ed53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 20/6/23 12:03, Richard Henderson wrote:
> On 6/19/23 19:14, Alex Bennée wrote:
>> +We don't currently generate the API documentation for QDEV due to QEMU
>> +macros confusing the kerneldoc tool. For now see the headers in
>> +``include/hw/qdev-core.h``
>> +
>> +..
>> +  kernel-doc:: include/hw/qdev-core.h
> 
> I'm confused.  Isn't that exactly what you're doing here?

IIUC the kernel-doc style comments from "hw/qdev-core.h"
are embedded as rST doc, see:
https://kernel.readthedocs.io/en/sphinx-samples/kernel-documentation.html#including-kernel-doc-comments


