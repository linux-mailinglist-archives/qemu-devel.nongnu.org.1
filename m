Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A057BD7E8
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn73-0003SO-Qj; Mon, 09 Oct 2023 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6h-0003A7-Mo
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6Y-0000AO-SL
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso43225225e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845792; x=1697450592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcautlB5vSVFo4vMCX8wZDEeLw5WS31TyE81+hqdwZU=;
 b=LqiENubTzJbwxZmhmbciLJv3+8ZiwzmAevxrBHFuBtw9bQtm4bV8KQdaLtQpTaZwvP
 cI3kBPm6NRqHGc7t13QEv7WrZDYcsXDOYnvmW77HVHwVi8gpxwyy2T3i5rUcf9zvM8Za
 9dGrpeA0enPcuDbMi+Yh44/bmyrQAuMvKnNDKJlapdWNatvVQjpoF/G1Y6Z6Zw9Q6gpz
 cgi7jK15DWKpeOQOA053Uv3FSMzFhd7q/UqKJASSMJvoPKMV3jX7dVhGX5mr5Hleq1qd
 VzNLpGeU8tJqMCvDyXw6WMKB6nZ9SBbhuYlxURI0dBoIa4zvhrg+NQNr4vlOMrUnqqi9
 MbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845792; x=1697450592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcautlB5vSVFo4vMCX8wZDEeLw5WS31TyE81+hqdwZU=;
 b=QfDpylCBDGsA8/dc7eUzGVSrp6d8/iLnd46DTC5a7jnC92x2KP5Pf4i6/E/yuFHGt4
 XxECR/3Ag44JFS5s7d1Z0m/cp2UUPaleZQZx52lDuzyH4eu11aYUeBweUwlvbZ5xLIM8
 T10szT4Ojjhoo7vYE6Czkp8UIJBfH+fyK/H8GeF1W3cfsv/+M9R0+2UZ3HdONQd63ja2
 nb5FDY6kbteiIGrzdvdtrTzxwJQ9MLzWbQvDs3qvJZmD+f8lWcZ3An9x0a9nfy8u4tzF
 eI1KyS4yvaa0e5D1bjdlhIvvMp5c2EWcivOUmxWLTf1TLnIcnd6YyMvqJCN1ROG3HdPH
 LDxQ==
X-Gm-Message-State: AOJu0Yy8inhV4S05TZK8l52daR2Z2cGOuzp2roFZk+b3PeuAsDLAZdEH
 Nm9UIfjLRXTcpv54MHGURxJsEdR5EtOEOJ4AjnM=
X-Google-Smtp-Source: AGHT+IECNxLaTShJTwYGhhlueGvaDGtPvWyJV+BbpMnax0WiFV0cp3rSzo95fjNM0tE0lAyPZPioqA==
X-Received: by 2002:a05:600c:2191:b0:405:36a0:108f with SMTP id
 e17-20020a05600c219100b0040536a0108fmr14034470wme.41.1696845791966; 
 Mon, 09 Oct 2023 03:03:11 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm13067525wms.24.2023.10.09.03.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/10] tests/virtio-scsi: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 12:02:44 +0200
Message-ID: <20231009100251.56019-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Rename the (unused) 'allow' argument, following the pattern
used by the other tests in this file. This fixes:

  tests/qtest/virtio-scsi-test.c:159:61: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
                                                              ^
  tests/qtest/virtio-scsi-test.c:37:25: note: previous declaration is here
  static QGuestAllocator *alloc;
                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/virtio-scsi-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index ceaa7f2415..db10d572d0 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -156,7 +156,7 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev)
     return vs;
 }
 
-static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
+static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QTestState *qts = global_qtest;
 
-- 
2.41.0


