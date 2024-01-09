Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE798281AD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7Yq-0007CQ-Bu; Tue, 09 Jan 2024 03:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7Yp-0007CI-0R
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:34:11 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN7Ym-0006Hr-6L
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:34:10 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d40eec5e12so21619095ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 00:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704789246; x=1705394046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pwz0upJHXWEzfJ9vGKUNx5rPczxdBY5Tr9cWyH6fU1s=;
 b=LlGI/OtMZow2fK0TBQl9Qj8b7yohZrIClgekYepjaCnugw48ikxQvYjdtWhnDUi48o
 kRjgQd6OLM/F4Mk0UkhTq+qx4fDcPWPjRzvohr/Rta6Zt/gUaINVWLa1bfFgcJDMZgUi
 bcHaBfqwyfag0gImDq2PYuY4EnDa0kyWRCJk6Qc6PxiDey0QxFEbCjUrojI/iCgoVKR+
 VX78CcWaBesKhliugYIE7m/mYEfg9HEgSLGV+mR78vtPNkMMBxovPRKMeMvFMef2xJaY
 Jv2ndDbIJjC/PFb7FJTyCV77txduhHXp93JRPG70jaWr358z+MPgLXwB47nJTEIzUbZ/
 EMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704789246; x=1705394046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pwz0upJHXWEzfJ9vGKUNx5rPczxdBY5Tr9cWyH6fU1s=;
 b=NXmrSoKs7jvag2AbL9+0RZXLNpZPYfA5+zGX6Z/3ZWAgqE89oG9OWNBrRpBgQEtLBq
 1fZHRVs8qjk8KiOJ3QMAFae3itLqgm8TWjk9jZhCLjiE006LKxXxhFpSES6VvZ2kKBVW
 Z9yBUGAuT+HOR8jiSvXQ3eg1Q8EtjOuhJmgAZxYHQc+LbT2GkqRmY325+Dx53YMoSw2x
 VrIAH2CXmesDt0QKpCjTa4oSjyqut3rvD4TbUYn5PC85rP5Gp8WcTII2J4LRj3eAJ0JO
 gJ+Ss/Oo+e/4W63c1Ue47hvpuXqCsRpQcpcMXanwV8cS53MRcKzC/nQXv7fhifIeSFci
 iugg==
X-Gm-Message-State: AOJu0YxVqBpHg850AY4208aoLEw8A4jucQ78sx938t02g5+hdFOg81x9
 EsdXf/TtLmI9qmdpk7krQ2fEbZ8fTwFyXg==
X-Google-Smtp-Source: AGHT+IGGXhDetuo37QmrLyLYP8lwAgD36K2ipP4pUtTjm+IuBxapGEZZ9a5cuxjJZKsHcpm+J4ssZw==
X-Received: by 2002:a17:902:ecc4:b0:1d4:a381:e92a with SMTP id
 a4-20020a170902ecc400b001d4a381e92amr6083786plh.37.1704789246539; 
 Tue, 09 Jan 2024 00:34:06 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a17090341c800b001d53f81f894sm1194806ple.122.2024.01.09.00.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:34:06 -0800 (PST)
Message-ID: <572b2855-9f8f-4f6d-a029-d4c9e4b239bc@linaro.org>
Date: Tue, 9 Jan 2024 19:33:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] linux-user: Add code for PR_GET/SET_UNALIGN
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20211220214135.189157-1-richard.henderson@linaro.org>
 <20211220214135.189157-4-richard.henderson@linaro.org>
 <bd92d4c4-8d12-4036-8d9d-385d67099e4e@linaro.org>
 <98572a44-c587-4591-b2e4-b07f6f28bde3@linaro.org>
 <77aa582f-3c0c-47de-984b-69faabfaafdf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <77aa582f-3c0c-47de-984b-69faabfaafdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/9/24 10:21, Philippe Mathieu-Daudé wrote:
> On 8/1/24 22:13, Richard Henderson wrote:
>> On 1/9/24 04:15, Philippe Mathieu-Daudé wrote:
>>>> +/*
>>>> + * This can't go in hw/core/cpu.c because that file is compiled only
>>>> + * once for both user-mode and system builds.
>>>> + */
>>>>   static Property cpu_common_props[] = {
>>>> -#ifndef CONFIG_USER_ONLY
>>>> +#ifdef CONFIG_USER_ONLY
>>>>       /*
>>>> -     * Create a memory property for softmmu CPU object,
>>>> -     * so users can wire up its memory. (This can't go in hw/core/cpu.c
>>>> -     * because that file is compiled only once for both user-mode
>>>> -     * and system builds.) The default if no link is set up is to use
>>>> +     * Create a property for the user-only object, so users can
>>>> +     * adjust prctl(PR_SET_UNALIGN) from the command-line.
>>>
>>> How can I test this per-thread property?
>>
>> -cpu foo,prctl-unalign-sigbus=true
>>
>>
>>> Shouldn't this be an accel (TCG/user) property, for all threads?
>>
>> There is always one cpu at user-only startup, and it is copied on clone.
>>
>> Logically it would be a kernel property, since it's something the kernel does, not the 
>> cpu.  But cpu vs accel makes no difference to me; it was just easy here.
> 
> Can a process started with prctl(PR_SET_UNALIGN) unset it before
> forking?

Yes.

> "kernel property" as "accel property" works for me.

Does it really matter though, especially now that the cpu property has been present for 
two years now.


r~


