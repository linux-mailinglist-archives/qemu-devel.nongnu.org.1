Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C007B9D80
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOgK-0001ep-FA; Thu, 05 Oct 2023 09:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOgH-0001eC-3J
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOgA-00071L-TB
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696513573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcPE8sD+Ltnegn3oYNrKCaF5w7h+dF2fnQ+7SJzxwgI=;
 b=T0PMDzG1V6a5eaKpW9WssR3sFo+c2NeJDMWZeHigawEhFU0TlYrrxE3VR0DbIYgjrrjg6W
 3GW1if40L0BeCsA/zXh4rRU4vEkP+XxMlbNfWKX8qeKaUUDK7ibK653ENW0/ErpHwYziQ6
 EqWQHqgD/JnLJ7C2SS/HI4xFuO6nd+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-NxndKoPHPYCPipKMk92L7w-1; Thu, 05 Oct 2023 09:46:05 -0400
X-MC-Unique: NxndKoPHPYCPipKMk92L7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 672D5101AA70;
 Thu,  5 Oct 2023 13:46:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A14CC15BB8;
 Thu,  5 Oct 2023 13:46:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0845821E6904; Thu,  5 Oct 2023 15:46:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
References: <87lecp6w7x.fsf@pond.sub.org>
 <1b36bc2a-3bba-d876-5ea7-f3e37d9ec464@linaro.org>
Date: Thu, 05 Oct 2023 15:46:00 +0200
In-Reply-To: <1b36bc2a-3bba-d876-5ea7-f3e37d9ec464@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 2 Oct 2023 08:20:47
 +0200")
Message-ID: <871qe9yyg7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 29/9/23 13:43, Markus Armbruster wrote:
>> Back in 2014 (time flies), I posted
>>
>>      Subject: MAINTAINERS leaves too many files uncovered
>>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub=
.org/
>>
>> I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
>> (at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.
>>
>> Unsurprisingly, the number of files in the tree
>>
>>      $ git-ls-files | wc -l
>>
>> grows over time:
>>
>>      year  2014  2015  2016  2018  2023
>>      #     3746  4387  4921  6461  9788
>>
>> Looks exponential to me, doubling every seven years or so.
>>
>> The number of .c files has grown more slowly:
>>
>>      year  2014  2015  2016  2018  2023
>>      #     1836  1945  2132  2633  3588
>>
>> The number of .c files not covered by MAINTAINERS
>>
>>      $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no=
-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >=
unmaintained-files
>>      $ grep -c '\.c$' unmaintained-files
>>
>> went down a lot after my first post, but has since flatlined:
>>
>>      year  2014  2015  2016  2018  2023
>>      #     1066   461   402   259   246
>>
>> It looks like we've pretty much stopped adding more unmaintained .c
>> files, i.e. cherry-picking the kernel's 13f1937ef33 (checkpatch: emit a
>> warning on file add/move/delete) as commit 4be6131e329 worked.
>> On the other hand, we're not making progress on the remaining old ones
>> anymore.
>
> How many new files without maintainers?

Since we added the warning:

    $ git-diff --diff-filter=3DA --name-only 4be6131e329 36e9aab3c56 | grep=
 '\.c$' | join unmaintained-files - | wc -l
    105

Less than 20 per year.  Could be worse.

Full list appended.

> Shouldn't we turn this warning into an error, so new files must have
> maintainers?

We'd have to make the check a lot smarter first.  Not sure that's worth
it.

checkpatch.pl warns when it detects file additions, deletions, or
renames without MAINTAINERS update.

It doesn't warn when the MAINTAINERS update doesn't cover everything
changed.

It may warn when no MAINTAINERS change is needed, say because existing
patterns cover the new files.



accel/dummy-cpus.c
backends/confidential-guest-support.c
disas/capstone.c
disas/disas-mon.c
disas/disas.c
disas/riscv-xthead.c
disas/riscv-xventana.c
event-loop-base.c
hw/core/cpu-sysemu.c
hw/core/gpio.c
hw/core/hotplug-stubs.c
hw/core/machine-hmp-cmds.c
hw/core/resettable.c
hw/core/vm-change-state-handler.c
hw/display/acpi-vga-stub.c
hw/display/acpi-vga.c
hw/display/artist.c
hw/display/ati.c
hw/display/ati_2d.c
hw/display/ati_dbg.c
hw/display/i2c-ddc.c
hw/gpio/gpio_pwr.c
hw/hyperv/hyperv.c
hw/hyperv/hyperv_testdev.c
hw/hyperv/syndbg.c
hw/input/lasips2.c
hw/intc/nios2_vic.c
hw/intc/riscv_aclint.c
hw/intc/riscv_aplic.c
hw/intc/riscv_imsic.c
hw/mem/cxl_type3_stubs.c
hw/misc/axp2xx.c
hw/misc/i2c-echo.c
hw/misc/pvpanic-isa.c
hw/misc/pvpanic-pci.c
hw/misc/sbsa_ec.c
hw/pci-host/gpex-acpi.c
hw/ppc/fw_cfg.c
hw/ppc/pef.c
hw/sensor/dps310.c
hw/sensor/emc141x.c
hw/sensor/lsm303dlhc_mag.c
hw/sensor/max31785.c
hw/virtio/vdpa-dev-pci.c
hw/virtio/vdpa-dev.c
hw/watchdog/sbsa_gwdt.c
monitor/fds.c
pc-bios/optionrom/pvh_main.c
softmmu/async-teardown.c
softmmu/datadir.c
softmmu/globals.c
softmmu/rtc.c
stats/stats-hmp-cmds.c
stats/stats-qmp-cmds.c
target/i386/cpu-dump.c
target/i386/cpu-sysemu.c
target/i386/host-cpu.c
tests/bench/atomic64-bench.c
tests/bench/qtree-bench.c
tests/tcg/hppa/stby.c
tests/tcg/m68k/denormal.c
tests/tcg/m68k/trap.c
tests/tcg/minilib/printf.c
tests/tcg/ppc64/bcdsub.c
tests/tcg/ppc64/byte_reverse.c
tests/tcg/ppc64/mffsce.c
tests/tcg/ppc64/mtfsf.c
tests/tcg/ppc64/non_signalling_xscv.c
tests/tcg/ppc64/signal_save_restore_xer.c
tests/tcg/ppc64/test-aes.c
tests/tcg/ppc64/vector.c
tests/tcg/ppc64/xxspltw.c
tests/tcg/riscv64/noexec.c
tests/tcg/riscv64/test-aes.c
tests/tcg/riscv64/test-div.c
tests/tcg/riscv64/test-fcvtmod.c
tests/unit/test-bdrv-drain.c
tests/unit/test-bdrv-graph-mod.c
tests/unit/test-bitmap.c
tests/unit/test-block-iothread.c
tests/unit/test-blockjob.c
tests/unit/test-char.c
tests/unit/test-cutils.c
tests/unit/test-div128.c
tests/unit/test-error-report.c
tests/unit/test-image-locking.c
tests/unit/test-interval-tree.c
tests/unit/test-nested-aio-poll.c
tests/unit/test-qgraph.c
tests/unit/test-qtree.c
tests/unit/test-write-threshold.c
tests/unit/test-xs-node.c
util/atomic64.c
util/block-helpers.c
util/crc-ccitt.c
util/guest-random.c
util/int128.c
util/interval-tree.c
util/memalign.c
util/nvdimm-utils.c
util/qemu-co-timeout.c
util/qsp.c
util/qtree.c
util/selfmap.c
util/thread-context.c


