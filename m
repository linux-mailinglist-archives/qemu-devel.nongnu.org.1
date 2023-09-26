Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E607AF176
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQ9-0002gY-8R; Tue, 26 Sep 2023 13:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPK-00021J-8G
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPI-0006cO-FP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M07xDw6TXMyJHjZ2y4nMSfqsVz0WjNJ4Em8wo+xhqKI=;
 b=F1fyR75A76vCAMVJ0WTcr7S3Ae8GGBqOgnqqyjGjJ8+RrwTEFzmVZ/kNE2oBf9Gp2NXF9D
 rdhSUocuSixECMQVAU6aRV/N9ASrMSzteK+RiTzkzC+PjcNr/L1hxjfEgffZk0Kt5R3skm
 vufbZsn66E3jsBxSlSwp9Z1cTc7ndhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-lpOYZFuoPim-7gXZChtBgA-1; Tue, 26 Sep 2023 12:59:29 -0400
X-MC-Unique: lpOYZFuoPim-7gXZChtBgA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so84085285e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747567; x=1696352367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M07xDw6TXMyJHjZ2y4nMSfqsVz0WjNJ4Em8wo+xhqKI=;
 b=FGollEF98wQ6hcNI86+ivmQObhCFDRPgTfABB1w0145h1b/UGxtJb/4KA6OQs7jBKk
 JQUMEucoIFF3OTsDNiaxCNeRGsYbT64UaUhjTpK41Oix9y95EDTaOax6DOa0zF1G4snr
 f0iqzTydrbGeof0/2Y1kdDdaQ7nd/klTmZISJOUnH1HTpFKi37mpr6bBq0Osveo5CNpx
 tyDr9jJYr9cXnVjCPul0iBPqZd4FaRCTi6jgeAuVnxJnkgL/aBTLv66d2bcpACzWsJ6Y
 rbyd2Y2bPt1iWZa1alTXRlvVhPFBlVifrgJggpZBnee9v333pNkKaGnPmovoEpQ3Y21Q
 ad7A==
X-Gm-Message-State: AOJu0YxMI/Me+mTV6E6m3azhlIHgTvqR34E/CZsSC1iy2Ncqe7o+8C13
 2r7C5kp4a6A6EuQYl9EbqOyNibsYgCb/7s5OJUYKwXzFTD9LzIcClZi7svmQU4UzpgC5+Kj7SDN
 MjUqRT69Fnu1ew8StpuDmNulFXmi7mJIytfNChZoUrec6i25AQdGaeBGSHJKTqRW9N1aC5B7zWg
 w=
X-Received: by 2002:a05:600c:22c7:b0:401:c436:8999 with SMTP id
 7-20020a05600c22c700b00401c4368999mr9452834wmg.30.1695747567529; 
 Tue, 26 Sep 2023 09:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGkYlg+Q0ZYQ97LmE+hykWSIykhOHndQp80lnHaoixt6reZ9DUbMnjrcNr4/yIv/tpaHeLSA==
X-Received: by 2002:a05:600c:22c7:b0:401:c436:8999 with SMTP id
 7-20020a05600c22c700b00401c4368999mr9452814wmg.30.1695747567069; 
 Tue, 26 Sep 2023 09:59:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c205400b00403b63e87f2sm2837617wmg.32.2023.09.26.09.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/19] vl: remove shadowed local variables
Date: Tue, 26 Sep 2023 18:59:01 +0200
Message-ID: <20230926165915.738719-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index db04f98c36f..59a472a0b10 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3214,7 +3214,6 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             case QEMU_OPTION_watchdog_action: {
-                QemuOpts *opts;
                 opts = qemu_opts_create(qemu_find_opts("action"), NULL, 0, &error_abort);
                 qemu_opt_set(opts, "watchdog", optarg, &error_abort);
                 break;
@@ -3525,16 +3524,16 @@ void qemu_init(int argc, char **argv)
                 break;
             case QEMU_OPTION_compat:
                 {
-                    CompatPolicy *opts;
+                    CompatPolicy *opts_policy;
                     Visitor *v;
 
                     v = qobject_input_visitor_new_str(optarg, NULL,
                                                       &error_fatal);
 
-                    visit_type_CompatPolicy(v, NULL, &opts, &error_fatal);
-                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts);
+                    visit_type_CompatPolicy(v, NULL, &opts_policy, &error_fatal);
+                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts_policy);
 
-                    qapi_free_CompatPolicy(opts);
+                    qapi_free_CompatPolicy(opts_policy);
                     visit_free(v);
                     break;
                 }
-- 
2.41.0


