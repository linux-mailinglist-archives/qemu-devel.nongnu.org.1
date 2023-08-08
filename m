Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1F7774105
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDW-0001yt-ME; Tue, 08 Aug 2023 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDQ-0001O9-Ey
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDO-0003F7-9k
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe2ba3e260so56671365e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514588; x=1692119388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOzOH1LlLca377vY/qlVnv9NB+0PQt8L152jXs/ETl8=;
 b=IcoMAE+TUW1n2glAvNsp+xgNriDyKHygCA+pb7QozZ0nEDhbyLD2R+7FOWdlMCGMqM
 hWU5IzTJLfSJd8BC2JN8+7DZZM2mhCNz4l+gJ+fATB42g5zlTn4ZLHfio7LrLB9v9zlg
 WMH+sTf05ly0NUdUsctuyHCZcEE3tRX+uUcBvRoT974waRgCtt06hEBVrrGvx8lo9cxO
 lKgArOWEV16+gEUhw8jkLWrR4kZ3yZWE842/m4ZYl1TvGzncO1DVikVYsASqAYQNioeg
 4B+5o3IXIHAb+VehxPw2w3u9TEDXJC2XtzBUtTg6NV8sxHT0xnKJee6csfQm3esvp/ju
 GFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514588; x=1692119388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOzOH1LlLca377vY/qlVnv9NB+0PQt8L152jXs/ETl8=;
 b=A6XsgtA0rP8S9ywwJcLpO/8jrxq4pccpz1ihDhx3eS5Sw6O9WQQF+AXsKTUySsmYzd
 xuDg3nMF9885997z8z30gFaV21hI41GQUCqHZnxeCQYm0sQN0+MeZZxRGpave8EuaO3m
 5u8vAXMEZ8keJN1WQ/39T2aUOUdN1Of20opdBH1oL/XwscQT5RRjze0r2Mk5uLeIcw8a
 8JicSUM1taw2GsL8RygtJ8KW1PJIVQTTntJoocUgPyfyEl2cgHNY1NvksQv3oK2xO/oW
 8EcieVDIsXwYs9hytXyS0PDdVmkmVrdpOJcV76b6tJOa2+CqNg73Ef3BLn8bgjCAhbS0
 5mUQ==
X-Gm-Message-State: AOJu0YzJ42OOCZ/UKSnX40RIY0UibrloeBB3ilQRdZm5p5kIvLIYf92x
 7HBG6wryIasa/yA2sdsaQWmJxt1/wkEkAA==
X-Google-Smtp-Source: AGHT+IF2WwwEpyoyb9/W8ty19pDaIbmxRMnVUO6PgOxQ0KD5k/FP77qiBTDCwK+xwkJJeh2impUiSg==
X-Received: by 2002:a5d:4e07:0:b0:317:62c3:13a7 with SMTP id
 p7-20020a5d4e07000000b0031762c313a7mr69356wrt.19.1691514588656; 
 Tue, 08 Aug 2023 10:09:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:48 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 09/33] Add struct target_statfs to bsd-user/syscall_defs.h
Date: Tue,  8 Aug 2023 08:07:51 +0200
Message-Id: <20230808060815.9001-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 06be8244de..ab59d00a47 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -315,6 +315,31 @@ struct target_freebsd11_statfs {
     char     f_mntonname[88];      /* dir on which mounted*/
 };
 
+struct target_statfs {
+        uint32_t f_version;             /* structure version number */
+        uint32_t f_type;                /* type of filesystem */
+        uint64_t f_flags;               /* copy of mount exported flags */
+        uint64_t f_bsize;               /* filesystem fragment size */
+        uint64_t f_iosize;              /* optimal transfer block size */
+        uint64_t f_blocks;              /* total data blocks in filesystem */
+        uint64_t f_bfree;               /* free blocks in filesystem */
+        int64_t  f_bavail;              /* free blocks avail to non-superuser */
+        uint64_t f_files;               /* total file nodes in filesystem */
+        int64_t  f_ffree;               /* free nodes avail to non-superuser */
+        uint64_t f_syncwrites;          /* count of sync writes since mount */
+        uint64_t f_asyncwrites;         /* count of async writes since mount */
+        uint64_t f_syncreads;           /* count of sync reads since mount */
+        uint64_t f_asyncreads;          /* count of async reads since mount */
+        uint64_t f_spare[10];           /* unused spare */
+        uint32_t f_namemax;             /* maximum filename length */
+        uint32_t f_owner;               /* user that mounted the filesystem */
+        target_freebsd_fsid_t f_fsid;   /* filesystem id */
+        char      f_charspare[80];      /* spare string space */
+        char      f_fstypename[16];     /* filesystem type name */
+        char      f_mntfromname[1024];  /* mounted filesystem */
+        char      f_mntonname[1024];    /* directory on which mounted */
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


