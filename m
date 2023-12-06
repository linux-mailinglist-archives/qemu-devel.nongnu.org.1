Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA1807267
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 15:29:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAstm-0004TB-0F; Wed, 06 Dec 2023 09:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAstk-0004T2-4o
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:29:12 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAsti-0004YK-Jf
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:29:11 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54c846da5e9so3904711a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701872949; x=1702477749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QObWIwHoF89N2z5y8HXo20O9jmUqRvelo8TRN0vt2x0=;
 b=bt64qRBn5HbtiaBWnPdaMbbU6AgpGu0mvKlNW4TWOQH84akUokdxxN5yGLOf98D/fG
 2SqZWW3I/tPxEkNYB7mtwTOIFWXMvClcHRLMaKWj2w7uyt55W16If0Wi36pv4sANwTDL
 KNgOMq6w3cs9mIK+29ts3sstM3FTcanhaoOfjPr1809lrvOwav4gKVxUHACMrSaMab7H
 yOKK/BmkYGQQB0WOwlc1vwdGYL4/E9UVph3u7w4P3sOl1P9Vdgf0bWaGXNxcZoOFNIou
 6jZb1DWvZ3PQ5DmNp2dUIMvSVTF1QBfEEdrlSSBOITrkCHWiFEt2LUbd8K0D8eLwzP21
 rC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701872949; x=1702477749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QObWIwHoF89N2z5y8HXo20O9jmUqRvelo8TRN0vt2x0=;
 b=YUMnBSX0m44zFIeJVk3u+CT2kf8opAe0wfcWoCHdHGocrMBATKb/ILp43jmyJ7GKWN
 A85QOShOrZiyUiwmKc19VrW3myRUwcIO8dU4HikuRolNl8faunWqJG9EIRPQe2U7Kezu
 Mxieuldrz1UISC9lTq7v/ekMzPNyH5nULPgKjECz8kalO4RO9LaC8tiASGtn0Yugjl+N
 7+E7V/zv16goZRGUX3IRKe415ikZk9Y9WC5rB4dPMsJj6QIjJBF/atp0H4Audl/J1GOt
 ZsvZFh4R1K0IfDWxNOEVeFnZL52B3m+3X8HMyUfZi58RllZ5v+wOvszW9fFRSKMqdBlg
 CNyQ==
X-Gm-Message-State: AOJu0Yw4Fvle9Yxogk6TAMsSa8q6NKgQnhyt0O2GUglsFbkt0sCAHS1+
 9AMsFzZHSxwAmSzIibEuZpS3nM2yGpRy9vMjABg=
X-Google-Smtp-Source: AGHT+IFo8G2tjnlTsJw4OYeWlAgWglAQfdSxgQJ9k7uLTtk1S6srclJxbyTYwrxIC3mYuHEpSvM3iw==
X-Received: by 2002:a05:6402:c02:b0:54c:6fd0:fdea with SMTP id
 co2-20020a0564020c0200b0054c6fd0fdeamr657747edb.24.1701872948940; 
 Wed, 06 Dec 2023 06:29:08 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 l1-20020aa7c301000000b0054ca7afdf35sm23643edq.86.2023.12.06.06.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 06:29:08 -0800 (PST)
Message-ID: <189df9b0-7271-4463-98e4-e6e938a0cf6f@linaro.org>
Date: Wed, 6 Dec 2023 15:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Content-Language: en-US
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
 <20231204200937.GA9696@kitsune.suse.cz>
 <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
 <20231205100959.GB9696@kitsune.suse.cz>
 <20231206125619.GH9696@kitsune.suse.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231206125619.GH9696@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Hi Stefan,

On 6/12/23 13:56, Michal Suchánek wrote:
> On Tue, Dec 05, 2023 at 11:09:59AM +0100, Michal Suchánek wrote:
>> On Mon, Dec 04, 2023 at 03:02:45PM -0800, Richard Henderson wrote:
>>> On 12/4/23 12:09, Michal Suchánek wrote:
>>>> On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
>>>>> On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>>> +void tcg_unregister_thread(void)
>>>>>> +{
>>>>>> +    unsigned int n;
>>>>>> +
>>>>>> +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
>>>>>> +    g_free(tcg_ctxs[n]);
>>>>>> +    qatomic_set(&tcg_ctxs[n], NULL);
>>>>>> +}
>>>>>
>>>>> tcg_ctxs[n] may not be our context, so this looks like it could free
>>>>> another thread's context and lead to undefined behavior.
>>>
>>> Correct.
>>>
>>>> There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
>>>> well. That would require a bitmap of used threads contexts rather than a
>>>> counter, though.
>>>
>>> Or don't free the context at all, but re-use it when incrementing and
>>> tcg_ctxs[n] != null (i.e. plugging in a repacement vcpu).  After all, there
>>> can only be tcg_max_ctxs contexts.
>>
>> But you would not know which contexts are in use and which aren't without
>> tracking the association of contexts to CPUs.
>>
>> Unless there is a cpu array somewhere and you can use the same index for
>> both to create the association.
> 
> I tried to use cpu_index for correlating the tcg_ctx with cpu. I added
> some asserts that only null contexts are allocated and non-null contexts
> released but qemu crashes somewhere in tcg sometime after the guest gets
> to switch root.

Since this isn't trivial and is a long standing issue, let's not
block the 8.2 release with it.

Regards,

Phil.

