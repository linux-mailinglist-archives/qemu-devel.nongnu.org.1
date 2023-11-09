Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246B7E6FC1
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:59:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18Ml-0000NE-WC; Thu, 09 Nov 2023 11:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r18Mc-0000Gi-AB
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r18Ma-00041z-Gk
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699549119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDy6Q4yDmB3IqHyY3CU/6R2br3P+GyccczfabosLoRk=;
 b=bvrkGYuEeOZbtGGjQ/0PMbu1NOQIiotJdmzbH2RlZrIHWJWHOjFjHQon5UlHBud61YQTPq
 QbWKEq1oqcd+e/OLYzy3eDVq43lT0IceCrGa+zgy0kRFLnSmuk8AwPby04q7dyd75WSxeI
 JRVfTHr4iUg1qIQbEOOyOOnBRBSA0CI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-eb02IwukM2ylUgbVvMmjtA-1; Thu,
 09 Nov 2023 11:58:37 -0500
X-MC-Unique: eb02IwukM2ylUgbVvMmjtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A08A382254A;
 Thu,  9 Nov 2023 16:58:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91EDC25C1;
 Thu,  9 Nov 2023 16:58:35 +0000 (UTC)
Date: Thu, 9 Nov 2023 16:58:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Message-ID: <ZU0PuHyw8X8e/p0j@redhat.com>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
> On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
> > This Cirrus-CI based job takes ~12min, similarly to macOS job.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> > Based-on: <20231109150900.91186-1-philmd@linaro.org>
> >            "tests/vm/netbsd: Use Python v3.11"
> > ---
> >   .gitlab-ci.d/cirrus.yml | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > index e7f1f83c2c..7b01acb104 100644
> > --- a/.gitlab-ci.d/cirrus.yml
> > +++ b/.gitlab-ci.d/cirrus.yml
> > @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
> >       - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
> >     variables:
> >       QEMU_JOB_CIRRUS: 1
> > -    QEMU_JOB_OPTIONAL: 1
> > -
> >   x86-netbsd:
> >     extends: .cirrus_kvm_job
> > @@ -110,3 +108,4 @@ x86-openbsd:
> >       NAME: openbsd
> >       CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
> >       TEST_TARGETS: check
> > +    QEMU_JOB_OPTIONAL: 1
> 
> BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).

In the most recent pipeline FreeBSD too 22 mins, macOS 14 mins.

The key factor is that the Cirrus job needs to complete before the
GitLab job times out. We have a 1 hr 20 limit on GitLab jobs, and
Cirrus CI allows 2 jobs in parallel.

So in the worst case where the OpenBSD job was blocked until FreeBSD
job finished, we would be waiting about 45 mins for completion.

In the best case we would be waiting 36 mins.

Well technically the worst case would be no parallelization at all,
which is 70 mins serialized execution time, which is kinda close to
the 1hr20 limit. This does sometimes happen, but I don't know how
often.

Sometimes Cirrus CI can also delay the jobs starting for a while
due to lack of runners.

IOW, in normal times we could afford to enable all these jobs, but
if Cirrus CI is under heavy load we increase chance of timeouts.

I could have sworn our cirrus jobs were much slower in the past (around
the 40 min mark), as we had to cut down what we were running to avoid
frequent timeouts.

I'd say lets wait until this release is done though. Enable OpenBSD/NetBSD
when the new dev cycle opens up, so we can watch their stablility for a
bit, and not impact stability of the stable branch for this forthcoming
release.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


