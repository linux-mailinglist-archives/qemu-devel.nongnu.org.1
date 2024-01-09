Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E31828C4B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGdd-00061h-Hs; Tue, 09 Jan 2024 13:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNGdS-0005wd-HH
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNGdP-0006zS-R0
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704824130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHbx+mV+HR9hXX7SfgXG1TL5Ez1S+EPw9ufNplkokzw=;
 b=NiGmWgZP3246DaWfLc+o2OhdVcRZh7073Ph7sxKrYrLsEMF5nuBnRwoyuwJI5DRojhQg4v
 4g3+p8c4GXmILsodMGuwysg+PHPq//4RMLVnwMfkaNKmoaEVYbgg5Hm74/2ahceeVEZWwr
 7D4NKVMSLnGLCrFsNltsZoiaXuAiB34=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-QqmvvFr4N9aQNbsWQ9562A-1; Tue, 09 Jan 2024 13:15:28 -0500
X-MC-Unique: QqmvvFr4N9aQNbsWQ9562A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67f943c0e6bso61173576d6.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704824128; x=1705428928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHbx+mV+HR9hXX7SfgXG1TL5Ez1S+EPw9ufNplkokzw=;
 b=c8ZvHr8qKsNa1vgCyZKXyFukndadPrXMwWW9NlkNoxFJ7EqREu4NGuunKOOM3PqKgH
 9BI+dNwIzy09Zdw6UQG75qPJngy0t5EFeDbBe50KQAOgyma2MTFjrz3IlrYbJUUNJ5+l
 raIqPDa47VxxaFNn1Ky3WnIWk1xyLyrXkWpZhLDuFqi+AoY0+dGIhNnpAUBxfEHNtfpJ
 JPnHbCnRWt3ZRicokmUlErs7vN6z6L03Lr1NnMzH+RC+VHiQe5d2hhilCWMPsykwVToE
 xwlAHUaQkYODyjmKVD9tDqwsTwddOzcx5P7nMMhIB5fhA2a9UlET6kk+H2sNFY3n6Li2
 d8gw==
X-Gm-Message-State: AOJu0YyVbwPUXQZ07qHJf8C3vYG93tyk7hBI40TJMFZdTwlu3VlAbqlI
 xGwX+re2/TUjP53k3ZKSBusdoGY4XKGJzEwQOQm8hIovwzFTDAXS4gXp+SzsXPPXFvtOin/SjIs
 zcBkf2gJ9tQnPsFn8ycTOkrI=
X-Received: by 2002:ad4:5ca7:0:b0:67f:864b:d58a with SMTP id
 q7-20020ad45ca7000000b0067f864bd58amr6695202qvh.31.1704824128437; 
 Tue, 09 Jan 2024 10:15:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmrQI9ujVUXwt9+TfYSoJmIuamx+yhxIYU/63eX8xZkullDr8+HXA+GnHYlnB3dPQNtz0WPw==
X-Received: by 2002:ad4:5ca7:0:b0:67f:864b:d58a with SMTP id
 q7-20020ad45ca7000000b0067f864bd58amr6695190qvh.31.1704824128202; 
 Tue, 09 Jan 2024 10:15:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cfd83000000b00680c7c14d4bsm1082930qvr.129.2024.01.09.10.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:15:27 -0800 (PST)
Message-ID: <7036da8a-7a52-49e0-bcd1-8484ae86b336@redhat.com>
Date: Tue, 9 Jan 2024 19:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ci: Add a migration compatibility test job
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240105180449.11562-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On 1/5/24 19:04, Fabiano Rosas wrote:
> The migration tests have support for being passed two QEMU binaries to
> test migration compatibility.
> 
> Add a CI job that builds the lastest release of QEMU and another job
> that uses that version plus an already present build of the current
> version and run the migration tests with the two, both as source and
> destination. I.e.:
> 
>   old QEMU (n-1) -> current QEMU (development tree)
>   current QEMU (development tree) -> old QEMU (n-1)
> 
> The purpose of this CI job is to ensure the code we're about to merge
> will not cause a migration compatibility problem when migrating the
> next release (which will contain that code) to/from the previous
> release.
> 
> I'm leaving the jobs as manual for now because using an older QEMU in
> tests could hit bugs that were already fixed in the current
> development tree and we need to handle those case-by-case.
> 
> Note: for user forks, the version tags need to be pushed to gitlab
> otherwise it won't be able to checkout a different version.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   .gitlab-ci.d/buildtest.yml | 53 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 91663946de..81163a3f6a 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -167,6 +167,59 @@ build-system-centos:
>         x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>       MAKE_CHECK_ARGS: check-build
>   
> +build-previous-qemu:
> +  extends: .native_build_job_template
> +  artifacts:
> +    when: on_success
> +    expire_in: 2 days
> +    paths:
> +      - build-previous
> +    exclude:
> +      - build-previous/**/*.p
> +      - build-previous/**/*.a.p
> +      - build-previous/**/*.fa.p
> +      - build-previous/**/*.c.o
> +      - build-previous/**/*.c.o.d
> +      - build-previous/**/*.fa
> +  needs:
> +    job: amd64-opensuse-leap-container
> +  variables:
> +    QEMU_JOB_OPTIONAL: 1
> +    IMAGE: opensuse-leap
> +    TARGETS: x86_64-softmmu aarch64-softmmu
> +  before_script:
> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> +    - git checkout $QEMU_PREV_VERSION
> +  after_script:
> +    - mv build build-previous
> +
> +.migration-compat-common:
> +  extends: .common_test_job_template
> +  needs:
> +    - job: build-previous-qemu
> +    - job: build-system-opensuse
> +  allow_failure: true
> +  variables:
> +    QEMU_JOB_OPTIONAL: 1
> +    IMAGE: opensuse-leap
> +    MAKE_CHECK_ARGS: check-build
> +  script:
> +    - cd build
> +    - QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
> +    - QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-${TARGET}
> +          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
> +
> +migration-compat-aarch64:
> +  extends: .migration-compat-common
> +  variables:
> +    TARGET: aarch64
> +
> +migration-compat-x86_64:
> +  extends: .migration-compat-common
> +  variables:
> +    TARGET: x86_64


What about the others archs, s390x and ppc ? Do you lack the resources
or are there any problems to address ?

Thanks,

C.


