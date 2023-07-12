Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38B75076C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXm3-000272-JN; Wed, 12 Jul 2023 07:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJXlx-00026q-Va
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJXlw-00026I-16
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689160359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UnSurkQ4kYGuHiXimRRIyE/XbOh/Uph/SbHI2Cjs4ak=;
 b=CPErPpOVqaXfbnOaAaYSCZp/ednxds+bI9+lrxTeRQe3OYN9YAuEyS8AUIIxQFlULlksoY
 zWIf6dX/fC1PgHgihfh5UC5aPjREjNrVKe+F0Cd2nN4I3SW9ZXWU/tWYYAvMBpuPek6pUq
 pQQPYMjElVoHGey21a4X7WrDcaTi9PY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-oiur9O1dO6iDYizdquHLUw-1; Wed, 12 Jul 2023 07:12:35 -0400
X-MC-Unique: oiur9O1dO6iDYizdquHLUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5092E856F66;
 Wed, 12 Jul 2023 11:12:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BEF5200B402;
 Wed, 12 Jul 2023 11:12:33 +0000 (UTC)
Date: Wed, 12 Jul 2023 12:12:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Message-ID: <ZK6Kn8hB8soQBRsA@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org>
 <ZK2YS0v5G3iKyXwJ@redhat.com>
 <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jul 12, 2023 at 01:00:38PM +0200, Philippe Mathieu-Daudé wrote:
> On 11/7/23 19:58, Daniel P. Berrangé wrote:
> > On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
> > > Refresh the generated files by running:
> > > 
> > >    $ make lcitool-refresh
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   tests/docker/dockerfiles/debian-amd64.docker |  2 -
> > >   tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
> > >   tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
> > 
> > I don't know why this would be removing xen/pmem from these files. If
> > I run 'lcitool-refresh' on current git master that doesn't happen
> > 
> > Do you have any other local changes on top ?
> 


> ((887cba855b...))$ make -C build lcitool-refresh
> Generate tests/docker/dockerfiles/alpine.docker
> Generate tests/docker/dockerfiles/centos8.docker
> Generate tests/docker/dockerfiles/debian-amd64.docker
> Generate tests/docker/dockerfiles/fedora.docker
> Generate tests/docker/dockerfiles/opensuse-leap.docker
> Generate tests/docker/dockerfiles/ubuntu2004.docker
> Generate tests/docker/dockerfiles/ubuntu2204.docker
> Generate tests/docker/dockerfiles/debian-amd64-cross.docker
> Generate tests/docker/dockerfiles/debian-arm64-cross.docker
> Generate tests/docker/dockerfiles/debian-armel-cross.docker
> Generate tests/docker/dockerfiles/debian-armhf-cross.docker
> Generate tests/docker/dockerfiles/debian-mips64el-cross.docker
> Generate tests/docker/dockerfiles/debian-mipsel-cross.docker
> Generate tests/docker/dockerfiles/debian-ppc64el-cross.docker
> Generate tests/docker/dockerfiles/debian-riscv64-cross.docker
> Generate tests/docker/dockerfiles/debian-s390x-cross.docker
> Generate tests/docker/dockerfiles/fedora-win32-cross.docker
> Generate tests/docker/dockerfiles/fedora-win64-cross.docker
> Generate .gitlab-ci.d/cirrus/freebsd-13.vars
> Generate .gitlab-ci.d/cirrus/macos-12.vars
> ((887cba855b...))$ git diff -U0
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker
> b/tests/docker/dockerfiles/debian-amd64.docker
> index e39871c7bb..8f7521fdc2 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libpmem-dev \
> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libxen-dev \
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker
> b/tests/docker/dockerfiles/ubuntu2004.docker
> index 8f864d19e6..7f60143cbb 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -72 +71,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libpmem-dev \
> @@ -97 +95,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libxen-dev \
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
> b/tests/docker/dockerfiles/ubuntu2204.docker
> index 1d442cdfe6..5162927016 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libpmem-dev \
> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
> -                      libxen-dev \

What architecture are you running from ? I'm suspecting it is a non
x86_64 architecture as these pacakges are both arch conditionalized.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


