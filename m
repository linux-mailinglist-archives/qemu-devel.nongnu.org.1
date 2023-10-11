Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E67C53A2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 14:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYCq-0006Wd-71; Wed, 11 Oct 2023 08:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYCl-0006Vy-Su
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:20:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYCj-0006DK-62
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:20:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so1224505466b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697026843; x=1697631643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MpNtfuDlhaes3G/dLNwyDGSar9tVrmw/aWa66seDdn8=;
 b=nhIsK7h1xxmY7LGzXTMeM9K0zIgOD8k0MOoN79KoceuBTtOIOu7vcv9WKCr5nBz/es
 wWZ/rhBmtWDRrZ8idxOv9QUgm6zGSjGKotaJQzjaAL8kLLwWX9udsjw9J/QBKa556Oxg
 Pxzw8r65qSI4ajW0WnH63y1qVzqaZ03Jfcg2IUexNI7F4rDuQt+YbFg4N8mHmdNJQsW7
 xwvOnwu+IiUDlIEzudyWZ5YIIOHVc85Ckv5//oRd/iUjQiQHvz0Y3bZS1ighJofWQKkU
 BXbYCpg5s5bmt56Gb/CumJvxHHZ7RColuxJxSsDziVrPBZY+ib2HHYZEnSoX8rO2NAuD
 uTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697026843; x=1697631643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MpNtfuDlhaes3G/dLNwyDGSar9tVrmw/aWa66seDdn8=;
 b=GCKrhuvwkBgzBad96I+c2MVQ3IG+giFVmQeWQQU5DXhGesPx2dzKFfQ/NzcUxK1/fm
 bn+AuegZ6irBMEkqKZ3qns7t7/LRgtR2Zqg4jVNxOd6YlnnVfqjgOHmNHUnYTlTsWhHL
 ti6Ikc0S0FET2ugF0hFoJzlYDAhspLbKonI+xXW1SZcQDrYAPP+sMErf8pc31YILBeXs
 zvKU9/m1kWOpP1rucQdgOexFCPemTzNVMdWnOMHAP3QF9O6ps8Datk2BOqqUqHlWXUqd
 NuQ/NPpc8yFFnT8Jk6Wfo8Zfd9GNsjc4IFELNkkuEiTrl1hOnbV35/4KG1g3AAhfXOEE
 RNkg==
X-Gm-Message-State: AOJu0Yxj8hz9sbtFBmkGyDqQGinMGYMk0UipftiSKqHj+SQbVyoHgOZq
 c8UPsfpwzJuhuh53ffY0B9EXMw==
X-Google-Smtp-Source: AGHT+IFNBozNMJtMmD6pCKq7h3joQK7Pfd6w3fzjetoBj2I4+jQtcEyiVETByfquoGE9vNwblzvRSw==
X-Received: by 2002:a17:906:7484:b0:9b9:f980:8810 with SMTP id
 e4-20020a170906748400b009b9f9808810mr12326693ejl.34.1697026842642; 
 Wed, 11 Oct 2023 05:20:42 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 z1-20020a1709064e0100b0099bca8b9a31sm9780957eju.100.2023.10.11.05.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 05:20:41 -0700 (PDT)
Message-ID: <3cbe506f-5b91-4823-d0c2-a79b8917a0f2@linaro.org>
Date: Wed, 11 Oct 2023 14:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: wiki.qemu.org is experiencing technical difficulties
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Han Han <hhan@redhat.com>
References: <d0e0395a-25a9-18a1-ae97-c77708a94adb@linaro.org>
 <CAJSP0QXrKjJSQzVQpAKcxaqSOrRmgE4PYR7nbeRMGzKQg7JC-g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QXrKjJSQzVQpAKcxaqSOrRmgE4PYR7nbeRMGzKQg7JC-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 11/10/23 12:53, Stefan Hajnoczi wrote:
> Hi Philippe,
> For some reason the database was not running. It's back now.

Thanks Stefan!


