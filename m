Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14153C27EDB
	for <lists+qemu-devel@lfdr.de>; Sat, 01 Nov 2025 14:05:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFBHF-0005xY-Or; Sat, 01 Nov 2025 09:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFBH6-0005wn-43
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:04:09 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFBH0-00084G-Fc
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:04:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so632102866b.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762002226; x=1762607026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b8Wz6OTI3qMLX+37jfR3HdovQsKSn1kwKhUTx0OAFC0=;
 b=QteLnzMwUN2ql0VRQeKXuaX8SnJk74MtvbpyoDVhLm62KTezfXe3jCf78w41MV1lGc
 YeeIFJeUhbC9iSqll7Q71cd+EWWImQ6ybWkIC6H3GyMXVP6QFTMnr3MryIgy6RHl6pEf
 1O8rayUA0meb1cm3A9WUNqQnEHhllS/z9kv1CODwiJsOAyj3NJHSqY8qApEgocV8jroM
 W3u4EsoeZv3aC37+Cdwz9CyZs2wCcUWbgqSZGM/vjdKYwDiIVBVUYucKfuF/aK4i2t9X
 pfmxirdadL632BzF1K47AmEfvXg9cQzGV7475QX5jLDm3+1u2wpyuNsNMIS44vomj1P3
 wh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762002226; x=1762607026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8Wz6OTI3qMLX+37jfR3HdovQsKSn1kwKhUTx0OAFC0=;
 b=IeMt1qrKEOUAhF9cbY13ximEQvtvZ1nzoTWkVyQ50rkB26AnXW+XSmxGdS3snTNbbM
 h5pz+kHbbDHIj0k1t4z//4nFcjyuupKF214J1Y8iXZ4llexoq7EvIqNmhUSioiHYwJLa
 AWSTY54D9RCspxOiTlrGflTL+eAv4+YEtfxjpqk+d8ZXjRpWBOV/DHuhvKcdO1210IMG
 +eLUWvDjB84bOJfTVQPPM7ZvjoSJoHJePzLQ3M7Mhe0OTU7W4REL9e/riqeVHNtqeJLw
 Gdpm4pWyG3lhIR2AtnUATQPxo1RFsHAOOCpGgAEGQJ+EZKquUp9E/Od+xi5O5PXtN79M
 ax7Q==
X-Gm-Message-State: AOJu0YxmsdcT8LjuGTFRByRW/L+x68lS1omR8meVe2/Y40taON3l7TyX
 KfUAzoE2nuNLK+sKwrrme9N/sSD+XM4F+APq6tA9c3AyXlp8UImEzF93NWfDdw==
X-Gm-Gg: ASbGncso2DGpqarn8xL173F6VXFKHDTcThxhFfMWxSiXONzqI+8+KFo57i7wd+ykq1W
 ldfWv3vxo/jioFJ4OxBOJT+big+7pPnwaLfegFfUyucCcC8Rl39fWCTJCmIQTqdkeOxMaPUcgfk
 IcXL/JZDlVKamyqIDI/KamocARhqAtT4HA7NbAPkiQbo0GD1NdGS+7h59m/2T5xw8t45a0t3nso
 WGsCjsYcyV5nzZArnxjk9621SMr6U/OJF5dFC924nzrtg1ybmn/725DhoQks4JAIhb2YxsAFpLb
 MhKX8FmaX29vOt+FG/V0S4spkmR3BptRmTEFp1TZEg+5lyMNbbKFSZ0Pdq1PBZ1xsv3GnBkcY7g
 AtzFUkC4JVtsVm+klnRISqGyEJmBLJVGZgi9jLvl2ZRt3PteDe3IepBE30Mmgoj5I5GJWN6hrlk
 Y38ZEnhb9F0SQnx0MQlnQBnKLb6mO/XdBx
X-Google-Smtp-Source: AGHT+IFxfHqqIxFNb+6w3uAfW/REllCtH9BOY1/GqKE9rnqWrrpCyUKzMLh2R52yKqKI8ubTV1yjPQ==
X-Received: by 2002:a17:907:6eab:b0:b54:981c:405c with SMTP id
 a640c23a62f3a-b7070874d90mr638869366b.65.1762002226184; 
 Sat, 01 Nov 2025 06:03:46 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3e067sm459295966b.45.2025.11.01.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 06:03:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] qga/vss-win32/install: Remove _com_util::ConvertStringToBSTR()
Date: Sat,  1 Nov 2025 14:03:30 +0100
Message-ID: <20251101130330.1927-1-shentey@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that MSYS2 provides an implementation of the function it clashes with
QEMU's, resulting in a compilation error. Remove it since it doesn't seem
to be used anyway.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 qga/vss-win32/install.cpp | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 7b25d9098b..147bf387fd 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -548,25 +548,6 @@ STDAPI DllUnregisterServer(void)
 }
 
 
-/* Support function to convert ASCII string into BSTR (used in _bstr_t) */
-namespace _com_util
-{
-    BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
-        int len = strlen(ascii);
-        BSTR bstr = SysAllocStringLen(NULL, len);
-
-        if (!bstr) {
-            return NULL;
-        }
-
-        if (mbstowcs(bstr, ascii, len) == (size_t)-1) {
-            qga_debug("Failed to convert string '%s' into BSTR", ascii);
-            bstr[0] = 0;
-        }
-        return bstr;
-    }
-}
-
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
 {
-- 
2.51.2


