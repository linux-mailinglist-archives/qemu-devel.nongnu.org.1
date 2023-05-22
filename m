Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03470C48F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yw-0003Ye-VW; Mon, 22 May 2023 13:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yv-0003YF-3S
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19Yo-0004Am-5q
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eV5icg6UmB4voJH6eNVbqdN7St8XDqaIvFbM4fnM4ts=;
 b=HrP5sXVJUwS6D6xSJTuu8ttqa4Qpgt69Xol6RajF9ai0kUJz0N8sxEUFQ/f+7SFKMNtJlF
 HsfX/18bbi5i7YgcjRxhuMNiv/+HaDO2p+Rilf8aLW1fR1SiGAneXIMkkoox7zMF/TDh1v
 YWts1WKdWN4o1gsVdmd9wkcBeoEJOtw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-BtzcKK9dPqWyNdzGGWLy4A-1; Mon, 22 May 2023 13:43:02 -0400
X-MC-Unique: BtzcKK9dPqWyNdzGGWLy4A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5ff240197so8580725e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777381; x=1687369381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV5icg6UmB4voJH6eNVbqdN7St8XDqaIvFbM4fnM4ts=;
 b=D0RQoEfTpPNuqMi2RwgR/mNzP9p43/i1yNP7wGqfiipw3Kl7ZGcGXnx4bLIxjseOxA
 pojbWaQ+0bWesSZLVjnYxJ0XJZCDBqChLwbFVFQTBY+yN52tJ+37cEJyg8EGY+NFq2Ux
 yf8loMpOo4cOMMJ5b5au/wqAQ8aey2Q7YJgYFF1hLAs2alzSeLtDzzXPjdSPqxbAaEZ/
 S6G6h+g74OA02p+267QgR8ZHwlzZsW1MaPMF/LMsLZwxXeJuTATNXqSpfTqcl6+kQ2Ba
 T2wywnZK+ZZhO9Bbq7lsrENs0PzHHnhMSSkTpdL6fmm9bSAQw42oZRHhkZIWW5ZBq3Gu
 zanA==
X-Gm-Message-State: AC+VfDwiBzxHrsSxdK1RPY/6xBduxjdJ4wCCDyaf3CKf3ugQOD1LQzAy
 Hp+ktjoR759hzZC/ckzHQwiZtHSzTn+KdH55w5Emj1ekvZnqKwmUKGjkdO31NG45diwSn4EgKrR
 Z47OzU/1qwxPmrtyg3T6artiuThQgYdmm65+6cc1usrt93nPB6/Dp84oDcFG7/EkHeqMiIs5G
X-Received: by 2002:a05:600c:2150:b0:3f5:d0ba:3c1a with SMTP id
 v16-20020a05600c215000b003f5d0ba3c1amr7374238wml.4.1684777381687; 
 Mon, 22 May 2023 10:43:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79j5k9vXaeNjB1/uReRLc2rdtzEEeHnUjCKAH9XbU1hCRpKqdB69ARultk44BOpQr8oeTUNw==
X-Received: by 2002:a05:600c:2150:b0:3f5:d0ba:3c1a with SMTP id
 v16-20020a05600c215000b003f5d0ba3c1amr7374226wml.4.1684777381487; 
 Mon, 22 May 2023 10:43:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:43:01 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, Camilla Conte <cconte@redhat.com>
Subject: [PATCH v2 5/5] Add Kubernetes runner configuration
Date: Mon, 22 May 2023 18:41:54 +0100
Message-Id: <20230522174153.46801-6-cconte@redhat.com>
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

Custom values for the gitlab-runner Helm chart.
See https://wiki.qemu.org/Testing/CI/KubernetesRunners.

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .../ci/gitlab-kubernetes-runners/values.yaml  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 scripts/ci/gitlab-kubernetes-runners/values.yaml

diff --git a/scripts/ci/gitlab-kubernetes-runners/values.yaml b/scripts/ci/gitlab-kubernetes-runners/values.yaml
new file mode 100644
index 0000000000..204a96a842
--- /dev/null
+++ b/scripts/ci/gitlab-kubernetes-runners/values.yaml
@@ -0,0 +1,30 @@
+gitlabUrl: "https://gitlab.com/"
+runnerRegistrationToken: ""
+rbac:
+  create: true
+concurrent: 200
+runners:
+  privileged: true
+  config: |
+    [[runners]]
+      limit = 100
+      environment = [
+        "DOCKER_HOST=tcp://docker:2376",
+        "DOCKER_TLS_CERTDIR=/certs",
+        "DOCKER_TLS_VERIFY=1",
+        "DOCKER_CERT_PATH=/certs/client"
+      ]
+      [runners.kubernetes]
+        poll_timeout = 1200
+        image = "ubuntu:20.04"
+        cpu_request = "0.5"
+        service_cpu_request = "0.5"
+        helper_cpu_request = "0.25"
+        cpu_request_overwrite_max_allowed = "7"
+        memory_request_overwrite_max_allowed = "30Gi"
+      [[runners.kubernetes.volumes.empty_dir]]
+        name = "docker-certs"
+        mount_path = "/certs/client"
+        medium = "Memory"
+      [runners.kubernetes.node_selector]
+        agentpool = "jobs"
-- 
2.40.1


