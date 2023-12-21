Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825D81BD21
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:23:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMia-0007YA-KB; Thu, 21 Dec 2023 12:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiW-0007WV-8k
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiU-0004TM-Md
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5AFEUYZiaGJSifWk7hneOWRmCiS1T4SWFJVU19lhvA=;
 b=VP9nJvLRYqe7Skf/qmqMvj9D1f0OiXAA0hf14v/g4695CyJ+lWRZ1tV5i+rd8uALRr4+Kw
 RIWpn2uWGEOyDOmbl+wE65benQy69GAQBN3qjOoZwDL1K1T10dvRr/cWEhZQq78efeQVlf
 +34D1nt+889mfiaWUbhMK/BRX/C4EkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-jY0M5jrQOoS8TctKjfggZA-1; Thu, 21 Dec 2023 12:20:11 -0500
X-MC-Unique: jY0M5jrQOoS8TctKjfggZA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c3f0f88e3so7922795e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179210; x=1703784010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5AFEUYZiaGJSifWk7hneOWRmCiS1T4SWFJVU19lhvA=;
 b=i95QaZzgMAtQVD8vt7KL8J4eSxLB0B0hKo2Vzb8jj79zw5k2KEJfruLcOEZ7Hhaegz
 1L30nSgBDBHAqFXQYqTscy2pQpwWcE8Uwmdin4PMc29JEMyspXay6s7fuHX5NrP4rws1
 NT8nSQk1T//gdBP9E9F2ytz/IbsMx7FXrFrQ3LayTn6UlEWma9Qygt9Dn0qGPC83vAim
 Hh8n4JGEiBh38scseTpZUp6M5uS4TokTjb1L6Pjf3iPr6UnIhS4BI0vGs6njb4QFdFHa
 RCFJkX9ahiMAzfW7P/Ed1erEwfrrxQmIFVWxSHphDKOXoqpUOa1Nwwdbrd6YvJCa67dp
 a9+w==
X-Gm-Message-State: AOJu0YxX/jKi6NNpBu4VtIZ6OcLRIDoit3jzc2kJu4uuhL9QYgDlBANa
 qxIgePH40I4UTQVFl9dCcig02QeHtnXH4xO5u82SoD8Ty75fr3yleRpgOy6Fxs7ht6DSza3ObIm
 alhVW/QppTO58aYL6caT+DvXaGvAalITlDLteDkW4S3e8CR3/zQctEzwZnMG7gB+MW9qO8Zqipy
 n+1i0cuFQ=
X-Received: by 2002:a05:600c:a083:b0:40c:4ef8:a9eb with SMTP id
 jh3-20020a05600ca08300b0040c4ef8a9ebmr19829wmb.176.1703179210339; 
 Thu, 21 Dec 2023 09:20:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRsjT+pOYb2E78Zi5b6/1UPsa+viPSqNFC/DYXb6sbBPDTd8d7BURdDbA3DhwuqY2XXsF2Q==
X-Received: by 2002:a05:600c:a083:b0:40c:4ef8:a9eb with SMTP id
 jh3-20020a05600ca08300b0040c4ef8a9ebmr19819wmb.176.1703179209999; 
 Thu, 21 Dec 2023 09:20:09 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4f12000000b00336788c812fsm2455444wru.88.2023.12.21.09.20.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/21] configure: remove unnecessary subshell
Date: Thu, 21 Dec 2023 18:19:42 +0100
Message-ID: <20231221171958.59350-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not use a subshell to hide the shadowing of $config_host_mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 6ea8f53310e..c634948051b 100755
--- a/configure
+++ b/configure
@@ -1671,10 +1671,9 @@ if test "$targetos" = windows; then
 fi
 
 # tests/tcg configuration
-(config_host_mak=tests/tcg/config-host.mak
 mkdir -p tests/tcg
-echo "# Automatically generated by configure - do not modify" > $config_host_mak
-echo "SRC_PATH=$source_path" >> $config_host_mak
+echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
+echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
 
 tcg_tests_targets=
 for target in $target_list; do
@@ -1717,9 +1716,8 @@ for target in $target_list; do
 done
 
 if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_TARGETS=$tcg_tests_targets" >> config-host.mak
+    echo "TCG_TESTS_TARGETS=$tcg_tests_targets" >> $config_host_mak
 fi
-)
 
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
-- 
2.43.0


