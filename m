Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF7746E33
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcr7-0007Ag-JO; Tue, 04 Jul 2023 06:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGcr5-00079s-GW
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:01:55 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGcr0-0005OO-H6
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:01:55 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso5313898e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688464908; x=1691056908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DkBXckbJSO8thK7FqitO9OkdGoUbp1DaKSbowfDfM4=;
 b=H40Mxo0XufqOUV1XaL1a9BXcG3JlnlIao2QCmpmA85JbCPptMOK6L8DupEqkXkitHe
 waMbkKxzj5qZlj4AfpZEz4t/5L7IucGXQPY98zVlj39chUn6DJMK11Y6PzqSkQSgopAE
 X5mXQPAkeuBiOULfn1MuTifnasCRvWaaU84/i2/qYC6YrPGnrPltvgys4JMjNwHFbrHh
 bMsY0D5XiuFl7OreKizlikYo0965OSpszxXN9f329Bu7zeC12UzXqBANak3y8oZwh5/J
 ClX9mqbeuiZVB4BP5FWxyYhPPNxEPb9Dac8bmkVmrSxj1sbNWu1+7WIc1FnvYJMngp2j
 e4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688464908; x=1691056908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DkBXckbJSO8thK7FqitO9OkdGoUbp1DaKSbowfDfM4=;
 b=eoluyT34upJ7kfoW69H4A9pB0ArChoJSjsaFfofvh8GLlC2RHcCDuUvfmnQlGRvfjW
 2MAT4cpVtd7R0bdM7FpN90auo1pYPLwDBQ9KuBUN9xxuqZ6S/7GAjpqsgUEnv5b6zWPC
 8npR89EFwcawfC6MwyOI9AHJ5AHzhP2FFKSo9FZnZiwXwdc95WQ5k8SRbznS8NLVO8vh
 X/oKwBg57/yxzdIH5cDr7YyU2b3RsUzvKJRiKWzQ6tBsTsZuNfRGotzZKXYZmBFWRBS0
 cqJ63koeMrqUZpHCj3HOT8hBcLmlTr3RZ+5hxukbJkHvyb2Fne2HFJQjPDOlSbvm781d
 ZD0g==
X-Gm-Message-State: ABy/qLbCRIh2oVfLa3xPLHRLXjn2ZCemBWGVsJ8naOf07HCFyv6OZDCc
 UOBj5L74UCGxxFa2vyuV+oQNNA==
X-Google-Smtp-Source: APBJJlEjsjQ5Ho9tBJEX5DmIZKqrNbyuAYmHCfhB8y9a4eg7TDNt5YFSj7PKDpfwrPuqaeCcqoQPfw==
X-Received: by 2002:a05:6512:31d4:b0:4f9:5a0c:85b8 with SMTP id
 j20-20020a05651231d400b004f95a0c85b8mr10355612lfe.36.1688464908303; 
 Tue, 04 Jul 2023 03:01:48 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003141e86e751sm12078664wro.5.2023.07.04.03.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 03:01:47 -0700 (PDT)
Message-ID: <89346c32-d41c-0508-93d6-c40d6566b7ed@linaro.org>
Date: Tue, 4 Jul 2023 12:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 07/15] hw/timer/arm_timer: Extract arm_timer_reset()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-8-philmd@linaro.org>
 <CAFEAcA928VCeRVz7JQFGefxuyDn3LZC25zuLSJfYUg-7PkgyXw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA928VCeRVz7JQFGefxuyDn3LZC25zuLSJfYUg-7PkgyXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/6/23 16:46, Peter Maydell wrote:
> On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Extract arm_timer_reset() before converting this model to QOM/QDev
>> in few commits. This will become our DeviceReset handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/timer/arm_timer.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)


>> +static void arm_timer_reset(ArmTimerState *s)
>> +{
>> +    s->control = TIMER_CTRL_IE;
>> +}
> 
> Reset also should zero s->limit and s->int_level.
> (in arm_timer_init() this was implicit in the g_new0()).)

Oops I missed that, thanks!


