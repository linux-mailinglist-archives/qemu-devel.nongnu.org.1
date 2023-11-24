Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C737F77BE
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:26:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2c-0004fu-ST; Fri, 24 Nov 2023 10:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2a-0004fW-TU
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2Z-00049y-8X
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQQMgvxF9SwBnwwizEGgyfuBASfZamZJpC63FmNxYDo=;
 b=XLLlpZk5L/vUjZ/Ks5CD1obDn62DHzA8ySeI6fKLmpHCabUCUtqDe0GxCtOnvhiMSFkZ2A
 +t2J+rSkIG4yH1FPo7Oc6ol67bdj7if+QnsWxw1gcVEQDj60E2fXV+ABlbd5jsvjg1AP1S
 mOOHdsuk0GcWssrv4F+fKyQRiBVxeNs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-dlc5gImoPQWEwF1TmUCGow-1; Fri, 24 Nov 2023 10:24:21 -0500
X-MC-Unique: dlc5gImoPQWEwF1TmUCGow-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42387bd2759so27268301cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839460; x=1701444260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQQMgvxF9SwBnwwizEGgyfuBASfZamZJpC63FmNxYDo=;
 b=oF2yyBW+1BjEtWFiQQPHSfppZBfcBxguM14bHW6AvOoTBKchgwVEn0lBkpjjBka0fU
 6z6084M9SZOeOMIXhDTkMPm5UT/f7fATA9COehwB/lyTjMEMwhNd8t84vLkTJqMXSvCd
 0Qahcu9Zc9l3Jy0JTAu3ndKUZX4tqUt+UNyvI/oXWBPehx675FpkOdftOM55uvuoNWuQ
 67CS6CbnsJ51hG8eFNj2hkZ/vRaE0KpBfwtL61lJBZFyL9JG+7kdOc7lqgYd04pjWGIP
 YylDTSKCGUn4g7tEWMxaoaXfFt1UgEZHmqvn2T+7riYFVG4YfYGS5FoxpFUPEc6pW9+c
 RtJw==
X-Gm-Message-State: AOJu0Yz8CxN8pK0fb//Jl3kqTgER79mKNzzP3aRz1V0LRrG+S+daBu3U
 6rvEDNUkDLdyzejzu+RPO6rQA+jeL7qNz5hZvcKaD7EFsu9fZjIxC18BCYzSW2p00TLSj0P8s/c
 ZHM0cnTsv5noui/bVCIt/Un4ftreIg0I7j/BCHKpOt1nMmPvIamDw8/rw2tonnNnJja/PyKmHpY
 c=
X-Received: by 2002:a05:622a:110:b0:423:6f53:75bb with SMTP id
 u16-20020a05622a011000b004236f5375bbmr4156538qtw.4.1700839460395; 
 Fri, 24 Nov 2023 07:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJfIc9pzKTYhu+VdZpqO3uUD0GsS3ZZLbgwbpf1rMj4TQm+UPUErlabPYdr3SAcKFU5s4LBg==
X-Received: by 2002:a05:622a:110:b0:423:6f53:75bb with SMTP id
 u16-20020a05622a011000b004236f5375bbmr4156495qtw.4.1700839459957; 
 Fri, 24 Nov 2023 07:24:19 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 j16-20020ac86650000000b00423890096afsm1342747qtp.2.2023.11.24.07.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] buildsys: Bump known good meson version to v1.2.3
Date: Fri, 24 Nov 2023 16:24:02 +0100
Message-ID: <20231124152408.140936-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
2.43.0


