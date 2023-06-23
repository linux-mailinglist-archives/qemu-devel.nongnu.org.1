Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468B73B71D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfnU-0003pB-M0; Fri, 23 Jun 2023 08:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003kc-Ql
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:12 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmi-0003gh-TU
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:09 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f86e1bdce5so705351e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=Hb2QKjFKhS6CN9UAy8Fe0sRyzyl/vX/Gp7kO8bmVn/wYbE3gmcd+RXla+ak7d2MQ8n
 yxgg/b6VDUyJyWviHD6V8y+G/5t47M0U/puuhb/nuyse2YJgtxCy5UL8jUzxcwAKy9b7
 A4n8uBu+pCzauRTm0cWc9+xY4+ICvU43zTDqjGrKjK2Gqod96YRaOX5MYwFMBpx2qWe5
 jZquzrgQ5+PSelCfZ8wGuD1Us1emqEo7w76BXMzeJsj5XD6wfWcvLoCEpivghayzj8RC
 xj4TERq4Us8g5803tFRnzjay6De0GPiRE2PYgOtfcBfCCc6TdEa6mjQB0WT/31LaZmUn
 aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=XGzb6CUht6JABhZKFbGrftYGrQr67cgtBjc9okXmG2LiGXH0Zw2CX6yqPRoO2Yrmet
 7dAD7rl9mAgroYKCackKDwbCtMwayLQWxaTDegzkfQ0ZkJNrmtWOmtqokufwRWZNYZE1
 /KPWDR8okEEzgGlctzHJZ0m2+3Df89K6jLP0I/1TSfoH0pF6o2Xtwj7Cc+Nw1ft+PYyX
 nTi16ChCAkRQjozpHUEGDz1c8uHO6T9CBqYHu16cVWkJWzX10NnTmddBHtfrdjDbSefv
 Z2nrI5DWbqlVN9PpXjrot2fP0sdCzTRzLWY4zfmnJJ2JRwT2yGJx4/y3iMgU0R0en1ZC
 F/rQ==
X-Gm-Message-State: AC+VfDyHClucHcRErsf4DZSIwez68TgL4YLu0ysWrW5747yqb9qUeW/Z
 IPXJM+TB6o+wETCI26hlY/Mb5w==
X-Google-Smtp-Source: ACHHUZ4JVY3kfqXbNdp+0RXbwPzG2sg67l4flSzexxUI+3W7pd5yaArCU6rUz/6rIKvdfx8ESkf20A==
X-Received: by 2002:a19:791d:0:b0:4f8:6f40:4773 with SMTP id
 u29-20020a19791d000000b004f86f404773mr9242977lfc.7.1687522862905; 
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a5d498b000000b00307a86a4bcesm9415759wrq.35.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F41251FFBF;
 Fri, 23 Jun 2023 13:21:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 04/26] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Fri, 23 Jun 2023 13:20:38 +0100
Message-Id: <20230623122100.1640995-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


