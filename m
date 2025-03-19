Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0DA68EAB
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 15:14:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuAk-0002Bb-6W; Wed, 19 Mar 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuA8-0001h7-UC
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuu9u-0006k1-81
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742393532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwvLMYJeJG02WQ2NmmkQRE/PFhyFux9noPxSQ5LyLLU=;
 b=PhqDDjkqsVaeVMcHS6zGUJ2XyJbIMUuGc5t0Vdezwxit6gBMwXbFQgPG7CUhYbKAVirQEM
 OyNYK11q45m1I5Tsin2mezhUMb0o3kQyp3pPHr4juhAo+SEejIJ8q/Ah2CjInw9qH6875n
 uccr92vsVN4lTnlzgQUFURVFM0AqHpU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-znOt7mIfP3yPAoL_i1xAoA-1; Wed,
 19 Mar 2025 10:12:10 -0400
X-MC-Unique: znOt7mIfP3yPAoL_i1xAoA-1
X-Mimecast-MFC-AGG-ID: znOt7mIfP3yPAoL_i1xAoA_1742393528
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 056461800257; Wed, 19 Mar 2025 14:12:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 704D41800944; Wed, 19 Mar 2025 14:12:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5C83E18003AE; Wed, 19 Mar 2025 15:11:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 3/6] hw/uefi: fix error handling in uefi_vars_json_load
Date: Wed, 19 Mar 2025 15:11:55 +0100
Message-ID: <20250319141159.1461621-4-kraxel@redhat.com>
In-Reply-To: <20250319141159.1461621-1-kraxel@redhat.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Catch lseek errors.  Return on read errors.

Fixes: CID 1593154
Fixes: CID 1593157
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/uefi/var-service-json.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index f1c20a6b8c1e..ad3462cd1557 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -214,7 +214,7 @@ void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
     QObject *qobj;
     Visitor *v;
     char *str;
-    size_t len;
+    ssize_t len;
     int rc;
 
     if (uv->jsonfd == -1) {
@@ -222,7 +222,12 @@ void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
     }
 
     len = lseek(uv->jsonfd, 0, SEEK_END);
+    if (len < 0) {
+        warn_report("%s: lseek error", __func__);
+        return;
+    }
     if (len == 0) {
+        /* empty file */
         return;
     }
 
@@ -231,6 +236,8 @@ void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
     rc = read(uv->jsonfd, str, len);
     if (rc != len) {
         warn_report("%s: read error", __func__);
+        g_free(str);
+        return;
     }
     str[len] = 0;
 
-- 
2.48.1


