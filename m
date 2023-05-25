Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4B710E41
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bkx-0004Zv-Mt; Thu, 25 May 2023 10:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkr-0004WT-4D
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkp-0007YQ-HA
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY7zMTVVpyEJMUHIwvD7udn+W7XfH9WjAVo65QyNQzY=;
 b=i0G+Uo99jg7Y7qcScIBC73G2K7ZQbGDZTVRrdX+Qq8ZvHNOnWHKcMHtV/kFfZXvTXQZ8Bw
 zQC0Sjs5oeTp46kBkVARlQZrw/cg/rszDNuyw5O5di2f2mfjhCMWyW6q/SkWn1Ph4wTVqw
 OQxFoapSG5EF2QMNKZU/afEPfetwufk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Ply1kpZ7N7mKYyCbskqb4w-1; Thu, 25 May 2023 10:15:42 -0400
X-MC-Unique: Ply1kpZ7N7mKYyCbskqb4w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-510ddadbec6so2730358a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024141; x=1687616141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PY7zMTVVpyEJMUHIwvD7udn+W7XfH9WjAVo65QyNQzY=;
 b=Q7lOrPEJGV4w8UPnYVxH3zj4VNDGzeuSLvPhbK0PcZJEjl/25MCz91RZ7VQZ6219Z0
 QAmWPfNlHgZw3hVfa+bgT6U7699h4hNOl3/QOkkdMmz912LagSRhAigpJh/pNeNHIDa4
 jQqMTwQfBzw1XzCNaLtr4h7hGQyj2CBqf39tbBVyifRlmSeas6e8914ioF1bA6K/qi2/
 so8w1nCmlAk7k/k2DfDd1uCqcxFrCAE3lBXV56kgQvk/PrCoS98ay193f8jCg57A1R+F
 gRJG2Yldk50GwjoUr59IirM3xSDiVJlxY+6lRdruUe1NxuFcTDRECPjdSEvjA8JscOPb
 3uzA==
X-Gm-Message-State: AC+VfDxUPF1nC4SL9if6V1hlUYHukgvLlOhtVDyNzZZT/3XxlS4LWcjw
 Pqq9MzywUC6xQlkAAjFowu0qyVKwPrhSJmEoMYCfoqfMPvyuXjPgBL8iC6yS7Y/f8JrYiyso0HE
 lJEhD41XdmghGVYLWAmNCnyz7Du/wYc1G8f4n1xjhRnSWw14+pZ1n80GydsgjxUp8iH1rIZKujD
 I=
X-Received: by 2002:a17:907:807:b0:96a:246b:c65d with SMTP id
 wv7-20020a170907080700b0096a246bc65dmr1690874ejb.12.1685024140909; 
 Thu, 25 May 2023 07:15:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5M2I2lMSz3QGkQdapxFJz43F5PvQEq5CXosVp7LL49fMTlC6UUeexQ6Yx3Ho4wUkKJBr9dJw==
X-Received: by 2002:a17:907:807:b0:96a:246b:c65d with SMTP id
 wv7-20020a170907080700b0096a246bc65dmr1690847ejb.12.1685024140582; 
 Thu, 25 May 2023 07:15:40 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a1709061e8a00b0094ebc041e20sm893345ejj.46.2023.05.25.07.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/20] tests/docker: simplify HOST_ARCH definition
Date: Thu, 25 May 2023 16:15:17 +0200
Message-Id: <20230525141532.295817-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

ARCH is always empty, so just define HOST_ARCH as the result of uname.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 94015253254c..142e8605eee9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ NULL :=
 SPACE := $(NULL) #
 COMMA := ,
 
-HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
+HOST_ARCH = $(shell uname -m)
 USER = $(if $(NOUSER),,$(shell id -un))
 UID = $(if $(NOUSER),,$(shell id -u))
 
-- 
2.40.1


