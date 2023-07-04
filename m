Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9D746DBE
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcTr-0003VV-0K; Tue, 04 Jul 2023 05:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5427c2329=anthony.perard@citrix.com>)
 id 1qGcTm-0003QE-FA
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:37:51 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5427c2329=anthony.perard@citrix.com>)
 id 1qGcTj-0007oG-9F
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1688463467;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/0yM5i/MfkpAusvz4raS8zb7nUWfMXgPEhK7n7D3RcY=;
 b=Q8rPQszjgeurSfL9oEYjNo3pgcNUTsomKaghq1TJtYID2BX6UmGOvcV4
 Wa4m76HwgftDYGQx6HbB8KociUp+BBiGOLN7L0sPddDbms+7qFd0dOTBV
 n3BfNZrlBylsghfNLJ/nHsx9IULnvwsegnKwLZ33OEh6Yi2N18xv2iHic M=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 115110777
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:eV13K6rt8pNipSmBiEi2M4foXN9eBmIAZRIvgKrLsJaIsI4StFCzt
 garIBnTOqyCMTDyfYp1PoXi8BkD65HcyoAwTgI4rSo3HiwU9ZuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GpwUmAWP6gR5weBzyVNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAC4qcg/biO2M+auEFONc2sY/dfKoYLpK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSZBFOUslWcOSA3xETdxVRrk6VoqwmpXDe1gVr3JDmMcbPe8zMTsJQ9qqdj
 jufoj2gWk5Fa7RzzxK7132Tq7+VkxnVAr4fD6Wo+KNRoQyckzl75Bo+CgLg/KjRZlSFc9BVJ
 lEQ+yEuhbMv70HtRd74NzWhrXuZ+xIRRddUO+s97g6L1+zT+QnxLngJSHtNZcIrsOcyRCc2z
 RmZktXxHzttvbaJD3WH+d+8pCu/IyEPIUceZCUPSk0O5NyLnW0opkuRFJA5Svfz14CrX2iqm
 FhmsRTSmZ0NqtIUj6q0x2nevGymlsTLUlcOpVnuCzfNAhxCWGK1W2C5wQGFvaYcct/EHwnpU
 GsswJbHsr1XZX2ZvGnUGbhWQun0jxqQGGeE6WODCaXN4NhEF5SLWYlLqA9zK05yWirvUW+4O
 RSD0e+9CXI6AZdLUUOUS9jrYyjS5fK8fekJr9iNBja0XrB/dRWc4AZlblOK0mbmnSAEyP9va
 cvDIJz1UypGWMyLKQZaoM9EgNcWKt0WnzuPFfgXMTz6uVZhWJJlYehcawbfBgzIxKiFvB/U4
 75i2ziikn1ivBnFSnCPq+Y7dAlaRUXX8Liq86S7gMbfeFs5cIzgYteNqY4cl3tNxPsFzruRp
 i7hASe1CjPX3BX6FOlDUVg7AJuHYHq1hStT0fAEVbpw50UeXA==
IronPort-HdrOrdr: A9a23:TwgqKaj8SvSygiAvUawlSS/6C3BQXtwji2hC6mlwRA09TySZ//
 rBoB0+726RtN93YgBGpTngAtjkfZqyz/NICOUqUYtKGTOW3ldAT7sSj7cKoQeBJ8SWzIc0vs
 1dmupFeb7N5DBB/L/HCWKDcurIruPpzJyV
X-Talos-CUID: 9a23:jOj4Om+dqaFWS7ed3quVv1AzBt99fXLn9W7vfUWIVWR1EYbWFWbFrQ==
X-Talos-MUID: 9a23:yNPueQaJ6zCK0eBTiRrjuxwybslSzf6SBVsVgZtbgOjVOnkl
X-IronPort-AV: E=Sophos;i="6.01,180,1684814400"; d="scan'208";a="115110777"
Date: Tue, 4 Jul 2023 10:37:38 +0100
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
CC: Jan Beulich <jbeulich@suse.com>, <qemu-devel@nongnu.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: QEMU assert (was: [xen-unstable test] 181558: regressions - FAIL)
Message-ID: <947da45d-f336-4034-bf51-fb190420506b@perard>
References: <osstest-181558-mainreport@xen.org>
 <ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.local>
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=5427c2329=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 28, 2023 at 02:31:39PM +0200, Roger Pau Monné wrote:
> On Fri, Jun 23, 2023 at 03:04:21PM +0000, osstest service owner wrote:
> > flight 181558 xen-unstable real [real]
> > http://logs.test-lab.xenproject.org/osstest/logs/181558/
> > 
> > Regressions :-(
> > 
> > Tests which did not succeed and are blocking,
> > including tests which could not be run:
> >  test-amd64-amd64-xl-qcow2   21 guest-start/debian.repeat fail REGR. vs. 181545
> 
> The test failing here is hitting the assert in qemu_cond_signal() as
> called by worker_thread():
> 
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> #1  0x00007ffff740b535 in __GI_abort () at abort.c:79
> #2  0x00007ffff740b40f in __assert_fail_base (fmt=0x7ffff756cef0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x55555614abcb "cond->initialized",
>     file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198, function=<optimized out>) at assert.c:92
> #3  0x00007ffff74191a2 in __GI___assert_fail (assertion=0x55555614abcb "cond->initialized", file=0x55555614ab88 "../qemu-xen-dir-remote/util/qemu-thread-posix.c", line=198,
>     function=0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal") at assert.c:101
> #4  0x0000555555f1c8d2 in qemu_cond_signal (cond=0x7fffb800db30) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:198
> #5  0x0000555555f36973 in worker_thread (opaque=0x7fffb800dab0) at ../qemu-xen-dir-remote/util/thread-pool.c:129
> #6  0x0000555555f1d1d2 in qemu_thread_start (args=0x7fffb8000b20) at ../qemu-xen-dir-remote/util/qemu-thread-posix.c:505
> #7  0x00007ffff75b0fa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
> #8  0x00007ffff74e206f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> I've been trying to figure out how it can get in such state, but so
> far I had no luck.  I'm not a QEMU expert, so it's probably better if
> someone else could handle this.
> 
> In the failures I've seen, and the reproduction I have, the assert
> triggers in the QEMU dom0 instance responsible for locally-attaching
> the disk to dom0 in order to run pygrub.
> 
> This is also with QEMU 7.2, as testing with upstream QEMU is blocked
> ATM, so there's a chance it has already been fixed upstream.
> 
> Thanks, Roger.

So, I've run a test with the latest QEMU and I can still reproduce the
issue. The test also fails with QEMU 7.1.0.

But, QEMU 7.0 seems to pass the test, even with a start-stop loop of 200
iteration. So I'll try to find out if something change in that range.
Or try to find out why would the thread pool be not initialised
properly.

Cheers,

-- 
Anthony PERARD

