Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D94738776
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBz5s-0008M4-I9; Wed, 21 Jun 2023 10:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBz5l-0008KJ-Vr
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBz5j-0002U1-KJ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687358750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6QhWkamOe+HglNozC/LWiQIDXoyt7fZlLmYfUHCkDo=;
 b=PS4RcyJr+VCEb4or2ro7CTtwcS6ahsanz/VlLRpvtLs0vRZmpBTLDflfu+ePkeWGFFVhDo
 qa4Qqaem+BoV14GGmyZpYAWpUtgSX4eRbpWX1Hv82IPiOdF1oecflwPUVEMy9YCaU2agn9
 XCRcOAm3Q3/tfmHQ0EwO98aUjO0BfZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-0mik7WzlM0Kuw13Y4HIKLg-1; Wed, 21 Jun 2023 10:45:49 -0400
X-MC-Unique: 0mik7WzlM0Kuw13Y4HIKLg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3113533a608so1577161f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687358747; x=1689950747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A6QhWkamOe+HglNozC/LWiQIDXoyt7fZlLmYfUHCkDo=;
 b=GUMWXRP+3WCP2gNbXVCB42XzeA+7uUJtYArigz6yV271qhNAVKSFMF5a4WzDmVeHn8
 mTQKm+1PE14WR1vwB00joMCbe0U1mJLo5LOtAHxxqxjzgOiWepOFRpUQnESwMkhy/Yra
 IMKI17aev1vOd09Qk33G+Qs118QBQOhDPeY8B5GYRAuTLz01DFUKQlMfnSACfzuDrbOM
 OYw0wwkLojyXzn+qSwFsn6A1ZcoN7uYeSV4+G+UD/Fdy5hOPWZuWy3Xbagg6yVtCU5Nk
 t+lIlDMZzUN0DWO1kYwIPD7ERqN7qOA9SrBn9WuzhOEqf9TFpvDAsswVuIV9zxsJzZ+9
 0KPQ==
X-Gm-Message-State: AC+VfDx0w+vCV9k2X51nqmY6N+4wNHPHutxrIofNKkw6dTqvWMAT4hlg
 4ZLA6s7Da/rRcNO+J6hJfV1yImKUh2wVvvCz1Ju2Ttyk8Ido6tGJbjsaUbgM6li0eEKcQ84zv2k
 3Oa0AdpZNe/X79h4=
X-Received: by 2002:adf:f60c:0:b0:30e:3ec4:6de3 with SMTP id
 t12-20020adff60c000000b0030e3ec46de3mr10449816wrp.35.1687358747619; 
 Wed, 21 Jun 2023 07:45:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4134K0+ltTF5mADIiRoSx5PoxLADktfS7SYLuC9ubEigo3BplCkqp8E/2i4nk3k3NGNquV9w==
X-Received: by 2002:adf:f60c:0:b0:30e:3ec4:6de3 with SMTP id
 t12-20020adff60c000000b0030e3ec46de3mr10449803wrp.35.1687358747328; 
 Wed, 21 Jun 2023 07:45:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-207.web.vodafone.de.
 [109.43.177.207]) by smtp.gmail.com with ESMTPSA id
 m15-20020a056000008f00b0030e5bd253aasm4610832wrx.39.2023.06.21.07.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 07:45:46 -0700 (PDT)
Message-ID: <b49d46fb-f4d9-94b4-4bd2-895bb1b0b692@redhat.com>
Date: Wed, 21 Jun 2023 16:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] gitlab: allow overriding name of the upstream
 repository
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230608164018.2520330-1-berrange@redhat.com>
 <20230608164018.2520330-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230608164018.2520330-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08/06/2023 18.40, Daniel P. Berrangé wrote:
> The CI rules have special logic for what happens in upstream. To enable
> contributors who modify CI rules to test this logic, however, they need
> to be able to override which repo is considered upstream. This
> introduces the 'QEMU_CI_UPSTREAM' variable
> 
>    git push gitlab <branch> -o ci.variable=QEMU_CI_UPSTREAM=berrange
> 
> to make it look as if my namespace is the actual upstream. Namespace in
> this context refers to the path fragement in gitlab URLs that is above

s/fragement/fragment/

> the repository. Typically this will be the contributor's gitlab login
> name.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml      | 19 ++++++++++++-------
>   docs/devel/ci-jobs.rst.inc |  6 ++++++
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index fba9d31cc6..a1d734267a 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -5,6 +5,11 @@ variables:
>     # for different branches in contributor forks.
>     QEMU_CI_CONTAINER_TAG: latest
>   
> +  # For purposes of CI rules, upstream is the gitlab.com/qemu-project
> +  # namespace. When testing CI, it might be usefult to override this
> +  # to point to a fork repo
> +  QEMU_CI_UPSTREAM: qemu-project
> +
>   # The order of rules defined here is critically important.
>   # They are evaluated in order and first match wins.
>   #
> @@ -30,23 +35,23 @@ variables:
>         when: never
>   
>       # Publishing jobs should only run on the default branch in upstream
> -    - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
> +    - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
>         when: never
>   
>       # Non-publishing jobs should only run on staging branches in upstream
> -    - if: '$QEMU_JOB_PUBLISH != "1" && $CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH !~ /staging/'
> +    - if: '$QEMU_JOB_PUBLISH != "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH !~ /staging/'
>         when: never
>   
>       # Jobs only intended for forks should always be skipped on upstream
> -    - if: '$QEMU_JOB_ONLY_FORKS == "1" && $CI_PROJECT_NAMESPACE == "qemu-project"'
> +    - if: '$QEMU_JOB_ONLY_FORKS == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
>         when: never
>   
>       # Forks don't get pipelines unless QEMU_CI=1 or QEMU_CI=2 is set
> -    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
> +    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
>         when: never
>   
>       # Avocado jobs don't run in forks unless $QEMU_CI_AVOCADO_TESTING is set
> -    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != "qemu-project"'
> +    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
>         when: never
>   
>   
> @@ -66,7 +71,7 @@ variables:
>         allow_failure: true
>   
>       # Avocado jobs can be manually start in forks if $QEMU_CI_AVOCADO_TESTING is unset
> -    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != "qemu-project"'
> +    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
>         when: manual
>         allow_failure: true
>   
> @@ -78,7 +83,7 @@ variables:
>   
>       # Forks pipeline jobs don't start automatically unless
>       # QEMU_CI=2 is set
> -    - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != "qemu-project"'
> +    - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
>         when: manual
>   
>       # Jobs can run if any jobs they depend on were successful
> diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
> index f72537853b..f9ef14f2eb 100644
> --- a/docs/devel/ci-jobs.rst.inc
> +++ b/docs/devel/ci-jobs.rst.inc
> @@ -75,6 +75,12 @@ in a handful of namespaces
>      'latest', but if running pipelines for different branches
>      concurrently, it should be overridden per pipeline.
>   
> + * QEMU_CI_UPSTREAM - gitlab namespace that is considerd to be

s/considerd/considered/

> +   the 'upstream'. This defaults to 'qemu-project'. Contributors
> +   may choose to override this if they are modifying rules in
> +   base.yml and need to validate how they will operate when in
> +   an upstream context, as opposed to their fork context.
> +
>    * nnn - other misc variables not falling into the above
>      categories, or using different names for historical reasons
>      and not yet converted.

I can fix up the typos when picking up the patch, no need to resend.

Reviewed-by: Thomas Huth <thuth@redhat.com>


