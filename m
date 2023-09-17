Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB407A3E74
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bh-0006V5-Nb; Sun, 17 Sep 2023 18:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bf-0006To-7A
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bd-0002uj-Kw
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-402d499580dso42233625e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989456; x=1695594256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw1dyfbeN3ouZtpJ+EsLMpnbrhAyvsGjO2B8aC+yH6E=;
 b=ioJAUD7DnyjkijwFNbBbCHfELSRO+4Qc0sD7AZ/WvxTImmXs2A+7t06IKHwrJb5LNG
 gHviEx+4bqwTgUQds36ufLgCljQhBYK5atTl0swpB/UhBqXGhdgAXLsJCiMydy5IHIrI
 vNiY045LtOTN2ql4q8vBJngK3CFLYJUT0DhvEfsiHR4fcHIXckEFRTiQV5+IMIfJzOu9
 UT9ZL/oWbLFBICFKqyDhr1ITfcwfidDyGMy0woICXI4WZp8duPISHqc7js6/0WifERxq
 WCkaoNqQ98cwYHt7LXeacLqUAo/fPLRzM7FhlvTJ4Ig2+4QMsbseB04mFiUhdeGp4+SJ
 ZmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989456; x=1695594256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw1dyfbeN3ouZtpJ+EsLMpnbrhAyvsGjO2B8aC+yH6E=;
 b=bQO8P5NnuG6QrtqPlLwTKqfGTQ/HI6T7K8/U/hQ0pX6QH+80EoKzYqAs3Bp2b2FvOg
 o2+rPpl4yUOF62eVkc7GTLF/Z3bnRL0zYmfdklaaKHhHN1lVFHvpU70yLv+zq5xQ62Ox
 txao+FxKk9pBuoqrlBrtL5qb8p6GtE4nILVwI9YO5XmPsFXBz3jxuqG6fF66RGwXMccH
 gKavP9C1fiqKo+f1ZhWsfa8BPuUYNduWxJoEu1lkFfUI1X7IOY649ci497y90lDHCYcc
 tohsysOMb6xjshKNOY/Ql+vcsdWA3m/7Uwxcl22Szui+77NkCTalDTltMqHp4+jToevu
 RWZw==
X-Gm-Message-State: AOJu0YzHBS/y8rLRri7VdR0sAIUpDHSamkGVASucRXqRCo26fWHXS3Fg
 U3o8qSuGGqhkLVaUgZT4yDIxG6X4wFw=
X-Google-Smtp-Source: AGHT+IEexgJbOGFQY/wg0WfjAtXy7WGzsukFxIyjOqBC4JkE2wE++LRYUZMTsOa4Tb/RBReTRi9zWg==
X-Received: by 2002:a5d:4952:0:b0:317:6653:60b8 with SMTP id
 r18-20020a5d4952000000b00317665360b8mr5830122wrs.50.1694989455744; 
 Sun, 17 Sep 2023 15:24:15 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:15 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 07/28] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Mon, 18 Sep 2023 01:22:24 +0300
Message-ID: <20230917222246.1921-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 68410a0aa9..19e39a2f76 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)
     return code;
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    return tswap64(target_rlim);
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    return tswap64(rlim);
+}
+
-- 
2.42.0


