Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D854821F34
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhGh-0006Ft-N5; Tue, 02 Jan 2024 11:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGJ-0006DH-Qj
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGG-0002QK-7I
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:03 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so101436625e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211498; x=1704816298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BRQYwKaD5nL/etQUQHLcvnsdC8oyTg3NrDmrCWZHoMk=;
 b=yYAGIa5CtRSixTq6vJVQ2y37T2eH1sa6tbld34cUfDfudxvdYsKEpl4VuLiJ2e4S0t
 5fSmRN7VV9R7tilse6VdmKXA4+04/WgE6W3qleiq7Yi524kuqjhREnsJGgNwmr+IbQJp
 ROW8trxi5Jx4JoPiKdRInsKc7i93SLimiCjyI6E6CJJRBjXzqIbV0hs+h2zHkW7PWcoL
 OILo26dF5bGWaVWFAvmxwU9hO/nZnKUFbQiXMRDtRl7n1gRjnYZxDF1DbO3ELGegJMGQ
 GE3yj6mQ8fWGoERgLIgYoxBFnndPBZGIK8Q8zi97li74ehGIgBgTW2zKSlWkp/nQDFIA
 Kugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211498; x=1704816298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRQYwKaD5nL/etQUQHLcvnsdC8oyTg3NrDmrCWZHoMk=;
 b=PNIW7nOe05rU3f9ZLD1ApTRHkurH6LKg3rVCMkDjAop+8s4CcZj8QmqN+cvh3RW1ZD
 YBX6YXU+2aIaZN2f971FvaAXbLEGHekEAisfxoW53G6Zw0E1ELx1v2cupt+lhC5VX1Kh
 s64QLDE148dI8vii4TnzG8no0nTC8TzGWYHxQkvaGvCrcXwbCDVZA4UFxwMR31hod2Gf
 rRVBzbP1KpMsm2XXcx+HHW3AbjPF3qV+XWsrAl1ZTH0G0gCCuj322wMOmJyib6+9VyPU
 JCqTL5hD0dSJHSdF0TGcFPHAZ5WdhOSdOA7r/rfAxXeefXkW0qaWQPRb+d8yxpaLckQj
 +9NA==
X-Gm-Message-State: AOJu0YyXYytVZGOuHqKvVykP2P/jaIkqwVtT2Gcp3NX2yyPvhMGMIWWd
 0HbSSkVzIgrZzmi/+u+0tJadbv3fY6fuPrtiG7vSLcahfvc=
X-Google-Smtp-Source: AGHT+IHQtwEk+w4KhJjo4/830fznlZXmm0bpqHzLPVNoK/axg8rCeYPG/UvnDRhCrnJNCEZZWj+TiA==
X-Received: by 2002:a05:600c:4ed3:b0:40d:4d87:39f7 with SMTP id
 g19-20020a05600c4ed300b0040d4d8739f7mr4417565wmq.261.1704211498296; 
 Tue, 02 Jan 2024 08:04:58 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfec4a000000b00336670abdcasm28690520wrn.40.2024.01.02.08.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:04:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/5] qdev-properties: Try to improve use of dynamic
 property introspection
Date: Tue,  2 Jan 2024 17:04:49 +0100
Message-ID: <20240102160455.68612-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi,

This RFC series tries to work over some limitations exposed in
https://lore.kernel.org/qemu-devel/9293e63b-8032-4ea0-b516-9db6949fb607@linaro.org/

Eventually all QDev objects would use static QOM properties,
but in some cases we can not. ARMv7MState is a such example
adding properties that might end up irrelevant.

This is just an example, but thinking long term (in particular
in the context of dynamic machines) I'm looking at how this
could be improved. Thus this series. I don't like much this
current approach (because more boiler place and complexity)
however this seems to DTRT for the user.

Philippe Mathieu-Daudé (5):
  qdev-properties: Add qdev_property_del_static()
  qdev-properties: Add OptionalBool QAPI type
  hw/arm/armv7m: Convert ARMv7MState::vfp from bool to OptionalBool
  hw/arm/armv7m: Error if trying to set unavailable ARMCPU::vfp property
  hw/arm/armv7m: Do not expose 'vfp' property if ARM CPU doesn't have it

 qapi/common.json             | 16 ++++++++++++++++
 include/hw/arm/armv7m.h      |  2 +-
 include/hw/qdev-properties.h |  7 +++++++
 hw/arm/armsse.c              |  2 +-
 hw/arm/armv7m.c              | 12 +++++++++++-
 hw/core/qdev-properties.c    | 17 +++++++++++++++++
 6 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.41.0


