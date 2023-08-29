Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E378D020
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:15:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n3-0000p5-A2; Tue, 29 Aug 2023 19:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3lm-0005S2-IU
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:48:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3lk-0002pB-95
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:48:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68bedc0c268so4091306b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693334931; x=1693939731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bILrHuKJGQk3Tx3s/WuUuB+1xjlC0uRQe1JPvhzUVPA=;
 b=HjqqztEqFHYAqJJh9nb4ifA8JK1UJ9flDHVNabG5AY12QbQGxKJz2cg6cJH3rKcmLY
 uEHyC0Z1BnxLhoTFW7xcTVQwjvB6F6LTqooijGQnqSaux18qxUDqDxEgPoQ0SRBQi9JR
 RznRqx8qVHlnmniCub2H2XItQbe3tA9PBZwsUnBwm8Dxd9yvMwASKLkn3VkJpqTcm8Qm
 1y7DId6WJ9WvTHJEvKHPcYuPnvxsT3rlkwj9vPl7rH3ShR5AqSCXGZ3khRT6AFb5H+Kh
 CGeiWJk80m82tpMZjSJMJtW/ceyxqnvwn8X4KjKGgTu/PtWPFT03u3EufEO1rkfjk5kN
 XtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334931; x=1693939731;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bILrHuKJGQk3Tx3s/WuUuB+1xjlC0uRQe1JPvhzUVPA=;
 b=JTI5vMsdk3ZOO2KLPi7B07Zf4G1k1I9NS6diYAIn0ofi6omnnXyuH1syw2CyUki7WB
 +777N1fOKtrPDic7nEYlzMndJq3QW5LzRKLRZ/r1tFHdrJOFLaCN3EDOPEsPataDJNd+
 LH/zQsusNe5868T6UhCNK+75JUI9e5Os9G3A70Gh3NI+3U0i/3X1XZ6y5Z+27tctCUpF
 eDQzClNJLgRKuchH3swWo1/zLSMpwrbvEYScy62oW81Myo+anzG75aYPwGwNzjCda0x7
 NPeaIJcupAEdicnAHjYdkTVdBcOJ0fAl74l70uMZJ9X7T8f+XyIFKasgtXisobtscCGR
 Qrng==
X-Gm-Message-State: AOJu0YylX7oMuaZDtdqaS6g447w4fT8J2wBO42BgMxIFgGfYe8Y+8V2r
 b6S6gKrsveUK7nYJ8gIk83Ud/Q==
X-Google-Smtp-Source: AGHT+IFZ62U/llKhUheJTwEBnmrUj9rcT/GwvZFUINPG+9EXvLMSHHJsztjwAUd8nQChDy6YktZBXw==
X-Received: by 2002:a05:6a20:a10d:b0:14b:ea0d:e301 with SMTP id
 q13-20020a056a20a10d00b0014bea0de301mr245465pzk.0.1693334930734; 
 Tue, 29 Aug 2023 11:48:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d21-20020aa78695000000b0068a6972ca0esm8787093pfo.106.2023.08.29.11.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:48:50 -0700 (PDT)
Message-ID: <c01a92d3-e6ae-a852-9879-597dd694e576@linaro.org>
Date: Tue, 29 Aug 2023 11:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/10] meson: compile bundled device trees
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-6-pbonzini@redhat.com>
 <898e23ff-6ec7-a213-9e70-06085b4b3fb0@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <898e23ff-6ec7-a213-9e70-06085b4b3fb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 07:25, Philippe Mathieu-Daudé wrote:
> On 29/8/23 10:29, Paolo Bonzini wrote:
>> If dtc is available, compile the .dts files in the pc-bios directory
>> instead of using the precompiled binaries.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   pc-bios/Makefile    | 19 -------------------
>>   pc-bios/meson.build | 25 +++++++++++++++++++++----
>>   2 files changed, 21 insertions(+), 23 deletions(-)
>>   delete mode 100644 pc-bios/Makefile
> 
> 
>> +dtc = find_program('dtc', required: false)
>> +foreach f : [
>> +  'bamboo.dts',
>> +  'canyonlands.dts',
>> +  'petalogix-s3adsp1800.dts',
>> +  'petalogix-ml605.dts',
>> +]
>> +  out = fs.replace_suffix(f, '.dtb')
> 
> Does that work when building from read-only source directory?
> 
>> +  if dtc.found()
>> +    custom_target(f,
>> +        build_by_default: have_system,
>> +        input: files(f),
>> +        output: out,

Yes, because the output will be in the build directory, and installed from there,

>> +        install: get_option('install_blobs'),
>> +        install_dir: qemu_datadir,
>> +        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
>> +  else
>> +    blobs += out

whereas the fallback case copies from the source directory.


r~

>> +  endif
>> +endforeach
>> +
>>   if get_option('install_blobs')
>>     install_data(blobs, install_dir: qemu_datadir)
>>   endif
> 
> 


