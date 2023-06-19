Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2134735CDE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISv-0003Nf-0N; Mon, 19 Jun 2023 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISj-0003KJ-9B
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISh-000258-Em
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f8f3786f20so44202955e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194881; x=1689786881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqZkN80sHKFG/1nL+XOE6YDm/Z/wk4N5tP5bpONv3gA=;
 b=aGh+xSEChh285r3fEZZ72OP+h3yp7+pEaPcJs+I3s4tspPqHwlIgy0PZayBWYCnp86
 mvQaDyDuZ53sbkK9RbDLNiOBNyyG7GzI0oDg9KUzgqRvOCjFk8SPug5pHFvlbNtayMC0
 JPA6tYByGDINLBO21ZjHMvB+9CnT0hgT/2pnCWjgfCar/FD/dARpZxT+Rl18n40XX1EH
 VMA/WRaK/VgOMF5WtDHbiQTaytUF7vTkzUx7wH3eBwD+zQrFSL095eMiK2ozYGg0zW3I
 jkhPugmHPvWKCnauusqp9gKQlZqOUH0YXrmGb4pw/od33gnVoEp9JDnUtrB7tCI5bjSS
 WPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194881; x=1689786881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqZkN80sHKFG/1nL+XOE6YDm/Z/wk4N5tP5bpONv3gA=;
 b=PSF71iyEAEDgepvA58mC+gvMH1BRIXNB62JFDIG1RLkw58b+E7U9YFqaWnDCB2b2To
 nmU0HhzTQf9pLK29Z01J3ecgLPUFqyBFihrSLjDdKEI+MRJ+fou+ksmcmyiBNQ2rS4Yw
 gWSg0WYd5cg0d4+5jGTgedSLIpOr/d51HcQjZPXuF2acrgZ+ZyjPZlVnE9wpNWuDFWQD
 DKGW4uZI7FcQVORp48nNJqkS3ZNWriLifoijl0iO0EE94y2aTqb9pIWAc3zVrp4S5es7
 7y+fwy9wrQ0S4pLhgCphX+xHkAAjGaeVqgb28xZPWSkoSJiskB9DJMEQDNQs3KlNTxDQ
 B0Qw==
X-Gm-Message-State: AC+VfDyi/xJM8wjidXm+nwX+piwckLoDjO5HRQOeGNA3g/FVbyyQj9g5
 8x3I4a7J35TAACdjy5aoYiyd+A==
X-Google-Smtp-Source: ACHHUZ4RVGdbNB2/6AvDGaAdEcs0J+loHI11h4eZlZGSjQ2ZP3s1RQke1+uwDBnC1E5Yr3pjV8b4zw==
X-Received: by 2002:a7b:c459:0:b0:3f9:b3a3:52ef with SMTP id
 l25-20020a7bc459000000b003f9b3a352efmr1508484wmi.36.1687194881474; 
 Mon, 19 Jun 2023 10:14:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a1ced05000000b003f70a7b4537sm11315830wmh.36.2023.06.19.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6D851FFC0;
 Mon, 19 Jun 2023 18:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/5] docs/devel: introduce some key concepts for QOM
 development
Date: Mon, 19 Jun 2023 18:14:37 +0100
Message-Id: <20230619171437.357374-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619171437.357374-1-alex.bennee@linaro.org>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 docs/devel/qom.rst | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 98a4f178d5..53633fbd35 100644
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


