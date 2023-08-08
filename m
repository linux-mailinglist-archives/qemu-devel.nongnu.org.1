Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904C7740CD
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDV-0001us-B0; Tue, 08 Aug 2023 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDS-0001aA-01
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDQ-0003Fv-DW
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3175f17a7baso4457814f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514591; x=1692119391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAohi5/MwQLdUMXVp1G5/nl/7o/hanadDOctFfkZRfw=;
 b=DCmEYEO5jGPqkM6d13KJO227lSiQokys/lr04CeUSyBab+B2ShaNQ+tiH1h5xG1aeb
 3EQK+kF9qJkJc3aQ6KxyJFPQr0MKU511PRO+g4AypKaSx7ayjpmxZ3qpUvCQOQSPQlEw
 60nfF4w+T1L86SEImDUPEoeeyQRtYgGv7+FIApq3Weg5mwixSVUFgd7b4NDBsgNRFKlP
 EJzCKoUdmGOYx2hPeVcHl3TfWb7pzSNQotL3DVobCEvPo3pZPYDAw6ApgKpJOzqU+Uw0
 0pw06fL3ZUVSENXBfsMuTFmtdYz0T8ejei6CkxoFZY8uPWREz+VeRJBVuO2M9d3DAvcU
 RERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514591; x=1692119391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAohi5/MwQLdUMXVp1G5/nl/7o/hanadDOctFfkZRfw=;
 b=T5K5hUdnhaQhCEqYV6PuGqLb2E1ijLxGGLVOCoSM2jhRSKmEboLxQc5WLuF45WfURI
 kUq8TZxAOLJLxzBSXWxK4Wjn9HZSRI/yi36tk68E11pCSz3/TDZhT+EBL29xib/lhzvR
 bGJVBs6S/JAOD4jGp8A9qWyU5No3uPd6dlpcaWC39NSEbcdyE5+ruFty6Fvc9XwbZxXm
 /KzSIxQkggBURhC8VK87gbAUHojp7WTlAZLuKEkVFk7picNzx76lne5hypSe1ImWpZMZ
 bOM1DR5U6r5AR/2IG0daaK253sJq2Ni42uj8IdWH900VLoA1cmXn0cDgmnWrAR1YERwo
 OkZg==
X-Gm-Message-State: AOJu0YzYFm8Y2Q5HzHZdsjaQ+3CBdjPYoambL+Xwnw5IC32q0FBlshwP
 SbJX21nIULtZz1VlEuBCgNywOze33eO3Gw==
X-Google-Smtp-Source: AGHT+IHXpzVaQ6xs1wr9AF6VS3JY3yx7HoeKCS3kavyTSwEgW0WJQzgX6aQtHpKQChknCIY51VqXyQ==
X-Received: by 2002:adf:f88e:0:b0:317:df4f:4b97 with SMTP id
 u14-20020adff88e000000b00317df4f4b97mr52920wrp.7.1691514590836; 
 Tue, 08 Aug 2023 10:09:50 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 11/33] Define safe_fcntl macro in bsd-user/syscall_defs.h
Date: Tue,  8 Aug 2023 08:07:53 +0200
Message-Id: <20230808060815.9001-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 608731f0ac..52ebadbe2c 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -438,6 +438,8 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+#define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
+
 /* So far all target and host bitmasks are the same */
 #define target_to_host_bitmask(x, tbl) (x)
 #define host_to_target_bitmask(x, tbl) (x)
-- 
2.40.0


