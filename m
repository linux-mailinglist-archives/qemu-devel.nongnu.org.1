Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A580D84C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:44:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClG4-0004FY-Rq; Mon, 11 Dec 2023 13:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClG3-0004FB-DK
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:43:59 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClG1-000134-Ce
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:43:59 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33622099f23so1050785f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320236; x=1702925036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7iIbUe4HqEzpB8PWwuLJHVnIrXVBAvNw+FJ17pUIqGI=;
 b=iOZFMVl9+KDPFORkOWyi3tCCk7SAGCQmk6Cu6MNeDQUKqTIyEAXG5dnpKT6A5It5dh
 cNOESu8BwSt8s0LZb9H6z91BzA1oXGaIMdtwIpmUlQYQYSFBwzNtyHkpQnpi3nenVYIC
 N0GmvASkLGg8+Zg5JhSZurzYv6M1G44rGsZhg1vyOrm6/gc+bOH9s6sggDyS9rdpHuI8
 wsOuS+/MVyiA3uiswWpTHkduQWEPk8swvlde5itE8UKL6kc1XIbA8v9EabXlytu8nyfN
 zXE9PLHI874M2H4RsBaxeZzczSPSKdjus0Wx9D8//Qffol9OrVSxZZhGYj3sCBWeMufF
 6k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320236; x=1702925036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7iIbUe4HqEzpB8PWwuLJHVnIrXVBAvNw+FJ17pUIqGI=;
 b=fIU0rbchqnv/NEYVZ61aqTbMm2fDV5aEbvSlneZ23mrpexo0erGSHS8m8iB8EPVDIr
 i22CUt99/5X02HgP0YKBfm5oy/CTcfa/pgsMZBIrgyzmDh8ryDCJvssWXx/BkTqXyzPM
 WI1Qm/qq9eTrwzsYpyZ08baXomltWFCZ6XQ/At8G7e7i04SLK9vBJTR8VUTcyj9mwusY
 Z+yaoKUMxDqaM6EhLPyq3WR2wWIaJEKSMB/yBJ9ETLPEJsldCKyr4aaa89jvW7L91Mnt
 Q2jogbo2lAL7e741ZnfnXWLQI68K62UADmglI1xu5N9g9Wzc3KQoDN5v+x6SwnmklaAQ
 tqRw==
X-Gm-Message-State: AOJu0Yyxyj1Gyhdju6smGGodS1AdNzzbZRZIzjXV35chb+boFKyv9HG+
 rkTANLzpU9s5ElM2r50dTp8BDA==
X-Google-Smtp-Source: AGHT+IHcVLFuy3VC/x25Obl50gReIc5/CW0Kq5E8km55CQIrpoG9Nt3FRfpjfbl3CTGwOFUjok9Iqg==
X-Received: by 2002:adf:e951:0:b0:336:1b04:c0c1 with SMTP id
 m17-20020adfe951000000b003361b04c0c1mr1299666wrn.12.1702320235861; 
 Mon, 11 Dec 2023 10:43:55 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 f8-20020adff448000000b0033344666878sm9151217wrp.91.2023.12.11.10.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:43:55 -0800 (PST)
Message-ID: <89aea648-1254-47b8-a194-e4d22de5c097@linaro.org>
Date: Mon, 11 Dec 2023 19:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-21-richard.henderson@linaro.org>
 <db8f1d15-121c-4597-8f04-15661c7eaa3b@linaro.org>
 <CAFEAcA94EdEEcjvTZLYwnuv=ngQz5sD+ihY7ez+soeJMu=aXow@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA94EdEEcjvTZLYwnuv=ngQz5sD+ihY7ez+soeJMu=aXow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 11/12/23 15:34, Peter Maydell wrote:
> On Fri, 24 Nov 2023 at 12:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 23/11/23 05:42, Richard Henderson wrote:
>>> Drop fprintfs and actually use the return values in the callers.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/kvm_arm.h | 20 --------------------
>>>    target/arm/kvm.c     | 23 ++++++-----------------
>>>    2 files changed, 6 insertions(+), 37 deletions(-)
>>
>>
>>>    /*
>>>     * Sync the KVM MP_STATE into QEMU
>>>     */
>>> -int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
>>> +static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
>>>    {
>>>        if (cap_has_mp_state) {
>>>            struct kvm_mp_state mp_state;
>>>            int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
>>>            if (ret) {
>>> -            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
>>> -                    __func__, ret, strerror(-ret));
>>> -            abort();
>>
>> I suppose if this abort() had fired, we'd have reworked that code...
>> Maybe mention its removal? Otherwise,
> 
> Well, it's a "KVM has failed in a way that's fatal for the VM"
> kind of error. It's OK to drop the abort() here because since
> 7191f24c7fcf we will catch error returns from these arch-specific
> functions in the accel/kvm generic code. When this was written
> before that commit then if we didn't detect and print something
> here we'd just have silently dropped the error, I think.
> 
> I added a brief note to the commit message to that effect.

Thank you.


