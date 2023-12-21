Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BA81AD2E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9aB-0001bY-IJ; Wed, 20 Dec 2023 22:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9a8-0001U0-0x
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:45 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9a5-0003xm-Kz
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:43 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67f7da00237so1361026d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128720; x=1703733520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BUPjulL37v9I3fbW6Ju3ECNP2BMc62r5u4umTa9wVZE=;
 b=sLiqHNLQbqXowTEcwz2xKtIyxrPx4NwtA6Wyg/GWVIPnKVoDuG4JaIiHfEuVHGkGle
 +3BntLPhaElSUf7YIpz7q2ty6yQDQ+doKh0hQ+4U/xIIewaXWBshLmRXafUkl5lre5I5
 btCcSX/AsE/XsrLQN3YkXI9kKiYguMJ2rXT6Hdi6+Qzvq7IJNRhVkLPuSXxbBsfAwtgh
 EULHomF0GLL7peOg616jcsLaRfbd7EvgI2u5NyAlu4Zu6x03L0vHR1mKUUhKj2bEhKUq
 BO55TPBii5l48wnEYv4CPn/LVpzjtBuWWmdl2F7S7/POZ90dPBKk+hEB1yCmKjEw10+J
 qaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128720; x=1703733520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUPjulL37v9I3fbW6Ju3ECNP2BMc62r5u4umTa9wVZE=;
 b=tczlR10V2txjoh8Pnv4KCGNhT82P3kEsfIJn8w3Z9f+XKB73StdY3SgKZX6IOqKRd0
 Ue74S3/UeiajvLQmZTbZ/my6wSPxrRu7W58r/7Oz434qcpZw9b+VJPA8HRFoLe4jqkFY
 TMqCcSBew86V6GG/SN+7/nbNiWd4o88dBDKSolwdMjK5ZCKEIBzRnpxUB66BglOkGQsA
 B/8zRhr9W95A5doSO88pnqZqr7aeoRllrX9fe+ZqGTRjbb07UaM0KlpK6lFB+ek5nfYT
 DqC/er7m37htJsFZiOT1udITFfY3aFeaKhnUzgSqSyEePS3O6gMdxpcxbEwa/rBz2tkz
 PzyQ==
X-Gm-Message-State: AOJu0YyK5djiSNDM/3nJ2dP9GR4PMI4yDB8qTh5T7FWR/Sjcxbnq5RlC
 yEUXRi+sfYod9Qg3PTkqyBNhgmdo4JZJFMYxZhXY9/K1
X-Google-Smtp-Source: AGHT+IHDjXokRZ8J1Jpt2xan/fwe2tUGqqmiU/8TUzT8YdWXjNrrlBAmmh4dzkbi+kCv8KGaekRk9g==
X-Received: by 2002:a05:6214:1310:b0:67a:a721:ec0f with SMTP id
 pn16-20020a056214131000b0067aa721ec0fmr19188347qvb.83.1703128720497; 
 Wed, 20 Dec 2023 19:18:40 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/71] hw/audio: Constify VMState
Date: Thu, 21 Dec 2023 14:16:04 +1100
Message-Id: <20231221031652.119827-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/audio/ac97.c            | 4 ++--
 hw/audio/asc.c             | 4 ++--
 hw/audio/cs4231.c          | 2 +-
 hw/audio/cs4231a.c         | 2 +-
 hw/audio/es1370.c          | 4 ++--
 hw/audio/gus.c             | 2 +-
 hw/audio/hda-codec.c       | 8 ++++----
 hw/audio/intel-hda.c       | 4 ++--
 hw/audio/lm4549.c          | 2 +-
 hw/audio/marvell_88w8618.c | 2 +-
 hw/audio/pcspk.c           | 2 +-
 hw/audio/pl041.c           | 8 ++++----
 hw/audio/sb16.c            | 2 +-
 hw/audio/virtio-snd.c      | 2 +-
 hw/audio/wm8750.c          | 2 +-
 15 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 6a7a2dc80c..3f0053f94d 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1094,7 +1094,7 @@ static const VMStateDescription vmstate_ac97_bm_regs = {
     .name = "ac97_bm_regs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(bdbar, AC97BusMasterRegs),
         VMSTATE_UINT8(civ, AC97BusMasterRegs),
         VMSTATE_UINT8(lvi, AC97BusMasterRegs),
@@ -1142,7 +1142,7 @@ static const VMStateDescription vmstate_ac97 = {
     .version_id = 3,
     .minimum_version_id = 2,
     .post_load = ac97_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, AC97LinkState),
         VMSTATE_UINT32(glob_cnt, AC97LinkState),
         VMSTATE_UINT32(glob_sta, AC97LinkState),
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 0f36b4ce9b..87b5624326 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -555,7 +555,7 @@ static const VMStateDescription vmstate_asc_fifo = {
     .name = "apple-sound-chip.fifo",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(fifo, ASCFIFOState, ASC_FIFO_SIZE),
         VMSTATE_UINT8(int_status, ASCFIFOState),
         VMSTATE_INT32(cnt, ASCFIFOState),
@@ -575,7 +575,7 @@ static const VMStateDescription vmstate_asc = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = asc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(fifos, ASCState, 2, 0, vmstate_asc_fifo,
                              ASCFIFOState),
         VMSTATE_UINT8_ARRAY(regs, ASCState, ASC_REG_SIZE),
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index aefc3edea1..967caa7fcb 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -142,7 +142,7 @@ static const VMStateDescription vmstate_cs4231 = {
     .name ="cs4231",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CSState, CS_REGS),
         VMSTATE_UINT8_ARRAY(dregs, CSState, CS_DREGS),
         VMSTATE_END_OF_LIST()
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3aa105748d..9ef57f042d 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -637,7 +637,7 @@ static const VMStateDescription vmstate_cs4231a = {
     .minimum_version_id = 1,
     .pre_load = cs4231a_pre_load,
     .post_load = cs4231a_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY (regs, CSState, CS_REGS),
         VMSTATE_BUFFER (dregs, CSState),
         VMSTATE_INT32 (dma_running, CSState),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index fad5541211..4ab61d3b9d 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -765,7 +765,7 @@ static const VMStateDescription vmstate_es1370_channel = {
     .name = "es1370_channel",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32 (shift, struct chan),
         VMSTATE_UINT32 (leftover, struct chan),
         VMSTATE_UINT32 (scount, struct chan),
@@ -808,7 +808,7 @@ static const VMStateDescription vmstate_es1370 = {
     .version_id = 2,
     .minimum_version_id = 2,
     .post_load = es1370_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE (dev, ES1370State),
         VMSTATE_STRUCT_ARRAY (chan, ES1370State, NB_CHANNELS, 2,
                               vmstate_es1370_channel, struct chan),
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 6c2b586ca7..4beb3fd74e 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -209,7 +209,7 @@ static const VMStateDescription vmstate_gus = {
     .name = "gus",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32 (pos, GUSState),
         VMSTATE_INT32 (left, GUSState),
         VMSTATE_INT32 (shift, GUSState),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 0bc20d49f6..b22e486fda 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -812,7 +812,7 @@ static const VMStateDescription vmstate_hda_audio_stream_buf = {
     .name = "hda-audio-stream/buffer",
     .version_id = 1,
     .needed = vmstate_hda_audio_stream_buf_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(buf, HDAAudioStream),
         VMSTATE_INT64(rpos, HDAAudioStream),
         VMSTATE_INT64(wpos, HDAAudioStream),
@@ -825,7 +825,7 @@ static const VMStateDescription vmstate_hda_audio_stream_buf = {
 static const VMStateDescription vmstate_hda_audio_stream = {
     .name = "hda-audio-stream",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(stream, HDAAudioStream),
         VMSTATE_UINT32(channel, HDAAudioStream),
         VMSTATE_UINT32(format, HDAAudioStream),
@@ -837,7 +837,7 @@ static const VMStateDescription vmstate_hda_audio_stream = {
         VMSTATE_BUFFER(compat_buf, HDAAudioStream),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_hda_audio_stream_buf,
         NULL
     }
@@ -847,7 +847,7 @@ static const VMStateDescription vmstate_hda_audio = {
     .name = "hda-audio",
     .version_id = 2,
     .post_load = hda_audio_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(st, HDAAudioState, 4, 0,
                              vmstate_hda_audio_stream,
                              HDAAudioStream),
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 78ff9f9a68..9c54e60b71 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1158,7 +1158,7 @@ static int intel_hda_post_load(void *opaque, int version)
 static const VMStateDescription vmstate_intel_hda_stream = {
     .name = "intel-hda-stream",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctl, IntelHDAStream),
         VMSTATE_UINT32(lpib, IntelHDAStream),
         VMSTATE_UINT32(cbl, IntelHDAStream),
@@ -1174,7 +1174,7 @@ static const VMStateDescription vmstate_intel_hda = {
     .name = "intel-hda",
     .version_id = 1,
     .post_load = intel_hda_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pci, IntelHDAState),
 
         /* registers */
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index e7bfcc4b9f..a4a77c8dc6 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -329,7 +329,7 @@ const VMStateDescription vmstate_lm4549_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = lm4549_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(voice_is_active, lm4549_state),
         VMSTATE_UINT16_ARRAY(regfile, lm4549_state, 128),
         VMSTATE_UINT16_ARRAY(buffer, lm4549_state, LM4549_BUFFER_SIZE),
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index e6c09bdb8e..cc285444bc 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -273,7 +273,7 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
     .name = "mv88w8618_audio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(playback_mode, mv88w8618_audio_state),
         VMSTATE_UINT32(status, mv88w8618_audio_state),
         VMSTATE_UINT32(irq_enable, mv88w8618_audio_state),
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index fe7f07ced2..a4b89f1768 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -208,7 +208,7 @@ static const VMStateDescription vmstate_spk = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = migrate_needed,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 868dffbfd3..b435208c24 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -571,7 +571,7 @@ static const VMStateDescription vmstate_pl041_regfile = {
     .name = "pl041_regfile",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
 #define REGISTER(name, offset) VMSTATE_UINT32(name, pl041_regfile),
         #include "pl041.hx"
 #undef REGISTER
@@ -583,7 +583,7 @@ static const VMStateDescription vmstate_pl041_fifo = {
     .name = "pl041_fifo",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, pl041_fifo),
         VMSTATE_UINT32_ARRAY(data, pl041_fifo, MAX_FIFO_DEPTH),
         VMSTATE_END_OF_LIST()
@@ -594,7 +594,7 @@ static const VMStateDescription vmstate_pl041_channel = {
     .name = "pl041_channel",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(tx_fifo, pl041_channel, 0,
                        vmstate_pl041_fifo, pl041_fifo),
         VMSTATE_UINT8(tx_enabled, pl041_channel),
@@ -613,7 +613,7 @@ static const VMStateDescription vmstate_pl041 = {
     .name = "pl041",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(fifo_depth, PL041State),
         VMSTATE_STRUCT(regs, PL041State, 0,
                        vmstate_pl041_regfile, pl041_regfile),
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 18f6d252db..bf7f35a42b 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1324,7 +1324,7 @@ static const VMStateDescription vmstate_sb16 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = sb16_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32 (irq, SB16State),
         VMSTATE_UINT32 (dma, SB16State),
         VMSTATE_UINT32 (hdma, SB16State),
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 137fa77a01..ea2aeaef14 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -72,7 +72,7 @@ static const VMStateDescription vmstate_virtio_snd = {
     .unmigratable = 1,
     .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
     .version_id = VIRTIO_SOUND_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 57954a6314..ec2c4e1374 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -592,7 +592,7 @@ static const VMStateDescription vmstate_wm8750 = {
     .minimum_version_id = 0,
     .pre_save = wm8750_pre_save,
     .post_load = wm8750_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(i2c_data, WM8750State, 2),
         VMSTATE_INT32(i2c_len, WM8750State),
         VMSTATE_INT32(enable, WM8750State),
-- 
2.34.1


