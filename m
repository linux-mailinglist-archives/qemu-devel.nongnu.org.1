Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F507DFF63
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:27:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoZQ-0000zn-FH; Fri, 03 Nov 2023 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyoZN-0000zT-Jg
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qyoZK-0001ZW-FA
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698996371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g+ADesTLoxgqVJakPYzQ3xu9smRiqRbB8V9FjvP3Isc=;
 b=Od3oWUeElAxMvumcfR+Z28DzgbndApnhMHfVyxz2e0tI6Rffm3/Mna2bntIzdneBNSa9Rw
 H0801nNSx2OU9KGfPDeS8CtdbGW6D4lgIBDCM9eDybD/wPD5Nx9OQHZRi3KppzpyyhE0BX
 idyIGZPxVcNHZHT6xOM3ckJroXFDf3A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-m0vL0mKMOc-3wBVfpv15Tg-1; Fri, 03 Nov 2023 03:26:09 -0400
X-MC-Unique: m0vL0mKMOc-3wBVfpv15Tg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso121670066b.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 00:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698996368; x=1699601168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+ADesTLoxgqVJakPYzQ3xu9smRiqRbB8V9FjvP3Isc=;
 b=DMFffJne7RDvvDf+9GPnwGb52vHQs7Phcn6HhjxEqHzjSeaWfq4orh+lgrjuw5Brd5
 ggmyGCKN0Cy9Wye4rT5xeU6zfNCJvUvqXOTzeyM2qUFMaQhShixyTsXTxoYKCDgLEx8O
 YaBkbnHtcgEYWtvfjkjZwAyvJn+qncs/mRZ6/MlskDZVPNNYIP80BI18xUf5tKcEP0y3
 YM3Y38zBZI/dwMQzy+NI5hsT3UerwWXXu/a1hqLmrWFI8yb/ZsoeMV+5CFk/jZDXTfuZ
 22eAYkiCeTHoMYnnJcl9422WdBk/SBqneR52i9BYsigNXbnMhm3TFD5LtBV4Uaf35Sco
 2Bog==
X-Gm-Message-State: AOJu0YykQWRHQBOa22aNXaalWtVRvTdtjg8yxZLGnC35vLB2qm12zkHX
 0uEvSyP8x96ZUl67jWzfwVAbN9vgPzA49YFpB8byyqkwzr3qyTUNdNQlE4FoIVnE0UIjwBFYvon
 r+MC8MkgPvWOnmpD3kgsgjdHadcXALAoexGt67MtXjOlxu9yIZShhkavdufCRGPhtbxK1fr9ft0
 g=
X-Received: by 2002:a17:907:6d0f:b0:9be:6ccb:6a8f with SMTP id
 sa15-20020a1709076d0f00b009be6ccb6a8fmr5933662ejc.48.1698996368058; 
 Fri, 03 Nov 2023 00:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+eNiXWZV3kq9gLVy80n7IuIrKKzMPIROhqW5d9eZJ48HcvWnx08aNWt/G/3ZJ0S+pG3Wlg==
X-Received: by 2002:a17:907:6d0f:b0:9be:6ccb:6a8f with SMTP id
 sa15-20020a1709076d0f00b009be6ccb6a8fmr5933651ejc.48.1698996367615; 
 Fri, 03 Nov 2023 00:26:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a170906260300b0099bd1ce18fesm588707ejc.10.2023.11.03.00.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 00:26:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] container: silence httpd logs
Date: Fri,  3 Nov 2023 08:26:06 +0100
Message-ID: <20231103072606.221620-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

The httpd logs for qemu.org are huge and are exhausting the disk
space on the web server.  Silence them, they are of limited use
and also a possible privacy issue.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 container/conf.d/git.conf    | 2 ++
 container/conf.d/noname.conf | 2 ++
 container/conf.d/www.conf    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/container/conf.d/git.conf b/container/conf.d/git.conf
index 13093c5..a3df4a7 100644
--- a/container/conf.d/git.conf
+++ b/container/conf.d/git.conf
@@ -2,6 +2,8 @@
     ServerName git.qemu.org
     ServerAlias git.qemu.org
 
+    CustomLog /dev/null common
+
     RewriteEngine On
 
     RewriteRule ^/(git/)?([^/?;]+)\.git(/?|/HEAD|/info/.*|/objects/.*|/git-(upload|receive)-pack)$ http://gitlab.com/qemu-project/$2$3 [R,L]
diff --git a/container/conf.d/noname.conf b/container/conf.d/noname.conf
index db17b95..9080c64 100644
--- a/container/conf.d/noname.conf
+++ b/container/conf.d/noname.conf
@@ -2,6 +2,8 @@
     ServerName qemu.org
     ServerAlias qemu.org
 
+    CustomLog /dev/null common
+
     RewriteEngine On
 
     RewriteRule ^(.*) https://www.qemu.org$0 [R=301]
diff --git a/container/conf.d/www.conf b/container/conf.d/www.conf
index 1904b5a..d9f6360 100644
--- a/container/conf.d/www.conf
+++ b/container/conf.d/www.conf
@@ -2,6 +2,8 @@
     ServerName www.qemu.org
     ServerAlias www.qemu.org
 
+    CustomLog /dev/null common
+
     RewriteEngine On
     RewriteRule ^/docs/master(/.*|$) https://qemu-project.gitlab.io/qemu$1 [NE,P,L]
     Header edit Location ^(http:|https:)?//qemu-project\.gitlab\.io/qemu/ https://www.qemu.org/docs/master/
-- 
2.41.0


