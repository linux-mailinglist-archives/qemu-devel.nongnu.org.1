Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCD820A82
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:49:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUJ-0005e2-7I; Sun, 31 Dec 2023 03:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSu-00054j-IX
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSl-0000qR-W6
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XK6DAxWXNsgvVSkC/R4Wt2WjAVosUDj04x7U0VkU+5k=;
 b=ND9UnVN+tMhefRVppW58Fpjei1bPFc2MGKcj4xAsHV3mYtpMxs3q75U9KFvPvKop0VF7IS
 XRN6yFci1432+O9fVenAyfek5VinHFhMFk4TjI/4W4XXSh+m77unTjWQa2fuhpT/VYw6ht
 jZmmxmwxydP/qA1Axo3Q+7S+chpJ9V0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-5y--UkWXN1-oEMTMFbEq-g-1; Sun, 31 Dec 2023 03:46:25 -0500
X-MC-Unique: 5y--UkWXN1-oEMTMFbEq-g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-336937af9e9so3517614f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012383; x=1704617183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK6DAxWXNsgvVSkC/R4Wt2WjAVosUDj04x7U0VkU+5k=;
 b=Q3kC7GmyPPrKFD6Xcd+w2kPGGewP0FpVUFY+nbdq81fYBRzYR0qkxOQnFiZvpCsj8J
 otECAA1wp331EjYBOxaO2zmPk768CdK8rC2OcPfpsHQfbtzPDvJM/UhYlqWApcDkQuo5
 bI4dBXX2ZlfBfDxgV02ZO1jPq6Ncn26hEZF80fa8d94dbA49OAz4i4oJ/97q96iWoZDD
 XDkNwELtzyRhYg4uCXvoVZaS1HLrYGyWCRh4qcWLIh8Ow0NiVuNIho9/fGukQBLVlbs5
 wjb9gP538mBMqm2zaVLXaB1ORIbPY/LTDHs43h/QeFqPSke50cYBG2AoIE/eHmabUjca
 BMBg==
X-Gm-Message-State: AOJu0Yy52tm7oa3dxu03/kKSTCH9NcBNHrh0SJyIrQA8tyrBOsyZxEDm
 AQZufPgzLx6qf8Gf6xM0N+JgoGqvqmQn4YJD0WP3X3p0tvUjji6bCK8WD4q4sxHI+Ow9dpJWLnt
 j5hF9I1mh9rjCpkb3XuCGMi7Cd3Ps+sVKNDtga158WqSq43NEr3SxVauNUMN2BiCLauJQyljs/+
 uogrR5b9s=
X-Received: by 2002:a5d:6281:0:b0:336:80dc:bbcc with SMTP id
 k1-20020a5d6281000000b0033680dcbbccmr6441070wru.52.1704012383409; 
 Sun, 31 Dec 2023 00:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWxx05N5kvDBdN8nl+kOyq7p3ksqcKSSVItLl6Vl0AK16QrNQj7Vt0UI+QeM32WtVwEessPw==
X-Received: by 2002:a5d:6281:0:b0:336:80dc:bbcc with SMTP id
 k1-20020a5d6281000000b0033680dcbbccmr6441066wru.52.1704012383118; 
 Sun, 31 Dec 2023 00:46:23 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfec88000000b0033672971fabsm23049254wrn.115.2023.12.31.00.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/46] configure: remove unnecessary subshell
Date: Sun, 31 Dec 2023 09:44:45 +0100
Message-ID: <20231231084502.235366-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 9885cfed792..ed2d220040d 100755
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


