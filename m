Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91079D847
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg7i0-0005ld-8l; Tue, 12 Sep 2023 14:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg7hu-0005k1-4a; Tue, 12 Sep 2023 14:01:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg7hr-00034D-Gk; Tue, 12 Sep 2023 14:01:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 31AE12135C;
 Tue, 12 Sep 2023 21:01:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 997722795F;
 Tue, 12 Sep 2023 21:01:43 +0300 (MSK)
Message-ID: <4bc435cf-d6c7-885b-f806-48c961279b10@tls.msk.ru>
Date: Tue, 12 Sep 2023 21:01:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: cherry-picking something to -stable which might require other
 changes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Bin Meng <bmeng@tinylab.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
 <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
 <ZQCCcM1gUy3ODnyj@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZQCCcM1gUy3ODnyj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

12.09.2023 18:23, Daniel P. Berrangé wrote:
..
> I tend to try to cherry-pick the dependancies in case (1) too
> unless they are functionally invasive. Any time you manually
> adjust a patch, you increase the likelihood that later cherry
> picks will also require manual work. So I always favour a clean
> cherry-pick until the point the functional risk becomes
> unacceptable in the context of testing the change I'm pulling
> back.

Yeah, that's exactly my thought: if something in the subsystem
has changed, esp. when the new thing is now widely used, it is
best to try to pick it up (unless it is a big change by itself
or is a part of big change).

I already mentioned a trivial fix c255946e3df4 in this thread,
which can be applied cleanly if two other no-change patches are
in, 753ae97abc7 and dadee9e3ce6.  It is much more likely to hit
conflicts in this area in future updates if such updates will
happen if such renames like these two aren't picked up.

So, right in this same patch series, there's one more very similar
change:

commit 9ff31406312500053ecb5f92df01dd9ce52e635d
Author: Conor Dooley <conor.dooley@microchip.com>
Date:   Thu Jul 27 15:24:17 2023 +0100

     hw/riscv: virt: Fix riscv,pmu DT node path

--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -719,7 +719,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
      MachineState *ms = MACHINE(s);
      RISCVCPU hart = s->soc[0].harts[0];

-    pmu_name = g_strdup_printf("/soc/pmu");
+    pmu_name = g_strdup_printf("/pmu");
      qemu_fdt_add_subnode(ms->fdt, pmu_name);
      qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
      riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);

But all the nearby lines are touched by previous patch:

commit 568e0614d0979e0431a8d9dc0503a63b8b0f2d81
Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Date:   Tue Jan 24 18:22:33 2023 -0300

     hw/riscv/virt.c: rename MachineState 'mc' pointers to 'ms'
...
     Rename all 'mc' MachineState pointers to 'ms'. This is a very tedious
     and mechanical patch that was produced by doing the following:

     - find/replace all 'MachineState *mc' to 'MachineState *ms';
     - find/replace all 'mc->fdt' to 'ms->fdt';
     - find/replace all 'mc->smp.cpus' to 'ms->smp.cpus';
     - replace any remaining occurrences of 'mc' that the compiler complained
     about.

This patch by Daniel is a no-code-change, it really is just a rename of
variables.  I can rename variable back from ms to mc in the fix patch,
or I can apply this rename first and apply the fix patch cleanly, and
all subsequent changes will have much more chance to apply cleanly too.

What a wonderful world.. ;)

Thankfully, such cases are rare.  But we do have a few famous cases like this
still, some of which I also mentioned in the first message in this thread.

/mjt

