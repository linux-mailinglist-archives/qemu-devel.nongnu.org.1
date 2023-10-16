Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E362B7CA467
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5Q-0007bI-6r; Mon, 16 Oct 2023 05:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5O-0007T4-4S
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5M-0002gd-JC
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ou79WqmD8yS2zOSsjwA8bNuO+KR8sDzpMPHBQmM+hzw=;
 b=E3VVogZ6FmN+avE/iQ4ncziE/9bHceXXSvUIe2m8RkjzxsfmSJIlwSoVsrRHLRMzj7G1//
 KAOsgj9JspY1x8eNT9LuHWretROsHIOgGMKf74bS7OCah+Ft2A+L4Z6X8q6KcgG2thPqO3
 GdyHZNjTXu+kIfWklSqq5IjqJj0s7/g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-L1mL4jPUM_GuWrrsGSzZrg-1; Mon, 16 Oct 2023 05:40:26 -0400
X-MC-Unique: L1mL4jPUM_GuWrrsGSzZrg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so275465466b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449224; x=1698054024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ou79WqmD8yS2zOSsjwA8bNuO+KR8sDzpMPHBQmM+hzw=;
 b=XBfrFVefXGDLhX7dHzh3oCB0IxH97WanTCzzHo+DiF12SvhugKwtWeUq40u8StvWcC
 aqe50uLzob1UvzNrkR9vKlK/3HTx7SjRw6TCsWsi0QEw8TmEUpthOECqJBxfZXd22hPG
 /LZTWUZ3kXTE6zj1Wdvzx84hHGwBZCM3pFFha4HfVEuGylj3QjkM3/hbamImFmMrked1
 H43s+S4y141iXzinyUm1yEDhuW4YCX/+/9kV6er6BP44+qysjUfcLVnw/QaKlaGnSjl2
 9TKGamq6xauRvt/xQkFeCTg/h3U4FvVvgo0E2cxuIuuPDvlRVaE+9lqE8qBWSZR4fkWF
 84Vw==
X-Gm-Message-State: AOJu0YxCaJ3ZH98S5yhv5M6p3UQ+SyAfQYXXoJOgyIvZiLj0V823LSiT
 gBu8PG4fydukMP0FmkZbbImThrwYWGmVaG79HUeQLhXFw1F5i47QHwdfeeK28Ct0HZGd/JmbCWY
 yeyhPnRbkT7sko5Uuz0wC07AqKiLHvOouD23WHThjDVXUgToBFevohsya9NB6KHIcXltIUeVmrd
 c=
X-Received: by 2002:a17:907:1c0d:b0:9bf:f20:876d with SMTP id
 nc13-20020a1709071c0d00b009bf0f20876dmr5256975ejc.75.1697449224570; 
 Mon, 16 Oct 2023 02:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3uwHBiPuKLrWRVyGYo+Pozl1iQJj69ExnuJrGIsSyOnmaVvD2OYG0QKE7Ajo149WxIOFopA==
X-Received: by 2002:a17:907:1c0d:b0:9bf:f20:876d with SMTP id
 nc13-20020a1709071c0d00b009bf0f20876dmr5256958ejc.75.1697449224236; 
 Mon, 16 Oct 2023 02:40:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 30-20020a170906009e00b009ae587ce135sm3682458ejc.223.2023.10.16.02.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:40:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tests/vm: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 11:40:15 +0200
Message-ID: <20231016094016.173598-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

This is an error in Python 3.12; fix it by using a raw string literal
or by double-escaping the backslash.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/basevm.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a97e23b0ce0..6e31698906b 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -331,8 +331,8 @@ def console_init(self, timeout = None):
     def console_log(self, text):
         for line in re.split("[\r\n]", text):
             # filter out terminal escape sequences
-            line = re.sub("\x1b\[[0-9;?]*[a-zA-Z]", "", line)
-            line = re.sub("\x1b\([0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\\[[0-9;?]*[a-zA-Z]", "", line)
+            line = re.sub("\x1b\\([0-9;?]*[a-zA-Z]", "", line)
             # replace unprintable chars
             line = re.sub("\x1b", "<esc>", line)
             line = re.sub("[\x00-\x1f]", ".", line)
@@ -530,7 +530,7 @@ def get_qemu_version(qemu_path):
        and return the major number."""
     output = subprocess.check_output([qemu_path, '--version'])
     version_line = output.decode("utf-8")
-    version_num = re.split(' |\(', version_line)[3].split('.')[0]
+    version_num = re.split(r' |\(', version_line)[3].split('.')[0]
     return int(version_num)
 
 def parse_config(config, args):
-- 
2.41.0


