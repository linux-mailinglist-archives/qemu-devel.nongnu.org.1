Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18298737FBC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvXI-0005xz-6i; Wed, 21 Jun 2023 06:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBvXF-0005x1-RC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:58:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBvXD-0003MC-VI
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:58:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-982a0232bdcso889974166b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687345076; x=1689937076;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TswoE/cWbng7N3rzxjvBBpvcimCGZUEqqoDgjmoj0Uw=;
 b=MB1AwMPo8wgJ7wJx2GjyrJXA9d/lKW8gRqRAN+9fcbTBpUip32TkTBQEJU1uOWO9yP
 A7M0AZ+F3OVb9hc4tLw0SMSg6E7Ue/tqq6ke6fk2HoZN/eXYlAqimphSHIQLoqDv6eu0
 J6cjFJytf52JPu/ke5NrkhPlB+SUHfRHIojnIJESKJaJytGv6yVqUlMDmdXAsywO7uZ4
 FVYD6cl0PfwohoekfbxGUH30nKgQUKeHjw2kFDHFmGdFIrX/Q2Xw2vvq2iNfPRZnJKFC
 Q52ixniLFSC6AKRMhQqw83gFO19vxdsRE2SKyw4UhyAW6LZHWu4dThoPsNgmwJlhkwZw
 ThPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687345076; x=1689937076;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TswoE/cWbng7N3rzxjvBBpvcimCGZUEqqoDgjmoj0Uw=;
 b=NsHJK5y0eZitJNLD34dzrxdfOPLaqF6yB9Vi78Mn2xxGRuCLhz0Y9l9nM9uYQxWrbw
 b9QohJVhgyIWLljjHryarcjaO+IxN7wUdKKvEmPHSHR6GsuNese855wf2fu61GDyR7Ai
 OuPTkpL/a1M2vCNR53tYx1vS2bFT4esK5QjIfgBuOxe4c9dYNnYAjdobllA2PJ/ivnK3
 fcdcpZ8BzaZINQWVSOq43wqBMhgn0BZxF3DE0aJqPqOrjs36LoYHZ0fXIb0spBmrmg7w
 XM3dRwQtRA6wdqimzXhEFnRTBc9Aq6quxI+opI33y7lcUupM/vr/mBEHV3iU9wO/0fvO
 buGQ==
X-Gm-Message-State: AC+VfDySXoRVXB59S9sI/8zTN5p/0HcyrrpNC+mVHU/7qHErHnmUPMaE
 Lc7HUo+u6sG7J6LcD9pXo4scIQ==
X-Google-Smtp-Source: ACHHUZ7xyascRkiwA6mIKnaDRsVdsbVlKNNUrigH+tAmMsDFRdTLmhfcSLf3KWdJ0P9J9JpHGjFF2g==
X-Received: by 2002:a17:907:6088:b0:988:dc8e:2fec with SMTP id
 ht8-20020a170907608800b00988dc8e2fecmr6923382ejc.36.1687345076336; 
 Wed, 21 Jun 2023 03:57:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a056402134400b0051a468dc144sm2442811edw.20.2023.06.21.03.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 03:57:55 -0700 (PDT)
Message-ID: <780c8505-9cd7-87fd-c5cc-23f0e8aa455c@linaro.org>
Date: Wed, 21 Jun 2023 12:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "cputlb: Restrict SavedIOTLB to system emulation"
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230620175712.1331625-1-peter.maydell@linaro.org>
 <5b2bf86d-44fa-35ae-8049-b395d715adcb@linaro.org>
 <97cace68-b1d3-73f7-fa69-266ea0f36229@linaro.org>
In-Reply-To: <97cace68-b1d3-73f7-fa69-266ea0f36229@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 21/6/23 11:39, Philippe Mathieu-Daudé wrote:
> On 21/6/23 07:19, Richard Henderson wrote:
>> On 6/20/23 19:57, Peter Maydell wrote:
>>> This reverts commit d7ee93e24359703debf4137f4cc632563aa4e8d1.
>>>
>>> That commit tries to make a field in the CPUState struct not be
>>> present when CONFIG_USER_ONLY is set.  Unfortunately, you can't
>>> conditionally omit fields in structs like this based on ifdefs that
>>> are set per-target.  If you try it, then code in files compiled
>>> per-target (where CONFIG_USER_ONLY is or can be set) will disagree
>>> about the struct layout with files that are compiled once-only (where
>>> this kind of ifdef is never set).
> 
> Oops, sorry.
> 
>>> This manifests specifically in 'make check-tcg' failing, because code
>>> in cpus-common.c that sets up the CPUState::cpu_index field puts it
>>> at a different offset from the code in plugins/core.c in
>>> qemu_plugin_vcpu_init_hook() which reads the cpu_index field.  The
>>> latter then hits an assert because from its point of view every
>>> thread has a 0 cpu_index. There might be other weird behaviour too.
> 
> Why isn't this covered by CI, and where could we add a such check?

Actually it is covered and failed on staging:
https://gitlab.com/qemu-project/qemu/-/jobs/4503766933

Anyhow, sorry for the mess.

>>> Mostly we catch this kind of bug because the CONFIG_whatever is
>>> listed in include/exec/poison.h and so the reference to it in
>>> build-once source files will then cause a compiler error.
>>> Unfortunately CONFIG_USER_ONLY is an exception to that: we have some
>>> places where we use it in "safe" ways in headers that will be seen by
>>> once-only source files (e.g.  ifdeffing out function prototypes) and
>>> it would be a lot of refactoring to be able to get to a position
>>> where we could poison it.  This leaves us in a "you have to be
>>> careful to walk around the bear trap" situation...
>>>
>>> Fixes: d7ee93e243597 ("cputlb: Restrict SavedIOTLB to system emulation")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>   include/hw/core/cpu.h | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> Ho hum, thanks.  I'll apply this directly.
> 
> Thanks both.
> 


