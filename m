Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EBA7CD6A3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vY-0002VK-RC; Wed, 18 Oct 2023 04:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vC-0002BU-8b
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vA-0003iC-MZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhz5NoA8No/Gwx+ZeOtjgQ6Cuap6+7hqMf6Rp4/O1Yk=;
 b=hdrsvpi0WYiHf/ao4OAhSR5TtN0xZ0L4gsY/Sa8MXjvNWCKaRLFfJjS0J1xpuSxDsM0GA4
 CLNz4hEWF08KsUC3zw+8CKKSl77sKlOLdn+PuvFbUgq4bDT0rFi4wxQ5MQ4Km/BuHy376u
 CUYxZUw0t3eIRq2HSu258fdjqgmE29o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ZWFP1KLzMP-DlDrq7z7xew-1; Wed, 18 Oct 2023 04:28:50 -0400
X-MC-Unique: ZWFP1KLzMP-DlDrq7z7xew-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b822f5c156so482509166b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617729; x=1698222529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hhz5NoA8No/Gwx+ZeOtjgQ6Cuap6+7hqMf6Rp4/O1Yk=;
 b=LjgH4VxpFfpBnPwgmEntgYXdoGQWxezCNcPylfD0mLUdYWhL6tmF1VeFUywDAqprUy
 ofSDJ0m9T4FJi1mjelSZwjmDTnxSV4caIPqyxE0ZzaRDnMsriJGl8+fzQ2uwmYH6vmHK
 sSaY2qwzyhiBE0aYaJwEgOZIMP0tgu2C/LgSjBiyqMAw1Vbs70GdBFPax5TWTpqriY7e
 EDcdQGRFZtb08vWVUs1cTLI/U2PMcHtPtjZbqjs9qgjuDNZhQDGNdC85zh51+OpgXlwJ
 OHJTU61GQzHUA9FItJpTu2O2JqKJNsgFjIGITQflA6raf7sh1qV2C5i84BAvBJUORlLh
 f/Lw==
X-Gm-Message-State: AOJu0YynunYFhhpo+W4glsHiauZnWweU7LKIH1M/V9X5R3STaxjOOvh0
 Yd7ft5cewJID7UJyhllLXjC0mDmsBPnnTszXleYmk2kesbbl/PqgAK7zyOUynYTJ2rAIDKWvXF+
 xQKQaibDnixsQT69RuQiPcbpvy4OW1zwNUvEHivyGT/y30Z7zYXKcjg72vN9+ieZzAGq2d2huIM
 o=
X-Received: by 2002:a17:907:6ea8:b0:9c4:b8c9:1bf4 with SMTP id
 sh40-20020a1709076ea800b009c4b8c91bf4mr3994345ejc.19.1697617729019; 
 Wed, 18 Oct 2023 01:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwjcHKxxywjM/JYalw+fIB+w5uPB0G58JVCafeJFk895OP+ZeDdCrwGzK+g4NCP87KuyriKg==
X-Received: by 2002:a17:907:6ea8:b0:9c4:b8c9:1bf4 with SMTP id
 sh40-20020a1709076ea800b009c4b8c91bf4mr3994335ejc.19.1697617728709; 
 Wed, 18 Oct 2023 01:28:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a170906579300b0099bd5d28dc4sm1179698ejq.195.2023.10.18.01.28.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] meson-buildoptions: document the data at the top
Date: Wed, 18 Oct 2023 10:27:50 +0200
Message-ID: <20231018082752.322306-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 2e88732a291..4814a8ff61f 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -25,11 +25,15 @@
 import shlex
 import sys
 
+# Options with nonstandard names (e.g. --with/--without) or OS-dependent
+# defaults.  Try not to add any.
 SKIP_OPTIONS = {
     "default_devices",
     "fuzzing_engine",
 }
 
+# Options whose name doesn't match the option for backwards compatibility
+# reasons, because Meson gives them a funny name, or both
 OPTION_NAMES = {
     "b_coverage": "gcov",
     "b_lto": "lto",
@@ -49,6 +53,10 @@
     "werror",
 }
 
+# Builtin options that should be definable via configure.  Some of the others
+# we really do not want (e.g. c_args is defined via the native file, not
+# via -D, because it's a mix of CFLAGS and --extra-cflags); for specific
+# cases "../configure -D" can be used as an escape hatch.
 BUILTIN_OPTIONS = {
     "b_coverage",
     "b_lto",
-- 
2.41.0


