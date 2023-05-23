Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDE70D7AF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NWl-0004UU-Me; Tue, 23 May 2023 04:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NWi-0004N8-GV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NWg-000176-Ik
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684831069;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bu2Tbeot8sgUZOHHKvH5X7cvMt91XSc53213ZfF2eQ=;
 b=JkfLimtAZGiGql3i6K8qeQZ9A3CBwFfqHMIhU9nA4BepS/K6RajS47Wxk8mWrJd5tWznuG
 STAIaXiwoDloAnX63FIjNEOBi+GmacUCUA2US0mHm0HyvJxuVbc4Nb7tgE0JgxrkUQpiJc
 2AVPuWpcCa1B3uII60IOimoYbnJmNfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-TmDY3qY-MPGdvTTJkKXrvw-1; Tue, 23 May 2023 04:37:48 -0400
X-MC-Unique: TmDY3qY-MPGdvTTJkKXrvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4A8811E78
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:37:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE4540D1B60;
 Tue, 23 May 2023 08:37:46 +0000 (UTC)
Date: Tue, 23 May 2023 09:37:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH v2 5/5] Add Kubernetes runner configuration
Message-ID: <ZGx7Wd7ETt+2W+PB@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
 <20230522174153.46801-6-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522174153.46801-6-cconte@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 06:41:54PM +0100, Camilla Conte wrote:
> Custom values for the gitlab-runner Helm chart.
> See https://wiki.qemu.org/Testing/CI/KubernetesRunners.
> 
> Signed-off-by: Camilla Conte <cconte@redhat.com>
> ---
>  .../ci/gitlab-kubernetes-runners/values.yaml  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 scripts/ci/gitlab-kubernetes-runners/values.yaml

Can't say I'm massively familiar with this, but there's nothing
obviously terrible, so on the basis that you've tested it works

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/scripts/ci/gitlab-kubernetes-runners/values.yaml b/scripts/ci/gitlab-kubernetes-runners/values.yaml
> new file mode 100644
> index 0000000000..204a96a842
> --- /dev/null
> +++ b/scripts/ci/gitlab-kubernetes-runners/values.yaml
> @@ -0,0 +1,30 @@
> +gitlabUrl: "https://gitlab.com/"
> +runnerRegistrationToken: ""
> +rbac:
> +  create: true
> +concurrent: 200
> +runners:
> +  privileged: true
> +  config: |
> +    [[runners]]
> +      limit = 100
> +      environment = [
> +        "DOCKER_HOST=tcp://docker:2376",
> +        "DOCKER_TLS_CERTDIR=/certs",
> +        "DOCKER_TLS_VERIFY=1",
> +        "DOCKER_CERT_PATH=/certs/client"
> +      ]
> +      [runners.kubernetes]
> +        poll_timeout = 1200
> +        image = "ubuntu:20.04"

Is it viable to update to 22.04 whic is the current newest LTS release
stream ?

> +        cpu_request = "0.5"
> +        service_cpu_request = "0.5"
> +        helper_cpu_request = "0.25"
> +        cpu_request_overwrite_max_allowed = "7"
> +        memory_request_overwrite_max_allowed = "30Gi"
> +      [[runners.kubernetes.volumes.empty_dir]]
> +        name = "docker-certs"
> +        mount_path = "/certs/client"
> +        medium = "Memory"
> +      [runners.kubernetes.node_selector]
> +        agentpool = "jobs"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


