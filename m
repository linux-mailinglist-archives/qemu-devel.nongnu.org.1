Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3F7CA468
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5O-0007Rn-7u; Mon, 16 Oct 2023 05:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5L-0007MG-Ox
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5J-0002dY-Rf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kigZ1gdB5H+XjWPX4HIf/8kVEM1VbLJvt/chkAEw+1Y=;
 b=WgIYvUvgK+bGnhMlxXJ4scQIH/uBShj+oBUORBc06lA2fj+TH9RuJIoURe/sVMrwP2AlU8
 mGa6NOD+0TnnvdYe2YQHBi7WDLOTMpEY1VezEHJ9e6ZjDqkm9AE9s7DDgWSfC9efR2mL6Q
 ipEWCZq/hViBcT1GMVJV2yI2d0pdd1M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-CeEe8gdsMKOA92VDYzhI_g-1; Mon, 16 Oct 2023 05:40:22 -0400
X-MC-Unique: CeEe8gdsMKOA92VDYzhI_g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50796a3ac70so3146714e87.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449220; x=1698054020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kigZ1gdB5H+XjWPX4HIf/8kVEM1VbLJvt/chkAEw+1Y=;
 b=TLKs4CQ58Esq5knLCViSvmDJJirmB+exxVC6VYIA0Ved5EMtaUHVWxX3Ao5LGVag4H
 41Brwdxc5fdjOKDPRgYZueEkAuIOSRKOarfkPa+NMmrfO9+fJYjrI4DHu4PkRjlglGwr
 QYUSIBOuLABtn2x6Mh/RWR3ldinfy2uvCc/klyM5x8mr8U2qYxwLfZsIDWLJ8UGrZOZ4
 m4QK0YliN/XXaVmSGlxYExAuBw6QYRx5KwfCIQISKvgfExDXTfl7kPd3D3JOvXk8t/0M
 XCzYrQTcaw7iWstr5CyKDKlg8RE3JNPgc5/5TiwgcsZf8rR4B3BpEGPuMYFI+QnpZdWr
 U/Cw==
X-Gm-Message-State: AOJu0YzGg9wsxSt4PE+IMjXd5b20buftrQqwTjswTasGQAaKwFvZj79c
 ORiD/geItJKnREwccck0Wv4E6pWmg40Snj7oziTWAdnwfG2Ep9cwPG+Sg1Ozv06oYm6ci8fWsM5
 Cpe7w9tz13arVgIvJgw/iNQtuh7+7cZ9tWhG3a8pgI8m57narRNYkXxZ9H+kroLZKS3iVPU2FGH
 A=
X-Received: by 2002:a05:6512:794:b0:502:cc8d:f1fc with SMTP id
 x20-20020a056512079400b00502cc8df1fcmr24450511lfr.37.1697449220648; 
 Mon, 16 Oct 2023 02:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq6IQTY12+K3Foy9aJtYmNjNFklSwiLQUq6l9Z4eNO7JaJ03SFEksijgqJNE9zyVR+IsyBxw==
X-Received: by 2002:a05:6512:794:b0:502:cc8d:f1fc with SMTP id
 x20-20020a056512079400b00502cc8df1fcmr24450498lfr.37.1697449220232; 
 Mon, 16 Oct 2023 02:40:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bt8-20020a0564020a4800b0053e4783afbasm4529077edb.63.2023.10.16.02.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:40:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/hexagon: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 11:40:13 +0200
Message-ID: <20231016094016.173598-2-pbonzini@redhat.com>
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
 target/hexagon/hex_common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index dce1b852a7b..0da65d6dd6a 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -45,7 +45,7 @@ def uniquify(seq):
 immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
 reg_or_immre = re.compile(
     r"(((?<!DUP)[MNRCOPQXSGVZA])([stuvwxyzdefg]+)"
-    + "([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)"
+    r"([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)"
 )
 relimmre = re.compile(r"[#]([rR])(\d+)(?:[:](\d+))?")
 absimmre = re.compile(r"[#]([sSuUm])(\d+)(?:[:](\d+))?")
@@ -337,7 +337,7 @@ def read_attribs_file(name):
 
 
 def read_overrides_file(name):
-    overridere = re.compile("#define fGEN_TCG_([A-Za-z0-9_]+)\(.*")
+    overridere = re.compile(r"#define fGEN_TCG_([A-Za-z0-9_]+)\(.*")
     for line in open(name, "rt").readlines():
         if not overridere.match(line):
             continue
-- 
2.41.0


