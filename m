Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685DE79A720
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:11:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdsY-0004PO-RQ; Mon, 11 Sep 2023 06:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdsW-0004Le-Hv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:10:48 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdsT-00013K-Sj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:10:48 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-500a8b2b73eso6741317e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694427043; x=1695031843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Et+/8zFfFP+z+X3g+hcAV6BKJQEKLZjnGmoAXNc1tHY=;
 b=YE4KRF1mJ4ZXgMOOPeEtGEWyUBP0G6OdISMhF9ljF8utm6f9ePhJM1573dZZa7Fs+z
 8J1rz0hx9TCLDlNuP6S2H/dy08H2CmhJEoX+j1TsVjcHvLbI7WhhiFiD4cLM7+0NXB+V
 cqGcdylFWksIyspzK0ZAKmCq0N7X3TtFs5rlkgbxYY18KUnj64tlM/wTkxwNfr44w6JY
 j6zq59YkBF9qlPZcQqO8Gcg5omR07wyeVtkP76oxZ12bo6rA5cfeAJ8fWMW/0QUhYL9c
 qKxd7CZhZUm6OZq4i3zNLUfITapab1QH46jfrJpa7QA77td7LO8JVZr1khF8MlzX8Yso
 4uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694427043; x=1695031843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Et+/8zFfFP+z+X3g+hcAV6BKJQEKLZjnGmoAXNc1tHY=;
 b=M/Wdw7axHifajZCy4B9fduMf7/lkbgHJrM8lAud2LBfEeeAN5hKcZMOmqUeIDpFfmq
 ovJNWmNFl2Sbm5yEAJZJLEsdabm8NWGTC79+0wGIoj+U/2z3RrYQd5nAYy8UFhmUtA9V
 Ou5DCWSsVFTBtO1GumpMCCqvZBwr7HkfAddbxXjwPDDeIsSwdvDLRl4CwcflBZ7pYsqk
 4qQjloFeXGK9kxJRtJzmgBpgJeDucU9muikSvHLu/NnR/R1jG5NtAulzF4ThpuWWlip0
 8WJiuv2EkYO0r3XQyjLyo9xV29s5iwJI/Q+7Qpni2JbWLTTln4mVs6/1bJtMrf+CI24o
 yt7w==
X-Gm-Message-State: AOJu0YwasfzjjGHOsm1SrA8Uc6UcP+c2OOOChGHLBgG4e3b2pHtxtwp5
 r3Rp2s5wzo0+erKD7KVKzPjZRVFai2lZiOIWbmU=
X-Google-Smtp-Source: AGHT+IEJ64vykBi/sf0VU9BbbJxZdns21CxopztCNK3nJGUvQY3w3FJZ2tIfZl2dt5X/+m2cxZynaA==
X-Received: by 2002:a05:6512:15a3:b0:500:b3fe:916e with SMTP id
 bp35-20020a05651215a300b00500b3fe916emr8331070lfb.2.1694427043112; 
 Mon, 11 Sep 2023 03:10:43 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 g1-20020a170906394100b0099bc038eb2bsm5039790eje.58.2023.09.11.03.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 03:10:42 -0700 (PDT)
Message-ID: <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
Date: Mon, 11 Sep 2023 12:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 8/9/23 17:47, Stefan Hajnoczi wrote:
> I wonder how it passed CI?
> https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/

The conditions are:
- x86 host
- both system / user emulation enabled
- KVM disabled
- debug enabled

We have jobs with 3 of the 4, but none with
all the 4.

Is it worth test it?

> 
> Stefan
> 
> On Fri, 8 Sept 2023 at 11:02, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
>>> Applied, thanks.
>>>
>>> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
>>
>> Something in this has broken the build for me, it seems to be the
>> linux-user binary that doesn't link any more:
>>
>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'
>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: undefined reference to `kvm_arch_get_supported_cpuid'
>>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
>>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
>>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined references to `kvm_arch_get_supported_cpuid' follow
>>    clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
>>
>> In case it makes a difference, I'm using clang on F37.
>>
>> Kevin
> 


