Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3147775675
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVv-0004bD-Tn; Wed, 09 Aug 2023 05:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVs-0004YZ-1W
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVn-0003bJ-P7
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKkMMfp5f5GTO9zq5/sFXGqZZ9jl8Y+uDOHINW2MhH4=;
 b=iTp4pYMX2s4ffAePtGgAnBSJg9lhaJ2k+WnIJ2dLXRzBBEsyu6Fj1XgJy9wdFQsgAI9DFk
 Bdl3ZYaIzJ8yZain95n//hiGnS/9oEcm0KyJI8l1kaMjTGFcNdtrMPsoYr9rqv4Af2BvA3
 2EEyTKYksWLX3JXefcOUWjKmYqvQqgk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-nm6u6oFzOVexRTwZuYiDLg-1; Wed, 09 Aug 2023 05:29:48 -0400
X-MC-Unique: nm6u6oFzOVexRTwZuYiDLg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe661c0323so9412845e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573387; x=1692178187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKkMMfp5f5GTO9zq5/sFXGqZZ9jl8Y+uDOHINW2MhH4=;
 b=a7p0+ZifRcboRYVDqx75TbDUSteK9k2MUkQNSsOhwHf/Xq+Kgp/RQTfStYXEmIhQvd
 jPwQWXtTpu2+zGjXNosB0RIx4Gdp5CmfSQPfPozrIgkEJ471IT1r9gaIdqMEhgKsMMU7
 YD7nO6FkqFfnCphOQG+5+y82TWAtwyUK0VZokTS+2y4oMOOpm2r3Z2C77lhLnm4Grg1c
 1TTcod7cV3br4k9w+AGRhCTVgtlU6vSccF3PqfOlTyrd8woTcbCNqEquMxAHu+SoGIIT
 Z5R+84ZevHa9KuB62KY1+6M45wWk/T+k9a1hgQsV5h8MX7wiF7Cdhe02EZlcCzMQEla2
 eRyg==
X-Gm-Message-State: AOJu0YyIQoYTJWjbSKnNW/jaoZtaZi8hhRJIjDXHcCWAU3g6TcFNXx3W
 gxoaZAiKCTr08unWN3SU6NPRjD6kqyrknm3QHCEwdfPzgQ5UmqFgFoOj/470d4LShYigWfN7q3y
 50x0q0arxvlbvmyLRyFCYZ4vMfGDRag+1givmrRuNOsn9of50ypXnXPzm4dNKeAhYD43s+5BAxg
 o=
X-Received: by 2002:a05:600c:253:b0:3fe:687a:abad with SMTP id
 19-20020a05600c025300b003fe687aabadmr1622401wmj.20.1691573386625; 
 Wed, 09 Aug 2023 02:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzC1uv+eAYKcXsUN0IhbB4WqjDM8Ifpscm6RSUeP+z7My/H3hRcJqTuYZFFv9hkjPK6QF0WQ==
X-Received: by 2002:a05:600c:253:b0:3fe:687a:abad with SMTP id
 19-20020a05600c025300b003fe687aabadmr1622382wmj.20.1691573386026; 
 Wed, 09 Aug 2023 02:29:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c210a00b003fc02e8ea68sm1417504wml.13.2023.08.09.02.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 6/9] python: use vendored tomli
Date: Wed,  9 Aug 2023 11:29:30 +0200
Message-ID: <20230809092933.761524-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Debian only introduced tomli in the bookworm release.  Use a
vendored wheel to avoid requiring a package that is only in
bullseye-backports and is also absent in Ubuntu 20.04.

While at it, fix an issue in the vendor.py scripts which does
not add a newline after each package and hash.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                  |   6 ++++++
 python/scripts/vendor.py                   |   5 ++++-
 python/wheels/tomli-2.0.1-py3-none-any.whl | Bin 0 -> 12757 bytes
 3 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl

diff --git a/configure b/configure
index f13f0662b98..347153702c1 100755
--- a/configure
+++ b/configure
@@ -1018,6 +1018,12 @@ fi
 python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
+# Finish preparing the virtual environment using vendored .whl files
+
+if $python -c 'import sys; sys.exit(sys.version_info >= (3,11))'; then
+    $mkvenv ensure --dir "${source_path}/python/wheels" \
+        'tomli>=1.2.0' || exit 1
+fi
 if ! $mkvenv ensure \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 34486a51f44..76274871170 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -43,13 +43,16 @@ def main() -> int:
     packages = {
         "meson==0.63.3":
         "d677b809c4895dcbaac9bf6c43703fcb3609a4b24c6057c78f828590049cf43a",
+
+        "tomli==2.0.1":
+        "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
 
     with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8") as file:
         for dep_spec, checksum in packages.items():
-            file.write(f"{dep_spec} --hash=sha256:{checksum}")
+            print(f"{dep_spec} --hash=sha256:{checksum}", file=file)
         file.flush()
 
         cli_args = [
diff --git a/python/wheels/tomli-2.0.1-py3-none-any.whl b/python/wheels/tomli-2.0.1-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..29670b98d16e2bc770d4fea718582e1dc0dd8aca
GIT binary patch
literal 12757
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

literal 0
HcmV?d00001

-- 
2.41.0


