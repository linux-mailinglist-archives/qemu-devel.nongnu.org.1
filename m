Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A689B827A15
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:14:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMww0-0004cQ-5Z; Mon, 08 Jan 2024 16:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwvx-0004bk-Uy
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:13:21 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwvw-000758-7d
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:13:21 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d41bb4da91so8429095ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704748398; x=1705353198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7QmJgUYhxUnwQwy5HjZvdFZKJPqq5XiFXUCevP9wkOI=;
 b=YSZJnExmABPXdFIff58F7Hd/N/bdQPdsyzKtl0SDz4WvEAI8nhVpgp71orc5npa+pW
 cYoVAzsOxXa6vnDLMLVWVlADGgsJY5HQ/6m1PivBTDQvJAbcEjISAR/mdQa6Ppti3uMA
 Xji0p14ygQTOFxF1qZpC9tbvVT2muUSyiQINxib2Nah8vwyx+zHS/rstrD9/RYE5f9ai
 Bh1PC+nJVwKtTupa8L4mpY5s9fqyhSnSl4+STQvuaXxkqBbE72BBKimrykDnmbS4rNPD
 7T7Myh5Edr77sn0iisetQCRl+iwaIFUAJ4k0od8lR29d5shH+xT0RFThB6yULWindw4N
 ZWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748398; x=1705353198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QmJgUYhxUnwQwy5HjZvdFZKJPqq5XiFXUCevP9wkOI=;
 b=LgJYNf2e+LdO+j2Mt04quRrlYpO0rqnkHZd+v7Sp8Ju9FldSARGQ7CWfoGstg3E8kQ
 +SZIO8L/IysuRAUEhmACfgCwDvo0dRg3q44UfldprwupzwF6kMAPSFn6LAniTgajhSv1
 OrtuXSGa/OR2OLLrj679912maJK+5Vvez1i79OMQMmb6jqwjhkD6XqXv3kluKwTPvkiQ
 ktn30Pm4EUNbYhnKOMf0iuwRVqb6maI+3YMPRXipwL7F1QRN153Wyb+6TvLiilNuPN6V
 wWfLUSKEAgLQAF8rggxljDYZjSFL714SB6yQRGPB4+8qYTf3ylGl2bQeRZPkXZ7MxEAR
 yDMw==
X-Gm-Message-State: AOJu0YwxiSTnJl9JmD68GQb6tBuuaAfGbWi/X0eF9g5OE9d4mq8BfdND
 i/yy/6nSOTBF6amwVuYuXCy3dnNq/sbHHw==
X-Google-Smtp-Source: AGHT+IHceMH/+L9k30LCBRV6pg0Ia6yKipRGnxu4pO24WRyoKGyBTDufXYxFYdsGhAbyHd3VgT2B5w==
X-Received: by 2002:a17:902:f685:b0:1d5:389b:d43e with SMTP id
 l5-20020a170902f68500b001d5389bd43emr1520816plg.5.1704748397982; 
 Mon, 08 Jan 2024 13:13:17 -0800 (PST)
Received: from [192.168.1.66] ([103.194.3.133])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1709026a8a00b001d1cd7e4ad2sm332117plk.125.2024.01.08.13.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 13:13:17 -0800 (PST)
Message-ID: <98572a44-c587-4591-b2e4-b07f6f28bde3@linaro.org>
Date: Tue, 9 Jan 2024 08:13:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] linux-user: Add code for PR_GET/SET_UNALIGN
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20211220214135.189157-1-richard.henderson@linaro.org>
 <20211220214135.189157-4-richard.henderson@linaro.org>
 <bd92d4c4-8d12-4036-8d9d-385d67099e4e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bd92d4c4-8d12-4036-8d9d-385d67099e4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/9/24 04:15, Philippe Mathieu-Daudé wrote:
>> +/*
>> + * This can't go in hw/core/cpu.c because that file is compiled only
>> + * once for both user-mode and system builds.
>> + */
>>   static Property cpu_common_props[] = {
>> -#ifndef CONFIG_USER_ONLY
>> +#ifdef CONFIG_USER_ONLY
>>       /*
>> -     * Create a memory property for softmmu CPU object,
>> -     * so users can wire up its memory. (This can't go in hw/core/cpu.c
>> -     * because that file is compiled only once for both user-mode
>> -     * and system builds.) The default if no link is set up is to use
>> +     * Create a property for the user-only object, so users can
>> +     * adjust prctl(PR_SET_UNALIGN) from the command-line.
> 
> How can I test this per-thread property?

-cpu foo,prctl-unalign-sigbus=true


> Shouldn't this be an accel (TCG/user) property, for all threads?

There is always one cpu at user-only startup, and it is copied on clone.

Logically it would be a kernel property, since it's something the kernel does, not the 
cpu.  But cpu vs accel makes no difference to me; it was just easy here.

IIRC, this is simply a proxy for not really being able to inherit this bit across 
fork+exec like you can with the real kernel.


r~

