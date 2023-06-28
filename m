Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18372741B28
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3V-0001MK-JK; Wed, 28 Jun 2023 17:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3K-0001Jn-K3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3J-0008Q3-7m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wMxl19wPT6NOIYdfEthE3CTENPdu0RlUwoU249Hq90=;
 b=DINCsajt9LRTGrEJ/QXK25bXTbAS1q4nl2KhT+TIv7hdBjVSN1ZRgb2NrTtME/8fFpO+9V
 Rs1+i9xXQ1y7nJ/sO0sq0UouRT2Yyc86GTb7wbNKVGONqi+BrOLA3+lHM+NFZYHMEzs6Ke
 EOAF7BFWpSntDGu7f+F/xpWOrDz78MQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-0vFcQnnEOueCKhwG6dAjyQ-1; Wed, 28 Jun 2023 17:50:12 -0400
X-MC-Unique: 0vFcQnnEOueCKhwG6dAjyQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3a1f0f175f8so3144b6e.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989011; x=1690581011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wMxl19wPT6NOIYdfEthE3CTENPdu0RlUwoU249Hq90=;
 b=hW6X4s9/V+H15eaoO34tAZ2G3S5jHXxpxg/xGj9ZoCjN5VRTbNuXD8rNGJV6qmIoe5
 zHJ5ISeq72WlwgxvGyVD9dAMeXGX+WAfpXqQTypBMEyr9oqvA0gq36kV+6BNW4kCm93A
 j9NvPuxBUEb+3kTWfOD0Vlwu8tLxTd1u75YhyhEgc5XFMSwQX9FLrz24qA6t8gW0k/RG
 gxPzmhQC+L1g29izNk5q38zSGrC0H5CPcwoL52+yJnix5XBFwvM2O2aZcvr3X1rxA9xc
 bm6enUo0WcSjzWLrYpO9nUyKkJbxVRJ2tDhrClW/KqqB1I6Ro7fpwvl4A3MmLJWAJobB
 ytDQ==
X-Gm-Message-State: AC+VfDxYYqrtL1/LnrIIIgFp5iwwB3csVDdwiGb1yC/j86/98NyrO+g4
 9ooemGpBLcJsqMdjwaxNRMGQoW2pzakjANTrCV8WHHgx7MkkneM1hqLkcUolckY51oP4V2zMzE9
 6UOcGIswtCq0PjKwimQeDTV5j1GguB/iy/wVgEgXAFDxyB4yk4vpnSIRv3T0/p9L6j2U+nfgk
X-Received: by 2002:aca:b956:0:b0:3a1:ebb8:396a with SMTP id
 j83-20020acab956000000b003a1ebb8396amr879700oif.2.1687989011376; 
 Wed, 28 Jun 2023 14:50:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JqIs26rdIsHa5vAoH3Zji4TcLkG7DaKD57OALkh4PeQJzHwjZ4eSiMDNlVlveJF3Vtuivhg==
X-Received: by 2002:aca:b956:0:b0:3a1:ebb8:396a with SMTP id
 j83-20020acab956000000b003a1ebb8396amr879682oif.2.1687989011101; 
 Wed, 28 Jun 2023 14:50:11 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 7/7] migration: Provide explicit error message for file
 shutdowns
Date: Wed, 28 Jun 2023 17:50:02 -0400
Message-ID: <20230628215002.73546-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Provide an explicit reason for qemu_file_shutdown()s, which can be
displayed in query-migrate when used.

This will make e.g. migrate-pause to display explicit error descriptions,
from:

"error-desc": "Channel error: Input/output error"

To:

"error-desc": "Channel is explicitly shutdown by the user"

in query-migrate.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 419b4092e7..ff605027de 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
      *      --> guest crash!
      */
     if (!f->last_error) {
-        qemu_file_set_error(f, -EIO);
+        Error *err = NULL;
+
+        error_setg(&err, "Channel is explicitly shutdown by the user");
+        qemu_file_set_error_obj(f, -EIO, err);
     }
 
     if (!qio_channel_has_feature(f->ioc,
-- 
2.41.0


