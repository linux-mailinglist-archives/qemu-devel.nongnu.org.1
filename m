Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2E7B666B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncep-0004w4-7u; Tue, 03 Oct 2023 06:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnceo-0004vw-1X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qncel-0007Ab-RS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696328970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hc5QZngQ+EztSteTyqW+F+G/LVfZt7WyxLIeehY2Wxw=;
 b=fEGaFF70nWTx5R1AgUAH3Q1f1axZthsBUtq8bZSybxDsyi8enz11iBw6yO7ndBQajMns0S
 7aUsg9GkgfqfZa/7KEO4iUsPyK1b634i/NoPzl3OcVfzGj9sNNsUuNMakhaOuQSpEPZ/NL
 hLJrms1UekgU3YY213gjPR65ZEpwTwE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-p7aQIrR5PK-N-Rtl-eLmOg-1; Tue, 03 Oct 2023 06:29:29 -0400
X-MC-Unique: p7aQIrR5PK-N-Rtl-eLmOg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c625a7c507so7314855ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696328968; x=1696933768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hc5QZngQ+EztSteTyqW+F+G/LVfZt7WyxLIeehY2Wxw=;
 b=iU4yfENAenr7sN0uaoEvDh+3H5YaSkYYjF0j/Nm+fqcDpm0/+0QGB954IlXn8x17B3
 KvhmTqR3+tDvEG+JxqjNXRW6mSw+RYLwxz1eo5KDPB1EU1Jqc1T9uHbj2ZLwam0TaDH2
 z6eJeXiZDMY8EPiNlhLHzFvBD07fh5j2xFWskRSjsOkTKxASzpAAZqNJdl/zOb0bgpOw
 ssficGShqL9Z49mQTD8Ey0Zhb1tDkcrHzMz4f7wL6weykUFL5t8pKpwH/gei4OdTrUZV
 PI3WCQy0q9GAITUG+My9Fsqfu6myirbeUFbHFta9M0tCcvubDeVXQURGhTqkobYm0DjI
 Ephw==
X-Gm-Message-State: AOJu0YwrMX5tVQ7/clO1wci9XMXqpQsBAJnRW7E6+LjmYhsXOW8WXixO
 njcJT1PkXJoW4QbeHaD3KcBmGuEDy6WLBCUut0EONCN8qkXFG+jqO6gWi4fFAjwRrKRVfi4I+kK
 R62XdNBEaUbruaC8=
X-Received: by 2002:a17:903:2587:b0:1c2:218c:3762 with SMTP id
 jb7-20020a170903258700b001c2218c3762mr9903284plb.42.1696328967864; 
 Tue, 03 Oct 2023 03:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExxymt8bXe6IGFVykvmQr9oj2EeOM4nv4iry5iqYa02MS+6x/yR7kbWe1IIVPhwPm0se6lAw==
X-Received: by 2002:a17:903:2587:b0:1c2:218c:3762 with SMTP id
 jb7-20020a170903258700b001c2218c3762mr9903265plb.42.1696328967492; 
 Tue, 03 Oct 2023 03:29:27 -0700 (PDT)
Received: from localhost.localdomain ([115.96.159.31])
 by smtp.googlemail.com with ESMTPSA id
 je17-20020a170903265100b001bdd7579b5dsm1150767plb.240.2023.10.03.03.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 03:29:27 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/i386: changes towards enabling -Wshadow=local for x86
 machines
Date: Tue,  3 Oct 2023 15:58:02 +0530
Message-ID: <20231003102803.6163-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Code changes that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.

See also

   Subject: Help wanted for enabling -Wshadow=local
   Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
   https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org

CC: Markus Armbruster <armbru@redhat.com>
CC: Philippe Mathieu-Daude <philmd@linaro.org>
CC: mst@redhat.com

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/acpi-microvm.c | 4 ++--
 hw/i386/pc.c           | 1 -
 hw/i386/x86.c          | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

changelog:
v3: split the patches. Peter's changes are now in a seperate patch.
Addressed mst's suggestions. Removed message-ID
from commit log and added the reference to previous discussion thread
explicitly.
v2: kept Peter's changes from https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
and removed mine.

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index a075360d85..6ddcfb0419 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
-        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
+        Object *obj = object_dynamic_cast(OBJECT(kid->child),
+                                          TYPE_VIRTIO_MMIO);
 
         if (obj) {
             VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f31..e7a233e886 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = machine->device_memory->base;
 
         if (!pcmc->broken_reserved_end) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f034df8bf6..b3d054889b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        MachineState *ms = MACHINE(x86ms);
-
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-- 
2.42.0


