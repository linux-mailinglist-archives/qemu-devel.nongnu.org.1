Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E67E83C0
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Y50-0003Xk-N2; Fri, 10 Nov 2023 15:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DfYf=GX=gmx.de=deller@kernel.org>)
 id 1r1Y4l-0003Wk-E0
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:26:02 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DfYf=GX=gmx.de=deller@kernel.org>)
 id 1r1Y4i-0000Ew-Pn
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:25:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 3D974B8241B;
 Fri, 10 Nov 2023 20:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386FDC433C9;
 Fri, 10 Nov 2023 20:25:51 +0000 (UTC)
Date: Fri, 10 Nov 2023 21:25:48 +0100
From: Helge Deller <deller@gmx.de>
To: Sam James <sam@gentoo.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 joey.gouly@arm.com
Subject: Re: prctl call wrongly succeeds on HPPA?
Message-ID: <ZU6RzDKaDXHAwosp@p100>
References: <87lebjz9z6.fsf@gentoo.org> <875y2jro9a.fsf@gentoo.org>
 <0fec2446-a523-486f-9df7-4c6af9e2e0e3@gmx.de>
 <87zfzl8ix3.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfzl8ix3.fsf@gentoo.org>
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=SRS0=DfYf=GX=gmx.de=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

* Sam James <sam@gentoo.org>:
> 
> Helge Deller <deller@gmx.de> writes:
> 
> > On 11/3/23 13:53, Sam James wrote:
> >> Sam James <sam@gentoo.org> writes:
> >>> I recently hit an issue with systemd-254 which tries to use the new
> >>> prctl(PR_SET_MDWE) for systemd's MemoryDenyWriteExecute functionality.
> >
> > Is this still a problem?
> 
> Yes. When I get time, I will play with Dave's changes to allow using
> non-exeuctable stacks, but for now, it is broken until I can test these
> (thanks dave for working on that, and helge for the kernel side).
> 
> >
> >>> On HPPA, we still need executable stacks, so this option doesn't work
> >>> and leads to a segfault on boot.
> >
> > For kernel we don't need it any longer.
> > But there might be dependencies on glibc version and/or combination.
> > So, I've currently lost overview if we still need executable stacks...
> >
> 
> I don't remember which kernel version either.. I think it was last year
> that you finished off all the DSO bits.

Kernel 5.18+ should be OK:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df24e1783e6e0eb3dc0e3ba5a8df3bb0cc537408

> I had to configure binutils with --enable-default-execstack=no for it to
> work in addition to Dave's GCC patches. But I did not test systemd yet...
> 
> (sorry, I know this is equally vague.)
> 
> >>> Should this call be succeeeding on HPPA, or should we reject it for
> >>> now until we have things wired up?
> >>>
> >>> Reported to systemd at https://github.com/systemd/systemd/issues/29775.
> >>
> >> Lennart has made clear (and I don't think I disagree) that he considers
> >> this squarely a kernel bug.
> >
> > I've read the various bug reports and looked at the kernel commits regarding, e.g.
> >
> > commit b507808ebce23561d4ff8c2aa1fb949fe402bc61
> > Author: Joey Gouly <joey.gouly@arm.com>
> > Date:   Thu Jan 19 16:03:43 2023 +0000
> >
> >     mm: implement memory-deny-write-execute as a prctl
> >
> > but what is prctl(PR_SET_MDWE, PR_MDWE*, 0, 0)... expected to return on parisc?
> > EINVAL? ENOTSUP?
> 
> Maybe we can ask Joey or the ARM people what they expect the semantics
> to be.

Looking at https://fossies.org/linux/systemd/src/core/execute.c
 1636
 1637         /* use prctl() if kernel supports it (6.3) */
 1638         r = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0, 0, 0);
 1639         if (r == 0) {
 1640                 log_unit_debug(u, "Enabled MemoryDenyWriteExecute= with PR_SET_MDWE");
 1641                 return 0;
 1642         }
 1643         if (r < 0 && errno != EINVAL)
 1644                 return log_unit_debug_errno(u, errno, "Failed to enable MemoryDenyWriteExecute= with PR_SET_MDWE: %m");
 1645         /* else use seccomp */
 1646         log_unit_debug(u, "Kernel doesn't support PR_SET_MDWE: falling back to seccomp");
 1647
 1648         if (skip_seccomp_unavailable(u, "MemoryDenyWriteExecute="))
 1649                 return 0;
 1650
 1651         return seccomp_memory_deny_write_execute();
 1652 }

it seems this patch/hack might at least not report success:

diff --git a/kernel/sys.c b/kernel/sys.c
index 420d9cb9cc8e..fe4f2162457c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2384,6 +2384,10 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 {
 	unsigned long current_bits;
 
+	/* parisc still needs a writeable stack for older glibc versions */
+	if (IS_ENABLED(CONFIG_PARISC))
+		return -EINVAL;
+
 	if (arg3 || arg4 || arg5)
 		return -EINVAL;
 

A test would be good though, esp. since I don't know what the seccomp()
functions are doing then.

Helge

