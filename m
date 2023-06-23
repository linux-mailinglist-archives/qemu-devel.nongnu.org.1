Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C593473B743
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwe-0001Kp-VH; Fri, 23 Jun 2023 08:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwJ-0001AR-Sp
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:01 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwC-0000Tw-Nq
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:57 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f86bc35f13so730075e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523451; x=1690115451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+Ft1R3JBDSn9JTJ33FIkeeIZZV1IyyGZBrwy7UUFlQ=;
 b=UrZpQuhJ+ELEtNGXLL+z+JySVvPbOrVLnheKfv0tZpfAEc4bttSAfyN5sp1TfFEy94
 bR/7Ge85dIuxeFwTrYTkfvwRzEiqbMOxjiH+b7CQOSNVGwkzt96+s8f7gDllq0x7D0+P
 HNlt+/ykaqZ2Akdl5cnjLglFlppu64x7OMCiM5NB4PFfTWxlaRBWvzE1sIng6Ovr7i47
 0FKZDSJvZ5ERU3dZhBrB6Rfc+MDALLdfnpGY68Uq4iFpBIMY33H1s9SDBxH04VzDo8JX
 lKOAMQTn1CVdYx9OOj3xggbWREqfBK2qigxbCAFmf61rLC+dRlsukZ+pWFroD16b7PHQ
 DgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523451; x=1690115451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+Ft1R3JBDSn9JTJ33FIkeeIZZV1IyyGZBrwy7UUFlQ=;
 b=MCljgqjY68fAl6M2WIUTpswihzvwxZLXfi2kqNHIt7iJGOp/9mNJl2iJQrfgwwMYaF
 FMFkfzX92hVM3q00gre7G/iv7oSo3nHgKEVxuv7jz22el4tjLuXIzG4PgQFuQ7EwwoFt
 uWEzMX8H4L6mH3uNTUVY3w1Vy5z5xK2k35dv7em9xNHJ15rh0sn5G+4YAL+Dseo2kqRl
 0Omigfs38b/na2hmdKBfpHRc98gTuKj7gEWxuv4z7aHYNFfeKrvYhap8eWxWCt7QHYhq
 yDqeuXQhT40TQjkqpHEMIN+Cv7YEqeMp5ZNH/x5EuiWhJaFVitP2+ZcycpDWxrz2TgNk
 asrQ==
X-Gm-Message-State: AC+VfDwJ3nFmBE/jh11GWraCerzqX2g09fBgQF3sInGyn6YnJY6/wVWX
 nx+wtXz7r8EbjDeHeDx7sqDhrQ==
X-Google-Smtp-Source: ACHHUZ5IDZKKJxx8o+7MLxaC3WhQErEVaEaa63qb4/7b7ezPo9I4dfNU4ZkXrv2VRkgO+doDwMyLMw==
X-Received: by 2002:a19:e602:0:b0:4f9:5781:862a with SMTP id
 d2-20020a19e602000000b004f95781862amr5631412lfh.38.1687523450939; 
 Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f9bd9e3226sm2261931wmi.7.2023.06.23.05.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2DC31FFCF;
 Fri, 23 Jun 2023 13:21:03 +0100 (BST)
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 26/26] docs/devel: introduce some key concepts for QOM
 development
Date: Fri, 23 Jun 2023 13:21:00 +0100
Message-Id: <20230623122100.1640995-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Using QOM correctly is increasingly important to maintaining a modern
code base. However the current documentation skips some important
concepts before launching into a simple example. Lets:

  - at least mention properties
  - mention TYPE_OBJECT and TYPE_DEVICE
  - talk about why we have realize/unrealize
  - mention the QOM tree

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-6-alex.bennee@linaro.org>
---
 docs/devel/qom.rst | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c342ce18e3..0113afb6e6 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -13,6 +13,53 @@ features:
 - System for dynamically registering types
 - Support for single-inheritance of types
 - Multiple inheritance of stateless interfaces
+- Mapping internal members to publicly exposed properties
+
+The root object class is TYPE_OBJECT which provides for the basic
+object methods.
+
+The Device Class
+================
+
+The TYPE_DEVICE class is the parent class for all modern devices
+implemented in QEMU and adds some specific methods to handle QEMU
+device model. This includes managing the lifetime of devices from
+creation through to when they become visible to the guest and
+eventually unrealized.
+
+Device Life-cycle
+-----------------
+
+As class initialisation cannot fail devices have an two additional
+methods to handle the creation of dynamic devices. The ``realize``
+function is called with ``Error **`` pointer which should be set if
+the device cannot complete its setup. Otherwise on successful
+completion of the ``realize`` method the device object is added to the
+QOM tree and made visible to the guest.
+
+The reverse function is ``unrealize`` and should be were clean-up
+code lives to tidy up after the system is done with the device.
+
+All devices can be instantiated by C code, however only some can
+created dynamically via the command line or monitor. Likewise only
+some can be unplugged after creation and need an explicit
+``unrealize`` implementation. This is determined by the
+``user_creatable`` and ``hotpluggable`` variables in the root
+``DeviceClass`` structure.
+
+The QOM tree
+------------
+
+The QOM tree is a composition tree which represents all of the objects
+that make up a QEMU "machine". You can view this tree by running
+``info qom-tree`` in the :ref:`QEMU monitor`. It will contain both
+objects created by the machine itself as well those created due to
+user configuration.
+
+Creating a minimal device
+=========================
+
+A simple minimal device implementation may look something like bellow:
 
 .. code-block:: c
    :caption: Creating a minimal type
-- 
2.39.2


