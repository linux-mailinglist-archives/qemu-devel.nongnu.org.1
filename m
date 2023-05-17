Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0AD706CAF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ3Q-0008Oh-8I; Wed, 17 May 2023 11:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzJ3N-0008Bt-Hu
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:27:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pzJ3L-0000Yy-G2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:27:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23D436B83;
 Wed, 17 May 2023 18:26:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F151E610E;
 Wed, 17 May 2023 18:26:56 +0300 (MSK)
Message-ID: <8e6c152f-4349-f63e-9976-0f9cd412f8df@tls.msk.ru>
Date: Wed, 17 May 2023 18:26:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] gitlab: stable staging branches publish containers in
 a separate tag
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-4-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230517135448.262483-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.412,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

17.05.2023 16:54, Daniel P. Berrangé wrote:
> If the stable staging branches publish containers under the 'latest' tag
> they will clash with containers published on the primary staging branch,
> as well  as with each other. This introduces logic that overrides the
> container tag when jobs run against the stable staging branches.
> 
> The CI_COMMIT_REF_SLUG variable we use expands to the git branch name,
> but with most special characters removed, such that it is valid as a
> docker tag name. eg 'staging-8.0' will get a slug of 'staging-8-0'
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index a1d734267a..f379c182a7 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -1,7 +1,7 @@
>   
>   variables:
> -  # On stable branches this needs changing. Should also be
> -  # overridden per pipeline if running pipelines concurrently
> +  # On stable branches this is changed by later rules. Should also
> +  # be overridden per pipeline if running pipelines concurrently
>     # for different branches in contributor forks.
>     QEMU_CI_CONTAINER_TAG: latest
>   
> @@ -16,6 +16,9 @@ variables:
>   # Thus we group them into a number of stages, ordered from
>   # most restrictive to least restrictive
>   #
> +# For pipelines running for stable "staging-X.Y" branches
> +# we must override QEMU_CI_CONTAINER_TAG
> +#
>   .base_job_template:
>     variables:
>       # Each script line from will be in a collapsible section in the job output
> @@ -61,11 +64,23 @@ variables:
>       #############################################################
>   
>       # Optional jobs should not be run unless manually triggered
> +    - if: '$QEMU_JOB_OPTIONAL && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
> +      when: manual
> +      allow_failure: true
> +      variables:
> +        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG

Here, it somehow feels better to use $CI_COMMIT_BRANCH instead of $CI_COMMIT_REF_SLUG.
I know little about gitlab CI. It is REF_SLUG like a hashed value of COMMIT_BRANCH?

Other than that (here and below),

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

