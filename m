Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B8707024
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFj-0002Wy-Es; Wed, 17 May 2023 13:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEV-00007G-LO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLES-0004ME-QP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=550I0xQYvIiLjv/UoYMa94GFX66P9Jea4TA9rxktSMU=;
 b=GevTjJH9F2I4SyV3Hz3FeW1AmMJ4x4zeGfFXHJLTBXkaJdB4nQEHvyczqs0eENipV60pU/
 cHvJS/p3e5BpGnmE4mPHJZ5KNhdXQ9DIwfe9zOqZ9cx33MAHoX9K92sflzJKUPzaFc5Brz
 Rp8kSTLf/fIMXa6LHoRhi32pn0dCIwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-5QXc-1RYNF6JZ9IEVVSkBg-1; Wed, 17 May 2023 13:46:33 -0400
X-MC-Unique: 5QXc-1RYNF6JZ9IEVVSkBg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30940b01998so428993f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345592; x=1686937592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=550I0xQYvIiLjv/UoYMa94GFX66P9Jea4TA9rxktSMU=;
 b=P3ggUi//21IrUWHLoZ3XpFtFxvaZj8NdaYefilQY88hkE6eMGINEx/C+F3NMppEJMD
 aPHyuM56jbL9rWlKDN1xkQrMKCBzftmoIRPtcvd/UTu5NFqK9TlP4roT4xIOgGF1mhdk
 UUZ1PhaAUM7cHdOoIifNCKUV9IBMoXhkdXezhC/CCAiOxxV4b8tHkVeuei6kypgVzRCC
 u/J2NzaIXT1cYIEVZWF1kgGCnfhP56YjjbMT3jfyajAp9vmueZo1XlPAvlp1MuHmQ5vo
 IyGAbzAobxmgiqu61muChZJ+LeWjHOY2/6wS4jfrUS6i0f3x5AslNkrVrD/Hg60aci4d
 B0cA==
X-Gm-Message-State: AC+VfDwU0lZAIJhshNHjeBoNvwQFENswN/uc2xFqj1Kr3T3xjQcKIKqg
 4h6HB6DRPLVxIGAhSjXE8d+sK7+XEd6Q41yqQlso3zUo11Og9ERu4EoyGxyPlUXz89x5PJWUREB
 umHoel7YMYbIISbPHor68CnkPROsiTUDhDSjENz9rD9HUI3AnGHwjnYiAO+FTlmr2l9G+xuiOHi
 s=
X-Received: by 2002:adf:ef03:0:b0:306:b3f9:e2c9 with SMTP id
 e3-20020adfef03000000b00306b3f9e2c9mr1323190wro.6.1684345592496; 
 Wed, 17 May 2023 10:46:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tjSzEia+SIEVBbOdjz5Wc4qAuxvQNa2FJo+vbdGpiViIF/0MP1XWF/X6OJqJyWucBiumqPg==
X-Received: by 2002:adf:ef03:0:b0:306:b3f9:e2c9 with SMTP id
 e3-20020adfef03000000b00306b3f9e2c9mr1323175wro.6.1684345592181; 
 Wed, 17 May 2023 10:46:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d3-20020adfe883000000b00306299be5a2sm3601283wrm.72.2023.05.17.10.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/68] configure: Add courtesy hint to Python version failure
 message
Date: Wed, 17 May 2023 19:44:54 +0200
Message-Id: <20230517174520.887405-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

If we begin requiring Python 3.7+, a few platforms are going to need to
install an additional Python interpreter package.

As a courtesy to the user, suggest the optional package they might need
to install. This will hopefully minimize any downtime caused by the
change in Python dependency.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230221012456.2607692-3-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20230511035435.734312-25-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 22e31a46d115..52eca1cd4c53 100755
--- a/configure
+++ b/configure
@@ -1091,7 +1091,10 @@ fi
 
 if ! check_py_version "$python"; then
   error_exit "Cannot use '$python', Python >= 3.7 is required." \
-      "Use --python=/path/to/python to specify a supported Python."
+             "Use --python=/path/to/python to specify a supported Python." \
+             "Maybe try:" \
+             "  openSUSE Leap 15.3+: zypper install python39" \
+             "  CentOS 8: dnf install python38"
 fi
 
 # Resolve PATH
-- 
2.40.1


