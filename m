Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328807B8E22
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8aW-0004Rh-6w; Wed, 04 Oct 2023 16:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8aQ-0004RW-JL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8aD-00023D-Cc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zlOj7GbVpzulZHNd3lOjzg5ksKZ21Mzc3rDM65AgJc=;
 b=Ce6CkQGhhAH5hSB9Bvh0ArSTvXCWcMxg4ql6aoMvHXP+44ZFtD3Ggjx4jH3lepHgAVEqLN
 t3/W4mvnN8piYdNU0hUBZrjLfN81dFJ6xhzUtM9EtTZraS+EajeOx/6xwCcMew8s6YlcWs
 WFfYfYSdWl/DFFnYpYA4gHYrSmuOFDQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-ktEpcaB0PWCnvUjBK7Cqcw-1; Wed, 04 Oct 2023 16:34:58 -0400
X-MC-Unique: ktEpcaB0PWCnvUjBK7Cqcw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65b1c33bf59so1621026d6.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451697; x=1697056497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zlOj7GbVpzulZHNd3lOjzg5ksKZ21Mzc3rDM65AgJc=;
 b=M8qOboB0Ehf0FOau3s0Ys1eRgF2B1zwlpkUKYzbXe7WqFoMbeZ3QMmWsdS/whUq9AX
 kn5NLEsIzWqgQDljZ6X6ckwkUZafPxQXZ8Zw629+qmAGFkXmlaqVcR26t7uTXhJAP9UM
 hI4pRRV0FKtlCcwyLbYvFgIrTNOT9JdX1UHICG++ZpHPjbXpV3bqTPXwyMcqgbvZIE4P
 yfNjAa9CGoNFKpF5jO5KbQP65fdxsGSOlIEvISuTAt5drKHtUXaZ8cNlhQHBvcg5LbW7
 GfPhylkPVT2j9xCocxHcwkbRvM4R8A0cQgaqeIKVn1ZRIZc6jl7DflHoNM3FFAwYGkAj
 OXYQ==
X-Gm-Message-State: AOJu0YwsnhiY6m5Vot1JnllAZn72wb1l4tV5erGn45vi+vFCdGy4kVI6
 ls5JganMAWZUNklFzwWBpEscdlyqjz2ZTTNwFAD81Av0UbSUsPqtSkWSd+0A0ZPEIp2LokGhAwv
 bTlyWkl3of/Rrdp2xC5T60VW/ugdkQAIEfhJnYk5kXlY/8vMFAfP5bHDlodmVAqoI2gjl0HAS5w
 Npow==
X-Received: by 2002:a0c:e308:0:b0:635:e0dd:db4b with SMTP id
 s8-20020a0ce308000000b00635e0dddb4bmr3338599qvl.37.1696451697335; 
 Wed, 04 Oct 2023 13:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx/i+PF9Z4MUTbX3tksH0c46gSPTz/V8m82O3wQ17fXZknm2N7kQ0xf1VELtioQC67UOG7cA==
X-Received: by 2002:a0c:e308:0:b0:635:e0dd:db4b with SMTP id
 s8-20020a0ce308000000b00635e0dddb4bmr3338583qvl.37.1696451697037; 
 Wed, 04 Oct 2023 13:34:57 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:56 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 9/9] i386/sev: Replace SEV_ATTESTATION_REPORT with sev
 library equivalent
Date: Wed,  4 Oct 2023 16:34:18 -0400
Message-Id: <20231004203418.56508-10-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004203418.56508-1-tfanelli@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The LAUNCH_ATTESTATION ioctl fetches the guest VM's attestation report
from the PSP.

If the API ioctl call fails, fw_error will be set accordingly.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 target/i386/sev.c | 81 ++++++++++-------------------------------------
 target/i386/sev.h |  2 ++
 2 files changed, 18 insertions(+), 65 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 764a89d3a4..bedb8f379e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -160,27 +160,6 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
-static int
-sev_ioctl(int fd, int cmd, void *data, int *error)
-{
-    int r;
-    struct kvm_sev_cmd input;
-
-    memset(&input, 0x0, sizeof(input));
-
-    input.id = cmd;
-    input.sev_fd = fd;
-    input.data = (__u64)(unsigned long)data;
-
-    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
-
-    if (error) {
-        *error = input.error;
-    }
-
-    return r;
-}
-
 static int
 sev_platform_ioctl(int fd, int cmd, void *data, int *error)
 {
@@ -629,75 +608,47 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
     return sev_get_capabilities(errp);
 }
 
-static SevAttestationReport *sev_get_attestation_report(const char *mnonce,
-                                                        Error **errp)
+SevAttestationReport *qmp_query_sev_attestation_report(const char *mnonce_b64,
+                                                       Error **errp)
 {
-    struct kvm_sev_attestation_report input = {};
     SevAttestationReport *report = NULL;
-    SevGuestState *sev = sev_guest;
-    g_autofree guchar *data = NULL;
-    g_autofree guchar *buf = NULL;
-    gsize len;
-    int err = 0, ret;
+    g_autofree guchar *data = NULL, *mnonce = NULL;
+    gsize len, data_len;
+    int ret, fw_error;
+    KVMState *s = kvm_state;
 
     if (!sev_enabled()) {
         error_setg(errp, "SEV is not enabled");
         return NULL;
     }
 
-    /* lets decode the mnonce string */
-    buf = g_base64_decode(mnonce, &len);
-    if (!buf) {
+    mnonce = g_base64_decode(mnonce_b64, &len);
+    if (!mnonce) {
         error_setg(errp, "SEV: failed to decode mnonce input");
         return NULL;
     }
 
-    /* verify the input mnonce length */
-    if (len != sizeof(input.mnonce)) {
-        error_setg(errp, "SEV: mnonce must be %zu bytes (got %" G_GSIZE_FORMAT ")",
-                sizeof(input.mnonce), len);
+    if (len != SEV_ATTESTATION_REPORT_MNONCE_SIZE) {
+        error_setg(errp, "SEV: mnonce must be %d bytes (found %" G_GSIZE_FORMAT ")",
+            SEV_ATTESTATION_REPORT_MNONCE_SIZE, len);
         return NULL;
     }
 
-    /* Query the report length */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
-            &input, &err);
-    if (ret < 0) {
-        if (err != SEV_RET_INVALID_LEN) {
-            error_setg(errp, "SEV: Failed to query the attestation report"
-                             " length ret=%d fw_err=%d (%s)",
-                       ret, err, fw_error_to_str(err));
-            return NULL;
-        }
-    }
-
-    data = g_malloc(input.len);
-    input.uaddr = (unsigned long)data;
-    memcpy(input.mnonce, buf, sizeof(input.mnonce));
-
-    /* Query the report */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
-            &input, &err);
+    ret = sev_attestation_report(s->vmfd, mnonce, len, (void *) data,
+                                (unsigned int *) &data_len, &fw_error);
     if (ret) {
         error_setg_errno(errp, errno, "SEV: Failed to get attestation report"
-                " ret=%d fw_err=%d (%s)", ret, err, fw_error_to_str(err));
-        return NULL;
+          " ret = %d fw_err=%d (%s)", ret, fw_error, fw_error_to_str(fw_error));
     }
 
     report = g_new0(SevAttestationReport, 1);
-    report->data = g_base64_encode(data, input.len);
+    report->data = g_base64_encode(data, data_len);
 
-    trace_kvm_sev_attestation_report(mnonce, report->data);
+    trace_kvm_sev_attestation_report((char *) mnonce, report->data);
 
     return report;
 }
 
-SevAttestationReport *qmp_query_sev_attestation_report(const char *mnonce,
-                                                       Error **errp)
-{
-    return sev_get_attestation_report(mnonce, errp);
-}
-
 static int
 sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 {
diff --git a/target/i386/sev.h b/target/i386/sev.h
index f1af28eca0..a90909450c 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -48,6 +48,8 @@ bool sev_es_enabled(void);
 #define sev_es_enabled() 0
 #endif
 
+#define SEV_ATTESTATION_REPORT_MNONCE_SIZE 16
+
 uint32_t sev_get_cbit_position(void);
 uint32_t sev_get_reduced_phys_bits(void);
 bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
-- 
2.40.1


