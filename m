Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44477CA469
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5N-0007OC-9T; Mon, 16 Oct 2023 05:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5K-0007Id-Ie
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5H-0002bo-Qj
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=osYb4P7yKsOqBYf2AssoFGvXP8FQaTw6Vd8tofb+mDQ=;
 b=f+5pr/eSVc23/zMqxi0eykREJ+TiZeWR0jizKdggzeRVhXqTovm+KS2qJNzRVXJAISYlP+
 2L4dvyvm4SoiAKoxeW/3fB+ycfSxXR8a+xZk4Fas2t3qaBXeTcqPqyPHrwF55Xa+vfEWsM
 Y+Ym1p1zQ6JNmg8eN/zA8AxjmUOIByo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-zeI8fWo4MGKhi9uVQtbiOw-1; Mon, 16 Oct 2023 05:40:20 -0400
X-MC-Unique: zeI8fWo4MGKhi9uVQtbiOw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9bd86510329so307445366b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449219; x=1698054019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=osYb4P7yKsOqBYf2AssoFGvXP8FQaTw6Vd8tofb+mDQ=;
 b=AHJGHJf6epUSKqXH41Oh2ItatT3G7dRKFd1apk1udd4/sRAL6ocHAb/wFSQObbfQWU
 dv0x50DUjkSVsJphfZ68VHTrnmlAOje3cXZDgKkwZzqA+CFQiDXkzaRvUkcL/qBi/Lbj
 BRSA4iFFyFb8UwA2P1H8Am9eDO23tFCs1zq5g1wc2nOQK9wMuXdoQvaG5mSP+R311cW1
 4apgvlDGuyIODF7vrq0NkvKY6AwP4hAT1IOz/qxBC1F8SrKc8y0EJLgLpUqu+Ufy1kgo
 CO4DWNMPSmYKKAOtm03OM3xbyaKUm/0/hGoMMLss7i7qsl92Yeq5Mr0BFRxaTfKiqkl3
 hn6w==
X-Gm-Message-State: AOJu0YzOHzcidQ2ALC92jfwwcwa4Rk7v0L0PJH17JETQ66muiesvra1Y
 qf2gYldQa2UQ3fkduqMuAylI0QWIXY55c/OK7kccFanmBW37EttsvRNpq4wkDJJ/rtAP1JZlhVQ
 gWWzUtNm5GPvW818bUCu8yAFc+extdGpSNQzCKuF4FnRQLErELGvtfxK7kBOsrWMOYIXIXEWO3g
 Q=
X-Received: by 2002:a17:907:7f0c:b0:9be:fc31:8cd4 with SMTP id
 qf12-20020a1709077f0c00b009befc318cd4mr5762838ejc.18.1697449218955; 
 Mon, 16 Oct 2023 02:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHozOv2DBZUfTE2646RHFEa1J495wqcgnalCB+LT5F/NVfJHMEDPrY6Kkipvd8Oo2XhpQ60Eg==
X-Received: by 2002:a17:907:7f0c:b0:9be:fc31:8cd4 with SMTP id
 qf12-20020a1709077f0c00b009befc318cd4mr5762823ejc.18.1697449218492; 
 Mon, 16 Oct 2023 02:40:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a170906710f00b009ae5e46210asm3702447ejj.99.2023.10.16.02.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:40:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] docs/sphinx: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 11:40:12 +0200
Message-ID: <20231016094016.173598-1-pbonzini@redhat.com>
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


