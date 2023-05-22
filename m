Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD070C486
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:43:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yx-0003Yf-5v; Mon, 22 May 2023 13:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Ys-0003XW-6w
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Ym-0004Ai-SJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/dfQQP+Qk1Lx3YD64yyUjHQUxiwcv2SUZMQkz4wWjI=;
 b=goPwzGhJs6Z22bTlLehbOI6uOjWwhVplmImz9n3Ep+1UtX4Pg22VERJ4mBs64xwK3GIvdn
 GpShtFcCjodtlhzMasT3gU78OBLzT+jGKkdQR8uWlWiUBovq+lIfGBa+qJG+d5gJQAkqGt
 m8Oz4+okxOz/J/GqjOM63oJfBrwq7ik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-jhbxIoQ3Nk2Tsam66tIVTQ-1; Mon, 22 May 2023 13:43:01 -0400
X-MC-Unique: jhbxIoQ3Nk2Tsam66tIVTQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso7076785e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777380; x=1687369380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/dfQQP+Qk1Lx3YD64yyUjHQUxiwcv2SUZMQkz4wWjI=;
 b=bHJfUjJFJPR+7rKOvvrDoQ9Yc5tdoddqV69laCvMa3WKW68dovXTwr83ghAp6mKjTP
 QhXPDC/el1BGyjqwl/DgfcXedcBTSrNJKwtbbUlbimkBUxsi6AqPUIEjLzMQya+HW/Gh
 c6aws/UmWl5gPIio8q7H7iDWb00cfOGs2/bgu9vOTlr5RVPi9IFn/3CGCahWVMtQFsuL
 Oovbf06UEC1BjEMY+/HhOz4ktkqe3z5/t3zee+husemB2rmzuxEnO4yS7EGIpEdiEACl
 lVaG5nXbdVmr5MlEsdZ+sCqq69cN+IIU76/LT3p5IoKCBrtxGl5zct/FKw85BC+YoVD9
 SkYw==
X-Gm-Message-State: AC+VfDy2gpYtljsomhX1nuUAE1WJc8XDuVEbm1iq5HufWwKnmZMMXCUY
 LGFIruVSPGHUSBh7YOz/WJ16gaPUX00nQc+PGijpnhI6A3uRGLDIEB3DYhkDx++WEyyPVuyrvtd
 DFLTbjLRxhJqfeWhqWt3bPb6327L/YDW+gnRNIJzhm1ebA5jHQgjy7v/QiuqHgoXHHK2WRDbH
X-Received: by 2002:a7b:ca45:0:b0:3f4:2775:b45c with SMTP id
 m5-20020a7bca45000000b003f42775b45cmr8102467wml.3.1684777380354; 
 Mon, 22 May 2023 10:43:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ViepBi+vwqUyWzPaXRUhi6xo0MpfdWZhnzJ2/vojEPeVL+A9BJbbYxqxAdH+UrK0F4tqq8w==
X-Received: by 2002:a7b:ca45:0:b0:3f4:2775:b45c with SMTP id
 m5-20020a7bca45000000b003f42775b45cmr8102455wml.3.1684777380095; 
 Mon, 22 May 2023 10:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:42:59 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, Camilla Conte <cconte@redhat.com>
Subject: [PATCH v2 4/5] Add CI variable RUNNER_TAG
Date: Mon, 22 May 2023 18:41:53 +0100
Message-Id: <20230522174153.46801-5-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522174153.46801-1-cconte@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This allows to set a job tag dinamically.
We need this to be able to select the Kubernetes runner.
See https://wiki.qemu.org/Testing/CI/KubernetesRunners.

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/qemu-project.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index a7ed447fe4..4d914c4897 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -1,6 +1,13 @@
 # This file contains the set of jobs run by the QEMU project:
 # https://gitlab.com/qemu-project/qemu/-/pipelines
 
+variables:
+  RUNNER_TAG: ""
+
+default:
+  tags:
+    - $RUNNER_TAG
+
 include:
   - local: '/.gitlab-ci.d/base.yml'
   - local: '/.gitlab-ci.d/stages.yml'
-- 
2.40.1


