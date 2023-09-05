Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFD7921CC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSyf-0004wL-FC; Tue, 05 Sep 2023 06:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdSye-0004vy-2U
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdSya-00068k-DU
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693908483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=458i95STMVj0xZ58IBgIeQG9A3svePa5DHdd5rQPov0=;
 b=MPHWPZSVhvLWbdKQ88o4p2S2dYaQQy7RIj74hc2aDAq3/83ff+WU/wAjXb4DsSZeiKiIXK
 0McDeDdPDZkluxDpG8zNXntuIWCMOaZIYfB2cjBxl087X90uvWxH8ZwQDRXy1UanBkRjPe
 IbrdFdnncIDt3FBLSv2rFssqoAcNais=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-TGDlcXmMOBuv5w5su0hdSQ-1; Tue, 05 Sep 2023 06:08:01 -0400
X-MC-Unique: TGDlcXmMOBuv5w5su0hdSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso1218481f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693908480; x=1694513280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=458i95STMVj0xZ58IBgIeQG9A3svePa5DHdd5rQPov0=;
 b=bzD9y5Cj6615tUKGdOZY/r4lN5T4PIuP18X6UJ4wRVKMnupeSjNx/1kunaqEOci96Z
 kMWa78MbJPUYSzCNzUUdT3ZKgcXhiVIovrXq4m/AS4PEQr5GTeGTAjXFA60jNd/Fqy2F
 iE8JslmcmReN79FqvlDg/pZgVnQMS6emVES3iWNuEAd44bhSswKuNYk/gH7eML0fS1KR
 kc2LNdmQLVFH7rdM6JpUs5zuW4rW4Z9y8NxYDjsEfxdfSwAqGVDm46i3nT+BMatalc/d
 ugzsh4UGciEIS0ZDL6bkAT9cHMU3U5WzSoaZkffREXoxpc8dU+BP9tG4ryPwBGRDFq0b
 oyfw==
X-Gm-Message-State: AOJu0Ywbx54uFJz6tZEF6AHTml/fhaJtUoBkMLUChPNHtmnJekfNRaFy
 r9YrqHK12+KYBfyXvfvWQzYCOJi1peoG+93EsuqdrHx2cU5vYPFp56SESjs4KwOoXQ8IY5+B5Xw
 oolqNoyy8ViWzPy+sMxYha+wZYfnY3wpZP29znPxjMRou/KvXYxlSnelZr+0RV8vJAFWRl4omBI
 0=
X-Received: by 2002:a5d:490a:0:b0:314:1270:8fc with SMTP id
 x10-20020a5d490a000000b00314127008fcmr8984902wrq.0.1693908480095; 
 Tue, 05 Sep 2023 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVfr6NpavIVMsBt5v+M+9Bhmty10ZViSW14k67eljROvof2M9i2TSAaWWnPL4zBOXX6lBt9g==
X-Received: by 2002:a5d:490a:0:b0:314:1270:8fc with SMTP id
 x10-20020a5d490a000000b00314127008fcmr8984883wrq.0.1693908479689; 
 Tue, 05 Sep 2023 03:07:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y8-20020adff148000000b00317c742ca9asm16781575wro.43.2023.09.05.03.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 03:07:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] docs/system/replay: do not show removed command line option
Date: Tue,  5 Sep 2023 12:07:57 +0200
Message-ID: <20230905100757.298689-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-trivial@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/replay.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index 3105327423c..ca7c17c63da 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -181,7 +181,7 @@ Audio data is recorded and replay automatically. The command line for recording
 and replaying must contain identical specifications of audio hardware, e.g.:
 
 .. parsed-literal::
-    -soundhw ac97
+    -audio pa,model=ac97
 
 Serial ports
 ------------
-- 
2.41.0


