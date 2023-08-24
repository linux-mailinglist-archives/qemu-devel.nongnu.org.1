Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B967877DA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZF6v-0005Su-MP; Thu, 24 Aug 2023 14:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZF6q-0005N1-UY
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:31:08 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZF6o-0005l8-P4
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:31:08 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso23387a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692901865; x=1693506665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qXhNEIvRDS5Ellv4tkAMf5zoqYqHC4Z+IzpzARHLwzM=;
 b=albLzcGdsVpfEun7XzOeiR0tVbfIhksj1IsRx4JLoVshtvWZTWZl3z1dg6aW2JBIe6
 NTFl5ed8uBLT0ulFtg6xBoOneg8GJrbFG8cWzxdaPgBnbSwGX1qWmH9X9jrtRl6ECA09
 wGNtZP12Vs/yMG1k64QeQrPCqD/elwNR/lR74i2bd599hd0uCEqi12fg+9Rqj8HLBMQj
 WMx8IClRq9I4bxSWsvyrQOI0+Woavs8AkV11aGJZD52ILvMplSrZrfzl3FdZS69Ev8ft
 zv0KaZVk9B0Nx+ZA+rfV0DLTr5ZM/k9RZ821eBK8+b2Kob0dYFVSuGq21+PSReHAuEls
 bsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692901865; x=1693506665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXhNEIvRDS5Ellv4tkAMf5zoqYqHC4Z+IzpzARHLwzM=;
 b=JdRSjNljvQGTXF5cel7SK+kvG1oQnjirTOoTsdwffp7+z9EzT/VPmzvQ6vAoq6b1ub
 x1xfkHPVPGZxjzQ9cNtIThUEnNhrhHjXLgWl5BRD0w3kJvUBTSPOQSB1v/BJeb51qZ6W
 lHvci7C1qo7BhUwXc1jr0VWhrmrcR26sXY/LT07Rc/1HbvpMLrb7za9P9hv/Y6V6RA5j
 59zttmKsfPKnoG/t7DFkcBwbyQwxRBg41MWLu5wIwx8Xhc/gPppVSebwxqTSY6j2uZSN
 HsT+NJt9HopWfsZYptlO9s/Gt/LVg5FF0OEWSkSes9XhlmuR2QNLePPO3TzxkPOnJRLI
 zfxw==
X-Gm-Message-State: AOJu0YyqsO90613/PJQG5QeN6jFxJlEtt5mOlLpeP3wRXKoQDvCjwa6b
 oESASvNZtbiG/r2uEYJ8jwsDYA==
X-Google-Smtp-Source: AGHT+IGp+xA2QoLAQPVfeKEDUYnRpia4svg3lVCZYlxjdp552THXUukUFJ8VBF112+F2jEf/DaRUBQ==
X-Received: by 2002:a17:903:25d4:b0:1bc:2c83:f770 with SMTP id
 jc20-20020a17090325d400b001bc2c83f770mr12311575plb.45.1692901865321; 
 Thu, 24 Aug 2023 11:31:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:5418:3064:bd46:c048?
 ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a170902d2ce00b001bde77f3d0esm13160295plc.117.2023.08.24.11.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 11:31:04 -0700 (PDT)
Message-ID: <5d1a0fcf-12a9-7b7a-7aa6-f4b5960a4d1e@linaro.org>
Date: Thu, 24 Aug 2023 11:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
 <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org> <87sf88fobd.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sf88fobd.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/24/23 08:31, Alex Bennée wrote:
>> It's some sort of timing issue, which sometimes goes away when re-run.
>> I was re-running tests *a lot* in order to get them to go green while
>> running the 8.1 release.
> 
> There is a definite regression point for the test_pc_q35 case:

Not exactly "definite" because it does vanish.

> which bisects to:
> 
>    commit f7eaf9d702efdd02481d5f1c25f7d8e0ffb64c6e (HEAD, refs/bisect/bad)
>    Author: Richard Henderson <richard.henderson@linaro.org>
>    Date:   Tue Aug 1 10:46:03 2023 -0700
> 
>        accel/tcg: Do not issue misaligned i/o

Well, since you can reproduce it, would you please debug it.


r~

