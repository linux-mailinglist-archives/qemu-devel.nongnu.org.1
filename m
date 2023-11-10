Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478C7E7AEE
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:34:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Nts-0004Gu-PQ; Fri, 10 Nov 2023 04:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1Ntn-0004FO-7J
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1Ntl-0005pz-DF
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699608835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bakle7FqOgLycprUNSi5VK9z5UR63C51ASdoV5nB6nc=;
 b=FVqHrOvYsMk4/QcU0Xh5mx1dEtMasomkpr1Sv9adU5j3L28gh1nIY5WW6Kyfeu5Ed9m+Cl
 ld7/s2dyxXvGoDfBR9YGaNjNnNpevCzTM3AKE8VEiWVpYltyYLVDrNCqge8hxrodv/hy3q
 D3vSBcH2+tFWg+K0Wqdc7mm8cTufSv8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-ZEs-mJemPLaw76kaepCUBw-1; Fri,
 10 Nov 2023 04:33:50 -0500
X-MC-Unique: ZEs-mJemPLaw76kaepCUBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FA07381496E;
 Fri, 10 Nov 2023 09:33:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF4425C1;
 Fri, 10 Nov 2023 09:33:45 +0000 (UTC)
Date: Fri, 10 Nov 2023 09:33:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Message-ID: <ZU349/EL+cEBS/dK@redhat.com>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
 <ZU32PpBQc6jLmexY@redhat.com>
 <68a7b137-1709-4a1c-ba50-374aa30bc036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68a7b137-1709-4a1c-ba50-374aa30bc036@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On Fri, Nov 10, 2023 at 10:30:26AM +0100, Thomas Huth wrote:
> On 10/11/2023 10.22, Daniel P. Berrangé wrote:
> > On Thu, Nov 09, 2023 at 06:15:51PM +0100, Thomas Huth wrote:
> > > On 09/11/2023 17.58, Daniel P. Berrangé wrote:
> > > > On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
> > > > > > This Cirrus-CI based job takes ~12min, similarly to macOS job.
> > > > > > 
> > > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > ---
> > > > > > Based-on: <20231109150900.91186-1-philmd@linaro.org>
> > > > > >              "tests/vm/netbsd: Use Python v3.11"
> > > > > > ---
> > > > > >     .gitlab-ci.d/cirrus.yml | 3 +--
> > > > > >     1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > > > > > index e7f1f83c2c..7b01acb104 100644
> > > > > > --- a/.gitlab-ci.d/cirrus.yml
> > > > > > +++ b/.gitlab-ci.d/cirrus.yml
> > > > > > @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
> > > > > >         - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
> > > > > >       variables:
> > > > > >         QEMU_JOB_CIRRUS: 1
> > > > > > -    QEMU_JOB_OPTIONAL: 1
> > > > > > -
> > > > > >     x86-netbsd:
> > > > > >       extends: .cirrus_kvm_job
> > > > > > @@ -110,3 +108,4 @@ x86-openbsd:
> > > > > >         NAME: openbsd
> > > > > >         CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
> > > > > >         TEST_TARGETS: check
> > > > > > +    QEMU_JOB_OPTIONAL: 1
> > > > > 
> > > > > BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).
> > > ...
> > > > I could have sworn our cirrus jobs were much slower in the past (around
> > > > the 40 min mark), as we had to cut down what we were running to avoid
> > > > frequent timeouts.
> > > 
> > > You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd job
> > > are currently broken and only output some help text instead of compiling
> > > QEMU:
> > > 
> > >   https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
> > > 
> > > ... that's why the finish so fast.
> > > 
> > > IIRC last time I've seen them "working", they were running into the 80
> > > minute timeout again.
> > > 
> > > So the netbsd and openbsd job are indeed not very useful anymore. I think we
> > > should rather remove them and add a proper job via our own custom
> > > KVM-capable runners instead.
> > 
> > The CI job isn't the issue though - it is merely a sign of brokeness
> > elsewhere.  Either tests/vm/{netbsd,openbsd} are broken, or our entire
> > build process for those platforms is broken.
> > 
> > We need to root cause this, rather than hide it further by dropping
> > the CI jobs.
> 
> "make vm-build-netbsd" locally just works fine (as soon as Philippe's python
> fix gets merged). I just had another try with the cirrus-ci job, but it
> indeeds run into timeout issues again:
> 
>  https://gitlab.com/thuth/qemu/-/jobs/5501021556
> 
> I guess we could cut it down again by e.g. removing aarch64-softmmu from the
> target list ... but we then still have the problem that we can not run it by
> default due to the limitations of cirrus-ci only allowing to run 2 jobs in
> parallel. And as long as we don't run things by default, they apparently
> tend to bit-rot quite fast...

Right, even if we drop 1 target, with the other jobs we need to run in
Cirrus, it is still going to be too long. We would need it to be in the
30 min range maximum, to be viable running it by default I tink.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


