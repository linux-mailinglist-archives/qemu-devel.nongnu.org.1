Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576649F678F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 14:44:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLT-0002rS-MJ; Wed, 18 Dec 2024 08:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKu-0001gZ-9i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKq-0005jQ-HC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ebbe804913so975521b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529411; x=1735134211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOTVxfJuvRfeW8gHzVEFV1gFV9NuVJp64I2y0SWwCu4=;
 b=C48p6x25fGJRr4srPIrP5nSUvDkjoL6TxrboQnm2P/dlgBPGpilUZcOqsg2hcFUtei
 dMBGY7Uq/nzQiLWB8Lr3zE2cfCBIAAacP1GvME1qxuKoOk7p1XvbXcOChBWOLqFXdIYs
 VU9CcfGK6qSwMmHwv8ybJVemBSUL5LYK/0eBKR26Yev0Au7hBG8Ia70p/4UB1H5n1ejD
 Q5maYhy2JJTBWGqhoaeMZBHFK63eg0NUhE6aAcw0tJCiyFJ5fvbByIfpQE+zgZn2RhOG
 yKwRkqGPEyZslf3IXRME/HwDfW9EpSgrAWfKyP3nAwpF7ZFTomJk+IdpwTLBvEp1bNK4
 46rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529411; x=1735134211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOTVxfJuvRfeW8gHzVEFV1gFV9NuVJp64I2y0SWwCu4=;
 b=Jncmt4Kr936DdwEzjwXHpr1E5hbg74fYYJvpLqevA8evRaYNDs15ZWOCkeiep9p37F
 WuRdk8qmkbllTskQHG0Om18A7x/Y8VYj/vAoe+mrXv1E9j96hCYN5Y3G//FOKO9osYbU
 YhJk73TG4mmvEbir9DjFF0VCIQ5q0fDF7cV8etTeoCPJOOtI3sRp532stAMuZwlt+V+x
 Zqoxei03ClhysbJ5tkOkaX2AM2KQqHnYR8aoax9Sw2Iw4hQTkZgV+QkEevpFn+iWRdFF
 lr87IcMtHo0ygfbRl4tp4Mz3/BzJncUVo/9PstN3AIAUYWEpv2cDOg3QlhZKxOP6vaHD
 7ZyA==
X-Gm-Message-State: AOJu0Yx9d8rANeWwhJazCAIgLg2l+51L0IPGdEtbJLP1wX5I56Uy8SjD
 F5SK45XaHwaluWQ8XR5Of0CAWLJFAz/Cp5ytEx9uKs3SROMey3E7Z6NPnWFpWeXTDHPYCFE3jiG
 +yHNkuJrf
X-Gm-Gg: ASbGnct5um0CLfOXmLdY6sT5wB9ZVQ2/WDWs5UzuUSSbjpwucXOHjKd5lrvdTdxf0g5
 YHm0sXps4P1dEMP556fntGRUufIOO9WW7DA6Bj4yYrUXpyaZWF6TiPctDEEpQpW7CKHrSqyRxFa
 kNf/vQdDxY7+T/n+LeAqHKxiDereqGTi/QhlVHtat4/WBeceipeZfhTXzRLzwWkSWl0zX7huU1k
 keEq9P4SGB0ie67900BDax3TM2G7T1NFuza3/BSpieGBBjbax6GZixgXi98bW4O
X-Google-Smtp-Source: AGHT+IG2j+mnuacLtFJdf1/fv0JGbnXnmcZfJ1nCcelDjNGQn9rSp7lXnBe1cKn4EtG+yS0OcUpQSQ==
X-Received: by 2002:a05:6808:23ca:b0:3eb:3cca:8829 with SMTP id
 5614622812f47-3eccc097fe8mr1890666b6e.34.1734529410992; 
 Wed, 18 Dec 2024 05:43:30 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 24/24] Constify all opaque Property pointers
Date: Wed, 18 Dec 2024 07:42:51 -0600
Message-ID: <20241218134251.4724-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Via sed "s/  Property [*]/  const Property */".

The opaque pointers passed to ObjectProperty callbacks are
the last instances of non-const Property pointers in the tree.
For the most part, these callbacks only use object_field_prop_ptr,
which now takes a const pointer itself.

This logically should have accompanied d36f165d952 which
allowed const Property to be registered.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 backends/tpm/tpm_util.c          |  4 +-
 hw/block/xen-block.c             |  4 +-
 hw/core/qdev-properties-system.c | 48 ++++++++++----------
 hw/core/qdev-properties.c        | 78 ++++++++++++++++----------------
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/nvme/nguid.c                  |  4 +-
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  4 +-
 hw/vfio/pci-quirks.c             |  4 +-
 9 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index cf138551df..485982b17b 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -46,7 +46,7 @@ static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     TPMBackend *s, **be = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -66,7 +66,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
 
 static void release_tpm(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     TPMBackend **be = object_field_prop_ptr(obj, prop);
 
     if (*be) {
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 56a6713660..ec3413f116 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -485,7 +485,7 @@ static char *disk_to_vbd_name(unsigned int disk)
 static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -545,7 +545,7 @@ static int vbd_name_to_disk(const char *name, const char **endp,
 static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     XenBlockVdev *vdev = object_field_prop_ptr(obj, prop);
     char *str, *p;
     const char *end;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1034e9b580..1bae135276 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -90,7 +90,7 @@ bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
 static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
     const char *value;
     char *p;
@@ -116,7 +116,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
                              void *opaque, bool iothread, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     void **ptr = object_field_prop_ptr(obj, prop);
     char *str;
     BlockBackend *blk;
@@ -225,7 +225,7 @@ static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
 static void release_drive(Object *obj, const char *name, void *opaque)
 {
     DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     BlockBackend **ptr = object_field_prop_ptr(obj, prop);
 
     if (*ptr) {
@@ -269,7 +269,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
     Chardev *s;
     char *str;
@@ -305,7 +305,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
 
 static void release_chr(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
 
     qemu_chr_fe_deinit(be, false);
@@ -329,7 +329,7 @@ const PropertyInfo qdev_prop_chr = {
 static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     MACAddr *mac = object_field_prop_ptr(obj, prop);
     char buffer[2 * 6 + 5 + 1];
     char *p = buffer;
@@ -344,7 +344,7 @@ static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     MACAddr *mac = object_field_prop_ptr(obj, prop);
     int i, pos;
     char *str;
@@ -406,7 +406,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
     char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
 
@@ -417,7 +417,7 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
 static void set_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
@@ -485,7 +485,7 @@ const PropertyInfo qdev_prop_netdev = {
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
     char *p = g_strdup(audio_get_id(card));
 
@@ -496,7 +496,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
     AudioState *state;
     g_autofree char *str = NULL;
@@ -578,7 +578,7 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
                                              const char *name, void *opaque,
                                              Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
     int value;
 
@@ -614,7 +614,7 @@ const PropertyInfo qdev_prop_losttickpolicy = {
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value;
 
@@ -737,7 +737,7 @@ const PropertyInfo qdev_prop_zero_page_detection = {
 static void get_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     char buffer[64];
     char *p = buffer;
@@ -753,7 +753,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
 static void set_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     const char *endptr;
     uint64_t lob, upb;
@@ -815,7 +815,7 @@ const PropertyInfo qdev_prop_reserved_region = {
 static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     g_autofree GenericAlternate *alt;
     int32_t value, *ptr = object_field_prop_ptr(obj, prop);
     unsigned int slot, fn, n;
@@ -895,7 +895,7 @@ const PropertyInfo qdev_prop_pci_devfn = {
 static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
     char buffer[] = "ffff:ff:ff.f";
     char *p = buffer;
@@ -921,7 +921,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
 static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIHostDeviceAddress *addr = object_field_prop_ptr(obj, prop);
     char *str, *p;
     char *e;
@@ -1011,7 +1011,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
 static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
@@ -1045,7 +1045,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
@@ -1093,7 +1093,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
 static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
@@ -1130,7 +1130,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
@@ -1181,7 +1181,7 @@ const PropertyInfo qdev_prop_pcie_link_width = {
 static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
     char buffer[UUID_STR_LEN];
     char *p = buffer;
@@ -1196,7 +1196,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     QemuUUID *uuid = object_field_prop_ptr(obj, prop);
     char *str;
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 61929b2865..434a76f503 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -61,7 +61,7 @@ void *object_field_prop_ptr(Object *obj, const Property *prop)
 static void field_prop_get(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     return prop->info->get(obj, v, name, opaque, errp);
 }
 
@@ -78,7 +78,7 @@ static ObjectPropertyAccessor *field_prop_getter(const PropertyInfo *info)
 static void field_prop_set(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
 
     if (!qdev_prop_allow_set(obj, name, prop->info, errp)) {
         return;
@@ -100,7 +100,7 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
@@ -109,7 +109,7 @@ void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
@@ -131,13 +131,13 @@ const PropertyInfo qdev_prop_enum = {
 
 /* Bit */
 
-static uint32_t qdev_get_prop_mask(Property *prop)
+static uint32_t qdev_get_prop_mask(const Property *prop)
 {
     assert(prop->info == &qdev_prop_bit);
     return 0x1 << prop->bitnr;
 }
 
-static void bit_prop_set(Object *obj, Property *props, bool val)
+static void bit_prop_set(Object *obj, const Property *props, bool val)
 {
     uint32_t *p = object_field_prop_ptr(obj, props);
     uint32_t mask = qdev_get_prop_mask(props);
@@ -151,7 +151,7 @@ static void bit_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *p = object_field_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask(prop)) != 0;
 
@@ -161,7 +161,7 @@ static void prop_get_bit(Object *obj, Visitor *v, const char *name,
 static void prop_set_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -185,13 +185,13 @@ const PropertyInfo qdev_prop_bit = {
 
 /* Bit64 */
 
-static uint64_t qdev_get_prop_mask64(Property *prop)
+static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
     assert(prop->info == &qdev_prop_bit64);
     return 0x1ull << prop->bitnr;
 }
 
-static void bit64_prop_set(Object *obj, Property *props, bool val)
+static void bit64_prop_set(Object *obj, const Property *props, bool val)
 {
     uint64_t *p = object_field_prop_ptr(obj, props);
     uint64_t mask = qdev_get_prop_mask64(props);
@@ -205,7 +205,7 @@ static void bit64_prop_set(Object *obj, Property *props, bool val)
 static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *p = object_field_prop_ptr(obj, prop);
     bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
 
@@ -215,7 +215,7 @@ static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
 static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -237,7 +237,7 @@ const PropertyInfo qdev_prop_bit64 = {
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
@@ -246,7 +246,7 @@ static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     bool *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_bool(v, name, ptr, errp);
@@ -264,7 +264,7 @@ const PropertyInfo qdev_prop_bool = {
 static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -273,7 +273,7 @@ static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -303,7 +303,7 @@ const PropertyInfo qdev_prop_uint8 = {
 static void get_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint16_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
@@ -312,7 +312,7 @@ static void get_uint16(Object *obj, Visitor *v, const char *name,
 static void set_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint16_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint16(v, name, ptr, errp);
@@ -330,7 +330,7 @@ const PropertyInfo qdev_prop_uint16 = {
 static void get_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -339,7 +339,7 @@ static void get_uint32(Object *obj, Visitor *v, const char *name,
 static void set_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -348,7 +348,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
@@ -357,7 +357,7 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int32(v, name, ptr, errp);
@@ -382,7 +382,7 @@ const PropertyInfo qdev_prop_int32 = {
 static void get_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -391,7 +391,7 @@ static void get_uint64(Object *obj, Visitor *v, const char *name,
 static void set_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -400,7 +400,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
 static void get_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
@@ -409,7 +409,7 @@ static void get_int64(Object *obj, Visitor *v, const char *name,
 static void set_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     int64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_int64(v, name, ptr, errp);
@@ -432,7 +432,7 @@ const PropertyInfo qdev_prop_int64 = {
 static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint64(v, name, ptr, errp);
@@ -452,14 +452,14 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
 
 static void release_string(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     g_free(*(char **)object_field_prop_ptr(obj, prop));
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     char **ptr = object_field_prop_ptr(obj, prop);
 
     if (!*ptr) {
@@ -473,7 +473,7 @@ static void get_string(Object *obj, Visitor *v, const char *name,
 static void set_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     char **ptr = object_field_prop_ptr(obj, prop);
     char *str;
 
@@ -507,7 +507,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value = *ptr;
 
@@ -517,7 +517,7 @@ void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
 static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
     uint64_t value;
 
@@ -557,7 +557,7 @@ struct ArrayElementList {
  * specific element of the array. Arrays are backed by an uint32_t length field
  * and an element array. @elem points at an element in this element array.
  */
-static Property array_elem_prop(Object *obj, Property *parent_prop,
+static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
@@ -582,7 +582,7 @@ static Property array_elem_prop(Object *obj, Property *parent_prop,
  */
 static void release_prop_array(Object *obj, const char *name, void *opaque)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elem = *arrayptr;
@@ -609,7 +609,7 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
@@ -685,7 +685,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     ERRP_GUARD();
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elemptr = *arrayptr;
@@ -928,7 +928,7 @@ void qdev_prop_set_globals(DeviceState *dev)
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
@@ -937,7 +937,7 @@ static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_size(v, name, ptr, errp);
@@ -1020,7 +1020,7 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
 
     char buffer[1024];
     char *ptr = buffer;
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 0419f648b7..dbd9b58a4e 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -641,7 +641,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *events = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint32(v, name, events, errp)) {
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 829832bd9f..be63cb75e1 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -149,7 +149,7 @@ static void nvme_nguid_stringify(const NvmeNGUID *nguid, char *out)
 static void get_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
     char buffer[NGUID_STR_LEN];
     char *p = buffer;
@@ -162,7 +162,7 @@ static void get_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
     char *str;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b2d5327dbf..4e27b2961b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2463,7 +2463,7 @@ void css_reset(void)
 static void get_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CssDevId *dev_id = object_field_prop_ptr(obj, prop);
     char buffer[] = "xx.x.xxxx";
     char *p = buffer;
@@ -2492,7 +2492,7 @@ static void get_css_devid(Object *obj, Visitor *v, const char *name,
 static void set_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     CssDevId *dev_id = object_field_prop_ptr(obj, prop);
     char *str;
     int num, n1, n2;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5fbbf41a3d..94b1a5f639 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1453,7 +1453,7 @@ static void s390_pci_device_reset(DeviceState *dev)
 static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint32(v, name, ptr, errp);
@@ -1463,7 +1463,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     S390PCIBusDevice *zpci = S390_PCI_DEVICE(obj);
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint32_t *ptr = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint32(v, name, ptr, errp)) {
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index d37f722cce..c8e60475d5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1499,7 +1499,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -1509,7 +1509,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    Property *prop = opaque;
+    const Property *prop = opaque;
     uint8_t value, *ptr = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint8(v, name, &value, errp)) {
-- 
2.43.0


