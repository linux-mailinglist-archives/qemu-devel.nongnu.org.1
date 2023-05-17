Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DB707029
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEg-0000tr-Ke; Wed, 17 May 2023 13:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEA-0007xS-Ob
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLE8-0004Hu-K8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKBaLoWGdZ0RkyXEDY1BFQu3+SJiQML2IvZoS6F7Z0o=;
 b=ScyNVaqOpF7LcJpg/K5WblayG3hFqIZdYvdFc7LSaB4o5GxfXGfubW8mOIB78vH66lr1ED
 g8idDUNVDsJvQIA1JXZhpsZmOnN4/tOsJBIS2msivgsNnAPu1kUcR1dutd4KgvALlDHRM6
 P2fAkczAyfxfK48OOuCRw2l0tjd2z9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-7e4fBP5oPsGReDbtn9-HFQ-1; Wed, 17 May 2023 13:46:14 -0400
X-MC-Unique: 7e4fBP5oPsGReDbtn9-HFQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso4322815e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345573; x=1686937573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKBaLoWGdZ0RkyXEDY1BFQu3+SJiQML2IvZoS6F7Z0o=;
 b=JzjIkbmgTZEW3DGYDuRBkU1qprDYgIJF1FEGGwp1GTMhOBZowoyqI71gfA1jeeZ2zo
 XAp9stCYnzjAQ7A+VvbfR2FDc9E3waOmAPEHk+JxWZzURNbUPNkppTVMaqbF7TIzLrWf
 /OlCc8trGp/BZDl4WNb8J24t5iV3owuLFsRSpajlg9eqQWN/SOdLQBSmNxVlF6yVjf1L
 OsnNviZU5zUBW6XX299B35MNj2K1NPkhYgbGniWGM1rjPkpbsJUqP238QCQfLqll7VTi
 y/AxerJX89/6NLFxhs73vBQaWf+8atj5M7J9us56EqIs5g7f8GRZ0GGAz5xWKDlweNN0
 wk5w==
X-Gm-Message-State: AC+VfDyHRZl6MISrRXbrL1keKV5IKHYv+KwW49j32HFMpx5Vj5Mkf1uR
 OK/+hRxvlCergkwol1IWRXa2qgIS5RIq3A/iD6yAzDpC11RvuFoQCp+/RwKmWwF5c8sTO6R0k9g
 VKBnV3eST9pKYr1/D2Cjr3uTddq/uH0Blm87kyZKLyQW9m62XEo1PDGHceNOKjCfqcSp/BUqNBB
 4=
X-Received: by 2002:a05:600c:2313:b0:3f4:2266:8cf0 with SMTP id
 19-20020a05600c231300b003f422668cf0mr23818606wmo.10.1684345573375; 
 Wed, 17 May 2023 10:46:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46qK7StXan5/bvyLrSVW/8o6eQMBdepyJm9zeLXtBxUk6shOoqkazbc9JWuCSoUd4G1miQlA==
X-Received: by 2002:a05:600c:2313:b0:3f4:2266:8cf0 with SMTP id
 19-20020a05600c231300b003f422668cf0mr23818595wmo.10.1684345573109; 
 Wed, 17 May 2023 10:46:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003f421979398sm2854775wmb.26.2023.05.17.10.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 30/68] tests/vm: Configure netbsd to use Python 3.10
Date: Wed, 17 May 2023 19:44:42 +0200
Message-Id: <20230517174520.887405-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: John Snow <jsnow@redhat.com>

NetBSD removes some packages from the Python stdlib, but only
re-packages them for Python 3.10. Switch to using Python 3.10.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-13-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/netbsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 0b9536ca17bf..13eae109c042 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -30,6 +30,7 @@ class NetBSDVM(basevm.BaseVM):
         "git-base",
         "pkgconf",
         "xz",
+        "python310",
         "ninja-build",
 
         # gnu tools
-- 
2.40.1


