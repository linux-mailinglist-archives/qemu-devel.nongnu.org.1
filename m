Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB17C9F9C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH9J-00047q-2B; Mon, 16 Oct 2023 02:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH94-00042j-L4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH93-0005UO-4e
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhz5NoA8No/Gwx+ZeOtjgQ6Cuap6+7hqMf6Rp4/O1Yk=;
 b=UORIBvA3GsnKr2rGzrC1q3PLK4BNQoFjXrnJkdclZ7FWZGilg5QBkJAkH69vvN9iNuf33G
 gp3WqwHhRvvaA2U1lAUQaxNvAKL34cgb3r9vyp3sJH2tTJvyeZhBnyFC5G0A9TyFi1IFw6
 ra3u5/r3NMD1TNUdK6fNORkJHAEvJFk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-YEx8ZihuNPeJirJW-cHfjw-1; Mon, 16 Oct 2023 02:32:02 -0400
X-MC-Unique: YEx8ZihuNPeJirJW-cHfjw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ba247e03aeso279585066b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437921; x=1698042721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hhz5NoA8No/Gwx+ZeOtjgQ6Cuap6+7hqMf6Rp4/O1Yk=;
 b=gSqaaC8whmaETD+9i1svRHNaS4574a5iiSbnVbxJuO8GAZa4sL0uAqF6uheTAUI3ni
 /f2CWYv6m1N1qypZAHhMm2gNmi067FmQM135ZlcbEMkx+jJj4hweUfdvSX9mKNqhPSFl
 CdUsks/PFKudI4X3u77ZqOTpbcXO1QegSUKbChJgnmaIMYr+86HtN3PpN3ZClmQeibx8
 ojfc70xPU07Yd8uwl+LRfJqBL0eWFQeztXOHU6UVZ8M0/H07C146grrDeowycB957L34
 AnNYHmreXYGV0ku9+eOCOPBcDDAiPNXmXIRMLMSRnDIIONicKXfcjyht5DBHq2iiYY5q
 79sw==
X-Gm-Message-State: AOJu0YxwRsEfKOn8P3eh0er3w3YLN+DTzSJnuzGnIu6KJ0t+pe4udJz1
 KCP69mK+2JXGBH48JMaP0iaqX4/CIh6IQfQf+ezFton2vQmVby2ipdiM0Qiown5ad//Nd5aSnhS
 ByVCYc3J9jorU9VVhdRPqf4YcgoHDrZ8dYqMkIOKXPgN8aparhAwpYUftr67WfwEqK6s3eaEgUk
 c=
X-Received: by 2002:a17:906:6a19:b0:9a5:a0c6:9e8e with SMTP id
 qw25-20020a1709066a1900b009a5a0c69e8emr37462738ejc.31.1697437921274; 
 Sun, 15 Oct 2023 23:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzg/gggD4uLsmQzqyaQIiFLsMU215D0qbivs4qNkup6bsjQUwuGnObLaLTlkvDZFM2Ip/oDQ==
X-Received: by 2002:a17:906:6a19:b0:9a5:a0c6:9e8e with SMTP id
 qw25-20020a1709066a1900b009a5a0c69e8emr37462722ejc.31.1697437920902; 
 Sun, 15 Oct 2023 23:32:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 26-20020a170906225a00b009ade1a4f795sm3365187ejr.168.2023.10.15.23.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:32:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/17] meson-buildoptions: document the data at the top
Date: Mon, 16 Oct 2023 08:31:26 +0200
Message-ID: <20231016063127.161204-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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


