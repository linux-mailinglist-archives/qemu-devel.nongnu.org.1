Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F20B20996
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 15:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSAs-00027K-4W; Mon, 11 Aug 2025 09:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ulS9X-0001Ty-Mi
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ulS9V-0005k3-4H
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754917280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elgjpYb2Hkio50MGb3MjwggIEzIK4SdvZFLm1fE7Jpc=;
 b=fjl0TQVr3ZEduSWVt5cPYv5iMFYZt82iynqLWRFcHmYdPWlw5eemktvElw7nHYSc2KB3z/
 4coxT1HBQ+EbCV7OJyygTxz0wBFGRWJMw+3jv/abolpPBCdRyodOAI+T/PZxxH0ur/t8JB
 HWKZygULz0ylbWQInk/Zx3mqAVQUliA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-1mYdFxqdOI2IhI2iC3xDNw-1; Mon,
 11 Aug 2025 09:01:19 -0400
X-MC-Unique: 1mYdFxqdOI2IhI2iC3xDNw-1
X-Mimecast-MFC-AGG-ID: 1mYdFxqdOI2IhI2iC3xDNw_1754917276
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C48F18002E2; Mon, 11 Aug 2025 13:01:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32FC71800446; Mon, 11 Aug 2025 13:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E50C18000A4; Mon, 11 Aug 2025 15:01:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/3] hw/uefi: return success for notifications
Date: Mon, 11 Aug 2025 15:01:08 +0200
Message-ID: <20250811130110.820958-2-kraxel@redhat.com>
In-Reply-To: <20250811130110.820958-1-kraxel@redhat.com>
References: <20250811130110.820958-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set status to SUCCESS for ready-to-boot and exit-boot-services
notification calls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 37d05b71cf70..cbeccdbd2664 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -702,12 +702,14 @@ uint32_t uefi_vars_mm_vars_proto(uefi_vars_state *uv)
     case SMM_VARIABLE_FUNCTION_READY_TO_BOOT:
         trace_uefi_event("ready-to-boot");
         uv->ready_to_boot = true;
+        mvar->status = EFI_SUCCESS;
         length = 0;
         break;
 
     case SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE:
         trace_uefi_event("exit-boot-service");
         uv->exit_boot_service = true;
+        mvar->status = EFI_SUCCESS;
         length = 0;
         break;
 
-- 
2.50.1


