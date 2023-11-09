Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D547E71C3
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:54:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AAQ-0000GN-3X; Thu, 09 Nov 2023 13:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AAO-0000G3-Dn
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:54:12 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AAM-00063p-Me
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:54:12 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso205262066b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699556049; x=1700160849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+e5Ki+tlrDQdsoYNQoY+LGYAF9bDFtQ3TC3wjh0Ter4=;
 b=GUVkYff4xKr2L3TNl3GlER9wD/nvTNNDEvV/f3cIss5ofAXbs4urhxAfeiZb7Cq10W
 1m5Oy/6ckVPEtnPQL3Ygy9HuQfFMhsZ0n5J1uRL25GEVlTCsSEMI9V/EBUcGXA7sveYE
 iK0XpKH1bHP2DR5xayIA42FYE61zl//aFETnoC3yIjcE6/X5z1knpOaoZeqFZZSOKxLL
 5qtmdL6y6PXgFL25T5quBx3b40lxtp0Qce7WfF32mJdQLa4hOr9mbWowbKnINKmEVs/O
 c1Xo1UClxJN5JESHZYDRuWpRkAnx4rGpvF6tizt8i7v7nCcbc/Tx66WT/x/pJddCLqtN
 JMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699556049; x=1700160849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+e5Ki+tlrDQdsoYNQoY+LGYAF9bDFtQ3TC3wjh0Ter4=;
 b=Kww/ILSYmfdi4RI5F4uwhIa9p0LtKPs3pPwv+J/8GMj6Rxy3O74VszrFfQoFLHRjg5
 dvQZ7KCxcPCRvLulwl8x+TbgGLIPRwFI1k+psaWhCIzSLUYJiHYqrGq8uHcg40SYAgTJ
 79AGVMkaeZLL79BCaWvQ/sWYQtjnv50LS7iWAcSp/b0YFJwRJLrUD+f29OXYesji0pn+
 VWWLlsAyoPP6hYdOZR6lSYrpYVKdXU+8WO2uZNT6hYy90km0ywCco+HMCq3gpgwB6T7f
 RejR/+DlpEu1hztwgSh6b5MWKP5h2Cw6mbfoafuHkChVXCZ4Edwg77yGXY6NNR04ZQYx
 3paA==
X-Gm-Message-State: AOJu0YyV+28Y0JLuZ/4+NaC8RK/NJEAzqbn4aCkPYUcvgEJFym2ZXucg
 YgxoMRdOg3KcEiUJ5DiVVZS8rPWDgdLAAotXlRbBMQ==
X-Google-Smtp-Source: AGHT+IEbujev2ifR1Bt+24yXRn/WQ/o8Wcfu0oBFJJfUe8iIGAXXqUXc8zRLxSYLjBdHcu9RfpWvFg==
X-Received: by 2002:a17:906:29d5:b0:9e5:2b2e:5b64 with SMTP id
 y21-20020a17090629d500b009e52b2e5b64mr1438139eje.12.1699556048699; 
 Thu, 09 Nov 2023 10:54:08 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 jz6-20020a170906bb0600b009df5d874ca7sm2884987ejb.23.2023.11.09.10.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 10:54:08 -0800 (PST)
Message-ID: <8a491ad7-fbb1-4c9e-a735-79afa41859fe@linaro.org>
Date: Thu, 9 Nov 2023 19:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 9/11/23 18:15, Thomas Huth wrote:
> On 09/11/2023 17.58, Daniel P. Berrangé wrote:
>> On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
>>> On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
>>>> This Cirrus-CI based job takes ~12min, similarly to macOS job.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> Based-on: <20231109150900.91186-1-philmd@linaro.org>
>>>>             "tests/vm/netbsd: Use Python v3.11"
>>>> ---
>>>>    .gitlab-ci.d/cirrus.yml | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>>>> index e7f1f83c2c..7b01acb104 100644
>>>> --- a/.gitlab-ci.d/cirrus.yml
>>>> +++ b/.gitlab-ci.d/cirrus.yml
>>>> @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
>>>>        - cirrus-run -v --show-build-log always 
>>>> .gitlab-ci.d/cirrus/$NAME.yml
>>>>      variables:
>>>>        QEMU_JOB_CIRRUS: 1
>>>> -    QEMU_JOB_OPTIONAL: 1
>>>> -
>>>>    x86-netbsd:
>>>>      extends: .cirrus_kvm_job
>>>> @@ -110,3 +108,4 @@ x86-openbsd:
>>>>        NAME: openbsd
>>>>        CONFIGURE_ARGS: 
>>>> --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
>>>>        TEST_TARGETS: check
>>>> +    QEMU_JOB_OPTIONAL: 1
>>>
>>> BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).
> ...
>> I could have sworn our cirrus jobs were much slower in the past (around
>> the 40 min mark), as we had to cut down what we were running to avoid
>> frequent timeouts.
> 
> You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd 
> job are currently broken and only output some help text instead of 
> compiling QEMU:
> 
>   https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
> 
> ... that's why the finish so fast.

Doh, I didn't noticed...

> IIRC last time I've seen them "working", they were running into the 80 
> minute timeout again.
> 
> So the netbsd and openbsd job are indeed not very useful anymore. I 
> think we should rather remove them and add a proper job via our own 
> custom KVM-capable runners instead.

Warner, Richard, OK with that?


