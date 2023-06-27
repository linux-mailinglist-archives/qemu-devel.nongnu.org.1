Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9C74009B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGP-0008MK-U3; Tue, 27 Jun 2023 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGK-0007yR-Ej
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGF-0005mu-Lc
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79f0so32613885e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882186; x=1690474186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=VdGrfPA6puzynaTrxTFdyHjJSEEkIgsO6RsORbiy5JhNRfN9QsMoj6jtRHHMbUUvMV
 BiHAj0em54V6lf/Rl5gOk5quzoLvPFci4XTZ7SklZP8sf4x+UKZvuYDOsQvS+Js1et4V
 RezQ9Gg5vxJmmzCw5SgOeRmr2HKLVrR0NhJdTd2AJkFB+3hCKirvOafPER5wM+COCb50
 2S/7gH0suykPW60tSscOzGTyAFOZmnu7nrgqpLIcRb0D/qYot2qgrQctFfldeJkFW3+x
 MdcprhveDXLEjfHSrFz8y3pzpZtLwJD+D8HQgORuMHWol+XTPw3Vry+QU/TpC2ut7bU/
 RKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882186; x=1690474186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=YSdwCRCSpp0XwkB/Hp0pWSgK+dOfKTQW8bCaBLSir8xokrZp3SHBO0MQ1jVykAuX5a
 /V4ASiZsQzwMyM1/LIgOlMXav4LMjS8KvM9URRl136+IQp5NVpn7KpioklfNAJNPzK2t
 KLwAm3rYUbv+gGxFi76MWpPL9CKTur+sQshf71z4JySlW5zp5AgzlfVqurF7BqS9H6/7
 j2wYNfyg/Pzcxk0b87DY+826AmnXXqbeaAtd/24ix1G6BMh+5HCvyVfkJEQAK3SMecu+
 60qI6uyUw3QzF0iVH5apEcnAuN6NvSTEuCEkBQ7z7PF+IR77KwVNchDD/9zd7o5zCg7Q
 4FOQ==
X-Gm-Message-State: AC+VfDzPOmKJ1x/aU9brUfOoL9Mi5SrEn4apvKUgTMkkNFuTOZH0hqU9
 7TQhHTSdfAXbq13Jd4JaPqpRRGEok4EBEk4HNdg=
X-Google-Smtp-Source: ACHHUZ61ObIFeAo3IF+vqdWk8wY8wwgHKlip50dsT+Q5Ex1ANzz7YTnkSQAEtEE7/ZM5O/7pUbU7Mw==
X-Received: by 2002:a05:600c:2284:b0:3fa:8219:9163 with SMTP id
 4-20020a05600c228400b003fa82199163mr13570168wmf.21.1687882186358; 
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b003fbacc853ccsm80148wmc.18.2023.06.27.09.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5964E1FFC0;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 04/36] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Tue, 27 Jun 2023 17:09:11 +0100
Message-Id: <20230627160943.2956928-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


