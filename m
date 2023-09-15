Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153637A2203
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARe-0003Xx-KP; Fri, 15 Sep 2023 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARG-0003Cl-8P
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARD-00029H-HH
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so25870755e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790534; x=1695395334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTrovK4fIdtvshi0BSJ6A7SGaTiEX1KvDjEUM74fc78=;
 b=ZQV3TrVjCvf9BPyQ5Fct6sxl/U6/q8f1SiYfjG8kX3XrfCXinXqXE0ANqHrw+bXZK0
 JQY7Y3g/3im48WjlRr4xk6kloThVeSj5v243cOrQQMbt5vH06+upGzKIA+hpi+4Z1d5w
 U0jduwqzjAIdg2PWjRR4zl4xqozwGGJh0kKfKFbxzIaU20Bgju9/7idufEJ1v41Glili
 gtosfZ7iTBM66jgAte43pw27dzpAHWeMUBq0fEcr1x7I5X2aXXsa9n6eeXUBgArMyv/4
 n3aRIHoZC5TSIgzZdjL653KbF/UUcm5bAUQV7HrJKp3XWpGGTRgcdrZ8Wtf8QrKCZJGi
 EtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790534; x=1695395334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTrovK4fIdtvshi0BSJ6A7SGaTiEX1KvDjEUM74fc78=;
 b=HY+7kXCbkfYZhCE6lnZdaVqwKUNtDH999kZ/i0eCbM+nGihTZWNJyHHzN4k8YMS/gy
 BtaCv+y9u0VybciSnBQRHMK/YVbQrKuRrFBzVcEEw5801a0nxhbyg/JD+5fqe8OEiiVs
 bRSML3t4JdLdj6snMwRMRvHsnJAGx34FT7LuYHcJB7YXW/6Hn4INO/kKemh8slDlZEbp
 oAUiWbfUe0KNYNfVY5DtbUMsJq5cr49sn3Nd5x+hcvQAXtCTZRT3e0VVjOeBZJeRXjzA
 XlNYNzFIdWQrkj9c13l8tIt5TMlsf4BC8FcTVBa1wHBV5nssW0kk0kI71Ogf+Cta+Dtj
 t8aw==
X-Gm-Message-State: AOJu0Ywrss2gnRH6YF3c/jeDvQ7BtjB0yZ/Eon6gPh7pF6JhfWoWlBkw
 Gm/wZoLuL5O/Ns17BCtXJtny/A==
X-Google-Smtp-Source: AGHT+IFl5Gn38Fb1Fs8+hYQfrM21xDtZSRgdwe2RKprtFax3+Jc4+DirnnYM4o54cDRwXJkFOVal+g==
X-Received: by 2002:a7b:c857:0:b0:3ff:233f:2cfb with SMTP id
 c23-20020a7bc857000000b003ff233f2cfbmr1778245wml.23.1694790534095; 
 Fri, 15 Sep 2023 08:08:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a7bcd86000000b003fee6e170f9sm4857598wmj.45.2023.09.15.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93CDE1FFC1;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 6/9] gitlab: make Cirrus CI timeout explicit
Date: Fri, 15 Sep 2023 16:08:46 +0100
Message-Id: <20230915150849.595896-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

On the GitLab side we're invoking the Cirrus CI job using the
cirrus-run tool which speaks to the Cirrus REST API. Cirrus
sometimes tasks 5-10 minutes to actually schedule the task,
and thus the execution time of 'cirrus-run' inside GitLab will
be slightly longer than the execution time of the Cirrus CI
task.

Setting the timeout in the GitLab CI job should thus be done
in relation to the timeout set for the Cirrus CI job. While
Cirrus CI defaults to 60 minutes, it is better to set this
explicitly, and make the relationship between the jobs
explicit

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-4-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230914155422.426639-7-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 41d64d6680..816d89cc2a 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -15,6 +15,9 @@
   stage: build
   image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
   needs: []
+  # 20 mins larger than "timeout_in" in cirrus/build.yml
+  # as there's often a 5-10 minute delay before Cirrus CI
+  # actually starts the task
   timeout: 80m
   allow_failure: true
   script:
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index a9444902ec..29d55c4aa3 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -16,6 +16,8 @@ env:
   TEST_TARGETS: "@TEST_TARGETS@"
 
 build_task:
+  # A little shorter than GitLab timeout in ../cirrus.yml
+  timeout_in: 60m
   install_script:
     - @UPDATE_COMMAND@
     - @INSTALL_COMMAND@ @PKGS@
-- 
2.39.2


