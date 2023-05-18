Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E1707F6C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbtX-0005GI-W5; Thu, 18 May 2023 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbtT-0005G6-IC
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbtR-0001ZU-JK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684409640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LKimyqQKbKZG0KAGalZV3+3YqE3WmBdF3Y0R/ZIAPYY=;
 b=hhgGxrKf3Q9i7x32t08KemTiMvp4CXnzYjA0I8ebt+VKatAnNDbDDBEEH/IJDewHnrHN3V
 /rgBjA04zKAEKSKOqlVtbsvn6ON6bszh+KaGlVSrx5/zNFWYIKzu3fSo6/vVbjtbZJZ0wn
 zHMyR7nmVOeufk8CI5n4kStufgyeF3w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-N27j9TyLMQCPEfSGtWLQcQ-1; Thu, 18 May 2023 07:33:58 -0400
X-MC-Unique: N27j9TyLMQCPEfSGtWLQcQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so2301566b.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409637; x=1687001637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LKimyqQKbKZG0KAGalZV3+3YqE3WmBdF3Y0R/ZIAPYY=;
 b=H3dj9odnxnHOxlHZlmFQtPCm5fwk/8PnSpxkq+wSFfgT+V51Uxf05s/i8SXMxG1tGf
 TOOk5bbYni/xSWnj03nY8PryZ/Op6TDhVtFXFIYvHDbDDMgmIFiwAlu/KzPKo1Xgcr7U
 U60Utum6R5wWOv2xfVlZQH76H15Dxn9jqk8bUfqHCuNs7NdyBXJrQ8rpWgttBcs/N1zJ
 6G1hkW/8HVlwQnrakfhQmMQzmQjqN0pNHIeQXqww3bUjXeadGnLze/V3VV2eO0/NA7n6
 eAhVJ4LLi+jAC/Bd/rzUd6QxBvIatHHdtr4jwNh9G3WgQk3LyPWb0Bf1rFKzeS2Kg0WQ
 aarQ==
X-Gm-Message-State: AC+VfDz7awwDnNinEYRil5e0jBJJbhddedvJ2hxDNnZnxLCCFJHd1jCs
 kIUGU8Jp9GkBJ0FIH+sfdsFcv6bWnHG8fViRX+eaH58YIgn1YtgrEHfx+CAJlOv6oh3dB5UPQVt
 Xe7W1UVHVvKC4pN4VYw+CpsRhO/WbSsOoCu1ZrCsd+xtQSIPtAzvma7pW2z0CX+xsIJ0YqhprRQ
 4=
X-Received: by 2002:a17:907:e9f:b0:94e:4b26:233c with SMTP id
 ho31-20020a1709070e9f00b0094e4b26233cmr5543655ejc.16.1684409637311; 
 Thu, 18 May 2023 04:33:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ629DhT2KNhgDOkVBiNuN9ZS+foTGo987r5nyzVdeGq2IHPzjGgeBagD+9FP3cLJfmpudWAGw==
X-Received: by 2002:a17:907:e9f:b0:94e:4b26:233c with SMTP id
 ho31-20020a1709070e9f00b0094e4b26233cmr5543639ejc.16.1684409636946; 
 Thu, 18 May 2023 04:33:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170906b28900b00965b0eb7b0csm861683ejz.103.2023.05.18.04.33.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:33:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts: make sure scripts are invoked via $(PYTHON)
Date: Thu, 18 May 2023 13:33:55 +0200
Message-Id: <20230518113355.1006000-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some scripts are invoked via the first "python3" binary in the PATH,
because they are executable and their shebang line is "#! /usr/bin/env
python3".  To enforce usage of $(PYTHON), make them nonexecutable.
Scripts invoked via meson need nothing else, and meson-buildoptions.py
is already using $(PYTHON).  For probe-gdb-support.py however the
invocation in the configure script has to be adjusted.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 2 +-
 scripts/meson-buildoptions.py | 0
 scripts/modinfo-collect.py    | 0
 scripts/modinfo-generate.py   | 0
 scripts/probe-gdb-support.py  | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100755 => 100644 scripts/meson-buildoptions.py
 mode change 100755 => 100644 scripts/modinfo-collect.py
 mode change 100755 => 100644 scripts/modinfo-generate.py
 mode change 100755 => 100644 scripts/probe-gdb-support.py

diff --git a/configure b/configure
index bcab685cfd97..31a787153e38 100755
--- a/configure
+++ b/configure
@@ -1767,7 +1767,7 @@ if test -n "$gdb_bin"; then
     gdb_version=$($gdb_bin --version | head -n 1)
     if version_ge ${gdb_version##* } 9.1; then
         echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-        gdb_arches=$("$source_path/scripts/probe-gdb-support.py" $gdb_bin)
+        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
     else
         gdb_bin=""
     fi
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
old mode 100755
new mode 100644
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
old mode 100755
new mode 100644
diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
old mode 100755
new mode 100644
diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
old mode 100755
new mode 100644
-- 
2.40.1


