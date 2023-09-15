Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F27A1F36
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8II-00083z-1A; Fri, 15 Sep 2023 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh8IF-00083e-Bd
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:51:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh8ID-0007fN-Rd
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:51:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9deso1983380b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694782288; x=1695387088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elOgSevuCNgAMJDDaNVSLwmdEKFfMYYrJOJft5/GhbE=;
 b=S0Bhk0A3lLY6Ut4r61oy+x4u2An528xmRMHaHwWx19GtSrVg2X5hDm/LG5lZbXvLE/
 tqOGYbqSrFb1LSfwWt3VSpZ2qa+m7kEsxj8gi3dyBvaLo40izdWlul/E90WvUxjFoPEl
 Fqdr5UKYW8MVOcFc0zAS5kRSYWOZvPAFvZbDBboRHymAwDZWT2wM7+mXt92jp5bkRA5J
 MNiLKWPrFkxhQRC3u6s+UwDvFxMerZmbQHfJpqHgvVrcKRPDlAz6tQewarBqNquIxpJ8
 yJjUoiykAHRQ42yj4PrT4bfwIn3TZv5GpQ7iiQVpNV3JQHzbpizvamhlJ95Or0aytYgy
 WRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782288; x=1695387088;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elOgSevuCNgAMJDDaNVSLwmdEKFfMYYrJOJft5/GhbE=;
 b=JJr4lxnlygULoCM0fngCv9aYvD7l9mkuvZEWEmA+7Cg8eqLoSCZVf8AeLKTezx7B4e
 iQa3Ni3OcqCtMssEgeiBZTVFms6FddmXqDRsuBCXTHy+bi8R7IGcXOoH2ZQHKV+51zm/
 LuazZX0uxI/klpSiHkV372oqsPLHyQrXzIaEm4ZYF0QqxcNUljEgNnzokAGg9dWg2Quz
 MEjTnSyl8UX6vGUN3fq2CqEEHPWXkQ5xId6HkL8m7R1WblRiRmWgu3o4labzw24SFEmh
 ZeFtyYpaaN+ev3H5SyWxoUSGO1+S8FIrGxtSpPkJKCzGwB0S+dkNI54QiPNc0EtHNrxJ
 8s1Q==
X-Gm-Message-State: AOJu0YwqAYVlmlgiM18YXEUciWWRgpsL9II9CAivPH8eoofXXPYgGoRl
 ucKHCJyjcN0ke6ySfNYVTR68Xg==
X-Google-Smtp-Source: AGHT+IFXK06FDxK/aVM92kvtkgrIdC9GRzge6Y/ssMGGx9gIZ0t/pWwo6zP7xK3I6uC68iwBb2VhEA==
X-Received: by 2002:a05:6a20:8f01:b0:152:6b63:f1e7 with SMTP id
 b1-20020a056a208f0100b001526b63f1e7mr1864873pzk.1.1694782288447; 
 Fri, 15 Sep 2023 05:51:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a62ab0f000000b00682a27905b9sm3039571pff.13.2023.09.15.05.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:51:28 -0700 (PDT)
Message-ID: <30591e5e-2f8f-1fde-c5e2-a1b543f8bc30@linaro.org>
Date: Fri, 15 Sep 2023 05:51:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable
 sbsa-ref/neoverse-v1
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230915113519.269290-1-marcin.juszkiewicz@linaro.org>
 <1e7ac58f-907b-826f-5a06-5caf8fb3b963@linaro.org>
In-Reply-To: <1e7ac58f-907b-826f-5a06-5caf8fb3b963@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/15/23 05:50, Richard Henderson wrote:
> On 9/15/23 04:35, Marcin Juszkiewicz wrote:
>>       def test_sbsaref_alpine_linux_neoverse_n1(self):
>>           """
>> -        :avocado: tags=cpu:max
>> +        :avocado: tags=cpu:neoverse-n1
>>           """
>>           self.boot_alpine_linux("neoverse-n1")
>> +    def test_sbsaref_alpine_linux_neoverse_v1(self):
>> +        """
>> +        :avocado: tags=cpu:neoverse-v1
>> +        """
>> +        self.boot_alpine_linux("neoverse-v1,pauth-impdef=on")
>> +
> 
> Second function shadows the first?

Bah.  -ENOCOFFEE.  n1/v1.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


