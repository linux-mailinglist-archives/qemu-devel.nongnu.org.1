Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF9745A57
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGsf-0001yu-MJ; Mon, 03 Jul 2023 06:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGsd-0001yV-2E
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:34:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGsb-0004sZ-4W
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:34:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso40292765e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688380439; x=1690972439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OlOJR69ntKPJ7hI8tA22v6JbbY67AbzIXt6KkOfarMU=;
 b=GXej702TsX7WyF9dGHALDff0fyEUs+6AQIdHaAP6/Ef1oq+nNzcdi85nQJzcJQCuMr
 MuWr4ka9tBE9xilC3YmfruAm5KM8vtiAL0GNdhAY1IxOAdH+Whrrx/CjmPzpiswnK0e0
 X5Ww7J7L9o2UQEHZQjNk1saO6lUdFLDQDJ26FsnVYULgL8n2Xikk2hkHS07FUkw6mCN7
 5mnI+pK9yl1n1YLvjUa/Ka+m/UvCDUg/N7qScw20IbUMytN/tvDXPLN53z+eMJ41fKhO
 JI7BRI+YyiDd/PonTsyjrpmz5A5GCyHsiaohqdQPPp4/YmeZh0d0ZJB80WyaEooReF3W
 snpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688380439; x=1690972439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlOJR69ntKPJ7hI8tA22v6JbbY67AbzIXt6KkOfarMU=;
 b=eZd8AokEdqWaAenEip5M8l013ABKQM4FNOcgoTQ248QCpg7PNI/DUXACfa1tShDzGw
 6ohuTDPphugCbMqNWr2stVRA+FzNll+Ss0liAynjV8tIfyYvkEN4lvuYJyDBVkbLGPgf
 W1cxbdpdEyXkLBACHk1aofq/IjfmpXQoETsJrleYAng5/K5PmoMY5Yub5N/ekGW80W9S
 1fWVF7eGpedz9utJfyfr6eUAvF/m//MIxjbTIVzbRE9L/d2Oc/4FXCIkyfIhfGAjt71u
 a/4MZlfjV8m6fnn7841VScEYImE+1U90VQ2wkYEhMxHXH/+FJXuj92IJr00esNIl5g7f
 eS6g==
X-Gm-Message-State: AC+VfDw1IT2ARDY3wKbUYjt7JAbAOVu3Dh/wbIfKFudcTf+vehTd42e4
 zfypfaqCeeVlodv3SPy0M1s0Ng==
X-Google-Smtp-Source: ACHHUZ4eFlZn4knRcOQwFOz3xh2hSYBgCHm6xetOAvJ9Nhn/VRk+GEcf0PJwa1/cd++hsoO7eqWpmw==
X-Received: by 2002:a7b:c38f:0:b0:3fb:a46c:7eac with SMTP id
 s15-20020a7bc38f000000b003fba46c7eacmr8616816wmj.7.1688380439491; 
 Mon, 03 Jul 2023 03:33:59 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fba9db141esm16297765wmi.38.2023.07.03.03.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 03:33:59 -0700 (PDT)
Message-ID: <575a4b78-8267-96b1-4764-2e492a69dcc6@linaro.org>
Date: Mon, 3 Jul 2023 12:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/24] accel/tcg: Introduce page_check_range_empty
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-8-richard.henderson@linaro.org>
 <873525jpja.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <873525jpja.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/3/23 11:45, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Examine the interval tree to validate that a region
>> has no existing mappings.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu-all.h | 11 +++++++++++
>>   accel/tcg/user-exec.c  |  7 +++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index 8018ce783e..5b2c230d52 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -224,6 +224,17 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
>>   void page_reset_target_data(target_ulong start, target_ulong last);
>>   int page_check_range(target_ulong start, target_ulong len, int flags);
>>   
>> +/**
>> + * page_check_range_empty:
>> + * @start: first byte of range
>> + * @last: last byte of range
> 
> * Context: holding mmap lock

Is this parsable magic? Two lines below I do say "memory lock must be held"...


r~

> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 


