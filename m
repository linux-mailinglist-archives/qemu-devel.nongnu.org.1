Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B041E81AD26
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Zz-00007O-63; Wed, 20 Dec 2023 22:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zw-0008Im-O8
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:32 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zv-0003w6-38
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:32 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-781197600bdso15722185a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128709; x=1703733509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GHmE213/jQLNhCgwdpR/N76z7mYnciRc3jPzsuH3Qo=;
 b=FA8s1NdnE3ZfO/rOtlsx7rzE1elsNsQd0Z7KXaEZselSlajcDDx4/GHgkzdU0HkdOE
 7rVB0Bz2aWrEK0DvUosXzMl6WlaPpvxXV3hUwJX59BrN92wq3RFh2I9JbJas3X17frHc
 QUme2MxN/8RfqMD1EF34tB4aLqoi+2A8fIa4gm28Fi/tq/Wjy89ePXqaABDLzJR/BP1p
 yM2uoKeBFeHrrIrt2FFT1jkojYDp2w5BMmsNMMunvyJJF69zxWQ1mP4P7CHuXm9mVFh/
 EgIi1JWvyXTZwOVRnz8cSesIsKnSxMaUX8iPFx1rCO8uBKzF3Rwq0kO1eYsM6/TO+Qbt
 /94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128709; x=1703733509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GHmE213/jQLNhCgwdpR/N76z7mYnciRc3jPzsuH3Qo=;
 b=pKlsMXs7MEemNI6AGb4gtoN3vhrveds2W9wFLQBA8KS+4Z5OBimfnifO2+m/QGQDmc
 4MSfcyx0e5rv9Yl7gT8pdcVw8J3Di2qo0Ot4EIn8RoMAcgLajJ+wgiaU4DhER/Qyv+0+
 /ErvC5oLStxnYvzzj36D1KipOx+wGnCT3VgpRnx+3vGFVt5OWjkEDv2uDKKQHBL/sbav
 g7De0KotessLRgYwYOIo79RuZQq2T2fScTzEd2Tcvpy0LbVvKDK8GLogN0f2NZ6CJjPn
 eoopAu5Y6BI68PDcj20o0jxqeIb7DFQElIRRKnwLmUHXnPHpCVCJ2w5+ZCiq/P0/xnsj
 RbCA==
X-Gm-Message-State: AOJu0Yy+vzhuT829wtISa1meiRjVz7Ndxlvi6N8407Fen6LCUqa3X0UG
 Mk9hVSkR3oBnNQ+UjiNIljfKv2jo8iqR0V3MWcS4s3o5
X-Google-Smtp-Source: AGHT+IEKp7pSK0aYI69mT/DIuuMQlpazzEAT24evW2BJ3kQlDoECt0ruiersLiSUxlrvZvK0MPPDOA==
X-Received: by 2002:a05:620a:2456:b0:77f:25ee:46ca with SMTP id
 h22-20020a05620a245600b0077f25ee46camr19640016qkn.143.1703128709174; 
 Wed, 20 Dec 2023 19:18:29 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH v2 20/71] hw/9pfs: Constify VMState
Date: Thu, 21 Dec 2023 14:16:01 +1100
Message-Id: <20231221031652.119827-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

Acked-by: Greg Kurz <groug@kaod.org>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 5f522e68e9..efa41cfd73 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -237,7 +237,7 @@ static const VMStateDescription vmstate_virtio_9p = {
     .name = "virtio-9p",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


