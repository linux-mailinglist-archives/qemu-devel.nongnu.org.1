Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23A82F289
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmWK-0000Ae-1r; Tue, 16 Jan 2024 11:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rPmW4-0008V3-Tz
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rPmW1-0005gq-2y
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705423332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DAO0gCB6l8jlk8++XPiJaILDLy7aS+Uormld+N4JZek=;
 b=DGZWlEmmeDYFF91lgiZ0uP7QS7n3TdfavMkQeVcmbOehON/C+li6A2dW8XobTBO2aLgx1m
 Yzo9dDRbXNsOiA9jxgdSIY584hjbq8lHBJfikmZgN3VN6k2yJKyuWXY1g60uBQm//dOZMx
 ZINjbbGa28gFx5xPV9JpdnBEwjJp4rs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-S_nsAw-JNjmCOmgDjvY3hQ-1; Tue, 16 Jan 2024 11:42:11 -0500
X-MC-Unique: S_nsAw-JNjmCOmgDjvY3hQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-598dfff253bso2358147eaf.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423330; x=1706028130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DAO0gCB6l8jlk8++XPiJaILDLy7aS+Uormld+N4JZek=;
 b=g0P2E0YJmPwm3fGyR4bdBJajKaS7vYxtJI30gc619Ma0qV4/ijedvxG4A+YmpAlHB9
 OcFr3wNRmgGuT5PPr2u9KBpkOC1bgs1WL9nPDDUXXo+JXl+nR08XWBSEi+MpB4+ftBAJ
 4I3MRJBnwjSYo+fDriuh3vQ+cn+jhDAVyzK+D6QJoVZNPKvT3bf2S2xwTkEK/+DT7bpb
 7ghgKNujzBYjA/I5/fbzOd5R1FSRRh26DDVsoSYV/N5+rchnTyiaPvTJfyt2hhx3jt4i
 hp0NjCRRibWRVB4HWKYwiVGIBSKhn/JYWat5vLQqvC6+CvoCoQkxzVTRjT3YlO1pkwOj
 nwtw==
X-Gm-Message-State: AOJu0Yw/pY/ZwoQGh/0i5jT4X0uYKgUpSzgAlbvPEmU7oRVZg1CPIAXR
 65/Fi2fOr5rRQXPGw9+IUTLKCWIMaEqVWxt0kr71IPqIOCy0sBc2Mxfulm0EOdq731j/MyDVSIH
 JFl0qqR3/76oiMSSF8dVv8nk=
X-Received: by 2002:a05:6359:410d:b0:175:9b44:6a37 with SMTP id
 kh13-20020a056359410d00b001759b446a37mr5474882rwc.1.1705423329941; 
 Tue, 16 Jan 2024 08:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNrQNXpXiaGHWpHJKNFg376+P0PZWhOIpc+khCvvmfKzvMM4zKj4NjlcrtVuaT2PcoSekeLQ==
X-Received: by 2002:a05:6359:410d:b0:175:9b44:6a37 with SMTP id
 kh13-20020a056359410d00b001759b446a37mr5474865rwc.1.1705423329601; 
 Tue, 16 Jan 2024 08:42:09 -0800 (PST)
Received: from fc37-ani.redhat.com ([203.163.245.66])
 by smtp.googlemail.com with ESMTPSA id
 k15-20020aa7998f000000b006dadc43f3f6sm9461333pfh.55.2024.01.16.08.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 08:42:09 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH] acpi/tests/avocado/bits: wait for 200 seconds for SHUTDOWN
 event from bits VM
Date: Tue, 16 Jan 2024 22:11:53 +0530
Message-Id: <20240116164153.3358822-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

By default, the timeout to receive any specified event from the QEMU VM is 60
seconds set by the python avocado test framework. Please see event_wait() and
events_wait() in python/qemu/machine/machine.py. If the matching event is not
triggered within that interval, an asyncio.TimeoutError is generated. Since the
default timeout for the bits avocado test is 200 secs, we need to make
event_wait() timeout the same value as well so that an early timeout is not
triggered by the avocado framework.

CC: peter.maydell@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/avocado/acpi-bits.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 68b9e98d4e..870cd2e36c 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -53,7 +53,7 @@
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
-
+BITS_TIMEOUT = 200
 
 def which(tool):
     """ looks up the full path for @tool, returns None if not found
@@ -133,7 +133,7 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
 
     """
     # in slower systems the test can take as long as 3 minutes to complete.
-    timeout = 200
+    timeout = BITS_TIMEOUT
 
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
@@ -401,6 +401,6 @@ def test_acpi_smbios_bits(self):
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
         # Rely on avocado's unit test timeout.
-        self._vm.event_wait('SHUTDOWN')
+        self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
         self.parse_log()
-- 
2.39.2


