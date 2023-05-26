Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B15A71249C
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UfR-0003ek-DJ; Fri, 26 May 2023 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2UfD-0003d0-M9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Uer-00050x-3b
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q24lgTZzDX54EUdjECo2U6h6oXNEyLIGSU/uCnCASvs=;
 b=UbLbD1n1AZ1FDF2kNZVtxiUD6zSz6jSfWrruC2Y4W46gL+vhUbjKP9JP/XzFSP8OFl6fln
 vQIJqW5gAf1fId0gb9UAgacU51Sy0fCk+gbenIES6HksilQaDF/iQ63hUcvUgqfdaHT6lu
 bky09P3q8wW+kcFFJvNl34t2yAkCXqw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-79NXb6-yN_6fbMzEGy5Wqg-1; Fri, 26 May 2023 06:26:49 -0400
X-MC-Unique: 79NXb6-yN_6fbMzEGy5Wqg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96fd6bd135dso73877766b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685096808; x=1687688808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q24lgTZzDX54EUdjECo2U6h6oXNEyLIGSU/uCnCASvs=;
 b=KHeBRWCONTF4gR3fJrlEGdQIT8WRbVMAxjuAYdvlgZVxsWKwxNqyAW4WDcm0vVd5dr
 Se+GrUzMyqxn/istyYYtWVk9d090MzFqkFYnKpgPB/q++aNbQC5TkrZKJpOPa5w9z8X1
 5lf/4GQyVUl/Wm11pD+m3RorX83x3yKHz/aJSJ89BuVcI83KDAXrPQiO44xTqqPcrCB2
 okn9y5ZnnYzwxOTCJFioQTGuGR/qC94qvfhtlN9osZ/Y6yQeftqNIDYB/pOsDeWxffel
 efAoC+ilcwxmAivHWkn2+pXnJIcw2TbxO9emeXZG661LLgO1TS8q305yg0V8w0i8L9z9
 GYBQ==
X-Gm-Message-State: AC+VfDzuCbieZPWe064v0imAyI9hdWG91fDtoLdtXpVUxXfeF13nE9fD
 re8phGeovQ6cGX6dVxcIA/QdGCfqrTahiBwx9pIdowvGnepQhugYMmBMzm6QxDCFKxBB9CTIYqg
 t423CUqZUnD6DxrulOSQL6qi0LCQoXIkpnOjVbsdMyiwfgDg3KyiBuDqlV62JI7pkIRVfj32ZaQ
 s=
X-Received: by 2002:a17:907:3dab:b0:95f:4889:412a with SMTP id
 he43-20020a1709073dab00b0095f4889412amr1613064ejc.33.1685096808476; 
 Fri, 26 May 2023 03:26:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64gIKej6vJ6ZEj67NSOxM2O/u/CmZP0IPw5r9uKLRQCQ9RK9oCoAhU1Oemh/odR+fKYxEJUg==
X-Received: by 2002:a17:907:3dab:b0:95f:4889:412a with SMTP id
 he43-20020a1709073dab00b0095f4889412amr1613041ejc.33.1685096807966; 
 Fri, 26 May 2023 03:26:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a170906b01800b0096f6e2f4d9esm1931984ejy.83.2023.05.26.03.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 03:26:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] slirp: update wrap to latest master
Date: Fri, 26 May 2023 12:26:46 +0200
Message-Id: <20230526102646.436758-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is recommended to use SSIZE_T for ssize_t on win32, but the commit
that is being used for slirp.wrap uses int.  Update to include the fix
as well as the other bugfix commit "ip: Enforce strict aliasing".

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/slirp.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/slirp.wrap b/subprojects/slirp.wrap
index ace4f26102f5..08291a4cf99a 100644
--- a/subprojects/slirp.wrap
+++ b/subprojects/slirp.wrap
@@ -1,6 +1,6 @@
 [wrap-git]
 url = https://gitlab.freedesktop.org/slirp/libslirp
-revision = 15c52d697529eb3e78c5d8aa324d61715bce33b6
+revision = 26be815b86e8d49add8c9a8b320239b9594ff03d
 
 [provide]
 slirp = libslirp_dep
-- 
2.40.1


