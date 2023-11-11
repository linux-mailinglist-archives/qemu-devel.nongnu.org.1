Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022967E8BE4
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:34:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1rrT-0000kn-DT; Sat, 11 Nov 2023 12:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reinoud@gorilla.13thmonkey.org>)
 id 1r1rrR-0000kf-3o
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:33:33 -0500
Received: from 2a02-a46b-bd8f-1-b9b1-f16b-e3de-c82.fixed6.kpn.net
 ([2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82] helo=gorilla.13thmonkey.org)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <reinoud@gorilla.13thmonkey.org>) id 1r1rrP-0007ei-Ij
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:33:32 -0500
Received: by gorilla.13thmonkey.org (Postfix, from userid 103)
 id 88BFC2FF0948; Sat, 11 Nov 2023 18:33:25 +0100 (CET)
Date: Sat, 11 Nov 2023 18:33:25 +0100
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
Message-ID: <ZU-65RIut9TWbx_F@gorilla.13thmonkey.org>
References: <20231109153510.92353-1-philmd@linaro.org>
 <737f6fe5-cf3e-4fdd-b5d8-28f71a2fa9e6@linaro.org>
 <ZU0PuHyw8X8e/p0j@redhat.com>
 <52df2072-a26e-4e73-afe0-65a877bafbdc@redhat.com>
 <ZU6cxnwMOqOEBu-F@gorilla.13thmonkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU6cxnwMOqOEBu-F@gorilla.13thmonkey.org>
Received-SPF: none client-ip=2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82;
 envelope-from=reinoud@gorilla.13thmonkey.org; helo=gorilla.13thmonkey.org
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.241,
 RCVD_IN_PBL=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Nov 10, 2023 at 10:12:38PM +0100, Reinoud Zandijk wrote:
> On Thu, Nov 09, 2023 at 06:15:51PM +0100, Thomas Huth wrote:
> > On 09/11/2023 17.58, Daniel P. Berrangé wrote:
> > > On Thu, Nov 09, 2023 at 04:35:56PM +0100, Philippe Mathieu-Daudé wrote:
...
> > You're right, Daniel. Seems like both, the Cirrus netbsd and the openbsd job
> > are currently broken and only output some help text instead of compiling
> > QEMU:
> > 
> >  https://gitlab.com/philmd/qemu/-/jobs/5497861511#L6834
> > 
> > ... that's why the finish so fast.
> > 
> > IIRC last time I've seen them "working", they were running into the 80
> > minute timeout again.
> > 
> > So the netbsd and openbsd job are indeed not very useful anymore. I think we
> > should rather remove them and add a proper job via our own custom
> > KVM-capable runners instead.
> 
> Even though I am a co-maintainer of the NetBSD support for Qemu I am not quite
> sure what testcase this is. Is this a regression test of installing NetBSD
> from an ISO? That somehow times out? Where can I find the resulting console
> output? Maybe the installer changed?

Re-reading the thread its about compiling Qemu on NetBSD. Doh. I am a novice
to the test kit you use so please forgive me if I don't make sense. Am I right
that it does install NetBSD OK, it then comes up and then tries to compile
Qemu on it but it fails due to some Python errors in the test script? Does it
use NetBSDs pkgsrc with its patches or has it its own method of dealing with
them?

With regards,
Reinoud


