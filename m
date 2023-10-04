Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEEC7B7C0A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny81-0000Cd-CM; Wed, 04 Oct 2023 05:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny7y-0000CN-H1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny7w-0006TD-QS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso19420675e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411507; x=1697016307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVoMcjjv2bIqEkJ3A7v1m4PGriAwn+2QtOS0Z+/4j70=;
 b=t7d1mABXyXd/HLjp43Uxqgppm6k7UH5qL8Q4AvMKHoiJ4EWCjjvXwZvQqZVOF1zc1K
 FED1AEobtHeuUybLmQyuNKeomvmRZFSsHmdSxbh//idfdO1D9GtQwK0rDLdXoHVidnxA
 52Z34RvMEmWMJ/TlL1RUHY7Z+NxCJr+nlntp210DqY2QqFp5QL123pO0UnQvUVWa1Ydr
 eYiPwabNdIWsX7Vek6YgLBj5vOlQj0o+zNX9RWdpryd7YKfqZO+RliSKhpjxXwdvpeAA
 3jqA0vh2a96FQqdW4ad6gjv176welxyezBwU8Mqa27MIC6010AqFxG348x8fGSNqIkgS
 ERXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411507; x=1697016307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVoMcjjv2bIqEkJ3A7v1m4PGriAwn+2QtOS0Z+/4j70=;
 b=w78V6L33XV1i+BqQM6OHnGRiJRdlKbhHSYKDAiQ8xG5eBP/6obdecdBlhn68YRkGqU
 JlnpHBIZetBzFnCnT5JfO/OK08bLY+kI0FZ0zaAttAxKM8PxkFu/0VvMPwtkXQcIOTzs
 dhKGp0jyWVlBbwFLaX6Ww+ca+GiJGbCA2DY+rt+w+mMJFcWgobccsq+T+l3CCyAG8PF/
 QrsoN2QvkMDfZ0Ymx00Az1v3g14HizmqP1mxYr3yuANZqkK0F6FtZ3t7ZyPQXAS2G93w
 em/CZ42dVzyF3IkX6VJ+40gmqrtYxpv+Hbuk1ffkPsMUDP8Mw2pSSicUGaa3KkRpCu9h
 nGnw==
X-Gm-Message-State: AOJu0YyjsExW5bicM4mXT2keaZ0kzz8zI11Jm6FuZwRjgpWUeiCh+v+S
 3hG/CrJb60SJvkV9Yfdrvuqr/fkm4Gn3yQpW9No=
X-Google-Smtp-Source: AGHT+IG9QBtbowosdpQu8bxpVVFwlSitWJhaZDXAxHd0GpzIgqWSp7pL55e2BnLWNz20spC3XgIlNw==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr1545472wru.28.1696411507095; 
 Wed, 04 Oct 2023 02:25:07 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 a8-20020a5d4d48000000b00324ae863ac1sm3514148wru.35.2023.10.04.02.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:25:06 -0700 (PDT)
Message-ID: <273f280c-22f5-7dc3-4410-01f6f4c67c8e@linaro.org>
Date: Wed, 4 Oct 2023 11:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86
 targets
Content-Language: en-US
To: Roman Bolshakov <roman@roolebo.dev>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>
References: <20230905123906.6880-1-philmd@linaro.org>
 <20230905123906.6880-3-philmd@linaro.org>
 <ZP4uPozEl3pjY2qg@MacBook-Air-Roman.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZP4uPozEl3pjY2qg@MacBook-Air-Roman.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/9/23 22:59, Roman Bolshakov wrote:
> On Tue, Sep 05, 2023 at 02:39:06PM +0200, Philippe Mathieu-Daudé wrote:
>> hvf_get_supported_cpuid() is only defined for x86 targets
>> (in target/i386/hvf/x86_cpuid.c).
>> Its declaration is pointless on all other targets.
>>
>> All the calls to it in target/i386/cpu.c are guarded by
>> a call on hvf_enabled(), so are elided when HVF is not
>> built in. Therefore we can remove the unnecessary function
>> stub.
>>
> 
> Looks good but you also need to include "hvf/hvf-i386.h" to
> target/i386/hvf/hvf-cpu.c, otherwise the build fails.

Oops, thanks for testing!


