Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C7C7B5184
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHDp-0006KM-Fv; Mon, 02 Oct 2023 07:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA+N=FQ=kaod.org=clg@ozlabs.org>)
 id 1qnHDd-0006Js-RC
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:36:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PA+N=FQ=kaod.org=clg@ozlabs.org>)
 id 1qnHDY-00077i-51
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:36:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rzf625nySz4x7V;
 Mon,  2 Oct 2023 22:35:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rzf606PCsz4x3q;
 Mon,  2 Oct 2023 22:35:52 +1100 (AEDT)
Message-ID: <88854727-a895-3727-8cd9-592caa41c3fc@kaod.org>
Date: Mon, 2 Oct 2023 13:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <87lecp6w7x.fsf@pond.sub.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87lecp6w7x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=PA+N=FQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-2.321, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/29/23 13:43, Markus Armbruster wrote:
> Back in 2014 (time flies), I posted
> 
>      Subject: MAINTAINERS leaves too many files uncovered
>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/
> 
> I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
> (at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.
> 
> Unsurprisingly, the number of files in the tree
> 
>      $ git-ls-files | wc -l
> 
> grows over time:
> 
>      year  2014  2015  2016  2018  2023
>      #     3746  4387  4921  6461  9788
> 
> Looks exponential to me, doubling every seven years or so.
> 
> The number of .c files has grown more slowly:
> 
>      year  2014  2015  2016  2018  2023
>      #     1836  1945  2132  2633  3588
> 
> The number of .c files not covered by MAINTAINERS
> 
>      $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
>      $ grep -c '\.c$' unmaintained-files
> 
> went down a lot after my first post, but has since flatlined:
> 
>      year  2014  2015  2016  2018  2023
>      #     1066   461   402   259   246
> 
> It looks like we've pretty much stopped adding more unmaintained .c
> files, i.e. cherry-picking the kernel's 13f1937ef33 (checkpatch: emit a
> warning on file add/move/delete) as commit 4be6131e329 worked.
> 
> On the other hand, we're not making progress on the remaining old ones
> anymore.
> 
> 
> Currently unmaintained files by extension, with a long tail that doesn't
> add up to anything interesting omitted:
> 
>                  #files                percent
>      ext     unmaintained  total     unmaintained
>      h               329    2504         13%
>      c               246    3588          7%
>      rst             103     240         43%
>      <none>           95     716         13%
>      build            52     211         25%
>      mak              47     104         45%
>      decode           44      77         57%
>      txt              23      53         43%
>      bin              20      27         75%
>      rom              15      15        100%
>      inc              14     147         10%
>      cocci            14      23         61%
> 
> Observations:
> 
> 1. More unmaintained .h than .c.  Suggests sloppy accounting in
>     MAINTAINERS.  Low-hanging fruit?
> 
> 2. The number of unmaintained .rst and .txt suggests we're less
>     interested in maintaining documentation.
> 
> 3. The number of unmaintained .build and .mak suggests we're less
>     interested in maintaining the build system.
> 
> 
> Where are the remaining unmaintained files now?  Top-scoring
> directories, files in sub-directories not counted:
> 
>      $ sed 's,/[^/]*$,/,;s,^[^/]*$,./,' unmaintained-files | sort | uniq -c | sort -nr
> 
>        # directory
>       84 include/qemu/
>       56 util/
>       50 pc-bios/
>       46 tests/unit/
>       45 tests/decode/
>       40 include/standard-headers/linux/
>       38 docs/system/
>       35 pc-bios/keymaps/
>       30 docs/devel/
>       26 configs/targets/
>       26 ./
>       25 roms/
>       22 target/i386/
>       22 hw/core/
>       19 scripts/
>       19 include/exec/
>       19 hw/display/
>       14 tests/multiboot/
>       14 scripts/coccinelle/
>       14 include/sysemu/
>       14 include/hw/
>       12 po/
>       12 hw/misc/
>       12 hw/intc/
>       12 docs/
>       11 pc-bios/optionrom/
>       11 docs/specs/
>       10 tests/tcg/riscv64/
>       10 tests/tcg/ppc64/
>       10 disas/
> 
> 
> Which unmaintained files are we still changing?  Unmaintained files
> sorted by number of commits in the past year (since commit 5433af7697b):
> 
>      $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list 5433af7697b.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn
> 
>      186 MAINTAINERS
>       65 target/i386/cpu.c
>       54 qemu-options.hx
>       45 target/i386/cpu.h
>       22 tests/unit/test-bdrv-drain.c
>       21 target/i386/ops_sse.h
>       21 VERSION
>       19 tests/unit/test-cutils.c
>       19 include/monitor/hmp.h
>       18 docs/system/arm/emulation.rst
>       16 include/qemu/osdep.h
>       16 hw/misc/meson.build
>       15 hw/virtio/meson.build
>       14 util/meson.build
>       12 include/qemu/typedefs.h
>       12 docs/about/removed-features.rst
>       11 util/cutils.c
>       10 tests/unit/test-block-iothread.c
>      [82 more with fewer than 10 changes]
> 
> Several of these we clearly need to cover in MAINTAINERS.
> 
> 
> Full list of unmaintained files: 

Regarding PPC, I am not sure where these common PPC files should go :

  configs/targets/ppc*
  docs/system/ppc/embedded.rst
  docs/system/target-ppc.rst
  hw/ppc/meson.build
  hw/ppc/trace*

under "PowerPC TCG CPUs" may be ?

These files :

  tests/tcg/ppc*

should go under "PPC TCG target" I believe.


I have patches for the rest.

Thanks,

C.


