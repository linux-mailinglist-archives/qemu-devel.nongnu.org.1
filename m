Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D820079E2DF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLlQ-00053H-35; Wed, 13 Sep 2023 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgLlJ-00052s-I2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:02:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgLlH-0001EW-Ar
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:02:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-403061cdf2bso40355485e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694595733; x=1695200533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xe6MqFGK/ptUu+T86YHQkfsfUOxtldvwwlNPM1pFiTI=;
 b=bThjB8+bmOsDpu9xaibYZxabZVihZdmw3SMg7/CNhiOY+Z4Z/vhnVbktc/pHOiZakm
 VfExF0dfZAOSVtkQP4bqeTHEVHUP8CtqFZZ3MFh6GjlQTUH4gfP9BIymOIKaf09umzmF
 Di+FW9Gm/I3yYzNGkuiEMBMgN4s3/SHYFlT3ifNO3DKeVyZXWeoCOaNanb/uiC8CrOAV
 wofqkIIQLTVi2aZ4Kkxu2uMgH3tw5/RBWJvAjn+0iXgBwv5EVLOFGFOtyhWxEMwpfxAm
 4pkBmVLAqtlkWcdN4ARLrYYUC8X2UDLS7GEinHGmUTBIbBrLNQCEfmr2Nf33arRxuTig
 5JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694595733; x=1695200533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xe6MqFGK/ptUu+T86YHQkfsfUOxtldvwwlNPM1pFiTI=;
 b=tfXT4FEdWm1K0QaRygZsWHQbgnPPtmLURt4FX7myuq2bUOc87zFk0Hhzd7vLn7WQ1x
 5Rz6rBsv88QL5kYWVROBN4C3UOvPMjus1W3tfic3kpn/4h/GWsiGjGtfo7uhdl4RTBjD
 ay+kqG+SbqrsLh3GkFQyeAMRphB0B/suTzeIKFUkF4geX/Bd84dAycapEtv5OGQ2V5J7
 k+50AJ/viDYnavxCUHQ6V2e7Os/jRKh598E7uQw2Cx7bQu64aXW9fwWdShTHlOi34nWL
 Z0LrG7UGbicm50Ba7CvTYc23mIevoySOCsfMR/iHOrXL7RTkdivx9Rcr3pPe5W0GSsPi
 9WOw==
X-Gm-Message-State: AOJu0YwolIGUVk1WQBxgcoYwJWT5y0xvhHbPCwomECzHccKqrtPPY7U+
 4Q0wVMTARu4p4XCwdkMB5rK87w==
X-Google-Smtp-Source: AGHT+IE6yyLIhYgsfFaQXW0eEC/aUhEtR8RrznU/yaYwzA3qd8pvyYQIuLDFOKRx9JhVmh92Z0EAPA==
X-Received: by 2002:a05:600c:2802:b0:401:6800:703c with SMTP id
 m2-20020a05600c280200b004016800703cmr1494028wmb.21.1694595733164; 
 Wed, 13 Sep 2023 02:02:13 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 f18-20020a7bcd12000000b00402f7e473b7sm1402592wmj.15.2023.09.13.02.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 02:02:12 -0700 (PDT)
Message-ID: <361eaa5e-67d4-bce0-679b-8faf6cb5ce32@linaro.org>
Date: Wed, 13 Sep 2023 11:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v4 2/3] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20230911211317.28773-1-philmd@linaro.org>
 <20230911211317.28773-3-philmd@linaro.org>
 <c33130ec-661a-a1ed-c285-eeaa52365358@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c33130ec-661a-a1ed-c285-eeaa52365358@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/9/23 16:05, Paolo Bonzini wrote:
> On 9/11/23 23:13, Philippe Mathieu-Daudé wrote:
>>   /*
>>    * Only for builtin_x86_defs models initialized with 
>> x86_register_cpudef_types.
>>    */
>> @@ -6163,6 +6195,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>               }
>>               *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
>> +#ifndef CONFIG_USER_ONLY
>>               /*
>>                * SGX cannot be emulated in software.  If hardware does 
>> not
>>                * support enabling SGX and/or SGX flexible launch control,
>> @@ -6181,6 +6214,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>                       CPUID_7_0_ECX_SGX_LC))) {
>>                   *ecx &= ~CPUID_7_0_ECX_SGX_LC;
>>               }
>> +#endif
> 
> This can use a variant of x86_cpu_get_supported_cpuid that returns a 
> single register; or it can be rewritten to use x86_cpu_get_supported_cpuid.

Great suggestion, thanks!

> In general, a lot of checks for accel_uses_host_cpuid() are unnecessary, 
> and the code can be modified to not depend on either KVM or HVF.

OK.

