Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BF798A8A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qee50-0004W6-4s; Fri, 08 Sep 2023 12:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qee4y-0004UG-4Q
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:11:32 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qee4v-0004BR-GP
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:11:31 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so286181266b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694189487; x=1694794287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIKGcYneX0QMmy25m80dXHB0Zz9nuIupozxUaWEUBwo=;
 b=l6YxzbXhBjGeYSboQ48R96ala2mAYjYvy7vcoFLo56dsSNxhNEA/zDRInl2rhTjpEv
 VItpdnyMra/YLQxNB1hZcIEnELYu9w/O3HiB8Ud61zhUI98UJgEnRonenis9TijCqTcj
 IqhMNC5074mgv9iBl+1BVsMvf8oqdlyTlv8BMw7jJgUymQba/TYLjH2xVhnexrSP9UOR
 cy2AFJuURtCNg1pkn8jnTAOqZUDecIe2MgWLZle7JI/dhF8W5uTtvRXyB1OBezXHwpyH
 XcHlutBo3JVHN62tf2mkv5HUDjNKEAJuKXf/GUXwTQyupIcKnALtvm351Ivqfn94uP6f
 QKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694189487; x=1694794287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIKGcYneX0QMmy25m80dXHB0Zz9nuIupozxUaWEUBwo=;
 b=Fy/BPwyb3p/IKuK2UWR4PLxgwA0YFnBiPk+qswfE6rfatF9oCGHSEGpKNbxtr2y97Y
 scpfEzTNToQaED8QUJJa9hg5lNP6whUOItzGD2mJDCRqd1SgsoFBIvOKqnmx/fL9za4C
 gLkFvQCjvKd3vyLtd1bAIctygVNyHhXyS/rGJl5FRzNI+vDRjgzuQGBd+u772LSeSWKF
 S85Tl2cjrZz1fCsW3LBSxBPhZzhna/cv9Zi2PvAhUPb86zJQCbwDW0ozMwfjE3WXVemv
 RiJJcWbDA7lphWLAEHESv2YBmhAKxH1RH9YRQfg4jYF/Vwks9mjivxpwGqDh0b6w84IQ
 WP4g==
X-Gm-Message-State: AOJu0Yy/k4sI3oqkdCS+SH0XXmMJiSfA6yvjnoMN3I9D75dqFhMX82PC
 cyrqg0nycmRcsOJI3B+2Gak5Hy0o0FvtyZ6Uido=
X-Google-Smtp-Source: AGHT+IEhbvn1WAiknMXXnwcxiyq3JBP8jEeW0Q0Q5s7Psi+4EHfcdiVnLlWeQuwek2YBGowxO0mzrA==
X-Received: by 2002:a17:906:8a59:b0:9a9:f2fd:2a2b with SMTP id
 gx25-20020a1709068a5900b009a9f2fd2a2bmr2198053ejc.73.1694189486814; 
 Fri, 08 Sep 2023 09:11:26 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 ck8-20020a170906c44800b009a5f1d1564dsm1205760ejb.126.2023.09.08.09.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 09:11:26 -0700 (PDT)
Message-ID: <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
Date: Fri, 8 Sep 2023 18:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZPs3UB8W4lsOFnxW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Kevin,

On 8/9/23 17:01, Kevin Wolf wrote:
> Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
> 
> Something in this has broken the build for me, it seems to be the
> linux-user binary that doesn't link any more:
> 
>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'

My patches. I can not reproduce so far,
What are your ./configure command options?

>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined references to `kvm_arch_get_supported_cpuid' follow
>    clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> In case it makes a difference, I'm using clang on F37.
> 
> Kevin


