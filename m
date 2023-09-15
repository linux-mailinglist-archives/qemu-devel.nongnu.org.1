Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 524807A2487
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCTk-0001WY-Ow; Fri, 15 Sep 2023 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhCTh-0001Tj-2u
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:19:38 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhCTd-0003hK-MU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:19:36 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34e15f33a72so8305135ab.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694798372; x=1695403172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIXgE7Mb8n3GueLj3X3zWtU+AI6Uk0jRW5mOaHXlKac=;
 b=NSc5Yy5D3WfyUCRDpBPLpO4TvtjfH9YWpSvt3WKwE/6wdjJZQVhFve3dXqE52j1r5F
 C6v9f8H2CTj5xdBchnt9QQQVYSCjaJQsxCDfUl8TLaCufVmC1y39ojCyLPMuKBbE3HTs
 oej+10PAUX7IzCLVwQAvB5WRIMWb0XK2yIb4rLakK70ANGLuu3D9Tm8hf7Yo5DT7qipM
 9rWXNR9hJliDZBVj0I+6aF3VGN1YcosjH3COgBRaQ0j9uECUqhZB9dTFY9VJJwEbTGA0
 ctTbCO5yCF6X54Uj2CqJrG+hWUbAMd/buW0DGOigEzOjEMaGJJObd349qcG8Vwgwgsx6
 786w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694798372; x=1695403172;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MIXgE7Mb8n3GueLj3X3zWtU+AI6Uk0jRW5mOaHXlKac=;
 b=X7jmZHN+mceBFCI12MEGLDc3Ato0pocE3on7y8io6jwEsq/ciPQpy7A81uCeuQGGvr
 0gTkoWZHq0QpaWJP04HQwC2DG+mW9LQroyhTM40IR6Hypv4m3Xv4fuuxt0U+GuhVQu1c
 PIAgddr0WcmkvLuAtTsLtcijdZRGAmjTEbVaQ3ssFlRsF21lZAUGZmPOfz3X1iD+YAlq
 GiNaMyKlq/UBPnud0Z/ORHSZWT2h6XJXuirSR5KMauQomXfsaeoFNXj/L0OHTgWROph4
 2ldfAx11veQx6TRjBFuV3k+KUe6mPV+Q1XFhm/6DwJoS8GfrXbsacss4Sw2fE3d2mi1H
 3XNg==
X-Gm-Message-State: AOJu0YwUYRQpCIp07mzVYtEg3bS82IbPkKkEhNkV6P6ceE9lrc6GwTdu
 25LjLJfxEThMVWba8ghugFcI5g==
X-Google-Smtp-Source: AGHT+IFuAVoLrfjw5LtZbtW7Nz1mY2nwwGURPxJhcoXaBgC6JiTD9Zrzc2gJ1Kf6gn0D6oHViFV1Kw==
X-Received: by 2002:a05:6e02:1244:b0:34a:a4a5:3f93 with SMTP id
 j4-20020a056e02124400b0034aa4a53f93mr2787468ilq.5.1694798372346; 
 Fri, 15 Sep 2023 10:19:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a63ac0a000000b00563e1ef0491sm2994542pge.8.2023.09.15.10.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:19:31 -0700 (PDT)
Message-ID: <c4e81221-d693-83ae-99e9-333954101c33@linaro.org>
Date: Fri, 15 Sep 2023 10:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] softmmu: Introduce cpu_address_space_sync
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
 <20230915163254.123338-4-richard.henderson@linaro.org>
 <fc6589b5-afc7-8fd1-a53b-ca600ab03100@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fc6589b5-afc7-8fd1-a53b-ca600ab03100@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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

On 9/15/23 09:57, Philippe Mathieu-Daudé wrote:
> On 15/9/23 18:32, Richard Henderson wrote:
>> Synchronously check and update the address space for the
>> current cpu for any slow path access.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/memory.h |  6 ++++++
>>   accel/tcg/cputlb.c    |  2 ++
>>   softmmu/physmem.c     | 20 ++++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 68284428f8..7ec842076f 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2780,6 +2780,12 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
>>   IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>>                                               bool is_write, MemTxAttrs attrs);
>> +/*
>> + * Ensure all cpu address spaces are up-to-date.
>> + * Return true if changes made and tlb flushed.
> 
> No return value, stale comment?

Whoops, yes.

r~

