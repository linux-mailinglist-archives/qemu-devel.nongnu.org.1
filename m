Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5077AB4F8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIz-00017b-5T; Fri, 22 Sep 2023 11:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIv-0000ko-HE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIr-0002pS-W1
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4aZIa2PSQ4iemAt8feI7jH/a2bDufHqmAyu5oMZZBw=;
 b=OLM7u+J4onUHD5nu/lRVIhoZBsEpbAAR8DtIM/NL2hRkcUFTXbauUd0SRV1+H1VcC+bAcx
 3PEx5B0XcSb/W9dP97LS8oHUg5yGRVtusktx7bAblIeeDAdf1dw47WbpuLemylEGnQzpoe
 QWo3AmOeTw5yLtZXup2HLFSSGFFXWBA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-DE5-JkQ2NH-QPHPMamTE_Q-1; Fri, 22 Sep 2023 11:42:48 -0400
X-MC-Unique: DE5-JkQ2NH-QPHPMamTE_Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso16646955e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397365; x=1696002165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4aZIa2PSQ4iemAt8feI7jH/a2bDufHqmAyu5oMZZBw=;
 b=KqDNJFayLbu3ATRa5yhKc9NtrczO1gnfZTl2WnudSxhLeraiGXCYsAOT3iAjRkqVeQ
 L4K2nnDptpcl9Sugtkqh214NBfDKgoJu41zf1a9AQcelRS1DsFNzmMikmbwe05Pn2wTQ
 zWw2pRfIhEA65F5Gl2yAd7lkHC9H6vLeDq4ITl8ZZoZe/xv80rC3Q1tpJZA1M9R+69o3
 V/ZXgXpPKAuaomOIwtFkozGJY1Kr+xTpL2B2ZieMl6HP8lM2xxoV7WeLPh5a8oDiU0zK
 ZQY4j17eF6pmhzZo0RYeBZ5Bs5Ayk3F8t4OX4NTRpVV7PRR7PQ1O6AdGX1MupRW19EXe
 fxqw==
X-Gm-Message-State: AOJu0Yyvp+LBClo+LxYQid/bfPQqtt6PupdP1zcfX9kgJ6aU1lj/cTKD
 FyI24kwcQdKZfhcw1ZF1nBDhig3y+hIjW0jWDYDsxIwlfnIJucKG+0a+8qo3kW1HbR7C8RIOVNx
 wcwU6g48lX00hfdv18ONAm1yLVq7tjOlreCO7dzzaqQnLvMbUWpDEaU66/SWj+nhT0XWeDYkM95
 Q=
X-Received: by 2002:a05:600c:ad6:b0:401:b1c6:97d8 with SMTP id
 c22-20020a05600c0ad600b00401b1c697d8mr7819796wmr.35.1695397365656; 
 Fri, 22 Sep 2023 08:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkSjfwUAeeNNYIut9i92JKnqBawbZMW5wo3kzWimKFxIMvn6Bom8/k80QaUuzxj8l4ciTGfQ==
X-Received: by 2002:a05:600c:ad6:b0:401:b1c6:97d8 with SMTP id
 c22-20020a05600c0ad600b00401b1c697d8mr7819780wmr.35.1695397365278; 
 Fri, 22 Sep 2023 08:42:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adfe3c1000000b0031ff1ef7dc0sm4734204wrm.66.2023.09.22.08.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 7/9] hw/display/xlnx_dp.c: Add audiodev property
Date: Fri, 22 Sep 2023 17:42:26 +0200
Message-ID: <20230922154228.304933-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

There was no way to set this and we need that for it to be able to properly
initialise.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <16963256573fcbfa7720aa2fd000ba74a4055222.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 43c7dd8e9cd..341e91e886f 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1385,6 +1385,11 @@ static void xlnx_dp_reset(DeviceState *dev)
     xlnx_dp_update_irq(s);
 }
 
+static Property xlnx_dp_device_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xlnx_dp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -1392,6 +1397,7 @@ static void xlnx_dp_class_init(ObjectClass *oc, void *data)
     dc->realize = xlnx_dp_realize;
     dc->vmsd = &vmstate_dp;
     dc->reset = xlnx_dp_reset;
+    device_class_set_props(dc, xlnx_dp_device_properties);
 }
 
 static const TypeInfo xlnx_dp_info = {
-- 
2.41.0


