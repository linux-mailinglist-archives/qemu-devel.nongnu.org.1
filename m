Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14D708D06
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 02:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzoC3-0006En-I4; Thu, 18 May 2023 20:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eldon-qemu@eldondev.com>)
 id 1pzoBw-0006Cy-KN
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:41:56 -0400
Received: from [209.195.0.149] (helo=npcomp.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eldon-qemu@eldondev.com>)
 id 1pzoBo-0006rm-El
 for qemu-devel@nongnu.org; Thu, 18 May 2023 20:41:55 -0400
Received: by npcomp.net (Postfix, from userid 1000)
 id 47F6512517D; Fri, 19 May 2023 00:41:45 +0000 ()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
 s=eldondev; t=1684456905;
 bh=YAKEqHpACpfQdfQcKGYGJ7DEjCfX+fGjBKue9a6qv5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NZBziGjQogLOgHOtuANsNShPV6HKmQRKMcOx8LUVOFT1KU8WJ4Pcro/X2TuUD6K7w
 2MJzXSpewPeZxsZi2r+O2Qd52mge8ggtqEzOLzbpqwItGdTjrDcaapVJF8HGH6x4KT
 JIDlI6ZBfroUuj7HMsiCeC8M7ceYfo0aJbI0y6Pc=
Date: Fri, 19 May 2023 00:41:45 +0000
From: Eldon Stegall <eldon-qemu@eldondev.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab shared runner time expired
Message-ID: <ZGbFya2IqoDR8153@invalid>
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 209.195.0.149 (failed)
Received-SPF: pass client-ip=209.195.0.149;
 envelope-from=eldon-qemu@eldondev.com; helo=npcomp.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Thu, May 18, 2023 at 12:26:33PM -0700, Richard Henderson wrote:
> So, here we are again, out of runner time with 13 days left in the month.
> 
> Did we come to any resolution since last time?  Holding development for that long just 
> isn't right, so I'll continue processing the hard way -- testing on private runners and 
> local build machines.

Hi Richard,
We should have capacity for private runners to execute several jobs in
parallel.  Here [1] is an example of one that ran on a private runner today.

I have been thinking about suggesting a strategy to run jobs that lend
themselves to amd64 linux runners pinned to private runners that match,
so more "shared" minutes can be spent on runners that have different
capabilites.

If there is another specific arch/OS runner you have in mind, I would be
happy to make efforts towards provisioning one in our infrastructure.
Particularly it seems like a lot of people are trying to use qemu to
support amd64 linux on M1 macs, so it might make sense to have a private
mac silicon macOS runner.

Also, since we have a hardware runner that can run with kvm capabilites,
it might make sense to carve some of those tests out for that tagged
runner. 

Since this is relatively new, I think I was personally in an observational
period before seeking input on those goals, but let me know you thoughts.

Thanks,
Eldon

[1] https://gitlab.com/qemu-project/qemu/-/jobs/4310866300

