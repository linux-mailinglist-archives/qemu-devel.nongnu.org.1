Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66CE74AFFA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhK-0002RC-6n; Fri, 07 Jul 2023 07:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhB-0002LL-AK; Fri, 07 Jul 2023 07:32:19 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh9-0006f1-Ma; Fri, 07 Jul 2023 07:32:17 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1b0719dd966so1771969fac.1; 
 Fri, 07 Jul 2023 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729534; x=1691321534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgDEIY1KrUkt0jFnt0ohTLSS3hQiqAQRVAjNcTpmkVU=;
 b=snGLczJldTpQwOK6t6dU7mYDaJtU+06SdzN3f+gLs9/+yQZL1F0QFZPH4+AIxIYxUZ
 k2aRGBLkDdqcl7SzshZ7tF4/crnohF24fP3yaS4l096uMi90CeTDJ/UFCSDHXHXqeYK3
 vkLjSAmI9RNcksqlY64WtkMYLDfrDIuBmCjrgHfuHjSMtcQfRvsYKlvQgaCIBcfRmXYg
 I/IK1EPETNoQXkBujGxkoULc6R8zNJ8ep6zoBQsv6BM5mjES313NExMy4J1O/tNaTx1+
 Skx6SICwBtBgruxVrlBY5j48GWs5/rtSOAe+9Oet7Mrf17USLttOsZ6ESwiL64KZDBx7
 5XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729534; x=1691321534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgDEIY1KrUkt0jFnt0ohTLSS3hQiqAQRVAjNcTpmkVU=;
 b=YUQ8eiKj5eq7yM8rCdkzOozfN8ycf4SS4W8X+A2OhYmLE+Y7MtcyHZ4T03bR5LZfJU
 l5F6mawxOuPL1secCarRqQMuFDdZs+LDfnk7lxd0IbWsfYgWjOpMPuuG+7mSlgNFBz6k
 lYq36THsKowhGkVVNn0DneICEeQi3nbPCd27vKDEfGgQ7WqqoL+R+q3OKH5HKYYora8z
 gYDJaYuEQqrXUyQkatbf4m672tAwjNCGZuD3E/DPfgASva6l/OvncKREZ6rW4+/HC0Qa
 YlVP4lKxpS8g5npso81QRkkyVQ32uoWOOWduIGfZVzFYR0hNBldXXmQ+rygUX+E2xDeM
 hKRA==
X-Gm-Message-State: ABy/qLZvmJSbboeYMBd1lv8GmwoezsbrpncD8gZ+ncZa9rB5uhXmlphS
 ET4uDoF+SxSmyrnsM4bzjcb8OFOrHWE=
X-Google-Smtp-Source: APBJJlEeJHkfb8HrcI3FUv+X5qhZJJsSYxHD8C2Re6hRryozxRhLTvRt9GIEVbmZnYBNyPm3LYAtuw==
X-Received: by 2002:a05:6870:c1d2:b0:1b0:3cd4:76d5 with SMTP id
 i18-20020a056870c1d200b001b03cd476d5mr5454728oad.37.1688729534218; 
 Fri, 07 Jul 2023 04:32:14 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:14 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/60] pnv/xive: Add property on xive sources to define PQ
 state on reset
Date: Fri,  7 Jul 2023 08:30:28 -0300
Message-ID: <20230707113108.7145-21-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The PQ state of a xive interrupt is always initialized to Q=1, which
means the interrupt is disabled. Since a xive source can be embedded
in many objects, this patch adds a property to allow that behavior to
be refined if needed.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230703081215.55252-2-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/xive.c        | 8 ++++++--
 include/hw/ppc/xive.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 84c079b034..f60c878345 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1232,8 +1232,7 @@ static void xive_source_reset(void *dev)
 
     /* Do not clear the LSI bitmap */
 
-    /* PQs are initialized to 0b01 (Q=1) which corresponds to "ints off" */
-    memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
+    memset(xsrc->status, xsrc->reset_pq, xsrc->nr_irqs);
 }
 
 static void xive_source_realize(DeviceState *dev, Error **errp)
@@ -1287,6 +1286,11 @@ static Property xive_source_properties[] = {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
+    /*
+     * By default, PQs are initialized to 0b01 (Q=1) which corresponds
+     * to "ints off"
+     */
+    DEFINE_PROP_UINT8("reset-pq", XiveSource, reset_pq, XIVE_ESB_OFF),
     DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
                      XiveNotifier *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3dfb06e002..9f580a2699 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -187,6 +187,7 @@ struct XiveSource {
 
     /* PQ bits and LSI assertion bit */
     uint8_t         *status;
+    uint8_t         reset_pq; /* PQ state on reset */
 
     /* ESB memory region */
     uint64_t        esb_flags;
-- 
2.41.0


