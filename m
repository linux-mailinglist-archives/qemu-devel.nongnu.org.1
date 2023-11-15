Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCC7EBAEE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:28:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34g1-0004cM-5I; Tue, 14 Nov 2023 20:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34fx-0004bw-Dt
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:26:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34fv-0003OS-RW
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:26:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so3074675ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700011598; x=1700616398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZpgIw8NKaz2b/Y+I1DUaKIx0Tu7c0o37rofpwN3XgQ=;
 b=TPTHh17UPpvTvnpQmd5bozL80+IgGpZ76yyriRr54uCDEMANb/m3Pszt4Vd9rAUAwP
 gw28878mJX2qpgD3Ij/YCIaOY2IZOgbwuIceh5Lht6sVsF7QA4F6ih44Dktfg/jkdT7K
 O/1dq3cOloIYt3Ne/BihlQ40Ed6dUYkeTMAFGQMNqe2LdcyB1vHuUyiCkj5TR/a6eGbA
 XLnCboSMM0JcvtlgdoUjpTiYrgnOKu/dCcrsXuHXeyKRaj/QTI5nr7NLETDgIgx3mE+A
 EQHSr6K4l83Hp4yyza+TLo0ANNm3gEhT5wUIE/GpkUif7+s6ZgB6QHAO5AUsmENbk+EG
 9gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700011598; x=1700616398;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jZpgIw8NKaz2b/Y+I1DUaKIx0Tu7c0o37rofpwN3XgQ=;
 b=Lz9pfwPzE5YGn67fb/n9y9ZDjdndumBNoPB2nmnRjTxuvLATM0qK3Y8BS7/NN3/8ok
 EWGHZxZLd02RCEHOB+ah9R0F4SyY6mqtzlVwFcHyfxRD/vqgjC0Xn63yDA2xVypm/lDU
 JQcUwvSdknkWuL4QZqKgyPUIe2N1WVqUpqayjKguZ2lQIabHAVLESj90IJ4RZ/0zrWEg
 wyeVBvHq+tPrmqOlGhSleFEtFykV796yeDaTuqGbYtGeEoV4CljMQlBym6wepid0SB9C
 IPQX++V7gA/NFYf73FtWigqvG+sBFuS9D132e200mjPcg+YQHBu1iWDMRg4LRLBvxbhi
 tZfw==
X-Gm-Message-State: AOJu0YzzUBN5Ml6vx2d3+wlRCNY5TQw7qeFyKxgCeOzta55cYOmuAaHj
 A6SYE0cu3J+Ol0KHyfApFid3ag==
X-Google-Smtp-Source: AGHT+IHT8m5YB7xfKJ3m+5xePsJHjYXfLNk/qbIO5JHwCkWLROB/tyP7+3twVknd4CVbBChdPVvb7Q==
X-Received: by 2002:a17:903:2284:b0:1cc:332f:9e4b with SMTP id
 b4-20020a170903228400b001cc332f9e4bmr5716935plh.1.1700011598356; 
 Tue, 14 Nov 2023 17:26:38 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a17090301d100b001bbb7af4963sm6347718plh.68.2023.11.14.17.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:26:38 -0800 (PST)
Message-ID: <3a3779a9-773d-4515-a6cf-5430e63cba24@linaro.org>
Date: Tue, 14 Nov 2023 17:26:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/31] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-25-gshan@redhat.com>
 <e954760c-aca8-427b-a286-2c57bd7609a7@linaro.org>
In-Reply-To: <e954760c-aca8-427b-a286-2c57bd7609a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/14/23 17:21, Richard Henderson wrote:
> On 11/14/23 15:56, Gavin Shan wrote:
>> QEMU will be terminated if the specified CPU type isn't supported
>> in machine_run_board_init(). The list of supported CPU type names
>> is tracked by mc->valid_cpu_types.
>>
>> The error handling can be used to propagate error messages, to be
>> consistent how the errors are handled for other situations in the
>> same function.
>>
>> No functional change intended.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/core/machine.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 0c17398141..5b45dbbbd5 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1394,6 +1394,7 @@ void machine_run_board_init(MachineState *machine, const char 
>> *mem_path, Error *
>>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>>       CPUClass *cc;
>> +    Error *local_err = NULL;
> 
> 
> There is no need for local_error; just use errp throughout.
> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Alternately, is this because passing &error_fatal will abort on the first error_setg, 
without all the hints?

In which case you can move local_error into the inner block and add a comment to that effect.


r~

