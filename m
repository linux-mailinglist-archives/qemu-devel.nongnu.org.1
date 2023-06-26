Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B473EE2F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:01:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFF-0002Zv-4o; Mon, 26 Jun 2023 17:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFC-0002Y3-Bj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF8-0004rK-KX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9b4bf99c2so48989645e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816769; x=1690408769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=y0nLxk0snNorSI6hy8O4jEf4FlNP7Ts438y4J+viEJoWCViSPRThDFMM32uK6Uv6oG
 1QihAK670HLzSpKYFRUpBYxoTPtO0bxLMBd/uLJrrtyxwR4bwVY1vHus0NPLqj4RW68C
 6HTd/z7SdnpmET2QdZqAxFOZx0Ot7WHbyO2XyfDA9XS/Or6lR+q4iCuMKoRhyhsmG+j9
 VlJ6aFL8/hF5+eOziiOE9wKM35jhHEtruawMbNWgcX15k969fy/wuaToFw8D+bSPZKH9
 4yPIJb0FqilAzJGajygIdemNS8gUXZmB1Y+SkW1XBEskB6M+5f/8PYZdgrRzKMFn6BoY
 FO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816769; x=1690408769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=SM4GGPIch7Ex5iUAHxFHmgrsrxxXEljBCNvm5C5VyYAnE1quUu8h6MvfKQgX0HwaP+
 iJK2YZ3+n2Is2OJPxBAE1SWyqOTmUj1EwiSZKIFvaFN3zaTPNUWbgVZD1kZSf8qj7WXK
 Bf20qnYEVMKMU+oiFRzm7zhxLtOdfB8Khaqu0+39WiSa1KuiPoBa2HFFC5B5wXzilS0W
 7zoCvfZsYbTD3jowUdmB8YYrLouwu8J3aNBjPmg8wXWW87ahIqSHDqekVkvoJ+jTwAB9
 upw/ULK4/jg/pHAuxUlr+0+IKfVcasHJXBV0gNiED9B/8P6xh3Q4xLKnlskrh+PzP7nf
 HAIA==
X-Gm-Message-State: AC+VfDwmXm7UHcYljIw5B9h1zT6M02K1j1kks10c/PZnu82R+WxGDzVT
 E70PJH+EBLmfsBTvsGc2U5AIng==
X-Google-Smtp-Source: ACHHUZ66Q2KT1EVq2R6AYQljZ4rgnsWELrc0t95sw9DEkXQ0z4qnmqALplaz3Jd12mZckM2j457+Rg==
X-Received: by 2002:a05:600c:22c2:b0:3f9:b19c:aab4 with SMTP id
 2-20020a05600c22c200b003f9b19caab4mr17137646wmg.6.1687816769384; 
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003f42158288dsm11730705wmk.20.2023.06.26.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 566031FFBF;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 04/26] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Mon, 26 Jun 2023 22:59:04 +0100
Message-Id: <20230626215926.2522656-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ani Sinha <anisinha@redhat.com>

When new dependencies and packages are added to containers, its important to
run CI container generation pipelines on gitlab to make sure that there are no
obvious conflicts between packages that are being added and those that are
already present. Running CI container pipelines will make sure that there are
no such breakages before we commit the change updating the containers. Add a
line in the documentation reminding developers to run the pipeline before
submitting the change. It will also ease the life of the maintainers.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230506072012.10350-1-anisinha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 203facb417..8f18052ba7 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -485,6 +485,12 @@ first to contribute the mapping to the ``libvirt-ci`` project:
    `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
    page on how to trigger gitlab CI pipelines on your change.
 
+ * Please also trigger gitlab container generation pipelines on your change
+   for as many OS distros as practical to make sure that there are no
+   obvious breakages when adding the new pre-requisite. Please see
+   `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
+   page on how to trigger gitlab CI pipelines on your change.
+
 For enterprise distros that default to old, end-of-life versions of the
 Python runtime, QEMU uses a separate set of mappings that work with more
 recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
-- 
2.39.2


