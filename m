Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E0A19EC6
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Jan 2025 08:19:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tarUG-0007UC-Ig; Thu, 23 Jan 2025 02:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUD-0007T3-CT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:45 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUA-0006Ci-HK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:45 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso1138457a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 23:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737616721; x=1738221521;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZqwJ3lt+S692i6rY22sQ+2HVEoq+Ggl5P39jwm8jG6c=;
 b=0z/J5m+tNZ1e+ZDApW4Sp+7gf0tC1EC7+Ta/UZ9L1LSPxn8r3q6bV8fVqz+expS7LK
 oi9plEYIzMcNKWcPtRpf2Adb6nVkO3xoTb6QusKGdVW1OaOeThG5F6hnBMpWJoeSqwcG
 Y5p3FdOmZaLeTWESa7ck4DRs+izqD7itmc8w3YTYcBTxaQapOrfPLpIykatCmMbbrF7Y
 UJ9WRoFQU8QmD+WRXE8eAqBi9tHsAzsAG4Bd3MTk2Z2CY747lkKMSKLritsaTPcjOLxs
 xoJ4r0lc/RUHnX/tEWKzF6WcDmKQkYaFxEL7hnBJXVnhRnJHZETx+7htFAQtiUycDOM0
 Ue4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737616721; x=1738221521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqwJ3lt+S692i6rY22sQ+2HVEoq+Ggl5P39jwm8jG6c=;
 b=Qc+HhvvAtx0mSCXN0GC7ry9TRvW4X1Sch3t/eO8bfjQ9q6pHZOR04dcj3YMNRzOo2L
 ueGyUsNck4hN2uzDMKxHhs2oxMVc4oILXdm+pW6/G5EBP9NVpTDiIsFw6P9zNuPSwYnu
 e/bT0+T2uOzaqOtO2pdS8c2Nh2bKU9jw58ke+n0OUGsmPhcztM19ZY7o4IPFOVbkW3v1
 W8u/4Yj9JZz7CfPLkpDDzcHS1PR9XBvEEE1JCmVDxaEvtAyvSabhXkixx+NTV3LuMh4t
 5q/dMLU34abd8KPjy/QvP6jIAUSpiYZ+faxsHdE2ljoOY7MDau08IDaY06pRH52LZCZV
 RXUQ==
X-Gm-Message-State: AOJu0YxXSq64a8SZ6FTivIi9aalDyPtTnJQGqHfVPYJeM0/3vH3H7HcL
 h15klt/ZuDQmbGPRAoGjv/+Dvt8AaQMFys9eNVIni/ZTFiqI7QrsitBQ5hav4TI=
X-Gm-Gg: ASbGnct91D/UiSwVX9QimPwVJNM+geomMkBH25Tiszv6mOEBmC+RVur0cLapNfB7v2C
 K9wXj6tysKhRfSKJz7a7dn9v2XppEVRfjK/lY8iDEFzKyFF4P/F5z9q6+S9WALtn8NGfFfKM1e9
 yMBEHdyAQGN/zjBuJzU9WDURDd1YeRMeNCFJoYw17t18+huzmhTUUX6kM7F9EDWKQOmEL6MG5nM
 C2Pf0A3xJvjAFe1YpamzT20m43WrcLrWsSmmxOh/CAgicZmxux+k3lEKBqbzuJW7PAShEGB45DK
 nRuuvx2N
X-Google-Smtp-Source: AGHT+IHNigt71t56kq3/8hvS8xUkWU5FBybI15QihYS3+igVdUYYDdekuIuOBW+AOGNwZEkOupjt9g==
X-Received: by 2002:a17:90b:2c85:b0:2ee:f80c:6892 with SMTP id
 98e67ed59e1d1-2f782c4d587mr32582051a91.3.1737616720780; 
 Wed, 22 Jan 2025 23:18:40 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f7e6abee96sm3062508a91.31.2025.01.22.23.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 23:18:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 23 Jan 2025 16:18:29 +0900
Subject: [PATCH v5 1/4] coreaudio: Improve naming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-coreaudio-v5-1-6873df4215a0@daynix.com>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
In-Reply-To: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

coreaudio had names that are not conforming to QEMU codding style.
coreaudioVoiceOut also had some members that are prefixed with redundant
words like "output" or "audio".
Global names included "out" to tell they are specific to output devices,
but this rule was not completely enforced.
The frame size had three different names "frameSize", "bufferFrameSize",
and "frameCount".

Replace identifiers to fix these problems.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 191 +++++++++++++++++++++++++++---------------------------
 1 file changed, 97 insertions(+), 94 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cadd729d50537850d81718b9284efed5877d9185..d6469b77cbde3d84a40017aed64279ab4fce6b29 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -33,37 +33,37 @@
 #define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
 
-typedef struct coreaudioVoiceOut {
+typedef struct CoreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t buf_mutex;
-    AudioDeviceID outputDeviceID;
-    int frameSizeSetting;
-    uint32_t bufferCount;
-    UInt32 audioDevicePropertyBufferFrameSize;
+    AudioDeviceID device_id;
+    int frame_size_setting;
+    uint32_t buffer_count;
+    UInt32 device_frame_size;
     AudioDeviceIOProcID ioprocid;
     bool enabled;
-} coreaudioVoiceOut;
+} CoreaudioVoiceOut;
 
-static const AudioObjectPropertyAddress voice_addr = {
+static const AudioObjectPropertyAddress voice_out_addr = {
     kAudioHardwarePropertyDefaultOutputDevice,
     kAudioObjectPropertyScopeGlobal,
     kAudioObjectPropertyElementMain
 };
 
-static OSStatus coreaudio_get_voice(AudioDeviceID *id)
+static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
 {
     UInt32 size = sizeof(*id);
 
     return AudioObjectGetPropertyData(kAudioObjectSystemObject,
-                                      &voice_addr,
+                                      &voice_out_addr,
                                       0,
                                       NULL,
                                       &size,
                                       id);
 }
 
-static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
-                                             AudioValueRange *framerange)
+static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
+                                                 AudioValueRange *framerange)
 {
     UInt32 size = sizeof(*framerange);
     AudioObjectPropertyAddress addr = {
@@ -80,7 +80,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
                                       framerange);
 }
 
-static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
+static OSStatus coreaudio_get_out_framesize(AudioDeviceID id, UInt32 *framesize)
 {
     UInt32 size = sizeof(*framesize);
     AudioObjectPropertyAddress addr = {
@@ -97,7 +97,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
                                       framesize);
 }
 
-static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
+static OSStatus coreaudio_set_out_framesize(AudioDeviceID id, UInt32 *framesize)
 {
     UInt32 size = sizeof(*framesize);
     AudioObjectPropertyAddress addr = {
@@ -114,8 +114,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
                                       framesize);
 }
 
-static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
-                                           AudioStreamBasicDescription *d)
+static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
+                                               AudioStreamBasicDescription *d)
 {
     UInt32 size = sizeof(*d);
     AudioObjectPropertyAddress addr = {
@@ -132,7 +132,7 @@ static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
                                       d);
 }
 
-static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
+static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32 *result)
 {
     UInt32 size = sizeof(*result);
     AudioObjectPropertyAddress addr = {
@@ -242,7 +242,8 @@ static void G_GNUC_PRINTF (3, 4) coreaudio_logerr2 (
 #define coreaudio_playback_logerr(status, ...) \
     coreaudio_logerr2(status, "playback", __VA_ARGS__)
 
-static int coreaudio_buf_lock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
+                                        const char *fn_name)
 {
     int err;
 
@@ -255,7 +256,8 @@ static int coreaudio_buf_lock (coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut *core,
+                                          const char *fn_name)
 {
     int err;
 
@@ -268,20 +270,20 @@ static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
-    static ret_type glue(coreaudio_, name)args_decl             \
-    {                                                           \
-        coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;     \
-        ret_type ret;                                           \
-                                                                \
-        if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
-            return 0;                                           \
-        }                                                       \
-                                                                \
-        ret = glue(audio_generic_, name)args;                   \
-                                                                \
-        coreaudio_buf_unlock(core, "coreaudio_" #name);             \
-        return ret;                                             \
+#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args)       \
+    static ret_type glue(coreaudio_, name)args_decl                   \
+    {                                                                 \
+        CoreaudioVoiceOut *core = (CoreaudioVoiceOut *) hw;           \
+        ret_type ret;                                                 \
+                                                                      \
+        if (coreaudio_voice_out_buf_lock(core, "coreaudio_" #name)) { \
+            return 0;                                                 \
+        }                                                             \
+                                                                      \
+        ret = glue(audio_generic_, name)args;                         \
+                                                                      \
+        coreaudio_voice_out_buf_unlock(core, "coreaudio_" #name);     \
+        return ret;                                                   \
     }
 COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
@@ -297,7 +299,7 @@ static ret_type glue(coreaudio_, name)args_decl             \
  * callback to feed audiooutput buffer. called without BQL.
  * allowed to lock "buf_mutex", but disallowed to have any other locks.
  */
-static OSStatus audioDeviceIOProc(
+static OSStatus out_device_ioproc(
     AudioDeviceID inDevice,
     const AudioTimeStamp *inNow,
     const AudioBufferList *inInputData,
@@ -306,33 +308,33 @@ static OSStatus audioDeviceIOProc(
     const AudioTimeStamp *inOutputTime,
     void *hwptr)
 {
-    UInt32 frameCount, pending_frames;
+    UInt32 frame_size, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *) hwptr;
     size_t len;
 
-    if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
+    if (coreaudio_voice_out_buf_lock (core, "out_device_ioproc")) {
         inInputTime = 0;
         return 0;
     }
 
-    if (inDevice != core->outputDeviceID) {
-        coreaudio_buf_unlock (core, "audioDeviceIOProc(old device)");
+    if (inDevice != core->device_id) {
+        coreaudio_voice_out_buf_unlock (core, "out_device_ioproc(old device)");
         return 0;
     }
 
-    frameCount = core->audioDevicePropertyBufferFrameSize;
+    frame_size = core->device_frame_size;
     pending_frames = hw->pending_emul / hw->info.bytes_per_frame;
 
     /* if there are not enough samples, set signal and return */
-    if (pending_frames < frameCount) {
+    if (pending_frames < frame_size) {
         inInputTime = 0;
-        coreaudio_buf_unlock (core, "audioDeviceIOProc(empty)");
+        coreaudio_voice_out_buf_unlock (core, "out_device_ioproc(empty)");
         return 0;
     }
 
-    len = frameCount * hw->info.bytes_per_frame;
+    len = frame_size * hw->info.bytes_per_frame;
     while (len) {
         size_t write_len, start;
 
@@ -348,16 +350,16 @@ static OSStatus audioDeviceIOProc(
         out += write_len;
     }
 
-    coreaudio_buf_unlock (core, "audioDeviceIOProc");
+    coreaudio_voice_out_buf_unlock (core, "out_device_ioproc");
     return 0;
 }
 
-static OSStatus init_out_device(coreaudioVoiceOut *core)
+static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
     OSStatus status;
-    AudioValueRange frameRange;
+    AudioValueRange framerange;
 
-    AudioStreamBasicDescription streamBasicDescription = {
+    AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = core->hw.info.bits,
         .mBytesPerFrame = core->hw.info.bytes_per_frame,
         .mBytesPerPacket = core->hw.info.bytes_per_frame,
@@ -368,20 +370,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice(&core->outputDeviceID);
+    status = coreaudio_get_voice_out(&core->device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                    "Could not get default output Device\n");
         return status;
     }
-    if (core->outputDeviceID == kAudioDeviceUnknown) {
+    if (core->device_id == kAudioDeviceUnknown) {
         dolog ("Could not initialize playback - Unknown Audiodevice\n");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_framesizerange(core->outputDeviceID,
-                                          &frameRange);
+    status = coreaudio_get_out_framesizerange(core->device_id,
+                                              &framerange);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -391,32 +393,32 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return status;
     }
 
-    if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
-        dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
-    } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
-        dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
+    if (framerange.mMinimum > core->frame_size_setting) {
+        core->device_frame_size = (UInt32) framerange.mMinimum;
+        dolog ("warning: Upsizing Buffer Frames to %f\n", framerange.mMinimum);
+    } else if (framerange.mMaximum < core->frame_size_setting) {
+        core->device_frame_size = (UInt32) framerange.mMaximum;
+        dolog ("warning: Downsizing Buffer Frames to %f\n", framerange.mMaximum);
     } else {
-        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
+        core->device_frame_size = core->frame_size_setting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_set_out_framesize(core->device_id,
+                                         &core->device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                     "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
+                                    (uint32_t)core->device_frame_size);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_get_out_framesize(core->device_id,
+                                         &core->device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -425,19 +427,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
                                     "Could not get device buffer frame size\n");
         return status;
     }
-    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
+    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_streamformat(core->outputDeviceID,
-                                        &streamBasicDescription);
+    status = coreaudio_set_out_streamformat(core->device_id,
+                                            &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                    "Could not set samplerate %lf\n",
-                                   streamBasicDescription.mSampleRate);
-        core->outputDeviceID = kAudioDeviceUnknown;
+                                   stream_basic_description.mSampleRate);
+        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -452,8 +454,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
      * with the callers of AudioObjectGetPropertyData.
      */
     core->ioprocid = NULL;
-    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
-                                       audioDeviceIOProc,
+    status = AudioDeviceCreateIOProcID(core->device_id,
+                                       out_device_ioproc,
                                        &core->hw,
                                        &core->ioprocid);
     if (status == kAudioHardwareBadDeviceError) {
@@ -461,20 +463,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
     if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
         coreaudio_playback_logerr (status, "Could not set IOProc\n");
-        core->outputDeviceID = kAudioDeviceUnknown;
+        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
     return 0;
 }
 
-static void fini_out_device(coreaudioVoiceOut *core)
+static void fini_out_device(CoreaudioVoiceOut *core)
 {
     OSStatus status;
     UInt32 isrunning;
 
     /* stop playback */
-    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
+    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
     if (status != kAudioHardwareBadObjectError) {
         if (status != kAudioHardwareNoError) {
             coreaudio_logerr(status,
@@ -482,7 +484,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
         }
 
         if (isrunning) {
-            status = AudioDeviceStop(core->outputDeviceID, core->ioprocid);
+            status = AudioDeviceStop(core->device_id, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr(status, "Could not stop playback\n");
             }
@@ -490,20 +492,20 @@ static void fini_out_device(coreaudioVoiceOut *core)
     }
 
     /* remove callback */
-    status = AudioDeviceDestroyIOProcID(core->outputDeviceID,
+    status = AudioDeviceDestroyIOProcID(core->device_id,
                                         core->ioprocid);
     if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
         coreaudio_logerr(status, "Could not remove IOProc\n");
     }
-    core->outputDeviceID = kAudioDeviceUnknown;
+    core->device_id = kAudioDeviceUnknown;
 }
 
-static void update_device_playback_state(coreaudioVoiceOut *core)
+static void update_out_device_playback_state(CoreaudioVoiceOut *core)
 {
     OSStatus status;
     UInt32 isrunning;
 
-    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
+    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
     if (status != kAudioHardwareNoError) {
         if (status != kAudioHardwareBadObjectError) {
             coreaudio_logerr(status,
@@ -516,7 +518,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
     if (core->enabled) {
         /* start playback */
         if (!isrunning) {
-            status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
+            status = AudioDeviceStart(core->device_id, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr (status, "Could not resume playback\n");
             }
@@ -524,7 +526,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
     } else {
         /* stop playback */
         if (isrunning) {
-            status = AudioDeviceStop(core->outputDeviceID,
+            status = AudioDeviceStop(core->device_id,
                                      core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
                 coreaudio_logerr(status, "Could not pause playback\n");
@@ -534,22 +536,22 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
 }
 
 /* called without BQL. */
-static OSStatus handle_voice_change(
+static OSStatus handle_voice_out_change(
     AudioObjectID in_object_id,
     UInt32 in_number_addresses,
     const AudioObjectPropertyAddress *in_addresses,
     void *in_client_data)
 {
-    coreaudioVoiceOut *core = in_client_data;
+    CoreaudioVoiceOut *core = in_client_data;
 
     bql_lock();
 
-    if (core->outputDeviceID) {
+    if (core->device_id) {
         fini_out_device(core);
     }
 
     if (!init_out_device(core)) {
-        update_device_playback_state(core);
+        update_out_device_playback_state(core);
     }
 
     bql_unlock();
@@ -560,7 +562,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
     OSStatus status;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *) hw;
     int err;
     Audiodev *dev = drv_opaque;
     AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
@@ -578,13 +580,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
     as->fmt = AUDIO_FORMAT_F32;
     audio_pcm_init_info (&hw->info, as);
 
-    core->frameSizeSetting = audio_buffer_frames(
+    core->frame_size_setting = audio_buffer_frames(
         qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
 
-    core->bufferCount = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
+    core->buffer_count = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
 
     status = AudioObjectAddPropertyListener(kAudioObjectSystemObject,
-                                            &voice_addr, handle_voice_change,
+                                            &voice_out_addr,
+                                            handle_voice_out_change,
                                             core);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
@@ -594,8 +597,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     if (init_out_device(core)) {
         status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
-                                                   &voice_addr,
-                                                   handle_voice_change,
+                                                   &voice_out_addr,
+                                                   handle_voice_out_change,
                                                    core);
         if (status != kAudioHardwareNoError) {
             coreaudio_playback_logerr(status,
@@ -612,11 +615,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 {
     OSStatus status;
     int err;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *) hw;
 
     status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
-                                               &voice_addr,
-                                               handle_voice_change,
+                                               &voice_out_addr,
+                                               handle_voice_out_change,
                                                core);
     if (status != kAudioHardwareNoError) {
         coreaudio_logerr(status, "Could not remove voice property change listener\n");
@@ -633,7 +636,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
 
 static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *) hw;
 
     core->enabled = enable;
     update_device_playback_state(core);
@@ -670,7 +673,7 @@ static void coreaudio_audio_fini (void *opaque)
     .pcm_ops        = &coreaudio_pcm_ops,
     .max_voices_out = 1,
     .max_voices_in  = 0,
-    .voice_size_out = sizeof (coreaudioVoiceOut),
+    .voice_size_out = sizeof (CoreaudioVoiceOut),
     .voice_size_in  = 0
 };
 

-- 
2.48.1


