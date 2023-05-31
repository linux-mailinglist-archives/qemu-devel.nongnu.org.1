Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051337185D5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NVd-0001cT-IZ; Wed, 31 May 2023 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4NVc-0001cK-Db
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4NVZ-0005CQ-Iu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545981;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=K+KxspMQr/rnzaKeb0YMRWd5kruI0IIEHGvkHvLTPOg=;
 b=b688+4T+W3Tdzd42YBwV4OqO6aSstCD2HtjnGchssGfHog5s5YqtYQx4OpMwZKTztvYjYm
 Lgw7lMo9uxbbu2MUoftPWZVXWuKsI9qRDBT7MQxghPd3kqCRb6ImrkjDGRw7Mk1+wFPpZ/
 c++K+EaAWG70glhWvhfNuBRl6SlJb4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-i6ONGLFWP_OE8KV9YaYI3Q-1; Wed, 31 May 2023 11:12:58 -0400
X-MC-Unique: i6ONGLFWP_OE8KV9YaYI3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54646802355;
 Wed, 31 May 2023 15:12:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3DB421C3;
 Wed, 31 May 2023 15:12:57 +0000 (UTC)
Date: Wed, 31 May 2023 16:12:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH 3/5] gitlab-ci: Move variables outside script
Message-ID: <ZHdj9u/kyuH8HYM6@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
 <20230531150824.32349-4-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531150824.32349-4-cconte@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 31, 2023 at 04:08:22PM +0100, Camilla Conte wrote:
> Also split long line for clarity.


> 
> Docs:
> https://docs.gitlab.com/ee/ci/variables/#use-cicd-variables-in-other-variables
> Signed-off-by: Camilla Conte <cconte@redhat.com>
> ---
>  .gitlab-ci.d/container-template.yml | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index fd7deb1c29..d146d1d197 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -1,20 +1,27 @@
>  .container_job_template:
>    extends: .base_job_template
> -  image: docker:stable
>    stage: containers
> +  image: docker:stable
>    services:
>      - docker:stable-dind
> +  variables:
> +    TAG: "$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
> +    COMMON_TAG: "$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
> +    DOCKERFILE: "$CI_PROJECT_DIR/tests/docker/dockerfiles/$NAME.docker"
> +    BUILD_CONTEXT: "$CI_PROJECT_DIR"
>    before_script:
> -    - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
> -    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
>      - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
>      - until docker info; do sleep 1; done
>    script:
>      - echo "TAG:$TAG"
>      - echo "COMMON_TAG:$COMMON_TAG"
> -    - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
> +    - >

This leading '>' seems redundant

> +      docker build
> +      --tag "$TAG"
> +      --cache-from "$TAG"
> +      --cache-from "$COMMON_TAG"
>        --build-arg BUILDKIT_INLINE_CACHE=1
> -      -f "tests/docker/dockerfiles/$NAME.docker" "."
> +      -f "$DOCKERFILE" "$BUILD_CONTEXT"

This is a functional change as $BUILD_CONTEXT expands
to something different that '.'.

IOW, this should be a separate commit

>      - docker push "$TAG"
>    after_script:
>      - docker logout
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


