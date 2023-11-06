Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8499D7E1FC7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:19:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxVK-0004Ez-G2; Mon, 06 Nov 2023 06:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxV9-0003Py-Ck
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:10:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxUq-0005zR-99
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:10:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40839807e82so26144725e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269018; x=1699873818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RacUCXaZM0ryRlMszwI6IYYuk8+9tjRt89OkiSY3LIw=;
 b=EzBOi4PfEALhKkouVWOm7FqjKNqKmlKeZepu8TqeJXEHXCyGnACc/Ig8NxK9QknSTm
 DaoMLF3KwWg1/5ZKC0DaX4ROo8SyD3VWOXwGnq8XwRzuMfuVg2/Re36ZIeoH3GY2LxnG
 p3NeINosJAf/FIXd5XKEOR9B2j2XKbHOoMIspZk8A9eIOGLpKmSQXm4Qp3xvJ96SfWdv
 ltAt4C8MkIvZJJP4glQqbJnuw6RnuHFMCZUVeMUkWkj+V5DdHLkHPviX/VKYd7r3l/b5
 OqZbIn2SRLYoA4ba1LhSwkIJGFjhGWTlNvXtQue8WHWzou9Vdwk8SnpzY5JmppPcZp+q
 u2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269018; x=1699873818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RacUCXaZM0ryRlMszwI6IYYuk8+9tjRt89OkiSY3LIw=;
 b=c6j969jSGs+nwI0+uyN10bPMMow3EWfT71dOtN6wT2qvM51N6iWcynZlgJ0n/eWo57
 NRPGbZdkuWMUA8yryabXVV4GS6sLS0dQQYJtymChO02U1NP/zNvuwoltKhCyUZX2aVNm
 HrquseR3q3aHX/4Tx/klPlqzvaoMbS8vFqDYDQF751ijOLpgRhbM9ktaLA5yKlC6sIZP
 TUZKqpT/cMsnvVBh5TKKW0eFUALzkaaGXUMFClT6eS8vNKIl+qF4TsVNQ2EcvmSxT+6i
 AUvvRbIgDfmZxiH3Lm1IfVQk9vp/iIdyiJrniZ/GXEB2dmKmhPt8n4iX4/w7zh82W5sw
 l3nw==
X-Gm-Message-State: AOJu0YxPT4iuE5b6nXnPO1555F9wRWNnDcFjE2jr5Ms5OJfj8skui7SM
 h1Ro34gavDChn435tz+69Bp2gvo9vJFcHxQ4EJM=
X-Google-Smtp-Source: AGHT+IHCLWJGvQCJQCgk0pcjJbrXFUVevq6ZIuy44lY2uK/9jLH2wD0CdVyKAn01kc68xmugzJzUNg==
X-Received: by 2002:a05:600c:4e12:b0:406:51a0:17ea with SMTP id
 b18-20020a05600c4e1200b0040651a017eamr11538636wmq.10.1699269018513; 
 Mon, 06 Nov 2023 03:10:18 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0a4c00b0040775501256sm12046304wmq.16.2023.11.06.03.10.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:10:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 59/60] MAINTAINERS: update libvirt devel mailing list address
Date: Mon,  6 Nov 2023 12:03:31 +0100
Message-ID: <20231106110336.358-60-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Effective immediately, the libvirt project has moved its list off
libvir-list@redhat.com, to devel@lists.libvirt.org

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20231027095643.2842382-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c57868c94c..3582e2a71a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4049,7 +4049,7 @@ F: gitdm.config
 F: contrib/gitdm/*
 
 Incompatible changes
-R: libvir-list@redhat.com
+R: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 Build System
-- 
2.41.0


