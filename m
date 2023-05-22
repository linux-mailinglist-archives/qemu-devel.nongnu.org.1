Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C63F70C485
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yc-0003WE-Pt; Mon, 22 May 2023 13:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19YW-0003VM-KD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19YK-00048Q-83
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VJclHB32htPmq7Fz7pgxOVZnrTaw5OWW+2fPrt3P54=;
 b=JCzV8+DT18S6DAPMuwxMYaoHcVldaDu/MDihB1E30dx9JHweUvoIuRmywMStg3EvBhvbx0
 RaRCSaSLMFcL9Yu7sKz4uiQqsxAfBZpdwChnm2ECyF0hYmaLNBTUD5pFXsU/J3Q41jIo8u
 d7G+/kkkOXu86rmgihJn7tzIHz3R+nw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-52Fi6Ck7MCyy5RqJNQqV9Q-1; Mon, 22 May 2023 13:42:29 -0400
X-MC-Unique: 52Fi6Ck7MCyy5RqJNQqV9Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f422dc5fafso38470295e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777347; x=1687369347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VJclHB32htPmq7Fz7pgxOVZnrTaw5OWW+2fPrt3P54=;
 b=c0xqCa80HNUaL1xTqpNWH2G8eeb8sND+ap+90Ss2+Tdky3jNBhGSfEfVZYeps8V6TI
 bNJ87n0+ty8M8d0EOq4PeovKWA+rxI5iUddQdt7A12z1pacunE9/EZSx8W5KklvshoXw
 0FzSX1rfOROVqENOLtMdRw1c/byOcQZlQBv+vtUX8Q4M8S8jRTsPGP7HWzLhnCq5n17O
 /SVfvaROYS1Dch3xkLa7p+2WG0QKhgo5lC749dLmQG3aeUN+muMypV0TbIjbBu4qeVde
 Nl9RM8I9/s1biaqJ9Mxqcqdh9n6LEKXpJr1CUwCzB0m9FmiJl5HnDuG2IIn+arijDrxF
 aPBA==
X-Gm-Message-State: AC+VfDybU8f7ceNzVA4wKQDvqQUjoBaNB2DcsD3OEnLwgVw5i0YfuGQS
 HsboZSR5NxjfC2iLCaBsdeYdl8PDbY44oG5YPzAGQMcTlUlNS9bk11QLsA501aBIGi8pUrlrPov
 ITV+cGKp6sQpsuLegkoZsk5wwVHuMs1KliEAV+yVC5mvBddF2JpLlzMBNzSv7DQL50Di3NI7Y
X-Received: by 2002:a1c:f30a:0:b0:3f1:6fb3:ffcc with SMTP id
 q10-20020a1cf30a000000b003f16fb3ffccmr7942048wmq.22.1684777347751; 
 Mon, 22 May 2023 10:42:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mg+lpYn3Ytq763ykUfiMVERmiy9RvhOGAQ40fPt1rsm+bwVLeRZ3lkH7gteTZcfx+iFqy0Q==
X-Received: by 2002:a1c:f30a:0:b0:3f1:6fb3:ffcc with SMTP id
 q10-20020a1cf30a000000b003f16fb3ffccmr7942035wmq.22.1684777347464; 
 Mon, 22 May 2023 10:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:42:27 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, Camilla Conte <cconte@redhat.com>
Subject: [PATCH v2 1/5] Remove redundant CI variables
Date: Mon, 22 May 2023 18:41:50 +0100
Message-Id: <20230522174153.46801-2-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522174153.46801-1-cconte@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cconte@redhat.com;
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

These are not needed when using gitlab.com shared runners.

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/opensbi.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 9a651465d8..13070575b6 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -48,9 +48,6 @@ docker-opensbi:
   variables:
     GIT_DEPTH: 3
     IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
-    # We don't use TLS
-    DOCKER_HOST: tcp://docker:2375
-    DOCKER_TLS_CERTDIR: ""
   before_script:
     - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
   script:
-- 
2.40.1


