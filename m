Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 890107DEA5C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMed-0007ID-Sm; Wed, 01 Nov 2023 21:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeO-0006Tx-Bo
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMeM-0004LL-5x
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:37:35 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2e73a17a0so264556b6e.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698889050; x=1699493850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfcfvCM44CNzCfVh5n1nc5lCu8ey+5nlcTa0SEohSWE=;
 b=WYyz7KrfjSySDJKYHhmvszBxmjRGUWdVJpin12zZcTw1JZpq12y/O6yqPnfqwxOPRG
 j4VHGlK66aarJ7uWUheEppCcY3Jj3ylaw7lVMs1vBWqD6BkcZ0DXAECI7xwlyJKTUaq+
 q9zmf+iVCBuYZNcf+9cst6a4C/vnzH8b00tQV891kRNOTptJ96dAH5e0WzrsVFRD+yXD
 UV/EgxQs4z7j1WQuIKOoTNLZh2oOrU+hwXXtlUkEBSLoj+JS7nx8DmprR3AgbKvS+weD
 q5UebbIEV34yWQ4WgRmJlLN22nPhjp3OvoSsjRZRwIGdUc+7VFVeT8bKB5nRtVgkUQZK
 39wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698889050; x=1699493850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfcfvCM44CNzCfVh5n1nc5lCu8ey+5nlcTa0SEohSWE=;
 b=bouZ9UKUeWQMADheGZf3Ffvwc0A3GV3n9XhUN89XswWO0pbddeDJegwHN5RlAyD+VC
 pNbobNuupjJlrSfiBB6GhGcp39++Xj+uVQ2UMN+aSZIW9Gsahr1eJ2XDzM56LavIQKN2
 tOhhfW8go3WisjuWRPNkZTtIipmvAqW+ws40qi3meZvoXPa7V/KQCKBmn49Yd6k+a8RG
 keF5MrYDrUQLSGiHELOjCgKKv9lcmyZZ/uNNbggTeR6F08Z5cqCZ9aUtWvRpmj5gkfoY
 qV9C0NVvHzrb5RdoSaIxOKoXEla6uDBsUsGiOl0g/Dw7A7rzDWoHkDdUX5Yu0IcyKGhz
 UD2w==
X-Gm-Message-State: AOJu0Yx+UbUoFGCapu99N0RPEUhOUv7KviVR6UYDnPKey6ty28suim26
 m6XtRzHdInyQmVBO1d7VARLg8XAK8fbpWIEFfMY=
X-Google-Smtp-Source: AGHT+IGjnKopjkcgyE2IXiMlOGakYEDXL1E+sjV93ePvpyF8LbJfuILKjnTMM12qr9BwQFxE0X4D0A==
X-Received: by 2002:a05:6808:1790:b0:3b2:f54b:8b45 with SMTP id
 bg16-20020a056808179000b003b2f54b8b45mr23159348oib.40.1698889050483; 
 Wed, 01 Nov 2023 18:37:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v20-20020aa78514000000b006934e7ceb79sm1800230pfn.32.2023.11.01.18.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 86/88] hw/hppa: Turn on 64-bit CPU for C3700 machine
Date: Wed,  1 Nov 2023 18:30:14 -0700
Message-Id: <20231102013016.369010-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 43c7afb89d..da9ca85806 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -696,7 +696,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
-    mc->default_cpu_type = TYPE_HPPA_CPU;
+    mc->default_cpu_type = TYPE_HPPA64_CPU;
     mc->init = machine_HP_C3700_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
-- 
2.34.1


