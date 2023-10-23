Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC77D3EAD
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMX-0005QU-Iv; Mon, 23 Oct 2023 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xLY2ZQYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com>)
 id 1quzMV-0005PK-96
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:11 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xLY2ZQYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com>)
 id 1quzMT-000700-Pq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:11 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a7c97d5d5aso51131057b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084548; x=1698689348; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8ppsMvh/1xNcNQO771azU3b29zpBvKMbcZRVkj/3Zw=;
 b=1KbHF9DCw6uQoXWT41IMraAkueuAzp4C25/48q1LyzLuZn36Fd6PMmvjZwGfkt2mnq
 4oSPy0VDW5cyTZVX8B940SoQdNqrBLxDvMyhG37GUlBAAFM1BbilTzAvDfqBaA/zg0uU
 8BrjMEj2HR3iZJbOCn5PhTjIEREUpjh5b0bb6+HCX+XCixaRwad8PQYWBq6hOiTRHtJ9
 PLz/Ms6CuhvTf1ivV/x5Qb2y1DjGA5QRtvkhGWJehUIZLdn3Yf5nDFp5GZY0pU7WCS9E
 XChJFdcAGQjkltgYq6Q57H9YQRPmqxXdYm8hxkUwKVfubfvjxpgs6Xb7fGLEHOWcmlDF
 hXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084548; x=1698689348;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X8ppsMvh/1xNcNQO771azU3b29zpBvKMbcZRVkj/3Zw=;
 b=S0g6gcseNY4YspJ5uaT1O3bylczjSo4W0HPVe95TwgmEqMsbrFztDgb5DqBk+PqdIc
 gIZysiwRlCk59xBvqgDBQac31lWb09QuRDbJeiIUhK8YqhLmPTWmX4FfYSI81ORhsrYk
 vOM432UmvRg3WyS5y5gisHSiF6hp1CpeRqsw0IjQ59RgpvmzA1z8UhJzLWgsWZAfMgpl
 Ktr1GzUjNCeDngAYjSqOgny0JpIWYsn9auzrOJGZ8CYOHWEqvhvExH6SFXOOamQ75ncs
 3FT2/bWHHvONKwqUuClH36wQuIv2x/ir2i9/gPM6RnHh79s3gMbSd4ycBQDIILut8mEZ
 M7oA==
X-Gm-Message-State: AOJu0YztZ9sVSARC7F9GcvyVt6RSJ1EjPHl9yUJ0PxkBT4JbI5m1ORFC
 RaEvJDFwbZi/IOfB29/SRMiO4P1Zz6E=
X-Google-Smtp-Source: AGHT+IHm70UmN1cCl5f/TrbhLMtBD23e0l3S94nMgRzBqiI8LfCWtDgwlJdnAX0uAeABr0aUrhOGmePvIRs=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:dfc3:0:b0:5a8:28e5:ca68 with SMTP id
 i186-20020a0ddfc3000000b005a828e5ca68mr224325ywe.5.1698084548530; Mon, 23 Oct
 2023 11:09:08 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:36 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-8-titusr@google.com>
Subject: [PATCH v3 7/8] hw/i2c: pmbus: immediately clear faults on request
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3xLY2ZQYKCj0shstrqfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--titusr.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The probing process of the generic pmbus driver generates
faults to determine if functions are available. These faults
were not always cleared resulting in probe failures.

Signed-off-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i2c/pmbus_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 3bce39e84e..481e158380 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1244,6 +1244,11 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
     pmdev->in_buf = buf;
 
     pmdev->code = buf[0]; /* PMBus command code */
+
+    if (pmdev->code == PMBUS_CLEAR_FAULTS) {
+        pmbus_clear_faults(pmdev);
+    }
+
     if (len == 1) { /* Single length writes are command codes only */
         return 0;
     }
-- 
2.42.0.758.gaed0368e0e-goog


