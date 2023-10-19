Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D317D0407
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:28:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaU3-0006mQ-IO; Thu, 19 Oct 2023 17:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTz-0006UK-Qw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:07 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTx-0001eK-V5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:07 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c50906f941so1671461fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750584; x=1698355384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPCUA2oPZ2wdqytvwya118q0tpbF9WOJR99LmJrLuIo=;
 b=JP4C1oN+LQvxxbPv8VJkBWDbdbs4ScUaXh9CrmLprg9YobphcGcE4sNpJMGhR1kY99
 t10f1OP3NqCxE7xnisWUJyjdItsKm9gINbADv3qJA5NaGNmCXP4ZK0dm4Zkfh4luT+g+
 ptYyMHFuGHcrT+qGPW5s3iJ6x47viHsLXh3KGGDalqlhLYagU17UhnA9ltWgkUSNUgEM
 aziaFi+OZiV6e1/BsaoDC9RZfatuYzn05IhXEWKQ14P8bYCsSJkwILTClLvSKFZkp0E7
 qGVxFzJAS7ufO2Z8OsHI1rICwJctrCoeBI4dmhikzfPCjOqP3M94uqmtyCMfr6VuOOoe
 kViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750584; x=1698355384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPCUA2oPZ2wdqytvwya118q0tpbF9WOJR99LmJrLuIo=;
 b=ts2vF4RunYFs1PjEU3OVWgxZYRnYVSUgVB0lCRtNaPmRaALVXWkONkG0dOMY5nyGAH
 3Bf+mje8fVQE4NfGOeTuVTN0b9YX36xWhCYtvX1DrUVeDViSoFgY72KlnP4LO/J1ff+B
 s0z44oZgpiqVoG4YQP7siSVBzKcD6Dq7DFgAcvNZabJBwG2nM7iNe2qBzoZLcWjsMwwi
 fCmgOO269CzO9R71Uw4c9KBdn4U2HhOB3FJfAlXyqo5jlxxQFeXCc36pzolnDVC/DXfy
 li0wyoO8tCcSXijciGjPy4OvQt+TXsz8gMJPILtZnfXrObOsTHmFGtdqXpKkp9+2KiRj
 sxMA==
X-Gm-Message-State: AOJu0YzSszBjAAMKxJa1Lrd7vupnmRbAY/b7DK7TM6i8u9KW0q1ktHA8
 gd4SFjRPR2NesSk8FJkmavVxNV+Ie6K8AGAwgCyjPQ==
X-Google-Smtp-Source: AGHT+IG2XhW5456/XiUHlU63rrpy3Vx8TiDaL3+bQ4US5wvSn5Gj7EL0pS8tnTdVUuTtivtr9dqftA==
X-Received: by 2002:a2e:b712:0:b0:2c5:47f:8ff7 with SMTP id
 j18-20020a2eb712000000b002c5047f8ff7mr109874ljo.18.1697750583934; 
 Thu, 19 Oct 2023 14:23:03 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm5434839wms.46.2023.10.19.14.23.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:23:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 43/46] hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
Date: Thu, 19 Oct 2023 23:18:08 +0200
Message-ID: <20231019211814.30576-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Access QOM parent with the proper QOM VIRTIO_SCSI_COMMON() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017140150.44995-5-philmd@linaro.org>
---
 hw/scsi/virtio-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..fa53f0902c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -761,7 +761,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
 
 static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
-    VirtIOSCSICommon *vs = &s->parent_obj;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     SCSIDevice *d;
     int rc;
 
-- 
2.41.0


