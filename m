Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779D707032
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGI-0003vC-Pp; Wed, 17 May 2023 13:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF3-0002FB-7c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF1-0004am-Iz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7L8ko30fbEd8tn2dVN6/DcnAocK307mvGHN2bv7IKMc=;
 b=X9/FzK+OaZ+vTeOKouEx9CiWeZLbx5mW02K5QF+5vJCMjB/Szp9F2sp0VYm4/lTvZl0vZI
 Xckx3QxyXuvDmpAVE5LPPnK4Z2s8s5Qn+nMvM9vKidpdSxhYok6YX8/prU9sXaKnKPJPWv
 cCdIWBmWBLXxCP/f46PLEjyXun5Lcds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-mYzqcgXBOxSAlsEcgSKaeQ-1; Wed, 17 May 2023 13:47:09 -0400
X-MC-Unique: mYzqcgXBOxSAlsEcgSKaeQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f419a053c5so1709615e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345628; x=1686937628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7L8ko30fbEd8tn2dVN6/DcnAocK307mvGHN2bv7IKMc=;
 b=VBsyJkrkzbvSHoucdusbeui7Dnf+FXzKNOmckYDU8sK2ePmt4Rli+wh9OLtYvno/rP
 c0MijjMTUybSLUUniWAMH3gOQIzrxbpqfXw14sVnGKX2Me1eq+AodJT76176bUZhUg1j
 vDs9EH1FcZhAgx4xOLCnfV6coWe/4XPbogQt6TFSCfF6U6Dyz6BfVVilr1MtEEWv9AZe
 8RhB1G/ZAifMwNUpKyxS9H/JCKLmktv5FrlophX5TPmqG4Qm6Q+ipsF0OM9zZVFSPX+T
 BWX4/r2sRyqR571cQx6kfHpSbq7y6LSLAAqV1wC+H/TpbPyQ6vpHWJ3jq8WMdXVXzoYl
 G8eA==
X-Gm-Message-State: AC+VfDz4uSRAQf3xaWOgi4oK6+y4FMmig4d+NRyq/KbQV0r4LY0FfABj
 f1AanjPbGJM1ZquRV5VoR3QKRE8EfZUlrw7AXenVRs6cvsyf71NJKmyJeJE/1Mjmj2+leBG09eh
 zfckXYw9Uku5Oc+/sPi0ZOE6tahmPYBqAvk74ZJaHjZBF1ECdQ47T6g9kYTT8WC173jKkNP8Y+h
 8=
X-Received: by 2002:a7b:c3ce:0:b0:3f4:2174:b28c with SMTP id
 t14-20020a7bc3ce000000b003f42174b28cmr2250983wmj.14.1684345627965; 
 Wed, 17 May 2023 10:47:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7B2zPC5ZLx4VG0qjVIDkKcMn9GjXNmG3lsp9UYwxJ+WVxHGrPSjLrnuXpuCmadTH3Z17PYNA==
X-Received: by 2002:a7b:c3ce:0:b0:3f4:2174:b28c with SMTP id
 t14-20020a7bc3ce000000b003f42174b28cmr2250972wmj.14.1684345627628; 
 Wed, 17 May 2023 10:47:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a7bc856000000b003f42cc3262asm2863586wml.34.2023.05.17.10.47.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 65/68] configure: remove unnecessary mkdir
Date: Wed, 17 May 2023 19:45:17 +0200
Message-Id: <20230517174520.887405-66-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is taken care of by the symlink shell function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index d0febe7cdfea..2d6ff2d6cef6 100755
--- a/configure
+++ b/configure
@@ -1673,7 +1673,6 @@ LINKS="$LINKS python"
 LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
     if [ -e "$source_path/$f" ]; then
-        mkdir -p "$(dirname ./"$f")"
         symlink "$source_path/$f" "$f"
     fi
 done
-- 
2.40.1


