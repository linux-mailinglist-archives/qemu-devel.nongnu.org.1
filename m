Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CC7E8523
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 22:35:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Z99-0002eH-LI; Fri, 10 Nov 2023 16:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reinoud@gorilla.13thmonkey.org>)
 id 1r1Yo3-0006pX-Cp
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 16:12:47 -0500
Received: from 2a02-a46b-bd8f-1-b9b1-f16b-e3de-c82.fixed6.kpn.net
 ([2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82] helo=gorilla.13thmonkey.org)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <reinoud@gorilla.13thmonkey.org>) id 1r1Yo1-0000qT-Ih
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 16:12:47 -0500
Received: by gorilla.13thmonkey.org (Postfix, from userid 103)
 id DF50C2FF0948; Fri, 10 Nov 2023 22:12:38 +0100 (CET)
Date: Fri, 10 Nov 2023 22:12:38 +0100
From: Reinoud Zandijk <reinoud@gorilla.13thmonkey.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Ryo ONODERA <ryoon@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH-for-8.2] .gitlab-ci.d/cirrus.yml: Promote NetBSD job
 as gating
Message-ID: <ZU6cxnwMOqOEBu-F@gorilla.13thmonkey.org>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
Received-SPF: none client-ip=2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82;
 envelope-from=reinoud@gorilla.13thmonkey.org; helo=gorilla.13thmonkey.org
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.245,
 RCVD_IN_PBL=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:34:26 -0500
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

On Thu, Nov 09, 2023 at 06:15:51PM +0100, Thomas Huth wrote:
> On 09/11/2023 17.58, Daniel P. Berrangé wrote:
> > On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
> > > On 9/11/23 16:35, Philippe Mathieu-Daudé wrote:
> > > > This Cirrus-CI based job takes ~12min, similarly to macOS job.
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > > Based-on: <20231109150900.91186-1-philmd@linaro.org>
> > > >             "tests/vm/netbsd: Use Python v3.11"
> > > > ---
> > > >    .gitlab-ci.d/cirrus.yml | 3 +--
> > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > > > index e7f1f83c2c..7b01acb104 100644
> > > > --- a/.gitlab-ci.d/cirrus.yml
> > > > +++ b/.gitlab-ci.d/cirrus.yml
> > > > @@ -94,8 +94,6 @@ aarch64-macos-12-base-build:
> > > >        - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
> > > >      variables:
> > > >        QEMU_JOB_CIRRUS: 1
> > > > -    QEMU_JOB_OPTIONAL: 1
> > > > -
> > > >    x86-netbsd:
> > > >      extends: .cirrus_kvm_job
> > > > @@ -110,3 +108,4 @@ x86-openbsd:
> > > >        NAME: openbsd
> > > >        CONFIGURE_ARGS: --target-list=i386-softmmu,riscv64-softmmu,mips64-softmmu
> > > >        TEST_TARGETS: check
> > > > +    QEMU_JOB_OPTIONAL: 1
> > > 
> > > BTW OpenBSD works for me, but takes ~20min (similar to the FreeBSD job).
> ...
> > I could have sworn our cirrus jobs were much slower in the past (around
> > the 40 min mark), as we had to cut down what we were running to avoid
> > frequent timeouts.
> 
> You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd job
> are currently broken and only output some help text instead of compiling
> QEMU:
> 
>  https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
> 
> ... that's why the finish so fast.
> 
> IIRC last time I've seen them "working", they were running into the 80
> minute timeout again.
> 
> So the netbsd and openbsd job are indeed not very useful anymore. I think we
> should rather remove them and add a proper job via our own custom
> KVM-capable runners instead.

Even though I am a co-maintainer of the NetBSD support for Qemu I am not quite
sure what testcase this is. Is this a regression test of installing NetBSD
from an ISO? That somehow times out? Where can I find the resulting console
output? Maybe the installer changed?

With regards,
Reinoud


