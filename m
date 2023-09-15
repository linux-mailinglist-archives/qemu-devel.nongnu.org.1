Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53857A228A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:37:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhArq-0001hp-Ku; Fri, 15 Sep 2023 11:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhArm-0001hF-8u
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:36:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhArk-0006uW-JJ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:36:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-403012f276dso24939885e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694792177; x=1695396977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5CI3NNC9SiJ1TxUL6btnHuQ4dhmRN5gG+G3zcqeRXVM=;
 b=sFJ+/LVIj96uWg40x7AmQA/MatKjp2eFUB/6chzmMqRrH7kKvG4rJMUiij+9l7VHmV
 nTA5ilqE9jNBpwUTsgb7nsKQCKv5QSrsYLWegmocWMiVqY6ExzvV6SeS8p1nn6VXU5b0
 YPKI+q9EzS0mKJU9HG70lgduJeYAkOt5RhnrYA3WE0V+jsFtUYVTKyWL17o5Nf4tp3Qs
 8r72Uz75YCma1/19jq2gLggE186taPSYWRhnd3Nw16uF461OEKw3JwpLMxtRSrdDmc0Z
 SOPAZw96YTCm1IdRtjS95WwMefIQL+VuXLlmyCUoO8QkEkI36KHUfw5PGvGuVM23xUYz
 Ik+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694792177; x=1695396977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CI3NNC9SiJ1TxUL6btnHuQ4dhmRN5gG+G3zcqeRXVM=;
 b=bxz6q7vszgIhZADuufmsbA6zYDKGtmqW4qapnErqyvbLTx1UC6o/yQio8GY8xFMZFP
 5dbaDaRC2BLSwAd1/1q7tsge4fq541R7xkRrTlYqZYKEgqSxhlwkAuynbZj0vnPp4i5H
 IdeqWvRGcpJur0fmUaEhe78An1Blh35Nc4taYYCjfrXF/hHlYbcIXds5wPhtYeDYAV77
 xhj9Y4s4zMEuC/bPndRy08PlLzUGX70RzLW6/qIoqPU4TD2G3cAlHztTOWQdHZoWAIqi
 qUym4PfHip0cNOI625EfMY87p3MUUSma/MwN8sZzfuU9bQ79ujrdxrEgrhHLUBPJxGZD
 FzhA==
X-Gm-Message-State: AOJu0YzX4m39jqD6Ifyq94EDZi5nar/5qGXLoO7jEKp1dbMofYUEhX5G
 ifskBCV75vGS/tFOz+16A03WMA==
X-Google-Smtp-Source: AGHT+IG41nLabpVAug2wTxpDa0exGVJNCN+kLHtI6EhFWzLSnPMKB9/WwA+qFIvR70brxexwhCSqTA==
X-Received: by 2002:a5d:4acb:0:b0:313:eb09:c029 with SMTP id
 y11-20020a5d4acb000000b00313eb09c029mr1787008wrs.43.1694792177339; 
 Fri, 15 Sep 2023 08:36:17 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 ci8-20020a5d5d88000000b0031fedb25b85sm2435154wrb.84.2023.09.15.08.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:36:16 -0700 (PDT)
Message-ID: <4cf84e75-2602-6676-9b85-92f5918232ba@linaro.org>
Date: Fri, 15 Sep 2023 17:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 06/11] exec: Rename cpu.c -> cpu-target.c
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-7-philmd@linaro.org>
 <fzzskmx5koxw7xzzwwv6jejnntnjdw7psfjgnwkulxaq2sw7qf@2ro4ydtvieyg>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fzzskmx5koxw7xzzwwv6jejnntnjdw7psfjgnwkulxaq2sw7qf@2ro4ydtvieyg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/9/23 16:19, Anton Johansson wrote:
> On 14/09/23, Philippe Mathieu-Daudé wrote:
>> We have exec/cpu code split in 2 files for target agnostic
>> ("common") and specific. Rename 'cpu.c' which is target
>> specific using the '-target' suffix. Update MAINTAINERS.
>> Remove the 's from 'cpus-common.c' to match the API cpu_foo()
>> functions.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS                   | 4 ++--
>>   meson.build                   | 4 ++--
>>   cpus-common.c => cpu-common.c | 0
>>   cpu.c => cpu-target.c         | 0
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>   rename cpus-common.c => cpu-common.c (100%)
>>   rename cpu.c => cpu-target.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00562f924f..12261d8eaf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -139,7 +139,8 @@ R: Paolo Bonzini <pbonzini@redhat.com>
>>   S: Maintained
>>   F: softmmu/cpus.c
>>   F: softmmu/watchpoint.c
>> -F: cpus-common.c
>> +F: cpu-common.c
>> +F: cpu-target.c

The renamed file is here ^

>>   F: page-vary.c
>>   F: page-vary-common.c
>>   F: accel/tcg/
>> @@ -1772,7 +1773,6 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   R: Yanan Wang <wangyanan55@huawei.com>
>>   S: Supported
>> -F: cpu.c
> Was the maintainer switch intentional?

(yes, see earlier)

> 
> Either way,
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

