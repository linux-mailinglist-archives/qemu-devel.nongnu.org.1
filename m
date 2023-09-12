Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675379D297
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3h7-0005vV-5D; Tue, 12 Sep 2023 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg3gt-0005uT-JU; Tue, 12 Sep 2023 09:44:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qg3gp-0003bj-GU; Tue, 12 Sep 2023 09:44:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA4EA2127F;
 Tue, 12 Sep 2023 16:44:26 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC6A1278B7;
 Tue, 12 Sep 2023 16:44:22 +0300 (MSK)
Message-ID: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
Date: Tue, 12 Sep 2023 16:44:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Bin Meng <bmeng@tinylab.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: cherry-picking something to -stable which might require other changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Hi!

I've an interesting situation here which I'd love to discuss.
Cc'ing authors of commits in question, but this is actually a much more
general topic than this very specific issue, - so also adding some more
addresses to Cc.

I tried to cherry-pick a trivial commit from master to stable-7.2, this one:

commit c255946e3df4d9660e4f468a456633c24393d468
Author: Thomas Huth <thuth@redhat.com>
Date:   Fri Jul 21 11:47:19 2023 +0200

     hw/char/riscv_htif: Fix printing of console characters on big endian hosts

--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -232,7 +232,8 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
              s->tohost = 0; /* clear to indicate we read */
              return;
          } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
-            qemu_chr_fe_write(&s->chr, (uint8_t *)&payload, 1);
+            uint8_t ch = (uint8_t)payload;
+            qemu_chr_fe_write(&s->chr, &ch, 1);
              resp = 0x100 | (uint8_t)payload;
          } else {
              qemu_log("HTIF device %d: unknown command\n", device);

(it's a whole commit).
The change is small, obvious and well-understood, but the patch does not
apply to 7.2.  For it to apply, either hand-editing the patch is necessary,
or other 2 changes are needed, which are (showing just the relevant parts
from much larger commits):

commit 753ae97abc7459e69d48712355118fb54268f8cb
Author: Bin Meng <bmeng@tinylab.org>
Date:   Thu Dec 29 17:18:17 2022 +0800

     hw/char: riscv_htif: Avoid using magic numbers

--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c

+#define HTIF_DEV_CONSOLE        1

              htifstate->env->mtohost = 0; /* clear to indicate we read */
              return;
-        } else if (cmd == 0x1) {
+        } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
              qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload, 1);
              resp = 0x100 | (uint8_t)payload;
          } else {


and:

commit dadee9e3ce6ee6aad36fe3027eaa0f947358f812
Author: Bin Meng <bmeng@tinylab.org>
Date:   Thu Dec 29 17:18:20 2022 +0800

     hw/char: riscv_htif: Use conventional 's' for HTIFState

--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c

              return;
          } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
-            qemu_chr_fe_write(&htifstate->chr, (uint8_t *)&payload, 1);
+            qemu_chr_fe_write(&s->chr, (uint8_t *)&payload, 1);
              resp = 0x100 | (uint8_t)payload;
          } else {


Both are actually no-ops, - first one defines a bunch of constants, replaces
"magic values" with these constants, and adds comments; second renames variables.
Neither of them has any impact on the resulting code, there's no actual code
changes, just the renames and comments.  But after these 2 patches, the patch
in question applies cleanly, and it is much more likely that subsequent patches
in the same file will apply cleanly too.

In this very specific case, I tend to pick the other two patches too, - esp.
having in mind 7.2 is to be maintained for quite a while (if not only for
debian), - so long-term it should be easier.  But at the same time it's tempting
to just back-port the tiny change in question to the older release.

It's the same doubt as I had with reentrancy fixes which landed in 8.1.  When
backporting other changes (in this case ide/ahci fixes), I either had to fix
context, or include the reentrancy fixes before applying that ide/ahci fix.
This one was nice, because I was not sure if I want to include reentrancy fixes
since the change is quite large, but the ability to apply other patches
unedited was really appealing.

Another example is https://gitlab.com/qemu-project/qemu/-/issues/1808 - the
fix needs translator_io_start() which is this:

commit dfd1b81274140c5f511d549f7b3ec7675a6597f4
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon May 22 23:08:01 2023 -0700

     accel/tcg: Introduce translator_io_start

but this commit is definitely problematic. The problem is that it isn't only
introduces this function, but at the same time it changes a lot of code to
use it, and when trying to apply it to older release, many places conflicts.
If it were just translator_io_start introduction as the subject says, with
conversion to this new function follows, things would be much better. But
the way how it is, I either have to introduce this routine in a stable-7.2-
specific patch (taken as a part of this dfd1b81274140 change), or replace
translator_io_start() usage in subsequent changes like the fix for #1808 ,
neither of which are good.

Quite similar situation was with markings of coroutine_fn etc, - it would
be nice if, in case when something will be used in many places, the definition
would come in a separate patch, with usage/conversion coming in the next patch.


It's all examples of various interesting things I'm seeing, - there are more.
Sure it all is a case-by-case basis.

At any rate, I'd love to have some comments about the situation with this trivial
console printing fix (personally I tend to include 2 previous "no-op" changes even
if both are somewhat large, instead of back-porting just the fix itself), and about
general "other" patch back-porting like this.

BTW, dadee9e3 "hw/char: riscv_htif: Use conventional 's' for HTIFState" has an
issue (which were there before but it hasn't been fixed):

-#define TOHOST_OFFSET1 (htifstate->tohost_offset)
-#define TOHOST_OFFSET2 (htifstate->tohost_offset + 4)
+#define TOHOST_OFFSET1      (s->tohost_offset)
+#define TOHOST_OFFSET2      (s->tohost_offset + 4)

  /* CPU wants to read an HTIF register */
  static uint64_t htif_mm_read(void *opaque, hwaddr addr, unsigned size)
  {
-    HTIFState *htifstate = opaque;
+    HTIFState *s = opaque;
      if (addr == TOHOST_OFFSET1) {
-        return htifstate->env->mtohost & 0xFFFFFFFF;
+        return s->env->mtohost & 0xFFFFFFFF;
      } else if (addr == TOHOST_OFFSET2) {
-        return (htifstate->env->mtohost >> 32) & 0xFFFFFFFF;
+        return (s->env->mtohost >> 32) & 0xFFFFFFFF;

these FROMHOST/TOHOST #defines should take an argument (s in this case).
But this is a different issue.

Thanks!

/mjt

