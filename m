Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C80EF70DCFA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTH-0007Zf-Jd; Tue, 23 May 2023 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTE-0007Z3-Va
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-0005Lu-Ow
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4856981f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846205; x=1687438205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4ka5Szv0DTbXfL92FfwWOXkHpQ6TgzA/lOFc8Q4SWI=;
 b=JznBAUlDfm9x4yov70Xj8MQ0YKNweOFCAVxuqyYaZ9K1YzJEAT2dVg5bJBI2vE120G
 tYks6QhrtyAOvysw+j+t3TIh6bvX7l43oI13K1FAA5bdesFrKy3PhlkWOPp2kOv9Cc3e
 /UwAH5gDvn/uamZkpJs5BP2tSEiQFevv1VitMBqLtcDtIcprpXExIDnhOGaWwtL24hDo
 3KX0uBS9mRvZhXPSmF3x5+gKBeN3uZRsGl0WyfonELY0d1kQEtrxDEUrUtcbUAMnk6TK
 z4R3Jlucf2kFbYIy93Xuml4rHdvtV6QphAYHCKvLwwiI/cjx8eaNCF8NoeyTC7X3hEtP
 amXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846205; x=1687438205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4ka5Szv0DTbXfL92FfwWOXkHpQ6TgzA/lOFc8Q4SWI=;
 b=GanMfz0kdSjP538X3sopshTu6f7umkHIon1iMRu1rpMoPlRhqpvJ7M6A5LKZTE11SX
 G/nJFV1wc58NaVB35R04fHYbxuYCQgOOVSU8qjuqgcp499+5iMQR8SRTEp750//FgVh4
 ajGDg7MCzOJ2d9vnv9cKoL6rnLeOR96vlLYFdg9wS9JYI6no+ZhWe46t8RTslNw8elaH
 j5kvSi0S/+zX8/5ZPg5TnE1oN4QRY20c1en4DKLuegDIH+j7abKzE0uh54YsoYo80wtE
 KmFRfa6oziLXXPCPZyNZKG13euAF+dabFUWd5enHhkPeyG2e7Bu+CqUF0U4hJL1K+a6N
 uSsg==
X-Gm-Message-State: AC+VfDwgd/SeG+Ek/AWcYzky+FfLDiHJab4Vs+QV678aQPQC4ueEHwu6
 rtxnZv2pzpWPAtMWXJjQJvEkVQ==
X-Google-Smtp-Source: ACHHUZ6l5SHA1aAUbFSmXMPr1V8btEduBBjeEJp1+A1V4UrX7l3OUohKmgoaFx/uzMDTpQcqnuI/Qw==
X-Received: by 2002:a5d:58e3:0:b0:309:22ba:dcdc with SMTP id
 f3-20020a5d58e3000000b0030922badcdcmr10746334wrd.42.1684846205732; 
 Tue, 23 May 2023 05:50:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a5d4e85000000b003047dc162f7sm10966703wru.67.2023.05.23.05.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 321C21FFBD;
 Tue, 23 May 2023 13:50:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 10/10] accel/tcg: include cs_base in our hash calculations
Date: Tue, 23 May 2023 13:50:00 +0100
Message-Id: <20230523125000.3674739-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

---
v4
  - use an additional 64 bit argument, shuffle qsp usage
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
index c2dcccadbf..8a5ad1f1f3 100644
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
+    return qemu_xxhash8(ab, cd, e, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
                                     uint32_t f)
 {
-    return qemu_xxhash7(ab, cd, e, f, 0);
+    return qemu_xxhash8(ab, cd, e, f, 0);
+}
+
+static inline uint32_t qemu_xxhash7(uint64_t ab, uint64_t cd, uint64_t ef,
+                                    uint32_t g)
+{
+    return qemu_xxhash8(ab, cd, ef, g, 0);
 }
 
 /*
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 973da2a434..8d67198e56 100644
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
2.39.2


