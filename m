Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 175CC7B6449
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnapM-0004sG-1D; Tue, 03 Oct 2023 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaob-00038A-HR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoY-0000ON-VY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5tBSULoyUh3MOQSGkOSKpnFNoNW+PF5NawtxjfSwPU=;
 b=eEAh2H2SVQhigannzt3zZqzo89/upNA1NIUt4LC8QVYEGLFRXRGPK8m6ujbb3r4qdNnEMQ
 ZbMj5UyBPgQ4813KAFVmkZVjbrSQ89FT9XqIIDY7Tmr5NTdufsoHVMBvEDy99I/Sau5up6
 7wv/WewthxHmNp8E+iQjgmxkMDI53Xo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-rhSwy28lMiyikR2IdQmsqQ-1; Tue, 03 Oct 2023 04:31:32 -0400
X-MC-Unique: rhSwy28lMiyikR2IdQmsqQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso49397466b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321890; x=1696926690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5tBSULoyUh3MOQSGkOSKpnFNoNW+PF5NawtxjfSwPU=;
 b=JIScMv54oBZmbukwp8HbfjuoCjWppi39H76uxo00E9EP0InFWUhm9QUBJgx7FXzbLY
 0slOcZP2KL8LKl9U6Abwe4RYFFBdSKqh+0hOsjyXlYWhSx7ayn1uLt8DnjP+4P+ksXbN
 Nf/q03oDuJNkGEvB+7OFbqhtJnspGqF1K63cpVRHay6C5c6iaWiNmzDx7K9qnI2V/RDE
 OHldYFI3gBWDx41EnurGvAf2XkymVtG7yc4BOBHQG/rIBATSFjd7QOLK02iTlDn876JN
 pWIOUYFr9J3AIMBs7Ox9uDXMOjaWg0bIrc2jvIig0qPjmuJmWWxo78kuAtVxGF6SEZnF
 N3iw==
X-Gm-Message-State: AOJu0YyKgSbZ6ghIaCTxV4x4tmdvUBE8jeIuxzxoomUjBbGcp1hdPYLt
 JT9qUs6oDbUMmyAXYLs9tBEabRAWraR47VF8tPn6a+BkjXJQgjrj7EQmPR4hFUHxg5fJiRzX6Sn
 tugUVKTCbD5RFKfZ6sCvQifUPfphINj1m6UQoEvjj3Q2Q4q74yCs5iKK0gIUJt/4gzeV/YLVdgq
 M=
X-Received: by 2002:a17:906:53d9:b0:9ae:7611:99bb with SMTP id
 p25-20020a17090653d900b009ae761199bbmr13338867ejo.59.1696321890618; 
 Tue, 03 Oct 2023 01:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq2EflKZlDI9rNf45LwXcZUUWMbPxG2im2GhxebTXkGKggicLJQ7OmygWvvuq6kf0uJv4hCA==
X-Received: by 2002:a17:906:53d9:b0:9ae:7611:99bb with SMTP id
 p25-20020a17090653d900b009ae761199bbmr13338850ejo.59.1696321890221; 
 Tue, 03 Oct 2023 01:31:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a170906410600b009ad8acac02asm663791ejk.172.2023.10.03.01.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 23/24] audio: propagate Error * out of audio_init
Date: Tue,  3 Oct 2023 10:30:40 +0200
Message-ID: <20231003083042.110065-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Martin Kletzander <mkletzan@redhat.com>

Starting from audio_driver_init, propagate errors via Error ** so that
audio_init_audiodevs can simply pass &error_fatal, and AUD_register_card
can signal faiure.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
[Reworked the audio/audio.c parts, while keeping Martin's hw/ changes. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c        | 37 ++++++++++++++++++-------------------
 audio/audio.h        |  4 ++--
 hw/arm/omap2.c       |  2 +-
 hw/audio/ac97.c      |  6 +++++-
 hw/audio/adlib.c     |  6 ++++--
 hw/audio/cs4231a.c   |  6 ++++--
 hw/audio/es1370.c    |  5 ++++-
 hw/audio/gus.c       |  6 ++++--
 hw/audio/hda-codec.c |  5 ++++-
 hw/audio/lm4549.c    |  8 +++++---
 hw/audio/pcspk.c     |  4 +---
 hw/audio/sb16.c      |  6 ++++--
 hw/audio/via-ac97.c  |  6 ++++--
 hw/audio/wm8750.c    |  5 ++++-
 hw/display/xlnx_dp.c |  6 ++++--
 hw/input/tsc210x.c   |  2 +-
 hw/usb/dev-audio.c   |  5 ++++-
 softmmu/vl.c         |  4 +---
 18 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 818d79e50f0..4289b7bf028 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1556,7 +1556,7 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 }
 
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-                             bool msg, Audiodev *dev)
+                             Audiodev *dev, Error **errp)
 {
     Error *local_err = NULL;
 
@@ -1577,12 +1577,10 @@ static int audio_driver_init(AudioState *s, struct audio_driver *drv,
         s->drv = drv;
         return 0;
     } else {
-        if (!msg) {
-            error_free(local_err);
-        } else if (local_err) {
-            error_report_err(local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
         } else {
-            error_report("Could not init `%s' audio driver", drv->name);
+            error_setg(errp, "Could not init `%s' audio driver", drv->name);
         }
         return -1;
     }
@@ -1733,7 +1731,7 @@ static void audio_create_default_audiodevs(void)
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, Error **errp)
 {
     static bool atexit_registered;
     int done = 0;
@@ -1760,9 +1758,9 @@ static AudioState *audio_init(Audiodev *dev)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = !audio_driver_init(s, driver, true, dev);
+            done = !audio_driver_init(s, driver, dev, errp);
         } else {
-            dolog ("Unknown audio driver `%s'\n", drvname);
+            error_setg(errp, "Unknown audio driver `%s'\n", drvname);
         }
         if (!done) {
             goto out;
@@ -1771,13 +1769,13 @@ static AudioState *audio_init(Audiodev *dev)
         for (;;) {
             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
             if (!e) {
-                dolog("no default audio driver available\n");
+                error_setg(errp, "no default audio driver available");
                 goto out;
             }
             s->dev = dev = e->dev;
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (!audio_driver_init(s, driver, false, dev)) {
+            if (!audio_driver_init(s, driver, dev, NULL)) {
                 break;
             }
             QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
@@ -1806,7 +1804,7 @@ out:
     return NULL;
 }
 
-void AUD_register_card (const char *name, QEMUSoundCard *card)
+bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
         if (!QTAILQ_EMPTY(&audio_states)) {
@@ -1820,13 +1818,18 @@ void AUD_register_card (const char *name, QEMUSoundCard *card)
             if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
                 audio_create_default_audiodevs();
             }
-            card->state = audio_init(NULL);
+            card->state = audio_init(NULL, errp);
+            if (!card->state) {
+                return false;
+            }
         }
     }
 
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
     QLIST_INSERT_HEAD(&card->state->card_head, card, entries);
+
+    return true;
 }
 
 void AUD_remove_card (QEMUSoundCard *card)
@@ -2153,17 +2156,13 @@ void audio_define(Audiodev *dev)
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
 }
 
-bool audio_init_audiodevs(void)
+void audio_init_audiodevs(void)
 {
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev)) {
-            return false;
-        }
+        audio_init(e->dev, &error_fatal);
     }
-
-    return true;
 }
 
 audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
diff --git a/audio/audio.h b/audio/audio.h
index 34df8962a66..80f3f92124d 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -94,7 +94,7 @@ typedef struct QEMUAudioTimeStamp {
 void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
 void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
-void AUD_register_card (const char *name, QEMUSoundCard *card);
+bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture(
     AudioState *s,
@@ -170,7 +170,7 @@ void audio_sample_from_uint64(void *samples, int pos,
 
 void audio_define(Audiodev *audio);
 void audio_parse_option(const char *opt);
-bool audio_init_audiodevs(void);
+void audio_init_audiodevs(void);
 void audio_help(void);
 
 AudioState *audio_state_by_name(const char *name, Error **errp);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 41b1f596dca..f170728e7ec 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -614,7 +614,7 @@ static struct omap_eac_s *omap_eac_init(struct omap_target_agent_s *ta,
         s->codec.card.name = g_strdup(current_machine->audiodev);
         s->codec.card.state = audio_state_by_name(s->codec.card.name, &error_fatal);
     }
-    AUD_register_card("OMAP EAC", &s->codec.card);
+    AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal);
 
     memory_region_init_io(&s->iomem, NULL, &omap_eac_ops, s, "omap.eac",
                           omap_l4_region_size(ta, 0));
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index c2a5ce062a1..6a7a2dc80c4 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1273,6 +1273,10 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
+    if (!AUD_register_card ("ac97", &s->card, errp)) {
+        return;
+    }
+
     /* TODO: no need to override */
     c[PCI_COMMAND] = 0x00;      /* pcicmd pci command rw, ro */
     c[PCI_COMMAND + 1] = 0x00;
@@ -1306,7 +1310,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
                           "ac97-nabm", 256);
     pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nam);
     pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nabm);
-    AUD_register_card("ac97", &s->card);
+
     ac97_on_reset(DEVICE(s));
 }
 
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 5f979b1487d..bd73806d83a 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -255,6 +255,10 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     AdlibState *s = ADLIB(dev);
     struct audsettings as;
 
+    if (!AUD_register_card ("adlib", &s->card, errp)) {
+        return;
+    }
+
     s->opl = OPLCreate (3579545, s->freq);
     if (!s->opl) {
         error_setg (errp, "OPLCreate %d failed", s->freq);
@@ -270,8 +274,6 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = AUDIO_HOST_ENDIANNESS;
 
-    AUD_register_card ("adlib", &s->card);
-
     s->voice = AUD_open_out (
         &s->card,
         s->voice,
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 5c6d6437320..3aa105748d3 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -678,13 +678,15 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!AUD_register_card ("cs4231a", &s->card, errp)) {
+        return;
+    }
+
     s->pic = isa_bus_get_irq(bus, s->irq);
     k = ISADMA_GET_CLASS(s->isa_dma);
     k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
 
     isa_register_ioport (d, &s->ioports, s->port);
-
-    AUD_register_card ("cs4231a", &s->card);
 }
 
 static Property cs4231a_properties[] = {
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 4f738a0ad88..90f73d4c23d 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -853,6 +853,10 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     ES1370State *s = ES1370(dev);
     uint8_t *c = s->dev.config;
 
+    if (!AUD_register_card ("es1370", &s->card, errp)) {
+        return;
+    }
+
     c[PCI_STATUS + 1] = PCI_STATUS_DEVSEL_SLOW >> 8;
 
 #if 0
@@ -868,7 +872,6 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io (&s->io, OBJECT(s), &es1370_io_ops, s, "es1370", 256);
     pci_register_bar (&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
 
-    AUD_register_card ("es1370", &s->card);
     es1370_reset (s);
 }
 
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 787345ce543..6c2b586ca71 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -241,14 +241,16 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     IsaDmaClass *k;
     struct audsettings as;
 
+    if (!AUD_register_card ("gus", &s->card, errp)) {
+        return;
+    }
+
     s->isa_dma = isa_bus_get_dma(bus, s->emu.gusdma);
     if (!s->isa_dma) {
         error_setg(errp, "ISA controller does not support DMA");
         return;
     }
 
-    AUD_register_card ("gus", &s->card);
-
     as.freq = s->freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index a26048cf15e..b9ad1f4c39e 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -685,11 +685,14 @@ static void hda_audio_init(HDACodecDevice *hda,
     const desc_param *param;
     uint32_t i, type;
 
+    if (!AUD_register_card("hda", &a->card, errp)) {
+        return;
+    }
+
     a->desc = desc;
     a->name = object_get_typename(OBJECT(a));
     dprint(a, 1, "%s: cad %d\n", __func__, a->hda.cad);
 
-    AUD_register_card("hda", &a->card);
     for (i = 0; i < a->desc->nnodes; i++) {
         node = a->desc->nodes + i;
         param = hda_codec_find_param(node, AC_PAR_AUDIO_WIDGET_CAP);
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 418041bc9c6..e7bfcc4b9fe 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -281,6 +281,11 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
 {
     struct audsettings as;
 
+    /* Register an audio card */
+    if (!AUD_register_card("lm4549", &s->card, errp)) {
+        return;
+    }
+
     /* Store the callback and opaque pointer */
     s->data_req_cb = data_req_cb;
     s->opaque = opaque;
@@ -288,9 +293,6 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     /* Init the registers */
     lm4549_reset(s);
 
-    /* Register an audio card */
-    AUD_register_card("lm4549", &s->card);
-
     /* Open a default voice */
     as.freq = 48000;
     as.nchannels = 2;
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index daf92a4ce11..fe7f07ced21 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -123,8 +123,6 @@ static int pcspk_audio_init(PCSpkState *s)
         return 0;
     }
 
-    AUD_register_card(s_spk, &s->card);
-
     s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
     if (!s->voice) {
         AUD_log(s_spk, "Could not open voice\n");
@@ -191,7 +189,7 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    if (s->card.state) {
+    if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
         pcspk_audio_init(s);
     }
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 535ccccdc98..18f6d252db3 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1402,6 +1402,10 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     SB16State *s = SB16 (dev);
     IsaDmaClass *k;
 
+    if (!AUD_register_card ("sb16", &s->card, errp)) {
+        return;
+    }
+
     s->isa_hdma = isa_bus_get_dma(bus, s->hdma);
     s->isa_dma = isa_bus_get_dma(bus, s->dma);
     if (!s->isa_dma || !s->isa_hdma) {
@@ -1434,8 +1438,6 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     k->register_channel(s->isa_dma, s->dma, SB_read_DMA, s);
 
     s->can_write = 1;
-
-    AUD_register_card ("sb16", &s->card);
 }
 
 static Property sb16_properties[] = {
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 676254b7a40..30095a4c7aa 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -426,6 +426,10 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     ViaAC97State *s = VIA_AC97(pci_dev);
     Object *o = OBJECT(s);
 
+    if (!AUD_register_card ("via-ac97", &s->card, errp)) {
+        return;
+    }
+
     /*
      * Command register Bus Master bit is documented to be fixed at 0 but it's
      * needed for PCI DMA to work in QEMU. The pegasos2 firmware writes 0 here
@@ -445,8 +449,6 @@ static void via_ac97_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->fm);
     memory_region_init_io(&s->midi, o, &midi_ops, s, "via-ac97.midi", 4);
     pci_register_bar(pci_dev, 2, PCI_BASE_ADDRESS_SPACE_IO, &s->midi);
-
-    AUD_register_card ("via-ac97", &s->card);
 }
 
 static void via_ac97_exit(PCIDevice *dev)
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index b5722b37c36..57954a63144 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -624,7 +624,10 @@ static void wm8750_realize(DeviceState *dev, Error **errp)
 {
     WM8750State *s = WM8750(dev);
 
-    AUD_register_card(CODEC, &s->card);
+    if (!AUD_register_card(CODEC, &s->card, errp)) {
+        return;
+    }
+
     wm8750_reset(I2C_SLAVE(s));
 }
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 341e91e886f..eee8f33a584 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1302,6 +1302,10 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     DisplaySurface *surface;
     struct audsettings as;
 
+    if (!AUD_register_card("xlnx_dp.audio", &s->aud_card, errp)) {
+        return;
+    }
+
     aux_bus_realize(s->aux_bus);
 
     qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
@@ -1320,8 +1324,6 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = 0;
 
-    AUD_register_card("xlnx_dp.audio", &s->aud_card);
-
     s->amixer_output_stream = AUD_open_out(&s->aud_card,
                                            s->amixer_output_stream,
                                            "xlnx_dp.audio.out",
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index e7960a50696..950506fb382 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -1102,7 +1102,7 @@ static void tsc210x_init(TSC210xState *s,
         s->card.name = g_strdup(current_machine->audiodev);
         s->card.state = audio_state_by_name(s->card.name, &error_fatal);
     }
-    AUD_register_card(s->name, &s->card);
+    AUD_register_card(s->name, &s->card, &error_fatal);
 
     qemu_register_reset((void *) tsc210x_reset, s);
     vmstate_register(NULL, 0, vmsd, s);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 8748c1ba040..d5ac1f8962e 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -944,12 +944,15 @@ static void usb_audio_realize(USBDevice *dev, Error **errp)
     USBAudioState *s = USB_AUDIO(dev);
     int i;
 
+    if (!AUD_register_card(TYPE_USB_AUDIO, &s->card, errp)) {
+        return;
+    }
+
     dev->usb_desc = s->multi ? &desc_audio_multi : &desc_audio;
 
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     s->dev.opaque = s;
-    AUD_register_card(TYPE_USB_AUDIO, &s->card);
 
     s->out.altset        = ALTSET_OFF;
     s->out.vol.mute      = false;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index cafb1a98427..98e071e63bb 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1962,9 +1962,7 @@ static void qemu_create_early_backends(void)
      * setting machine properties, so they can be referred to.
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
-    if (!audio_init_audiodevs()) {
-        exit(1);
-    }
+    audio_init_audiodevs();
 }
 
 
-- 
2.41.0


