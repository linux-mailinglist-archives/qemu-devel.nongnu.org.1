Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58074894F
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TO-0001e3-Qk; Wed, 05 Jul 2023 12:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TH-0001ZZ-Im
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TF-0003cO-O1
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wMxl19wPT6NOIYdfEthE3CTENPdu0RlUwoU249Hq90=;
 b=X4UuWnyiggDHXh60JSm/yrW4V/4pBzWV//Wy/ruOn48XkjHlSputnW4my7wm6Ahm6pOcLJ
 MFBd/Cexhr0pEYiEKt9c+3AFlxYCvFZSVsgzGbPIBuAVpgLBV3b7a3oLksbG55K5akO0cp
 uUudXavj+FVQMK68r+I/fUPKA+ucwxI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-r4bhcU94OHeNE4c0ajZSbw-1; Wed, 05 Jul 2023 12:35:11 -0400
X-MC-Unique: r4bhcU94OHeNE4c0ajZSbw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso128206085a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574911; x=1691166911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wMxl19wPT6NOIYdfEthE3CTENPdu0RlUwoU249Hq90=;
 b=PYPEiRwbXj2E1vJCRQz5gstRzGDbUL6lQ72sYRQj3TYwNNnKsLSa2grw9jYkWEHli+
 a9MrXfGCV6OvtKPV28nSmUMrQg3n8kZiBMT6SSJv5ACkdZ6Pjn0flS5aW3ZdCdc2bBhY
 R3wC6/4dtgoay0XBSy8VH+epAsOIZoczl6u8D8EXOS+bT5ysUVr31NKDwenrFJAgmAlz
 to78PXuDuXCTMEQp62jaF0+v6ECegdmw6hNOvqB8bH/HqQDnd9UqpLMeRQjqjL479JUt
 WD93vjM6LcDOoswgTx+93ltBlAUoAVqhRk8iPzWRzQNNjxX4gPOosRFcestLVZ9quvrW
 k9kQ==
X-Gm-Message-State: AC+VfDz0DGlkqGKWa4EozfNzv/79NPKwn+U209LVjk3bOIqIhTYliPss
 3j6Gyrh65p/z/Vm3eFGSvpqwjF3GQp1GGfK2agmzzih0V0D8Eb4cwo+KUtNtXApYI2aGv+OO5Lk
 pfFCuAw1tksj9mpDz2LqbJTFPFObpL2W6CrRUWismLJlu/m6puiIW8iZzs1W5FcD6Id10sd4S
X-Received: by 2002:a05:620a:1a8c:b0:767:3ea3:2ac8 with SMTP id
 bl12-20020a05620a1a8c00b007673ea32ac8mr20660582qkb.1.1688574911160; 
 Wed, 05 Jul 2023 09:35:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IFKvxhJeiheKhdmzEftt9xaEk1O0M9sytH+EQvg72sRgoXzLimEQF06RaJH+2BxA6KemY/w==
X-Received: by 2002:a05:620a:1a8c:b0:767:3ea3:2ac8 with SMTP id
 bl12-20020a05620a1a8c00b007673ea32ac8mr20660551qkb.1.1688574910762; 
 Wed, 05 Jul 2023 09:35:10 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 7/7] migration: Provide explicit error message for file
 shutdowns
Date: Wed,  5 Jul 2023 12:35:02 -0400
Message-ID: <20230705163502.331007-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Provide an explicit reason for qemu_file_shutdown()s, which can be
displayed in query-migrate when used.

This will make e.g. migrate-pause to display explicit error descriptions,
from:

"error-desc": "Channel error: Input/output error"

To:

"error-desc": "Channel is explicitly shutdown by the user"

in query-migrate.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 419b4092e7..ff605027de 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
      *      --> guest crash!
      */
     if (!f->last_error) {
-        qemu_file_set_error(f, -EIO);
+        Error *err = NULL;
+
+        error_setg(&err, "Channel is explicitly shutdown by the user");
+        qemu_file_set_error_obj(f, -EIO, err);
     }
 
     if (!qio_channel_has_feature(f->ioc,
-- 
2.41.0


