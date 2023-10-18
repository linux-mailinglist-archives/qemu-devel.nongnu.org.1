Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CF7CD6AD
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uc-0000oq-QS; Wed, 18 Oct 2023 04:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ua-0000h6-Mn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uZ-0003bg-6r
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12k6B/Wg5mmR2vWY9vc/bgGujWdlLmC+rj9GPnpZx0w=;
 b=V/oV78TendOyRwi4kPbsFh85d4YFCIvPnmsbHtixfz6mP7tZBAv8UExHQ00+KXtdyATwFL
 t40AlnxlYhuQTxtY4Cekxf3bP7jIs/wltDWl4tebntt43r3NUr8fbQcbLJSYrBXVpk4fL2
 lTdb51CcE3flAFtcueaM4lUwz2rFfmU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-zS9WPkrEOiKzbrp3An-tCg-1; Wed, 18 Oct 2023 04:28:13 -0400
X-MC-Unique: zS9WPkrEOiKzbrp3An-tCg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so457992566b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617691; x=1698222491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12k6B/Wg5mmR2vWY9vc/bgGujWdlLmC+rj9GPnpZx0w=;
 b=VOWFMdC4AJYelDUtB2W2IzpgnanHZ2vuH/+YrYnzIP64nyBMij5fnHOOO65jVMfkxX
 Uoq+D1TQw1PGvtAJt1WR4+HLu/I26kAOiMBnRgqjmbNIIOrs9+EYofaB3gOJDYswynYG
 ekmvNXipe6goFj1vROsQI8umNRHasOat9bcQU1O3itsVjAYzTWyk+Ns4ATwxUOiPwaCl
 +xH8+1EW984TVRQQPF+14K1bE+cfgGYp0EH+0zcuBR7sVcAzvJ9BTf4+hrge7mNZIGCf
 G7GfnHzNHj7/Y3D9W8hM/5LZDumiVloqeedVfAh+6KkL/0HFhOJcWeUMRtq2Ue6RS1t3
 +xkw==
X-Gm-Message-State: AOJu0YwqMpH6jrCNUE3ZExsRioAor2F2CehVlQHX+cNd/vxoElneykM9
 nQMuszBEsRkUbJTmT9HPrrQVwsi1fMfpfmx25E+GPDJbvJxcC50v+jsIVSpGgKBjlPUO4bicKjc
 aKXj9UyxGSES3FgEMe3YxhDF1zkirAAbGpo6guY9QnIqUF1qNx3OKASNNcQBn8WVOT4LFudtdm0
 I=
X-Received: by 2002:a17:907:97c3:b0:9c5:8a6b:29e with SMTP id
 js3-20020a17090797c300b009c58a6b029emr3679207ejc.13.1697617691283; 
 Wed, 18 Oct 2023 01:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdP0a0bIwmQUzZhm9TwDsLsY2XZ0PlcGgRHnnjWJNoH7kQYsBkAt1aaNcCB9gp3OkMP798ww==
X-Received: by 2002:a17:907:97c3:b0:9c5:8a6b:29e with SMTP id
 js3-20020a17090797c300b009c58a6b029emr3679196ejc.13.1697617691008; 
 Wed, 18 Oct 2023 01:28:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a170906a41a00b0099d798a6bb5sm1187955ejz.67.2023.10.18.01.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 09/32] tests/docker: avoid invalid escape in Python string
Date: Wed, 18 Oct 2023 10:27:29 +0200
Message-ID: <20231018082752.322306-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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


