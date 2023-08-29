Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D278C042
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6g-0002dh-Km; Tue, 29 Aug 2023 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6c-0002ci-Ts
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6W-0008Q1-FH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FG4l56w7PVcMl8GBpWCdbsM/10Bco9m9+W4L22ZsEjQ=;
 b=a0VtsR5WXOTtucMft4EJOs6aF1/TPPP2fbiT66qNx2G97WQgplrCOvzD/VxrT34Z0I+ib3
 7+IeTV4Qqft3ERsXRyGaPG1s7lunfvCuUeIk4Gt0z8SBQaXGxVENLV+j88/kbLp5nc3qFv
 L3GOPHNW5PItRs0oWuJm5ms+8pac5+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-xlWp7LzLOXKgYQ-pJqG3rw-1; Tue, 29 Aug 2023 04:29:37 -0400
X-MC-Unique: xlWp7LzLOXKgYQ-pJqG3rw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c879c41f4so1668577f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297775; x=1693902575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FG4l56w7PVcMl8GBpWCdbsM/10Bco9m9+W4L22ZsEjQ=;
 b=htio66Socs74mW1ou3fNKFzW2ZnQY39lEPVmt3p1HwpUErJOzAlCjGmSwuq3n8HpxQ
 qdTxZZfXAbuJ1C7FIqJynFnURdtVMqXn/dbSZtBjwzlEYk7eNyywpdtnGewNnoqNyoDy
 OlIsh+Lb6CCE1A6/0ycM58oIDgq+scyAmODWcwARpXBVrDCN4uvqZaj6MVDdC2cNDZF4
 bUy6IjRn+ihSnVTD1wYdzyuix+HlvLrXiTHWsn8WxKGvpacbdTZaUOm0i+Qqvbmn+Jbn
 ZV91Tp6vsvald27i/utdBzNhOiN7TzYWx5FSFWV0GDo/2kVwIjaWyt/8TX1MB0VLl/gW
 yL7A==
X-Gm-Message-State: AOJu0YwOD0j/EZstcehZ3MG5ifB7jaf3FGPa1c2RSTtvyEXCbkbG8ICE
 JPCUMd8waD8ymtEUYfn0AapGpSsTtpTCbc+44vS5r5RTJ8UB54Ei69Nk8A93nrIoy9H1QrPoZDb
 14BRTm4RsgGmyrRQ1SZakkBo786aztVKFpq2kBvm5lbSPXDwd37L5jGfQfOAxYqTtYRJB0GsPL8
 0=
X-Received: by 2002:a5d:6a43:0:b0:317:f7b0:85f with SMTP id
 t3-20020a5d6a43000000b00317f7b0085fmr19443195wrw.33.1693297775651; 
 Tue, 29 Aug 2023 01:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRfAbNHz+m2+OsmrTr3DksdkxPxB8QDKuyTa+C/A4sdl9Hb8vlhvOctYysheBTwxk4GR3/iw==
X-Received: by 2002:a5d:6a43:0:b0:317:f7b0:85f with SMTP id
 t3-20020a5d6a43000000b00317f7b0085fmr19443186wrw.33.1693297775270; 
 Tue, 29 Aug 2023 01:29:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a5d6a88000000b0031431fb40fasm12949098wru.89.2023.08.29.01.29.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] meson: do not unnecessarily use cmake for dependencies
Date: Tue, 29 Aug 2023 10:29:22 +0200
Message-ID: <20230829082931.67601-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

Both gvnc and sysprof-capture come with pkg-config files, so specify
the method to find them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration/meson.build | 2 +-
 tests/qtest/meson.build     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index ac71f132901..a91aa61c659 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,4 +1,4 @@
-sysprof = dependency('sysprof-capture-4', required: false)
+sysprof = dependency('sysprof-capture-4', method: 'pkg-config', required: false)
 glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
                          method: 'pkg-config', static: true)
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b071d400b37..df63909ee51 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -321,7 +321,7 @@ qtests = {
 }
 
 if vnc.found()
-  gvnc = dependency('gvnc-1.0', required: false)
+  gvnc = dependency('gvnc-1.0', method: 'pkg-config', required: false)
   if gvnc.found()
     qtests += {'vnc-display-test': [gvnc]}
     qtests_generic += [ 'vnc-display-test' ]
-- 
2.41.0


