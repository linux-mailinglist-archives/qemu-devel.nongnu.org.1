Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A089AB1E301
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 09:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMI-00013c-Ix; Fri, 08 Aug 2025 03:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLw-0000D3-Of
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLp-0007TD-JP
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xR8D/56i1iOxWYX8XCYXfSWlMrLCcRRefnU7ZWTReBE=;
 b=dRxC/hBVz8827Cq+PMWROJ2tKd6RT4z+qpVLfoGgljIDLTxI6MFhdRkWAQZ3kQBaM5Vw8B
 +qEZVDtL/e9Nc/eBJGU7Ro99qCWbZjM8aHlg3+QX3wEIU9FC8q0Buo13Mpg2o5mub245Qg
 k/Crwl/O85IRE7A5iHgKiRNp8L6fDG8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-KzUbm2NLMsSDCjLY3bCgsw-1; Fri, 08 Aug 2025 03:17:13 -0400
X-MC-Unique: KzUbm2NLMsSDCjLY3bCgsw-1
X-Mimecast-MFC-AGG-ID: KzUbm2NLMsSDCjLY3bCgsw_1754637432
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2424aaa9840so19921735ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637432; x=1755242232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xR8D/56i1iOxWYX8XCYXfSWlMrLCcRRefnU7ZWTReBE=;
 b=mmDcKWbW40W4EzY3W0bKISACWTiMCEHCAqPH+TlajKZZ/Uu7sX5Za7BxMldbK80InV
 cn9rQqARzqH68kZGznpn0EpsBaQBPOj18vMHckwd0xETG4Y1wppCY26L06BeZoZpd8Ww
 wShlfZFmuRDceQJ66x5Qsv/JMHpYnAHN/3KYrZHuJ3TfIS3EIUnX+fLo54CTevV4kNMD
 Kc6pGLnbtSvIDolsKzKCy5sYpaLltTFmP4X3NJDO5+fqXDdfwO7kuJgmffH/g9TH5Pn7
 4zFQg5+LIUZ06upYkFGgvuZyTMxMSfYDiMv6x7hUNVX9RyNA+Tw2qcExBFwu7Z5ymBuJ
 y4Ng==
X-Gm-Message-State: AOJu0YyM9U73u9Lw9TJ8Ki8JLkW+A2CVduQzEaFpzDWuH2kFwf+c14h5
 f6zQ2qycUr3C8fjLnn/gz2uI5JQGv0w5dVourkHulmJMaY5mnnBX8mIQ1HE3V6iAyxoh8OofHMc
 gQ8DVo8ifoDfG1pGnM9nimXKV8FqewYGn64x0hhU3+UH0bDaJ9Jzqf1/o
X-Gm-Gg: ASbGncski04mh7UOfXhgPa0NaVq5qZVAH0RwwJDlglIBLhJARiC3raWBJoiZU5WGGMU
 Z4wSZAAueGBeBx9xNVUaiBu2doowJ2V4/1AIzNaIOrcmYwE0WWJObItjoQNeR2z+mRI+O9Qwtua
 2JgK39dyZ20EJYVdxDNzjOQ2EagT2p/gT5VXihWKDrgM8dAQASgaJSKMm5pSwMEjKN7HRl8ziqn
 l2N2ItYRgillwZQ2jEDyg38qIp1aGcEXLJw8qo+L3U1gMpJr6pHfBYkCYvqcXSqAj1RArgIc6mM
 PheiDSc80sQ7Y5zCeDWwl/dMiotc0vbSjc5lAQqsJB+PH1nlFBIjVw==
X-Received: by 2002:a17:903:110f:b0:240:3584:6174 with SMTP id
 d9443c01a7336-242c205e73cmr30044345ad.21.1754637432447; 
 Fri, 08 Aug 2025 00:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7nG0vSxX+dzoskW1hYMKv5WaHMaQUdvMyZh5bcwYZTChgHpi7bvledH4OQhTOwQYz+BXo3g==
X-Received: by 2002:a17:903:110f:b0:240:3584:6174 with SMTP id
 d9443c01a7336-242c205e73cmr30043985ad.21.1754637431756; 
 Fri, 08 Aug 2025 00:17:11 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:43 +0530
Subject: [PATCH v10 17/27] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-17-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=armenon@redhat.com;
 h=from:subject:message-id; bh=gc/oopHWfeZQvmdbFG7kGiD+HQ0JqNNV+Ba/P3FzgFA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVfj13/sebjU6znvBocv+66u65M8Z5d7zOn+t8W2b
 zZ8UplztaOUhUGMi0FWTJGl4WuAbFNAYUSk7cvrMHNYmUCGMHBxCsBETrEw/E9kXWuv/cFQVjjO
 fkmRiuGnuivWkS/lF4pu+Zs0fTfjORWG/xkuPFVhVm8mvtj8Xmt9b4qfz5U3pvczY25ur702fWL
 PITYA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d5082ee1cbce6a870871aaf78ed47707787ffaed..18ca11e14aed906d0b1a7190acd6449f3f117e91 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2628,11 +2628,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.1


