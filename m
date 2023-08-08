Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E6E7740D1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDX-00020C-JI; Tue, 08 Aug 2023 13:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDV-0001xH-I5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDT-0003IF-UU
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3177f520802so30700f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514594; x=1692119394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Li5njnj5rgHVOwbkk/WAU1RkU+KgYUBfADRPNNiXvFM=;
 b=MMjHlLYSdKpVZDvh/4uVIYT3a6ty5r+0kCULETjZWtdZVFZyyLvuza6IkvJ8ro83/m
 cUX9tLGEoLjOhhW7MKlzWGogkmbYgX/qD/89M2E4LkBqLGL7a1HGcJF2kO0zfTFPNcRl
 jSBr/Sh5tPVgRZnWZC0oPygNrUP4EsPDOT9Dg65AmGgxZqe9Q7PA8KViNkRInik+L+5Z
 5L91Romobs9JTrpkfA8sicWnE3/36Wgs0U35OXzFr/pm0nbvramvR4PKgJuxl/RICWPf
 BTJeFlQ43h2dHo/PbnDLxLTXXs5HACH7ctpCn5ulx5QxCdWK7c3AUR4Mdhssj0/tWDMV
 lZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514594; x=1692119394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Li5njnj5rgHVOwbkk/WAU1RkU+KgYUBfADRPNNiXvFM=;
 b=PPCEwkwUNH5lwaD5UgW2mwIKgJcw84VC6RjNWQQyTuKU0Upajq1s9g+Hlpk+7Wq13y
 n01mAzLJJHf0+UKUnqJXSYmbUOSgRGfILlwiDRapKSCKPQIpPwUgrAkUVo1p7TTOrI8b
 ndAzQQOi6Uq0wjJJj8XZOLi6HY1X8e1pqJB+yJwfRwceIBuKoBXO8R0ZkzWRpCtLuVRL
 ajTFnJM4c86fAZHEAZw5ddf5gpCqpFQGVkX+aFoGwZ9zwtmrV+NWBLH9B0lLiMTbB/y+
 l5TFZDH8KgOW5NQueRtEWx9eC+7pk7k23a6TcdZndoAla23TRArtU6YFePWDF4B5ggr7
 t9MA==
X-Gm-Message-State: AOJu0Yxr2wL744Fg/J4Z50QiWFV5XNBXEh2gWsCYp6Zs7u9+Zdp3WA15
 c65lprls5oFuh+EUMF9a+qW1efT7h0l/pQ==
X-Google-Smtp-Source: AGHT+IFqEV3KNtCpj/J7gHgMCWsVtPx3gfMzIVoPiGF/y9NOrJZpGWrzn+o790blZ41o0R0LWahqYg==
X-Received: by 2002:a5d:518e:0:b0:317:6579:2b9f with SMTP id
 k14-20020a5d518e000000b0031765792b9fmr297067wrv.30.1691514594302; 
 Tue, 08 Aug 2023 10:09:54 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:53 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 14/33] Implement host-target convertion functions
Date: Tue,  8 Aug 2023 08:07:56 +0200
Message-Id: <20230808060815.9001-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat converstion functions:
h2t_freebsd_fhandle
t2h_freebsd_fhandle

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 8c73f7402c..6716cee3e2 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -92,3 +92,40 @@ abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * file handle conversion
+ */
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_READ, target_fh, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(host_fh->fh_fid.fid_data, target_fh->fh_fid.fid_data,
+        TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_fh, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(target_fh->fh_fid.fid_data, host_fh->fh_fid.fid_data,
+            TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 1);
+    return 0;
+}
+
-- 
2.40.0


