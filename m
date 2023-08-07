Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6647771D0B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwRc-000743-QP; Mon, 07 Aug 2023 05:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwRa-00073v-QS
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwRZ-0005ts-9S
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691400147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VnRSFbs1hM8IZ5PxM2KOh9Xy2iaLP0x3xNbTuk19tGM=;
 b=hDZUEiqNtbomUT+1sSgdKJLWHuCC8f9OVBi1GY/cCTeaeSJSF2Tf/pBU3iuDGHX0stQsHX
 XxczkOholx5NCRFcZRI4kKUBTm5K4TOciUU2qxW0A9tE+EofRchV+4LdRjZfXdJ5Xo8+sT
 out7Z1OI8n/pjHVe4AjLD7NEJdin+Nw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Q5cvtvSdNQCj_3WqWQu04w-1; Mon, 07 Aug 2023 05:22:26 -0400
X-MC-Unique: Q5cvtvSdNQCj_3WqWQu04w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso2143559f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691400145; x=1692004945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnRSFbs1hM8IZ5PxM2KOh9Xy2iaLP0x3xNbTuk19tGM=;
 b=I7VksmNrsOTRMd0eVDn8iSgKXVpB702AV0HyMhLeWZtSEd8bTTvVbIDCj95RD7Y2PK
 yEBjqqtlldhIoPheHQ1u+z+7g0KyYpKOEmaeq5NoYVDT08KvAt5RgGVIFpEcEKQfjo9k
 WZuYEAIaEzQoF4c8vhN6StqTdsUFl7VucaY35ZWXalXydFzmOzCDIWaWpxomtbzv2Yu2
 y5VnvyN8wIyv6KlDyKuTK6teX5hzKvJjWHWEKsI2qrdnou9oCM2JCfJT7fTF+dkGrDBS
 tN0+lfViEMo9v+ahc6YxsM740RxFVI0JNgKaC2HZCNIVsH6MOCbuZF+y8ePHN5k43Y6F
 F0dQ==
X-Gm-Message-State: AOJu0YxWaA70mr/QxcNtjAUYAfo6QhdevzrFHKhtLyt0XGmUQSjKW8hj
 9+MOmpqSqBARmXwDKCUaGbGcGep9YgNyTNiG2JHdPa+LWrAgGeMAUOZhFDstNorNjnKwg+DwT8T
 sx+r0sHyRrzuilVrQamE6sMY+HZnbxurwGr2ZuJxPbOASp+lpSDC+MapKQpkbhhB8IeEzIA8BRD
 4=
X-Received: by 2002:adf:f7c4:0:b0:30f:c42e:3299 with SMTP id
 a4-20020adff7c4000000b0030fc42e3299mr5089571wrq.60.1691400144800; 
 Mon, 07 Aug 2023 02:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1SAZUfWfmmUwRB8g0w7hoCCeEa+Q9aD1NXS8mtb+5xrGLR7scgh0DmpxW3UpqG5NSrSDE/Q==
X-Received: by 2002:adf:f7c4:0:b0:30f:c42e:3299 with SMTP id
 a4-20020adff7c4000000b0030fc42e3299mr5089556wrq.60.1691400144455; 
 Mon, 07 Aug 2023 02:22:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k14-20020adfd84e000000b003177e9b2e64sm9868091wrl.90.2023.08.07.02.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:22:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH for-8.2] configure: fix container_hosts misspellings and
 duplications
Date: Mon,  7 Aug 2023 11:22:22 +0200
Message-ID: <20230807092222.467446-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

container_hosts is matched against $cpu, so it must contain QEMU
canonical architecture names, not Debian architecture names.
Also do not set $container_hosts inside the loop, since it is
already set before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index f5a6624ddf1..0496189787a 100755
--- a/configure
+++ b/configure
@@ -1347,7 +1347,7 @@ probe_target_compiler() {
     sh4) container_hosts=x86_64 ;;
     sparc64) container_hosts=x86_64 ;;
     tricore) container_hosts=x86_64 ;;
-    x86_64) container_hosts="aarch64 ppc64el x86_64" ;;
+    x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
     xtensa*) container_hosts=x86_64 ;;
   esac
 
@@ -1458,7 +1458,6 @@ probe_target_compiler() {
         container_cross_prefix=x86_64-linux-gnu-
         ;;
       xtensa*)
-        container_hosts=x86_64
         container_image=debian-xtensa-cross
 
         # default to the dc232b cpu
-- 
2.41.0


