Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B67B81CD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2WW-0005XZ-Oi; Wed, 04 Oct 2023 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo2WR-0005VI-RP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:06:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo2WO-0007Dt-Ur
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:06:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso6346285e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696428399; x=1697033199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BvmtLqtZwV4gWiHuY3IW+B7giJD8PGIdyPHkZim0nX4=;
 b=RQSO2Qdh76iTKqJsEAqULlkazhK0oNu6ekaWlLudgY8/S+E++FIdhyHXi1c9ZCOfml
 ib+4dwCdC6Nt5ILFbs25h+mjQGTfm0BziMlUjwdWfpebmJkJPDFyNH6ouD0O2IJl+Tx1
 CpXl4d92d4oVRhIW4PV9dWtKrx2dtqUHgUxpvYQbhQTB1QQTb87WmzRKf2sCmyqRVZ4l
 4fDZhGi2dkQex8RfdzCkncJT6z7zZ7DaziM7lky0WJZmelj9HUmK4LBzhZwNXt7KxwYg
 1WwmWK+w0TY5wIXK881XwsGEUr+F/kzt+17Ql43h7ihTf6+h4fBLj3xEJEdZ5yYjEL2Y
 DTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428399; x=1697033199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvmtLqtZwV4gWiHuY3IW+B7giJD8PGIdyPHkZim0nX4=;
 b=NT4WDpBm4tUvVpyXah0c/KMsTQMK6Vu6OpqPAXOaT/7/4WElT9HGUSQJ3xVq8M9G+P
 e+mZT0/4FRQjo5XRkwOePihQOdqg9/xnwyaX6LTpb3saw+Stt08JPQw+hiejwfkEQ4Ix
 7skpY4G9Sn9LaW5+Dtx5CIqRw2Rt1KIN0/3CY/y++J7e7afsuB/8ILuVyOS4Tx75+ToP
 9i01JYGsgll+cbv5PfyFwaIn1Pw2ntx6QWdztSzgchdl2yyUyNa4d+JTk6dGTO5lNt3H
 czF5LEIHPQriEIVDQ5P6kNGa35hVg1pEtQBMM2sI21zze0oMuj12PWBVTc3Fzp15cw0U
 A1pA==
X-Gm-Message-State: AOJu0YzDeGNajfzzpp0FpuP/T6ek56jpPw9Vl4gEe0vflxF26ogyTlI+
 9+/GCUgseRHUVOphPYA1pO3eog==
X-Google-Smtp-Source: AGHT+IEbTvdXJskOq2r4K4RoT+3YvkUEHjnWQrvJnbBpeUy5bP3Gr7FyuzBr4NuuQh6NwuJu4jpUbQ==
X-Received: by 2002:adf:e9c1:0:b0:31f:f2dc:db7d with SMTP id
 l1-20020adfe9c1000000b0031ff2dcdb7dmr2178875wrn.65.1696428398785; 
 Wed, 04 Oct 2023 07:06:38 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056000128200b0032196c508e3sm4137728wrx.53.2023.10.04.07.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 07:06:38 -0700 (PDT)
Message-ID: <191a6af3-489b-04bc-0afb-092bdb437a47@linaro.org>
Date: Wed, 4 Oct 2023 16:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20231004090629.37473-1-philmd@linaro.org>
 <ZR1bjpEi5HdFp2xj@redhat.com>
 <85be2979-c0ca-3eb4-dae9-bbabf256c201@redhat.com>
 <00b2ec16-162e-9204-3a04-f45e0edeeb15@suse.de>
 <CABgObfZBTZZvcSPcMSRLWscyEz7B-2h9g28FJx7t7Ggux6E9cA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZBTZZvcSPcMSRLWscyEz7B-2h9g28FJx7t7Ggux6E9cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/23 15:49, Paolo Bonzini wrote:
> On Wed, Oct 4, 2023 at 3:41 PM Claudio Fontana <cfontana@suse.de> wrote:
>>
>> On 10/4/23 14:37, Thomas Huth wrote:
>>> On 04/10/2023 14.33, Daniel P. Berrangé wrote:
>>>> Am I mis-understanding what you mean by 'finishes' here, as
>>>> I see many references to softmmu remaining
>>>> In particular under configs/
>>>>
>>>> I was also hoping it meant that we'd be changing configure
>>>> to allow
>>>>
>>>>       configure --target-list=x86_64-system
>>>>       configure --target-list=x86_64-vm
>>>>
>>>> for less typing
>>>
>>> Maybe we should also bikeshed about the naming first... "system" is a quite
>>> overloaded word in this context already, and "vm" sounds rather like
>>> hardware-accelerated stuff ... what about using something like "sysemu"? Or
>>> "fullsys" for "full system emulation" (in contrast to "user space"-only
>>> emulation)?
> 
> I agree that changing other remnants should be done right
> after this patch, for example $softmmu in configure. Changing
> all targets is a very large and very user-visible change, it is
> required but it should be planned very well.

As usual I should have been more verbose in my cover.

This series focus on the C code (and travis) to avoid misuse
of 'softmmu'.

Yes I agree it would be nice to also rename the binaries, but
this is a buildsys change (even if we use symlinks/aliases for
some deprecation period). This is not a tiny patch, and requires
thoughts.

On one hand I'd rather not rush renaming binaries -- annoying
users -- without a clear long term plan (which I'm not clear about).

On another hand I wouldn't delay Richard user-mode work.
Renaming binaries seems orthogonal to me, and could be done
later IMO.

> As to the actual target names, I think system is the only
> consistent choice since we have --enable/--disable-system
> (as pointed out by Claudio) and qemu-system-*.  sysemu
> may make a little more sense in the codebase (we have
> include/sysemu after all), but maybe that ship has sailed
> since we have many occurrences of "system", for example
> system_ss and other related sourcesets.
> 
> Paolo
> 


