Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435217CD691
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uq-0001gp-4L; Wed, 18 Oct 2023 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uo-0001f5-A1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1um-0003eP-Rx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLArINKdo6Ey6TFV8Luh6W8bJ4ZGOIGe53j+qUGkQVg=;
 b=ieFgjvYihUN6PaeRw6iEpTGFX1dx5CVL1xKkruIE+D/l7fioZLoO6uqPgrSr4JIoa/p/CW
 UVOHJjiumjgwaghWXkkwopSqbYjvK0GYU0gVVMbIXjFvZq8lCyT3o/QHc8nThH1Y6xp2TZ
 FsGc7lngBjVZ7XOAa5X/9uXTFz5Kk28=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-_yYRWlstNYiu6mK1B-xK7A-1; Wed, 18 Oct 2023 04:28:21 -0400
X-MC-Unique: _yYRWlstNYiu6mK1B-xK7A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9be8013f2d1so292905766b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617700; x=1698222500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLArINKdo6Ey6TFV8Luh6W8bJ4ZGOIGe53j+qUGkQVg=;
 b=VBtEqMf8wH+C5UuYzDX+JushJYLzAsJNyw2Vw595lvkoM1xtGgrOGnT07yhF65uBCG
 G27ardjM27tE/Hemd5J842W3gBvcL89QK3hHEPgJj50F3fYhbhv/YFjDjS8F3ZzgcTbk
 7xIciGb5nUpHnzhbJSSWJxKpkE9WAiIo1nzdTiN6vfjCgDu/OxMpDA/MpLBMbQY3g7N4
 HfKydXg2GdOC5UxqYKrCxjLmhQbUuskLaW5LxyTw+uK6YcHg7bMLmHbF+XrapiLf4YG/
 xN+k9/JjutWdonJTvI6TLaX9GFjz1Xz5pdJQs2sPfEYvqZmZvkRoBV/FEIVtdxOMLd4L
 lHIw==
X-Gm-Message-State: AOJu0Yz4JCQGPPOgr5trVKA1iB0+Wanmctdw+cLe3+tWY67XxcAkjyVM
 mLgIWr0mek9hORaPz714EGcSeM7hwcqAzhNzKISl13I9wgKfv9VF2v/RJ3Qxq2jBzVP6bXUgTmN
 iy77FmEdEHCFDpYxEnmgLcqoryxcrtrGsEoGop0BEEaDRspXtg4GkExjkIijh3oe5Ki3dBc0T/8
 w=
X-Received: by 2002:a17:907:7b81:b0:9be:9d5f:6967 with SMTP id
 ne1-20020a1709077b8100b009be9d5f6967mr3454164ejc.69.1697617700207; 
 Wed, 18 Oct 2023 01:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9HjFisCyhljM+i6ujaAanuuLkm4DcJSLab9W1NHEh4oioiHcaV2yCuj8Y42oFYbyUSmNuPA==
X-Received: by 2002:a17:907:7b81:b0:9be:9d5f:6967 with SMTP id
 ne1-20020a1709077b8100b009be9d5f6967mr3454149ejc.69.1697617699769; 
 Wed, 18 Oct 2023 01:28:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 mm27-20020a170906cc5b00b009929ab17be0sm1178768ejb.162.2023.10.18.01.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 13/32] tests/vm: avoid invalid escape in Python string
Date: Wed, 18 Oct 2023 10:27:33 +0200
Message-ID: <20231018082752.322306-14-pbonzini@redhat.com>
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
index 8aef4cff967..61725b83254 100644
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


