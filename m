Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E58297A7
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 11:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNVqx-0004Zy-Ue; Wed, 10 Jan 2024 05:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNVqv-0004ZE-9O
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:30:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNVqt-00045e-GT
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704882626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xlPPuIn6dUTLaZF+s3RPOy8CDwvCSeFrvuswVxt3Vqk=;
 b=W7OugwGelFHq+zyP3bjuss1p01zXjG2YcT8AdtTcthE9W67PK3P3mw3zw13Ke3w9wZCRcO
 Tyxd3XXPzQYeCbMtughXfgAs4/UUBzb2aozQz9rkPf6t8APBL/XAYlCgbux6B9FmGFVtdo
 BaaQuZfr4FXAqSfT6UxEAAkB3kxIoRw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-oS8eY_qUPF2SuJGhtfGTMQ-1; Wed, 10 Jan 2024 05:30:23 -0500
X-MC-Unique: oS8eY_qUPF2SuJGhtfGTMQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7831f409539so407525585a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 02:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704882623; x=1705487423;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlPPuIn6dUTLaZF+s3RPOy8CDwvCSeFrvuswVxt3Vqk=;
 b=BHVjEb7+ATuhmL7i1ORuq0a2XmoO83ePjeDINExfTninnIrwRTM39fUC2SZ7NE23oQ
 wcjHqsXTcpGyZgoKHtT2tlZb2VS24hBI+aX0A9RfALcYdZFMoy24OD52z/czkug7hqcI
 +PiuArbZh2JeqQCdiHQNwUUq39lXouLJA8r/nSvXziu/oivwu1YI4Jxeo9YcpdNVhkxQ
 xFQjkOcu9OkxdIAZDigAwdTGM5KPdF4TvaHFkzgHvvqhYx3QodAwcAsQx7Ju/4hUSZsR
 6vKxCa6eUMnVjuDDjD98XC5RTbqGcyixEDOlUqCWK9AvMekasUbUTXQHR31fGzJCa3G2
 YwTw==
X-Gm-Message-State: AOJu0Yw8x+HRNDYLdaOGySUTmPruwmUHPP60ZCgUSou4ppr8532i3RKT
 CTgCS/L2m4DdPlKhCIzBfggoTW9uyW5fzJnbWwDljayflhN8hQrr3yFpEH8FzZc75uHa011GC3e
 tiwjLE/TU0HkBXDCSHnPat60=
X-Received: by 2002:a05:620a:43aa:b0:783:3909:b32b with SMTP id
 a42-20020a05620a43aa00b007833909b32bmr352585qkp.101.1704882622970; 
 Wed, 10 Jan 2024 02:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEB0lIPxBnPvMiz4viDFmtH/W1Vo6/wexJtpTj4ISB35OYvRfEbIXLsheLd9UsX3QCSN3W0A==
X-Received: by 2002:a05:620a:43aa:b0:783:3909:b32b with SMTP id
 a42-20020a05620a43aa00b007833909b32bmr352567qkp.101.1704882622643; 
 Wed, 10 Jan 2024 02:30:22 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 y11-20020a05620a25cb00b007830ce180basm1489873qko.120.2024.01.10.02.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 02:30:22 -0800 (PST)
Message-ID: <7d4f5624-83d2-4330-9315-b23869529e99@redhat.com>
Date: Wed, 10 Jan 2024 11:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ci: Add a migration compatibility test job
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de>
 <7036da8a-7a52-49e0-bcd1-8484ae86b336@redhat.com> <878r4y8br7.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <878r4y8br7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 09/01/2024 21.58, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 1/5/24 19:04, Fabiano Rosas wrote:
>>> The migration tests have support for being passed two QEMU binaries to
>>> test migration compatibility.
>>>
>>> Add a CI job that builds the lastest release of QEMU and another job
>>> that uses that version plus an already present build of the current
>>> version and run the migration tests with the two, both as source and
>>> destination. I.e.:
>>>
>>>    old QEMU (n-1) -> current QEMU (development tree)
>>>    current QEMU (development tree) -> old QEMU (n-1)
>>>
>>> The purpose of this CI job is to ensure the code we're about to merge
>>> will not cause a migration compatibility problem when migrating the
>>> next release (which will contain that code) to/from the previous
>>> release.
>>>
>>> I'm leaving the jobs as manual for now because using an older QEMU in
>>> tests could hit bugs that were already fixed in the current
>>> development tree and we need to handle those case-by-case.
>>>
>>> Note: for user forks, the version tags need to be pushed to gitlab
>>> otherwise it won't be able to checkout a different version.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>    .gitlab-ci.d/buildtest.yml | 53 ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 53 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>> index 91663946de..81163a3f6a 100644
>>> --- a/.gitlab-ci.d/buildtest.yml
>>> +++ b/.gitlab-ci.d/buildtest.yml
>>> @@ -167,6 +167,59 @@ build-system-centos:
>>>          x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>>>        MAKE_CHECK_ARGS: check-build
>>>    
>>> +build-previous-qemu:
>>> +  extends: .native_build_job_template
>>> +  artifacts:
>>> +    when: on_success
>>> +    expire_in: 2 days
>>> +    paths:
>>> +      - build-previous
>>> +    exclude:
>>> +      - build-previous/**/*.p
>>> +      - build-previous/**/*.a.p
>>> +      - build-previous/**/*.fa.p
>>> +      - build-previous/**/*.c.o
>>> +      - build-previous/**/*.c.o.d
>>> +      - build-previous/**/*.fa
>>> +  needs:
>>> +    job: amd64-opensuse-leap-container
>>> +  variables:
>>> +    QEMU_JOB_OPTIONAL: 1
>>> +    IMAGE: opensuse-leap
>>> +    TARGETS: x86_64-softmmu aarch64-softmmu
>>> +  before_script:
>>> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
>>> +    - git checkout $QEMU_PREV_VERSION
>>> +  after_script:
>>> +    - mv build build-previous
>>> +
>>> +.migration-compat-common:
>>> +  extends: .common_test_job_template
>>> +  needs:
>>> +    - job: build-previous-qemu
>>> +    - job: build-system-opensuse
>>> +  allow_failure: true
>>> +  variables:
>>> +    QEMU_JOB_OPTIONAL: 1
>>> +    IMAGE: opensuse-leap
>>> +    MAKE_CHECK_ARGS: check-build
>>> +  script:
>>> +    - cd build
>>> +    - QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
>>> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
>>> +    - QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-${TARGET}
>>> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
>>> +
>>> +migration-compat-aarch64:
>>> +  extends: .migration-compat-common
>>> +  variables:
>>> +    TARGET: aarch64
>>> +
>>> +migration-compat-x86_64:
>>> +  extends: .migration-compat-common
>>> +  variables:
>>> +    TARGET: x86_64
>>
>>
>> What about the others archs, s390x and ppc ? Do you lack the resources
>> or are there any problems to address ?
> 
> Currently s390x and ppc are only tested on KVM. Which means they are not
> tested at all unless someone runs migration-test on a custom runner. The
> same is true for this test.
> 
> The TCG tests have been disabled:
>      /*
>       * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
>       * is touchy due to race conditions on dirty bits (especially on PPC for
>       * some reason)
>       */
> 
>      /*
>       * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
>       * there until the problems are resolved
>       */
> 
> It would be great if we could figure out what these issues are and fix
> them so we can at least test with TCG like we do for aarch64.
> 
> Doing a TCG run of migration-test with both archs (one binary only, not
> this series):
> 
> - ppc survived one run, taking 6 minutes longer than x86/Aarch64.
> - s390x survived one run, taking 40s less than x86/aarch64.
> 
> I'll leave them enabled on my machine and do some runs here and there,
> see if I spot something. If not, we can consider re-enabling them once
> we figure out why ppc takes so long.

I was curious and re-enabled the ppc64 and s390x migration tests with TCG on 
my laptop here, running "make check-tcg -j$(nproc)" in a loop. s390x 
unfortunately hang after the second iteration already, but ppc64 survived 25 
runs (then I stopped it).

So we might want to try to re-enable ppc64 at least. But we might need to 
cut the run time for ppc64 with TCG a little bit, it is currently the 
longest test on my system (it takes 240s to finish, while all other tests 
finish within 150s).

  Thomas


