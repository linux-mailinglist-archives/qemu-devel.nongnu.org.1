Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA17CA465
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5U-0007mC-0Z; Mon, 16 Oct 2023 05:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5R-0007gj-2N
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5P-0002ib-Hn
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yQHSU18s/IxqMTzYLPyCVp4HqDLtdKCCysne3i19W6E=;
 b=QvlhZAbBU2pT4Ro7be3VX1kT3pvKFzjsFMnwRIEi+5emZ2iExtpqx4K9ybLPyS1uSheFdH
 J+3Sr2DOhVpaopnWpNDkyLXOc9JYQrUG95pvZi5hmdBZ/CLjt6pWOH9RWMrrLRQQBdioKj
 S/Q0d5oIAH9oLHOazCUcwcjlB0yR4xE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-GBQyv45HMOOW6K2-A4ZBMQ-1; Mon, 16 Oct 2023 05:40:28 -0400
X-MC-Unique: GBQyv45HMOOW6K2-A4ZBMQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso24790966b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449226; x=1698054026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQHSU18s/IxqMTzYLPyCVp4HqDLtdKCCysne3i19W6E=;
 b=Kf33XzpXeFIS9X+QVTS/p6MIwNTyPlbidQIv03F7hFFyxPmR1t7s+z9b6kUibCaHt+
 TqtfYSIMaTOwzCQnAeSplfplMDTrOhpp8C/cQFrJNdCbBM11PM6dqJrz+hByqGA8usr9
 yRNqSp67qJR4ggi4bECbTv7RzyHokgk588VKWGSbd0371G5EcS3iuzsYtH2jh1/YcUWg
 LE8qHaBzylW85wx/ffwjk9k5xYYI7LDf2jc8HveClaAj4f8hO35ndeJTPYFHJ/8ixIp3
 42huUE7odasLX98GaXGRdcgkHHuokiUafKYNVyyT4J1A4di57BXAj8cevdrJB88/qrYE
 HmEA==
X-Gm-Message-State: AOJu0Yx60nDld4tiEPVe/X6Wn3pPT6NcMfJUot4xVa8bfVzztndRw+fr
 jsVm2p8u+SWMxrizxoZMCqIrc04J/hTBZGBY6qxfl+vMWoeQf7hdDPJgIYrPpEq1fA4C6dw40rQ
 UOc5XSQgV09SablfZF6rwVsRn5vmyue+IlINjQSgigqDq6wc2JulOBrpzJpKoAtt8npbiB3qPJ0
 s=
X-Received: by 2002:a17:907:608e:b0:9be:ea59:1457 with SMTP id
 ht14-20020a170907608e00b009beea591457mr4879497ejc.40.1697449226504; 
 Mon, 16 Oct 2023 02:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrdR97NawnhVuCHvO2ILjrtKsTx6Yt2VoSjZGs9TGPMdYO9/TJU1x0UkfMMfNyo/r+A1V6jg==
X-Received: by 2002:a17:907:608e:b0:9be:ea59:1457 with SMTP id
 ht14-20020a170907608e00b009beea591457mr4879482ejc.40.1697449226168; 
 Mon, 16 Oct 2023 02:40:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 jz28-20020a17090775fc00b009ae57888718sm3595293ejc.207.2023.10.16.02.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:40:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tracetool: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 11:40:16 +0200
Message-ID: <20231016094016.173598-5-pbonzini@redhat.com>
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

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py        | 14 +++++++-------
 scripts/tracetool/format/log_stap.py |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 33cf85e2b04..b29594d75e0 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -210,12 +210,12 @@ class Event(object):
 
     """
 
-    _CRE = re.compile("((?P<props>[\w\s]+)\s+)?"
-                      "(?P<name>\w+)"
-                      "\((?P<args>[^)]*)\)"
-                      "\s*"
-                      "(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
-                      "\s*")
+    _CRE = re.compile(r"((?P<props>[\w\s]+)\s+)?"
+                      r"(?P<name>\w+)"
+                      r"\((?P<args>[^)]*)\)"
+                      r"\s*"
+                      r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
+                      r"\s*")
 
     _VALID_PROPS = set(["disable", "vcpu"])
 
@@ -326,7 +326,7 @@ def __repr__(self):
                                           fmt)
     # Star matching on PRI is dangerous as one might have multiple
     # arguments with that format, hence the non-greedy version of it.
-    _FMT = re.compile("(%[\d\.]*\w+|%.*?PRI\S+)")
+    _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List conversion specifiers in the argument print format string."""
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 0b6549d534a..b49afababd6 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -83,7 +83,7 @@ def c_fmt_to_stap(fmt):
     # and "%ll" is not valid at all. Similarly the size_t
     # based "%z" size qualifier is not valid. We just
     # strip all size qualifiers for sanity.
-    fmt = re.sub("%(\d*)(l+|z)(x|u|d)", "%\\1\\3", "".join(bits))
+    fmt = re.sub(r"%(\d*)(l+|z)(x|u|d)", r"%\1\3", "".join(bits))
     return fmt
 
 def generate(events, backend, group):
-- 
2.41.0


