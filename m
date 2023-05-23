Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1D70DCFF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTK-0007aW-4y; Tue, 23 May 2023 08:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTH-0007Zu-Dw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT4-0005Js-Gf
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3093a6311dcso7291396f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6c49RYzHWdVq3P3yg8J3+/TKBPogcBQppAeDcgAsBA=;
 b=Qz3tdzyoS9ILyQlJtfPKfKH/yxDz5t4bp3sPiRWtHlM/yevCT1Z1ZSF/LcnIo+BGjK
 Vat6061KSGbQbG3JQhjJjne7lE9iSlZtetSUBYdMICJTW22ZugQxiNCTFTnhZIK02Z7y
 bD3HGiaL5TZBUbifpaB+dacZQncVVoE73g8Y5qtC6MpGf3d+5DZRFYTLKcw+qP5j/tt2
 IjttZlSguuVBULlJ1/480YdX4hKnjIypCVqwc0ylpGdLIBdXsVDXX45IYWxjAyefuAHO
 Tz2uqdRlbqPVYTAKCkyqcPBSXe5I20kvvIaLhQJ5Q9Xr/BfYTizbfCIH9fLaXDv6s89d
 54MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6c49RYzHWdVq3P3yg8J3+/TKBPogcBQppAeDcgAsBA=;
 b=Cg23NBzIoQJhu3Ltlzd6nR5ydFsKu/y+vU0+vaRyP7a+xYUjv7/We/tKZQU31nTxQY
 zhxmB9TZCjTf/MTBGHn9SLlwb26640s1Jnmi1RCz55m8flnOXDYOIsKnjQr6glWaNjCi
 ap9qEc3UD4qYLQhPW7Z3ARFJG8NAN/nhPd5hjQ08RggFad8Zye/KUg+Mw84INQ9E4wNw
 WmBlkvUf1niMEJHjxE8lCXdRgRcaQfXmj6cNrZQb0Scqsyy61JHpYnAIGkTJuOdoWINm
 /mF7LZHFdALOdXnQVn86AigDWkfGvarUjE661biiyk8dW/LdboqiNYPRtPNq2QR9DREJ
 bijw==
X-Gm-Message-State: AC+VfDwgosU6/fxFqwqVTR0KmG9yaDdofHnQCzR3TD07v2du9xUqx00P
 eBRvOw0NTkHrg7O/CgAEZfkUVg==
X-Google-Smtp-Source: ACHHUZ4XAznovqbdL4ofYv9FPd+H5uvyDjjJaACFBaiR6IadmiO26F8yjGk+Zlny3Iinj750sF6osA==
X-Received: by 2002:a5d:40c2:0:b0:309:839:be3e with SMTP id
 b2-20020a5d40c2000000b003090839be3emr9870522wrq.33.1684846203793; 
 Tue, 23 May 2023 05:50:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a5d4243000000b002cea9d931e6sm10972862wrr.78.2023.05.23.05.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0FACF1FFC2;
 Tue, 23 May 2023 13:50:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 09/10] hw/9pfs: use qemu_xxhash4
Date: Tue, 23 May 2023 13:49:59 +0100
Message-Id: <20230523125000.3674739-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

No need to pass zeros as we have helpers that do that for us.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503091756.1453057-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-10-alex.bennee@linaro.org>
---
 hw/9pfs/9p.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9621ec1341..991645adca 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -738,15 +738,14 @@ static VariLenAffix affixForIndex(uint64_t index)
     return invertAffix(&prefix); /* convert prefix to suffix */
 }
 
-/* creative abuse of tb_hash_func7, which is based on xxhash */
 static uint32_t qpp_hash(QppEntry e)
 {
-    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino_prefix, e.dev);
 }
 
 static uint32_t qpf_hash(QpfEntry e)
 {
-    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino, e.dev);
 }
 
 static bool qpd_cmp_func(const void *obj, const void *userp)
-- 
2.39.2


