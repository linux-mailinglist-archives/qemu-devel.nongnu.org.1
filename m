Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8A9F1595
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 20:13:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB36-0004WS-Ns; Fri, 13 Dec 2024 14:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2J-0003Gy-Ie
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB22-0006bi-K9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb9de518e2so751518b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116936; x=1734721736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPVKWgGGlxNMwJ/5ikAY8qQoL1FGwCZ0ZC/Ic6OB61c=;
 b=Umt6+CUXQT5runt/quR0craxg7rrNJnp3wqAwfbce8fRoeDX2Rr7LaFyq1TJjA7TC1
 OEzturid4z0iPikBvCEszZVC1NdHRtQhVK9HGYxkbwinLFr+jRm3ezZatpfuySgYpotj
 MrO1kvRVz/K8lGYRs74XuqCGcypExa1SNd4BqXQ0+ztDZhX3zBW10Yg9kaX090pab5Mq
 bwIFryPhcNDoWQnPdJ/jregO03bgsD4MJxQp5CkyshJRUj6qfeiJlGPAittTZa5oKxcb
 YX+rrpsMc0ByNEh7ps6fyzQYXQglmldSiMOmmVUvJKMfAOF/fLqgTEmGVyjOY6W9Jr9Q
 z+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116936; x=1734721736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPVKWgGGlxNMwJ/5ikAY8qQoL1FGwCZ0ZC/Ic6OB61c=;
 b=V2umZxRdAO04dB7BMrdcBAw02FXfzsNZ5PWePYMvcx7cMuqNXwDbiWST/GdDzLjr+K
 PzcgGYDAxhN0kpS8NmfmXSgURLwF5TEozMh6NXZMhCluZ3+cXfpOM3CmNubXOgl2UYhW
 5M++Vxne8DzZvURrMM4jWj4TgQkwPkNXUOlCopMGjI/VAe32JojlA59xq/YIH83z1k0d
 KvSW6hcnQnH/grTgn1D7aHRSQl9A7o+mnX/kIMk/jwPhpnaibtAyfF3Wg47NijQNzyrB
 0qeStJ9B8J17nO/pRmxh4vYBnueyRODxkVnMYz0aS8MdBVUnkT2Y56MECuziP8iIj3Y4
 xCPg==
X-Gm-Message-State: AOJu0Yz+vK19Umi1tgdTCLPv6yGSXur1X5Lg82Sd/gxy0BaVBCnVdxU6
 61vm2QP6yO7kdi4G748qZ0JTHgNQsJ3zWs6ntwSlSgh+zmXhDgl1cdgphPO8t/mrJ2nTUqS3hV7
 VeSx95sCc
X-Gm-Gg: ASbGncv93Kn5pHqOP2AS+1iq9P/J94hHN1n8LK0sGbKhysqHt3TqbsQqcGbJcAeLFOo
 TOfU8Q8jHGKwsO9qpTdNIyamez888VzhHNC/ZYwDhWk9fTdDQAiuawpA+IMQS1Hw0Yu+LZnE4uz
 bYaCmRwd4FVSUXWLl7gZMjV0zisMKI2DQjnt5Fsw7SNEpe26uX0aMTybmUB/abC96ETk2GxJyUr
 ZMlbRJi+vfx6SBcE/4SpR5MeIfa39KG06+rqb14S7rXMkJF+MBh4Y1EENWnh3t9
X-Google-Smtp-Source: AGHT+IHqmqm/BgKYlJCaxgNZv3mbBU5PS1tBPWK2PHAnbl+Un4w4Ky7Z7I6UX9KlSVaDpgtVFjbD6Q==
X-Received: by 2002:a05:6808:198e:b0:3eb:3b6e:a731 with SMTP id
 5614622812f47-3eba67fe5c8mr2348947b6e.6.1734116936647; 
 Fri, 13 Dec 2024 11:08:56 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 16/71] hw/audio: Constify all Property
Date: Fri, 13 Dec 2024 13:06:50 -0600
Message-ID: <20241213190750.2513964-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/audio/ac97.c           | 2 +-
 hw/audio/adlib.c          | 2 +-
 hw/audio/asc.c            | 2 +-
 hw/audio/cs4231a.c        | 2 +-
 hw/audio/es1370.c         | 2 +-
 hw/audio/gus.c            | 2 +-
 hw/audio/hda-codec.c      | 2 +-
 hw/audio/intel-hda.c      | 4 ++--
 hw/audio/pcspk.c          | 2 +-
 hw/audio/pl041.c          | 2 +-
 hw/audio/sb16.c           | 2 +-
 hw/audio/via-ac97.c       | 2 +-
 hw/audio/virtio-snd-pci.c | 2 +-
 hw/audio/virtio-snd.c     | 2 +-
 hw/audio/wm8750.c         | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index e373f09d78..8033bbbaed 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1324,7 +1324,7 @@ static void ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property ac97_properties[] = {
+static const Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index bd73806d83..c1d8faecb4 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -297,7 +297,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     portio_list_add (&s->port_list, isa_address_space_io(&s->parent_obj), 0);
 }
 
-static Property adlib_properties[] = {
+static const Property adlib_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AdlibState, card),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 805416372c..452039418d 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -695,7 +695,7 @@ static void asc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->asc);
 }
 
-static Property asc_properties[] = {
+static const Property asc_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ASCState, card),
     DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 2d69372087..abc38720a3 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -689,7 +689,7 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
     isa_register_ioport (d, &s->ioports, s->port);
 }
 
-static Property cs4231a_properties[] = {
+static const Property cs4231a_properties[] = {
     DEFINE_AUDIO_PROPERTIES(CSState, card),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9a508e7b81..6170425a5a 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -868,7 +868,7 @@ static void es1370_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property es1370_properties[] = {
+static const Property es1370_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ES1370State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 4beb3fd74e..dd5a5a3441 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -290,7 +290,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     AUD_set_active_out (s->voice, 1);
 }
 
-static Property gus_properties[] = {
+static const Property gus_properties[] = {
     DEFINE_AUDIO_PROPERTIES(GUSState, card),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c340a9481d..8bd8f62c48 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -857,7 +857,7 @@ static const VMStateDescription vmstate_hda_audio = {
     }
 };
 
-static Property hda_audio_properties[] = {
+static const Property hda_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6918e23c5d..3e4a755228 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -37,7 +37,7 @@
 /* --------------------------------------------------------------------- */
 /* hda bus                                                               */
 
-static Property hda_props[] = {
+static const Property hda_props[] = {
     DEFINE_PROP_UINT32("cad", HDACodecDevice, cad, -1),
     DEFINE_PROP_END_OF_LIST()
 };
@@ -1215,7 +1215,7 @@ static const VMStateDescription vmstate_intel_hda = {
     }
 };
 
-static Property intel_hda_properties[] = {
+static const Property intel_hda_properties[] = {
     DEFINE_PROP_UINT32("debug", IntelHDAState, debug, 0),
     DEFINE_PROP_ON_OFF_AUTO("msi", IntelHDAState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("old_msi_addr", IntelHDAState, old_msi_addr, false),
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a4b89f1768..7a6b9f52d3 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -215,7 +215,7 @@ static const VMStateDescription vmstate_spk = {
     }
 };
 
-static Property pcspk_properties[] = {
+static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index eb96dc2898..6c66a240cb 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -625,7 +625,7 @@ static const VMStateDescription vmstate_pl041 = {
     }
 };
 
-static Property pl041_device_properties[] = {
+static const Property pl041_device_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index fd76e78d18..143b9e71e1 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1440,7 +1440,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     s->can_write = 1;
 }
 
-static Property sb16_properties[] = {
+static const Property sb16_properties[] = {
     DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
     DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 85243e6313..e43ddf37f3 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -459,7 +459,7 @@ static void via_ac97_exit(PCIDevice *dev)
     AUD_remove_card(&s->card);
 }
 
-static Property via_ac97_properties[] = {
+static const Property via_ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(ViaAC97State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index ab58c6410e..b762d7e81e 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -27,7 +27,7 @@ struct VirtIOSoundPCI {
     VirtIOSound vdev;
 };
 
-static Property virtio_snd_pci_properties[] = {
+static const Property virtio_snd_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c5581d7b3d..e2b112e059 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_virtio_snd = {
     },
 };
 
-static Property virtio_snd_properties[] = {
+static const Property virtio_snd_properties[] = {
     DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
     DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
                        VIRTIO_SOUND_JACK_DEFAULT),
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index ec2c4e1374..19e7755060 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -706,7 +706,7 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
     wm8750_clk_update(s, 1);
 }
 
-static Property wm8750_properties[] = {
+static const Property wm8750_properties[] = {
     DEFINE_AUDIO_PROPERTIES(WM8750State, card),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


