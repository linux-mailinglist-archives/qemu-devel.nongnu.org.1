Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBB7C9F6E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH0b-0002Kc-K3; Mon, 16 Oct 2023 02:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH0S-0002KB-Qw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH0O-00042l-Hd
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=12k6B/Wg5mmR2vWY9vc/bgGujWdlLmC+rj9GPnpZx0w=;
 b=fGK6ak5o/aEdaYKmfUY+ek3Flu6Vv2LQcGFoYpxGSxMV3Zrugjk6jeTtCXM6Xg9Ab9Bj66
 BVIaab0L7bFDTsym9LuFUH7TO974xi+8x3+Wtr5fZp3a7tLaZ2yBF2XnOgMDpnlwRfrmkq
 qlJDklTJfk53Zb6MWCEqDaWFLQKVg6M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-blbXxxoIMH2WA_hCzcK7AA-1; Mon, 16 Oct 2023 02:23:04 -0400
X-MC-Unique: blbXxxoIMH2WA_hCzcK7AA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52f274df255so5722497a12.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437382; x=1698042182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=12k6B/Wg5mmR2vWY9vc/bgGujWdlLmC+rj9GPnpZx0w=;
 b=KL1pCpRXtwti0vieq7XOUgRfANaal+8AyB1Og3OaOU68ctTPuyyybe+CGwqCHJEPdN
 pPOw63lhHCvDerT8WW3jjYVRA1PgmnFakj+sWooAo0wH+Zd4pul7dSsP92bleePN5RFh
 WhIr8VAA1tgVMsAor9atZbE2z2wtiuquy8zZdMOTJjbiHeHb2vQTc4NPhTqtttUwyv1s
 64hQ7hyWNs0lQoyIZgAtSCWWkiVOvgaaXjii05pFUg0pkE0TSZzs+7d8a3jYsJB1sdzk
 mHHwu0LgEhIYCZxtD3OeaB6Q4OoIJ8qjlkcUJqD/7Lxp9Qe6+ehtDxYRlFoslbVwRJbH
 zK+g==
X-Gm-Message-State: AOJu0Yy6R5AQIKLnfaHclLkzP9+lDomkRugkU6qv0qNdZ7ccvssvLX3A
 q1SYTgHx53q9NlTieNMdQIjVr9ToET1eMrMP/tsHA2rlubj/pkP8l0V5YH/fIzTXUfHYo1nOhjP
 Gazu4Oe+iwdP7cLsFu35dLrcLPVIkp5KPM/1w/7wfOEfqAgdSYA1GmD0qemWY4GUgOxvcSYeaHo
 o=
X-Received: by 2002:a05:6402:35d4:b0:523:2e23:a0bf with SMTP id
 z20-20020a05640235d400b005232e23a0bfmr5652064edc.11.1697437382638; 
 Sun, 15 Oct 2023 23:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcOfvZCzJrgEPlImQ+nlcKAimWRbbew6/k5sGxtYmheXpnQIl98qNZtsUiJeRoJ1A0lKmGYQ==
X-Received: by 2002:a05:6402:35d4:b0:523:2e23:a0bf with SMTP id
 z20-20020a05640235d400b005232e23a0bfmr5652055edc.11.1697437382288; 
 Sun, 15 Oct 2023 23:23:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05640217c900b0053d9a862e2csm8147709edy.56.2023.10.15.23.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:23:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tests/docker: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 08:23:00 +0200
Message-ID: <20231016062300.160160-1-pbonzini@redhat.com>
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
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 688ef62989c..3b8a26704df 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -186,7 +186,7 @@ def _check_binfmt_misc(executable):
               (binary))
         return None, True
 
-    m = re.search("interpreter (\S+)\n", entry)
+    m = re.search(r"interpreter (\S+)\n", entry)
     interp = m.group(1)
     if interp and interp != executable:
         print("binfmt_misc for %s does not point to %s, using %s" %
-- 
2.41.0


