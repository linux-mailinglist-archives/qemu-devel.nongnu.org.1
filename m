Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F47925B49
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jul 2024 13:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxow-0004rH-5k; Wed, 03 Jul 2024 07:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxon-0004nn-O6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxoc-0006Ux-VQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A7BB21BB8;
 Wed,  3 Jul 2024 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bn3xHi3lxjssOPgbXjQ9XFBREa5789qaRLPlY+KI8z0=;
 b=qasAejs6aaiCT5iXd75/BTOOnl8gujuEd6L51g82/N0NKfXla6fs/uSbGYRrOaR88WJIiJ
 bkXVHGswDbYw+7PhWCMXAAKPHcVrvXT25Ynk5Iqi9IUqbUXFAYkldIp3YxW5KKmzX5nnAS
 EtEapgYEaQV5q4ltqgnsWZ1JQGBOJL0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bn3xHi3lxjssOPgbXjQ9XFBREa5789qaRLPlY+KI8z0=;
 b=qasAejs6aaiCT5iXd75/BTOOnl8gujuEd6L51g82/N0NKfXla6fs/uSbGYRrOaR88WJIiJ
 bkXVHGswDbYw+7PhWCMXAAKPHcVrvXT25Ynk5Iqi9IUqbUXFAYkldIp3YxW5KKmzX5nnAS
 EtEapgYEaQV5q4ltqgnsWZ1JQGBOJL0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F45413974;
 Wed,  3 Jul 2024 11:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iEsZHaowhWZ6cgAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Jul 2024 11:06:18 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v4 02/17] backends/confidential-guest-support: Add functions
 to support IGVM
Date: Wed,  3 Jul 2024 12:05:40 +0100
Message-ID: <c07dcfe9496a8682bf262bfa6caa180e0eefcce4.1720004383.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720004383.git.roy.hopkins@suse.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

In preparation for supporting the processing of IGVM files to configure
guests, this adds a set of functions to ConfidentialGuestSupport
allowing configuration of secure virtual machines that can be
implemented for each supported isolation platform type such as Intel TDX
or AMD SEV-SNP. These functions will be called by IGVM processing code
in subsequent patches.

This commit provides a default implementation of the functions that
either perform no action or generate an error when they are called.
Targets that support ConfidentalGuestSupport should override these
implementations.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 include/exec/confidential-guest-support.h | 75 +++++++++++++++++++++++
 backends/confidential-guest-support.c     | 31 ++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index 02dc4e518f..4834efbe38 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -21,6 +21,7 @@
 #ifndef CONFIG_USER_ONLY
 
 #include "qom/object.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
@@ -28,6 +29,36 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
                     CONFIDENTIAL_GUEST_SUPPORT)
 
 
+typedef enum ConfidentialGuestPlatformType {
+    CGS_PLATFORM_SEV,
+    CGS_PLATFORM_SEV_ES,
+    CGS_PLATFORM_SEV_SNP,
+} ConfidentialGuestPlatformType;
+
+typedef enum ConfidentialGuestMemoryType {
+    CGS_MEM_RAM,
+    CGS_MEM_RESERVED,
+    CGS_MEM_ACPI,
+    CGS_MEM_NVS,
+    CGS_MEM_UNUSABLE,
+} ConfidentialGuestMemoryType;
+
+typedef struct ConfidentialGuestMemoryMapEntry {
+    uint64_t gpa;
+    uint64_t size;
+    ConfidentialGuestMemoryType type;
+} ConfidentialGuestMemoryMapEntry;
+
+typedef enum ConfidentialGuestPageType {
+    CGS_PAGE_TYPE_NORMAL,
+    CGS_PAGE_TYPE_VMSA,
+    CGS_PAGE_TYPE_ZERO,
+    CGS_PAGE_TYPE_UNMEASURED,
+    CGS_PAGE_TYPE_SECRETS,
+    CGS_PAGE_TYPE_CPUID,
+    CGS_PAGE_TYPE_REQUIRED_MEMORY,
+} ConfidentialGuestPageType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -66,6 +97,40 @@ typedef struct ConfidentialGuestSupportClass {
 
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
     int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
+
+    /*
+     * Check for to see if this confidential guest supports a particular
+     * platform or configuration
+     */
+    int (*check_support)(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary);
+
+    /*
+     * Configure part of the state of a guest for a particular set of data, page
+     * type and gpa. This can be used for example to pre-populate and measure
+     * guest memory contents, define private ranges or set the initial CPU state
+     * for one or more CPUs.
+     *
+     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
+     * context for a virtual CPU. The format of the data depends on the type of
+     * confidential virtual machine. For example, for SEV-ES ptr will point to a
+     * vmcb_save_area structure that should be copied into guest memory at the
+     * address specified in gpa. The cpu_index parameter contains the index of
+     * the CPU the VMSA applies to.
+     */
+    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp);
+
+    /*
+     * Iterate the system memory map, getting the entry with the given index
+     * that can be populated into guest memory.
+     *
+     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
+     */
+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp);
 } ConfidentialGuestSupportClass;
 
 static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
@@ -94,6 +159,16 @@ static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
     return 0;
 }
 
+#define CONFIDENTIAL_GUEST_SUPPORT_CLASS(klass)                \
+    OBJECT_CLASS_CHECK(ConfidentialGuestSupportClass, (klass), \
+                       TYPE_CONFIDENTIAL_GUEST_SUPPORT)
+#define CONFIDENTIAL_GUEST_SUPPORT(obj)           \
+    OBJECT_CHECK(ConfidentialGuestSupport, (obj), \
+                 TYPE_CONFIDENTIAL_GUEST_SUPPORT)
+#define CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(obj)          \
+    OBJECT_GET_CLASS(ConfidentialGuestSupportClass, (obj), \
+                     TYPE_CONFIDENTIAL_GUEST_SUPPORT)
+
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 052fde8db0..68e6fd9d18 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -14,14 +14,45 @@
 #include "qemu/osdep.h"
 
 #include "exec/confidential-guest-support.h"
+#include "qapi/error.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
+static int check_support(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary)
+{
+    /* Default: no support. */
+    return 0;
+}
+
+static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest state is not supported for this platform");
+    return -1;
+}
+
+static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp)
+{
+    error_setg(
+        errp,
+        "Obtaining the confidential guest memory map is not supported for this platform");
+    return -1;
+}
+
 static void confidential_guest_support_class_init(ObjectClass *oc, void *data)
 {
+    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    cgsc->check_support = check_support;
+    cgsc->set_guest_state = set_guest_state;
+    cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
 static void confidential_guest_support_init(Object *obj)
-- 
2.43.0


