Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8FA044AF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Jan 2025 16:35:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBau-00037e-HT; Tue, 07 Jan 2025 10:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBar-00036Y-3x
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBap-00053E-Dn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJ/oGwKUkmWyexNQEwby0Nfm4jUz5BbqBK6Rvm1+Xzc=;
 b=FiIO13CthDXDD6fJoMpXuc45ItL90NTpp0CL/AuUE5qWvdOW//8CoSjl2iCcr4nGwcoadJ
 kQgEwQDBzQhvmG97Cz5cjkzjFE0HU9Fn2InJ8Ak9alqEwpIJ22DKS4f9pQ+nFGwancsxw6
 tJiyFB2SVg97vN4vKC3IiFpyY6MumBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-4DaALzO2OuukTaYS_HLweA-1; Tue,
 07 Jan 2025 10:34:03 -0500
X-MC-Unique: 4DaALzO2OuukTaYS_HLweA-1
X-Mimecast-MFC-AGG-ID: 4DaALzO2OuukTaYS_HLweA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E6B1955F3A; Tue,  7 Jan 2025 15:34:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E119019560A2; Tue,  7 Jan 2025 15:33:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 992ED18003A5; Tue, 07 Jan 2025 16:33:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 03/21] hw/uefi: add include/hw/uefi/var-service.h
Date: Tue,  7 Jan 2025 16:33:30 +0100
Message-ID: <20250107153353.1144978-4-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add state structs and function declarations for the uefi-vars device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/uefi/var-service.h | 186 ++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 include/hw/uefi/var-service.h

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
new file mode 100644
index 000000000000..e078d2b0e68f
--- /dev/null
+++ b/include/hw/uefi/var-service.h
@@ -0,0 +1,186 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi-vars device - state struct and function prototypes
+ */
+#ifndef QEMU_UEFI_VAR_SERVICE_H
+#define QEMU_UEFI_VAR_SERVICE_H
+
+#include "qemu/uuid.h"
+#include "qemu/queue.h"
+
+#include "hw/uefi/var-service-edk2.h"
+
+#define MAX_BUFFER_SIZE (64 * 1024)
+
+typedef struct uefi_variable uefi_variable;
+typedef struct uefi_var_policy uefi_var_policy;
+typedef struct uefi_vars_state uefi_vars_state;
+
+typedef struct uefi_vars_cert uefi_vars_cert;
+typedef struct uefi_vars_hash uefi_vars_hash;
+typedef struct uefi_vars_siglist uefi_vars_siglist;
+
+struct uefi_variable {
+    QemuUUID                          guid;
+    uint16_t                          *name;
+    uint32_t                          name_size;
+    uint32_t                          attributes;
+    void                              *data;
+    uint32_t                          data_size;
+    efi_time                          time;
+    void                              *digest;
+    uint32_t                          digest_size;
+    QTAILQ_ENTRY(uefi_variable)       next;
+};
+
+struct uefi_var_policy {
+    variable_policy_entry             *entry;
+    uint32_t                          entry_size;
+    uint16_t                          *name;
+    uint32_t                          name_size;
+
+    /* number of hashmarks (wildcard character) in name */
+    uint32_t                          hashmarks;
+
+    QTAILQ_ENTRY(uefi_var_policy)     next;
+};
+
+struct uefi_vars_state {
+    MemoryRegion                      mr;
+    uint16_t                          sts;
+    uint32_t                          buf_size;
+    uint32_t                          buf_addr_lo;
+    uint32_t                          buf_addr_hi;
+    uint8_t                           *buffer;
+    QTAILQ_HEAD(, uefi_variable)      variables;
+    QTAILQ_HEAD(, uefi_var_policy)    var_policies;
+
+    /* boot phases */
+    bool                              end_of_dxe;
+    bool                              ready_to_boot;
+    bool                              exit_boot_service;
+    bool                              policy_locked;
+
+    /* storage accounting */
+    uint64_t                          max_storage;
+    uint64_t                          used_storage;
+
+    /* config options */
+    char                              *jsonfile;
+    int                               jsonfd;
+    bool                              force_secure_boot;
+    bool                              disable_custom_mode;
+};
+
+struct uefi_vars_cert {
+    QTAILQ_ENTRY(uefi_vars_cert)  next;
+    QemuUUID                      owner;
+    uint64_t                      size;
+    uint8_t                       data[];
+};
+
+struct uefi_vars_hash {
+    QTAILQ_ENTRY(uefi_vars_hash)  next;
+    QemuUUID                      owner;
+    uint8_t                       data[];
+};
+
+struct uefi_vars_siglist {
+    QTAILQ_HEAD(, uefi_vars_cert)  x509;
+    QTAILQ_HEAD(, uefi_vars_hash)  sha256;
+};
+
+/* vars-service-guid.c */
+extern const QemuUUID EfiGlobalVariable;
+extern const QemuUUID EfiImageSecurityDatabase;
+extern const QemuUUID EfiCustomModeEnable;
+extern const QemuUUID EfiSecureBootEnableDisable;
+
+extern const QemuUUID EfiCertSha256Guid;
+extern const QemuUUID EfiCertSha384Guid;
+extern const QemuUUID EfiCertSha512Guid;
+extern const QemuUUID EfiCertRsa2048Guid;
+extern const QemuUUID EfiCertX509Guid;
+extern const QemuUUID EfiCertTypePkcs7Guid;
+
+extern const QemuUUID EfiSmmVariableProtocolGuid;
+extern const QemuUUID VarCheckPolicyLibMmiHandlerGuid;
+
+extern const QemuUUID EfiEndOfDxeEventGroupGuid;
+extern const QemuUUID EfiEventReadyToBootGuid;
+extern const QemuUUID EfiEventExitBootServicesGuid;
+
+/* vars-service-utils.c */
+gboolean uefi_str_is_valid(const uint16_t *str, size_t len,
+                           gboolean must_be_null_terminated);
+size_t uefi_strlen(const uint16_t *str, size_t len);
+gboolean uefi_str_equal_ex(const uint16_t *a, size_t alen,
+                           const uint16_t *b, size_t blen,
+                           gboolean wildcards_in_a);
+gboolean uefi_str_equal(const uint16_t *a, size_t alen,
+                        const uint16_t *b, size_t blen);
+char *uefi_ucs2_to_ascii(const uint16_t *ucs2, uint64_t ucs2_size);
+int uefi_time_compare(efi_time *a, efi_time *b);
+void uefi_trace_variable(const char *action, QemuUUID guid,
+                         const uint16_t *name, uint64_t name_size);
+void uefi_trace_status(const char *action, efi_status status);
+
+/* vars-service-core.c */
+extern const VMStateDescription vmstate_uefi_vars;
+void uefi_vars_init(Object *obj, uefi_vars_state *uv);
+void uefi_vars_realize(uefi_vars_state *uv, Error **errp);
+void uefi_vars_hard_reset(uefi_vars_state *uv);
+
+/* vars-service-json.c */
+void uefi_vars_json_init(uefi_vars_state *uv, Error **errp);
+void uefi_vars_json_save(uefi_vars_state *uv);
+void uefi_vars_json_load(uefi_vars_state *uv, Error **errp);
+
+/* vars-service-vars.c */
+extern const VMStateDescription vmstate_uefi_variable;
+uefi_variable *uefi_vars_find_variable(uefi_vars_state *uv, QemuUUID guid,
+                                       const uint16_t *name,
+                                       uint64_t name_size);
+void uefi_vars_set_variable(uefi_vars_state *uv, QemuUUID guid,
+                            const uint16_t *name, uint64_t name_size,
+                            uint32_t attributes,
+                            void *data, uint64_t data_size);
+void uefi_vars_clear_volatile(uefi_vars_state *uv);
+void uefi_vars_clear_all(uefi_vars_state *uv);
+void uefi_vars_update_storage(uefi_vars_state *uv);
+uint32_t uefi_vars_mm_vars_proto(uefi_vars_state *uv);
+
+/* vars-service-auth.c */
+bool uefi_vars_is_sb_pk(uefi_variable *var);
+bool uefi_vars_is_sb_any(uefi_variable *var);
+efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
+                                  mm_variable_access *va, void *data);
+efi_status uefi_vars_check_secure_boot(uefi_vars_state *uv, uefi_variable *var);
+void uefi_vars_auth_init(uefi_vars_state *uv);
+
+/* vars-service-pkcs7.c */
+efi_status uefi_vars_check_pkcs7_2(uefi_variable *siglist,
+                                   void **digest, uint32_t *digest_size,
+                                   mm_variable_access *va, void *data);
+
+/* vars-service-siglist.c */
+void uefi_vars_siglist_init(uefi_vars_siglist *siglist);
+void uefi_vars_siglist_free(uefi_vars_siglist *siglist);
+void uefi_vars_siglist_parse(uefi_vars_siglist *siglist,
+                             void *data, uint64_t size);
+uint64_t uefi_vars_siglist_blob_size(uefi_vars_siglist *siglist);
+void uefi_vars_siglist_blob_generate(uefi_vars_siglist *siglist,
+                                     void *data, uint64_t size);
+
+/* vars-service-policy.c */
+extern const VMStateDescription vmstate_uefi_var_policy;
+efi_status uefi_vars_policy_check(uefi_vars_state *uv,
+                                  uefi_variable *var,
+                                  gboolean is_newvar);
+void uefi_vars_policies_clear(uefi_vars_state *uv);
+uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
+                                      variable_policy_entry *pe);
+uint32_t uefi_vars_mm_check_policy_proto(uefi_vars_state *uv);
+
+#endif /* QEMU_UEFI_VAR_SERVICE_H */
-- 
2.47.1


