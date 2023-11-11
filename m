Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDE7E8B62
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvb-0003tB-8E; Sat, 11 Nov 2023 10:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvZ-0003p4-Ca
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvW-0008Ju-Ez
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmUReIKnCgHwKeQ8mgDCHmJ5OYZe6yUipuBRHMuoC1E=;
 b=JkY35ev2ageL2WzANa6dOoZ9p8dJKMlBNjntFugAsZZyGu1YvMex7Ww+BYWM+uJYa12vuV
 EFGYuYIuR66ePcc9SFDZHrcfHtTqimB8Iqg8jK2DCZdXI8zRmpqK6kV1BAvtQy60SKs3pt
 T88Y6wdhNKDMTpzZjXPCtvgfVbxLNPU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-STAzA1yXMlGnw_cpC5_zOA-1; Sat, 11 Nov 2023 10:29:36 -0500
X-MC-Unique: STAzA1yXMlGnw_cpC5_zOA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9e61e969b19so115130766b.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716574; x=1700321374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmUReIKnCgHwKeQ8mgDCHmJ5OYZe6yUipuBRHMuoC1E=;
 b=mWUso/krv32f0ZvU83lU6eOygKtif8sSU79FKbd0zkxbwzgj9GOvN4OJdOGT2QtE+X
 iENehxqHYje/nO/WX33k2fhsVLv5iWJb+PZxEVN79YicQD0U5qzZZY5ClJvqJ602BqxA
 +RYzKrgmTw8wGU2Nn8yvj1gfVIRwINgMAIWahLAQd3DmnmKOX+SvQWouFt8xeFM5i+2j
 xjCGdsurIe4VKDkZAFbw3AQzGa46fR+kR2TfpzsN74jzA3C0g2qcHCbzIYwx6e7XhDIW
 8OQrfuiuCm3K6a0nkYd+kBMxfwTGNFEd1ZSDPDfH4bRLq47cEyhmVIKzvedn+x+83Ux4
 cv7w==
X-Gm-Message-State: AOJu0YzDTmy/8ByOleQGONTDJSUZwl53IsJtWbZxauHUjBoJh4GfllST
 3+syvzZiB0Gh9ZebPWbxPHD40/Nz4dE49qjT0aOh/J4shd4GP7P8pSrgF76J2/2Ho4P7x+QnVzb
 WtJOnTiKHqtxeCN1zZQ4PReZHMJPaDyXhWGVXshlHSXZ/1cJauHdwneRUzWXtv/3DM3g2w5LhV0
 E=
X-Received: by 2002:a05:6402:6c3:b0:543:4fdb:de84 with SMTP id
 n3-20020a05640206c300b005434fdbde84mr1755354edy.7.1699716574704; 
 Sat, 11 Nov 2023 07:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhy75PzPkJDXpy/Mc6F/Q1W/ZMAvXal+kYUnP9W3QuHWYW08AokXIgtww6cwnmaW7CO0tcPg==
X-Received: by 2002:a05:6402:6c3:b0:543:4fdb:de84 with SMTP id
 n3-20020a05640206c300b005434fdbde84mr1755344edy.7.1699716574430; 
 Sat, 11 Nov 2023 07:29:34 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p19-20020aa7d313000000b0053deb97e8e6sm1095621edq.28.2023.11.11.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] buildsys: Bump known good meson version to v1.2.3
Date: Sat, 11 Nov 2023 16:29:21 +0100
Message-ID: <20231111152923.966998-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We need meson v1.2.3 to build QEMU on macOS Sonoma.  It
also builds fine all our CI jobs (as tested by also bumping
"accepted" in pythondeps.toml), so let's use it as our
"good enough" packaged wheel.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231109160504.93677-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/vendor.py                    |   4 ++--
 python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
 python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
 pythondeps.toml                             |   2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl

diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 76274871170..1038b14ae0c 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==0.63.3":
-        "d677b809c4895dcbaac9bf6c43703fcb3609a4b24c6057c78f828590049cf43a",
+        "meson==1.2.3":
+        "4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1",
 
         "tomli==2.0.1":
         "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
diff --git a/python/wheels/meson-0.63.3-py3-none-any.whl b/python/wheels/meson-0.63.3-py3-none-any.whl
deleted file mode 100644
index 8a191e3a200eba6783297676729ec85ceb96f89d..0000000000000000000000000000000000000000
Binary files a/python/wheels/meson-0.63.3-py3-none-any.whl and /dev/null differ
diff --git a/python/wheels/meson-1.2.3-py3-none-any.whl b/python/wheels/meson-1.2.3-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..a8b84e5f114ad3fbec8ae56008426a90bccfc168
GIT binary patch
Binary files /dev/null and b/python/wheels/meson-1.2.3-py3-none-any.whl differ
diff --git a/pythondeps.toml b/pythondeps.toml
index 4beadfd96f5..0e884159993 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
+meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
 
 [docs]
 sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
-- 
2.41.0


