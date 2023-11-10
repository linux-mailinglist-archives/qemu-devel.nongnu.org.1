Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A817E7AE4
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:31:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nqy-0001Qd-DT; Fri, 10 Nov 2023 04:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r1NqZ-0001IV-Cy
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r1NqW-0005LZ-2s
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699608633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o/gSqr3euw/9ojjrtKu2Emy797vAtlehLPlF6krrX7Y=;
 b=PIooQgFEwMnOl3/XpL6oXdmQtk4MvBekbNCQwScQy1dgGtlvQ+SIvyDZQj0lraRIHlXL7C
 tf0017KVVutlY9vDOA9SIyqXpBdjWb4wg5pllSF6YOVE8S1xAWAZQ4fSLdMe4Dt52eEr+0
 T7+UxYGQUA7p5FmMqEGPd4hkbMBoqKs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-GIVC-8rNP0qMN10epuUjsA-1; Fri, 10 Nov 2023 04:30:31 -0500
X-MC-Unique: GIVC-8rNP0qMN10epuUjsA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41cbc7d2e58so21741351cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699608631; x=1700213431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/gSqr3euw/9ojjrtKu2Emy797vAtlehLPlF6krrX7Y=;
 b=AN9UmpII2/eSYB7LQbn9Afaj274NActrL4AVNvBDuR3YUFcQnMugyN10Yui05s98rT
 f7TELLOoTiupI/QMrNrUzIVQV7xDvGPaDhTjZp72i9Qbrg/Wj7Gxr38nw0ictiVNsdFw
 lSSf9Y7iEWQSGUmPCHKAL0aOiHlr0VtcdOIAKETaguyt2VF6IKr2JfLQSr3nf+x/eT2f
 xeWFYBIXceGloDYWud+VArJBMSn4sVz+icivkLBepHPB9Hr/CJIsNngHFV+vgxpHdCc/
 CxOxq8m3sbNFgKWLy/UJOZiFnGvS7jvx+sAajTkOJdi+OS3oW5w0xjzYF59sz9ugjJuR
 tqXA==
X-Gm-Message-State: AOJu0YzAaIDpjHqkiaWlKn1xjfRV2uXVOvXUufU9lcWUqd+e+GJJG9rt
 oVPatORVPTlHWNvfEG0boeQQo55tbKGTDMuKwKO+vIqfq84S8BgR6YWtITlqbfV5NR3UG5R0Vbo
 CwBQ3FvdSPqexS7s=
X-Received: by 2002:ac8:5d8a:0:b0:41e:1cc8:f280 with SMTP id
 d10-20020ac85d8a000000b0041e1cc8f280mr8486562qtx.59.1699608631274; 
 Fri, 10 Nov 2023 01:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLuxAO0VVzOzYxN337004gGOtXFTFDIUpHGvOiWRhcLwrSocOQ/vrq6FVbpRTnMipk+xYuHQ==
X-Received: by 2002:ac8:5d8a:0:b0:41e:1cc8:f280 with SMTP id
 d10-20020ac85d8a000000b0041e1cc8f280mr8486550qtx.59.1699608631011; 
 Fri, 10 Nov 2023 01:30:31 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 v7-20020ac87487000000b0041815bcea29sm467470qtq.19.2023.11.10.01.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 01:30:30 -0800 (PST)
Message-ID: <68a7b137-1709-4a1c-ba50-374aa30bc036@redhat.com>
Date: Fri, 10 Nov 2023 10:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Beraldo Leal <bleal@redhat.com>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
 <ZU32PpBQc6jLmexY@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZU32PpBQc6jLmexY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/11/2023 10.22, Daniel P. Berrangé wrote:
> On Thu, Nov 09, 2023 at 06:15:51PM +0100, Thomas Huth wrote:
>> On 09/11/2023 17.58, Daniel P. Berrangé wrote:
>>> On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
>>>>> This Cirrus-CI based job takes ~12min, similarly to macOS job.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> Based-on: <20231109150900.91186-1-philmd@linaro.org>
>>>>>              "tests/vm/netbsd: Use Python v3.11"
>>>>> ---
>>>>>     .gitlab-ci.d/cirrus.yml | 3 +--
>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>>>>> index e7f1f83c2c..7b01acb104 100644
>>>>> --- a/.gitlab-ci.d/cirrus.yml
>>>>> +++ b/.gitlab-ci.d/cirrus.yml
>>>>> @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
>>>>>         - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
>>>>>       variables:
>>>>>         QEMU_JOB_CIRRUS: 1
>>>>> -    QEMU_JOB_OPTIONAL: 1
>>>>> -
>>>>>     x86-netbsd:
>>>>>       extends: .cirrus_kvm_job
>>>>> @@ -110,3 +108,4 @@ x86-openbsd:
>>>>>         NAME: openbsd
>>>>>         CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
>>>>>         TEST_TARGETS: check
>>>>> +    QEMU_JOB_OPTIONAL: 1
>>>>
>>>> BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).
>> ...
>>> I could have sworn our cirrus jobs were much slower in the past (around
>>> the 40 min mark), as we had to cut down what we were running to avoid
>>> frequent timeouts.
>>
>> You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd job
>> are currently broken and only output some help text instead of compiling
>> QEMU:
>>
>>   https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
>>
>> ... that's why the finish so fast.
>>
>> IIRC last time I've seen them "working", they were running into the 80
>> minute timeout again.
>>
>> So the netbsd and openbsd job are indeed not very useful anymore. I think we
>> should rather remove them and add a proper job via our own custom
>> KVM-capable runners instead.
> 
> The CI job isn't the issue though - it is merely a sign of brokeness
> elsewhere.  Either tests/vm/{netbsd,openbsd} are broken, or our entire
> build process for those platforms is broken.
> 
> We need to root cause this, rather than hide it further by dropping
> the CI jobs.

"make vm-build-netbsd" locally just works fine (as soon as Philippe's python 
fix gets merged). I just had another try with the cirrus-ci job, but it 
indeeds run into timeout issues again:

  https://gitlab.com/thuth/qemu/-/jobs/5501021556

I guess we could cut it down again by e.g. removing aarch64-softmmu from the 
target list ... but we then still have the problem that we can not run it by 
default due to the limitations of cirrus-ci only allowing to run 2 jobs in 
parallel. And as long as we don't run things by default, they apparently 
tend to bit-rot quite fast...

  Thomas


