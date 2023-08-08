Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95D7740D8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDU-0001qZ-KQ; Tue, 08 Aug 2023 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDO-0001Jb-1t
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDM-0003EZ-58
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe426b86a8so49231255e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514586; x=1692119386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8c0UiTP0CXlpBRG3LiEhnTkrlyEnfFw6XtkO2ZFdDvw=;
 b=WnU41zyHu3b/gHPxXlRfkN3LlOxxtJ+lVPGCfk42Ud+4GWuIW7emWqdlzy6Lzc0tF6
 ovun13ZGYpMyDmAP9L5M0JGFusu04qmFxjLnkaR+7NqZHIIeUINJ27dgKGyVfKeM/AG6
 a/1m8o0Z1CMNYppaLr+sPtN3u4+qY6GmY8W0DvtUBGDZUtptXJOEJcoH8rQUsQtYMZOr
 5uW3IV1KCM//cWzxb99UWFhk+sLELsVM58rpJvjPAsW/37MhItKSyYzduXs9CedFE3OD
 l/ssDdEtfJVZ7das8N+JvTTZBfCuH/VwefKluIzKZZ6RQxjiiPqYmyOhJwe3cleYcVr4
 LeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514586; x=1692119386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8c0UiTP0CXlpBRG3LiEhnTkrlyEnfFw6XtkO2ZFdDvw=;
 b=HCf2bRZivjXqpYnze5XjKSjDwArIm1pr2Y2VfCzgL46hO5YhQPVJRx3OMzUPAteXG2
 XAkSL3VCrAoRj/R2idvTdLBGZ/UGnrtKhoSt5Q6XmkgV0Q/sD1KbR74/x/2dZIATYgt9
 D8FrXn/U0OG3hANe6zSb2HUscrlGRsDELovK+eaaJhZmTXoNkttcM+FR9w2pWtVs/Tg8
 nyIPK7a0cgPkenUZ8XQK+fc2xeGL73C0wHv9E7JBKS098olq1TonZ4b9NdHSAnEUHhQT
 MaGKyCSzpT52HMH/bldOu7G5K4NQEDE1GBEObV+ueMeCVIEI4wm0lmCHzP0SAqdOOHlb
 y9CA==
X-Gm-Message-State: AOJu0Yx9xi8Q+6JNWuSgh2+E7jhG4ijjFHx5pivp4KA90JulaSAtQtgG
 8GXI+ZHLspJd7msBFMURqDF1s3+u3YtP8Q==
X-Google-Smtp-Source: AGHT+IGjpbTHwu+pFQTgTHViAd8wtQTmA+9t5NjhTIpuLa+ZSJelMOSga41h+TaPT0zh3TgVzVqOCA==
X-Received: by 2002:a5d:684a:0:b0:317:6530:a4d3 with SMTP id
 o10-20020a5d684a000000b003176530a4d3mr57993wrw.26.1691514586399; 
 Tue, 08 Aug 2023 10:09:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:46 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 07/33] Add struct target_stat to bsd-user/syscall_defs.h
Date: Tue,  8 Aug 2023 08:07:49 +0200
Message-Id: <20230808060815.9001-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
 bsd-user/syscall_defs.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 5ef76ffa52..e796e7e13d 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -212,6 +212,44 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
+#if defined(__i386__)
+#define TARGET_HAS_STAT_TIME_T_EXT       1
+#endif
+
+struct target_stat {
+        uint64_t  st_dev;               /* inode's device */
+        uint64_t  st_ino;               /* inode's number */
+        uint64_t  st_nlink;             /* number of hard links */
+        int16_t   st_mode;              /* inode protection mode */
+        int16_t   st_padding0;
+        uint32_t  st_uid;               /* user ID of the file's owner */
+        uint32_t  st_gid;               /* group ID of the file's group */
+        int32_t   st_padding1;
+        uint64_t  st_rdev;              /* device type */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+        int32_t   st_atim_ext;
+#endif
+        struct  target_freebsd_timespec st_atim; /* time of last access */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+        int32_t   st_mtim_ext;
+#endif
+        struct  target_freebsd_timespec st_mtim; /* time of last data modification */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+        __int32_t st_ctim_ext;
+#endif
+        struct  target_freebsd_timespec st_ctim;/* time of last file status change */
+#ifdef TARGET_HAS_STAT_TIME_T_EXT
+        __int32_t st_btim_ext;
+#endif
+        struct  target_freebsd_timespec st_birthtim;   /* time of file creation */
+        int64_t   st_size;              /* file size, in bytes */
+        int64_t   st_blocks;            /* blocks allocated for file */
+        uint32_t  st_blksize;           /* optimal blocksize for I/O */
+        uint32_t  st_flags;             /* user defined flags for file */
+        uint64_t  st_gen;               /* file generation number */
+        uint64_t  st_spare[10];
+};
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


