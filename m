Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81270DD20
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RdT-0001dl-29; Tue, 23 May 2023 09:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1RdF-0001Yb-Ux
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q1Rd8-000865-Bx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684846842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUiDsP4c2ZcvdCzXTNl2e/zh5VBYAvOyZankmJ5FYkY=;
 b=UuOm9de4jUBvvaYY1K2Im+XTL1+mWpXDe7tBKhON7dsragsDZEaiO1FRCUcUJSaAxc4zrf
 9YUvOvNuNqUtf3s0j6Eg+G6ejlDGtc1dw94SD9alKnudlMV9gMhf5FDrJ30yXt/PMbxmeo
 m+OChFEIKcPaXorI/JAebt+ZfmWjv4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-x_xiVDNXMvS2uGCv5DuE1Q-1; Tue, 23 May 2023 09:00:39 -0400
X-MC-Unique: x_xiVDNXMvS2uGCv5DuE1Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60f085cd2so852665e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846838; x=1687438838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUiDsP4c2ZcvdCzXTNl2e/zh5VBYAvOyZankmJ5FYkY=;
 b=IuMYjfMvQzvZnvnQi1UBVNlK3sECS9TpmyyycqQTgpZ8xPmlPnVC0XdqPKtzoW4Qbl
 SgsmTpwf8YySblpevuoH8Ino8mt78AuuuVMbJ6DapNWCirYurEtN9snmD9+hXFqt6HxU
 h9abMuY8vCuOTeeprPDYerGgfF87HwMcPcRCYQumwf0YRIJ2nb8IhndzUl2SYHv1Mo0q
 mC58O2Xf+ngW+WlNVTMRjigRcFQMU8KAS4OJRtI/uBGkEK1ucQTUHAGz4n+GQMyjPURM
 ERYMJoGNJvw72MnZS4nNj7wMndwMfkignr6TK1CizqO/NxhMdmntY7mYonTwbR88X+3m
 3B/A==
X-Gm-Message-State: AC+VfDxX28pgn3dJqjPOYVQHBsshvUw67HdV+SowUUxSKj6bqYHtvZmv
 h+z5Rxcqy4mlKYsruDZULvh5gGdVfVkjytB3mPshED8Rj0i3SP3BazSt45ScfbQodjgSvKMW6Ji
 qGHabXlaB9iyVWXesd+lJKakNKhkp9czexyx4+DmLMkdxx3kUqnPaZM6Zlnnmk/W8jPDnL98mwS
 U=
X-Received: by 2002:a1c:7505:0:b0:3f4:f4d1:5c28 with SMTP id
 o5-20020a1c7505000000b003f4f4d15c28mr10777346wmc.24.1684846838450; 
 Tue, 23 May 2023 06:00:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5U6Xo78gMHnQsl6YjUK5Ydojd4aaJiqQOKAqHrZ+5dhUVfK3LJ1RIVMVEUyjukit63eGAbxQ==
X-Received: by 2002:a1c:7505:0:b0:3f4:f4d1:5c28 with SMTP id
 o5-20020a1c7505000000b003f4f4d15c28mr10777289wmc.24.1684846837828; 
 Tue, 23 May 2023 06:00:37 -0700 (PDT)
Received: from toolbox.redhat.com ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a7bc8d8000000b003f60a446fe5sm2460553wml.29.2023.05.23.06.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:00:37 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com, richard.henderson@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH v3 5/5] Add Kubernetes runner configuration
Date: Tue, 23 May 2023 13:49:59 +0100
Message-Id: <20230523124958.27318-1-cconte@redhat.com>
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
Changes since previous version (PATCH v2 5/5):
- Update ubuntu tag to 22.04. I tested it and it works.
- Remove concurrent jobs limits (use defaults).

 .../ci/gitlab-kubernetes-runners/values.yaml  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 scripts/ci/gitlab-kubernetes-runners/values.yaml

diff --git a/scripts/ci/gitlab-kubernetes-runners/values.yaml b/scripts/ci/gitlab-kubernetes-runners/values.yaml
new file mode 100644
index 0000000000..34c9befdce
--- /dev/null
+++ b/scripts/ci/gitlab-kubernetes-runners/values.yaml
@@ -0,0 +1,28 @@
+gitlabUrl: "https://gitlab.com/"
+runnerRegistrationToken: ""
+rbac:
+  create: true
+runners:
+  privileged: true
+  config: |
+    [[runners]]
+      environment = [
+        "DOCKER_HOST=tcp://docker:2376",
+        "DOCKER_TLS_CERTDIR=/certs",
+        "DOCKER_TLS_VERIFY=1",
+        "DOCKER_CERT_PATH=/certs/client"
+      ]
+      [runners.kubernetes]
+        poll_timeout = 1200
+        image = "ubuntu:22.04"
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


