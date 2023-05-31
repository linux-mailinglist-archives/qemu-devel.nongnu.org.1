Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B5718A87
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RoW-0001BN-CP; Wed, 31 May 2023 15:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoU-0001At-Kv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoS-0002fS-Jc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0bRHaw6a/XCO9x1BsFkywdp6jnak01uQbrcuI2sOX0=;
 b=JxB8eAfSxxVawcQQ3zGboT8QA9+uzZWcMQyyTdUoho1QTFTjXKvA2MfKB5y4rmcdhYJzoU
 639WIkeP5fbSIn1Ip4MHtMkNMZ9Tvwfu0QgKUW/UTSQ910qxepnGvMyrUmx6GZom+Pnzus
 1g1VZPu7CudriuHy4eciyXDxt+5mXZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-87H55AgWOSS9VuQETTyWrQ-1; Wed, 31 May 2023 15:48:47 -0400
X-MC-Unique: 87H55AgWOSS9VuQETTyWrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2639A8007D9;
 Wed, 31 May 2023 19:48:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F332166B25;
 Wed, 31 May 2023 19:48:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/11] accel/tcg: include cs_base in our hash calculations
Date: Wed, 31 May 2023 15:48:15 -0400
Message-Id: <20230531194815.1508961-12-stefanha@redhat.com>
In-Reply-To: <20230531194815.1508961-1-stefanha@redhat.com>
References: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

We weren't using cs_base in the hash calculations before. Since the
arm front end moved a chunk of flags in a378206a20 (target/arm: Move
mode specific TB flags to tb->cs_base) they comprise of an important
part of the execution state.

Widen the tb_hash_func to include cs_base and expand to qemu_xxhash8()
to accommodate it.

My initial benchmark shows very little difference in the
runtime.

Before:

armhf

➜  hyperfine -w 2 -m 20 "./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot"
Benchmark 1: ./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot
  Time (mean ± σ):     24.627 s ±  2.708 s    [User: 34.309 s, System: 1.797 s]
  Range (min … max):   22.345 s … 29.864 s    20 runs

arm64

➜  hyperfine -w 2 -n 20 "./qemu-system-aarch64 -cpu max,pauth-impdef=on -machine type=virt,virtualization=on,gic-version=3 -display none -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-arm64 -device scsi-hd,drive=hd -smp 4 -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark-pigz.service' -snapshot"
Benchmark 1: 20
  Time (mean ± σ):     62.559 s ±  2.917 s    [User: 189.115 s, System: 4.089 s]
  Range (min … max):   59.997 s … 70.153 s    10 runs

After:

armhf

Benchmark 1: ./arm-softmmu/qemu-system-arm -cpu cortex-a15 -machine type=virt,highmem=off -display none -m 2048 -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-armhf -device scsi-hd,drive=hd -smp 4 -kernel /home/alex/lsrc/linux.git/builds/arm/arch/arm/boot/zImage -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark.service' -snapshot
  Time (mean ± σ):     24.223 s ±  2.151 s    [User: 34.284 s, System: 1.906 s]
  Range (min … max):   22.000 s … 28.476 s    20 runs

arm64

hyperfine -w 2 -n 20 "./qemu-system-aarch64 -cpu max,pauth-impdef=on -machine type=virt,virtualization=on,gic-version=3 -display none -serial mon:stdio -netdev user,id=unet,hostfwd=tcp::2222-:22,hostfwd=tcp::1234-:1234 -device virtio-net-pci,netdev=unet -device virtio-scsi-pci -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-bullseye-arm64 -device scsi-hd,drive=hd -smp 4 -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz -append 'console=ttyAMA0 root=/dev/sda2 systemd.unit=benchmark-pigz.service' -snapshot"
Benchmark 1: 20
  Time (mean ± σ):     62.769 s ±  1.978 s    [User: 188.431 s, System: 5.269 s]
  Range (min … max):   60.285 s … 66.868 s    10 runs

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230526165401.574474-12-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-11-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 accel/tcg/tb-hash.h   |  4 ++--
 include/qemu/xxhash.h | 23 +++++++++++++++++------
 accel/tcg/cpu-exec.c  |  2 +-
 accel/tcg/tb-maint.c  |  4 ++--
 util/qsp.c            |  2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 1d19c69caa..2ba2193731 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -62,9 +62,9 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
-                      uint32_t flags, uint32_t cf_mask)
+                      uint32_t flags, uint64_t flags2, uint32_t cf_mask)
 {
-    return qemu_xxhash6(phys_pc, pc, flags, cf_mask);
+    return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask);
 }
 
 #endif
diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
index c2dcccadbf..0259bbef18 100644
--- a/include/qemu/xxhash.h
+++ b/include/qemu/xxhash.h
@@ -48,8 +48,8 @@
  * xxhash32, customized for input variables that are not guaranteed to be
  * contiguous in memory.
  */
-static inline uint32_t
-qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
+static inline uint32_t qemu_xxhash8(uint64_t ab, uint64_t cd, uint64_t ef,
+                                    uint32_t g, uint32_t h)
 {
     uint32_t v1 = QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 = QEMU_XXHASH_SEED + PRIME32_2;
@@ -59,6 +59,8 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
     uint32_t b = ab >> 32;
     uint32_t c = cd;
     uint32_t d = cd >> 32;
+    uint32_t e = ef;
+    uint32_t f = ef >> 32;
     uint32_t h32;
 
     v1 += a * PRIME32_2;
@@ -89,6 +91,9 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
     h32 += g * PRIME32_3;
     h32  = rol32(h32, 17) * PRIME32_4;
 
+    h32 += h * PRIME32_3;
+    h32  = rol32(h32, 17) * PRIME32_4;
+
     h32 ^= h32 >> 15;
     h32 *= PRIME32_2;
     h32 ^= h32 >> 13;
@@ -100,23 +105,29 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
 
 static inline uint32_t qemu_xxhash2(uint64_t ab)
 {
-    return qemu_xxhash7(ab, 0, 0, 0, 0);
+    return qemu_xxhash8(ab, 0, 0, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash4(uint64_t ab, uint64_t cd)
 {
-    return qemu_xxhash7(ab, cd, 0, 0, 0);
+    return qemu_xxhash8(ab, cd, 0, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
 {
-    return qemu_xxhash7(ab, cd, e, 0, 0);
+    return qemu_xxhash8(ab, cd, 0, e, 0);
 }
 
 static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
                                     uint32_t f)
 {
-    return qemu_xxhash7(ab, cd, e, f, 0);
+    return qemu_xxhash8(ab, cd, 0, e, f);
+}
+
+static inline uint32_t qemu_xxhash7(uint64_t ab, uint64_t cd, uint64_t ef,
+                                    uint32_t g)
+{
+    return qemu_xxhash8(ab, cd, ef, g, 0);
 }
 
 /*
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4a1dce98ff..60ca9e229e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -233,7 +233,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     }
     desc.page_addr0 = phys_pc;
     h = tb_hash_func(phys_pc, (cflags & CF_PCREL ? 0 : pc),
-                     flags, cflags);
+                     flags, cs_base, cflags);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index bc1961ea55..892eecda2d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -887,7 +887,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     /* remove the TB from the hash list */
     phys_pc = tb_page_addr0(tb);
     h = tb_hash_func(phys_pc, (orig_cflags & CF_PCREL ? 0 : tb->pc),
-                     tb->flags, orig_cflags);
+                     tb->flags, tb->cs_base, orig_cflags);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
     }
@@ -968,7 +968,7 @@ TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 
     /* add in the hash table */
     h = tb_hash_func(phys_pc, (tb->cflags & CF_PCREL ? 0 : tb->pc),
-                     tb->flags, tb->cflags);
+                     tb->flags, tb->cs_base, tb->cflags);
     qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
     /* remove TB from the page(s) if we couldn't insert it */
diff --git a/util/qsp.c b/util/qsp.c
index 8562b14a87..2fe3764906 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -144,7 +144,7 @@ uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t ab)
     uint32_t e = callsite->line;
     uint32_t f = callsite->type;
 
-    return qemu_xxhash6(ab, cd, e, f);
+    return qemu_xxhash8(ab, cd, 0, e, f);
 }
 
 static inline
-- 
2.40.1


