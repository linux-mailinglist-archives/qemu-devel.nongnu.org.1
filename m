Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36227CD68A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:31:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uh-0001DW-CR; Wed, 18 Oct 2023 04:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uc-0000th-O1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ub-0003cA-1U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osYb4P7yKsOqBYf2AssoFGvXP8FQaTw6Vd8tofb+mDQ=;
 b=NhW1yR0VDKO8/UdVgPZI1SRvN0lnMU7wSBLtvauKgT8CCaKCu+wgmU+vNI3KEJ/H7oklE5
 AEFbjy8+CH+WW1Lv0cTSo10q9sTT/KIXWospaWyJnmxpgauDZTVk+th5JzS9Si0sJkHlzB
 Ny6if/21W6YHeIoh5lWvQp7s8A2WB90=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-nE43XSaMOBiSbKkhEN_KwA-1; Wed, 18 Oct 2023 04:28:15 -0400
X-MC-Unique: nE43XSaMOBiSbKkhEN_KwA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso486634966b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617693; x=1698222493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osYb4P7yKsOqBYf2AssoFGvXP8FQaTw6Vd8tofb+mDQ=;
 b=IsdKsUNZz7fjU99aHztPZjMzoak3eN2Myiyxvcb4fqa8dQCsviz27vKRxDMibD955f
 bTXamz9YKMPM1Ewvy+ZiTOIzgArRkDkDhhNhwerXBh5pzFSGXwk/b3PQtSAYkuN2l8og
 02PWbovzNXoWQ75Y+kwl5AC1gXgkwViaTfb5nvfW4vy3OaZWNzGvR+XxhIJzFNynli7O
 fgLSNXbceuMT1/phHlxYuEXLzQfSE7l2PtUW58L4VzH4svHQVAGkIhvV2sWhOzrHYAlb
 9GECEMbTf+PTagKa4SgJ9v0yWNUd5smmZVF71QCw74fs0E4Bc4RTgfsr3lAP4nQJiCEy
 1a4A==
X-Gm-Message-State: AOJu0YwyH5BbM844/C5t0U5GPgo+Ufbwzz9DBWcQO84UaORv7HG+xYFF
 aPthjPAQC/Ex4oNP3dIsm6Bc9dUVKjySEbSB3wfBsmR9q0Z20s5XZdkf9vDWnvTJ9v/0S1Tz+Jm
 2PYRSfTWgddBTyfrX5/p0YSlebYbgrBESyBpfZMTfN0ecgpJKF7QmbNuFaunuhr9olHADEW2ds9
 w=
X-Received: by 2002:a17:907:1b0a:b0:9bf:10f3:e435 with SMTP id
 mp10-20020a1709071b0a00b009bf10f3e435mr3153500ejc.1.1697617693275; 
 Wed, 18 Oct 2023 01:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGchnyx0RIse5pR/YExo1XrD5ZYoEMELwlhoB7/XU3808fhoOLyva9lwJBKo+gWmO5dz4Y+Ww==
X-Received: by 2002:a17:907:1b0a:b0:9bf:10f3:e435 with SMTP id
 mp10-20020a1709071b0a00b009bf10f3e435mr3153488ejc.1.1697617692843; 
 Wed, 18 Oct 2023 01:28:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a17090603c800b0098ec690e6d7sm1181297eja.73.2023.10.18.01.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 10/32] docs/sphinx: avoid invalid escape in Python string
Date: Wed, 18 Oct 2023 10:27:30 +0200
Message-ID: <20231018082752.322306-11-pbonzini@redhat.com>
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

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/sphinx/hxtool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index fb0649a3d5b..9f6b9d87dcc 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -49,7 +49,7 @@ def serror(file, lnum, errtext):
 
 def parse_directive(line):
     """Return first word of line, if any"""
-    return re.split('\W', line)[0]
+    return re.split(r'\W', line)[0]
 
 def parse_defheading(file, lnum, line):
     """Handle a DEFHEADING directive"""
-- 
2.41.0


