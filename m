Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDC7B0B5B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 19:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlYl0-0000dy-Nj; Wed, 27 Sep 2023 13:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanxiongchuan@isrc.iscas.ac.cn>)
 id 1qlYku-0000df-Nc
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:55:24 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanxiongchuan@isrc.iscas.ac.cn>)
 id 1qlYko-0002Pq-UT
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:55:22 -0400
Received: from localhost.localdomain (unknown [223.72.70.217])
 by APP-03 (Coremail) with SMTP id rQCowACXnWl4bBRlRIKBDw--.5656S3;
 Thu, 28 Sep 2023 01:55:11 +0800 (CST)
From: Xiongchuan Tan <tanxiongchuan@isrc.iscas.ac.cn>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org,
	Xiongchuan Tan <tanxiongchuan@isrc.iscas.ac.cn>
Subject: [PATCH 1/1] linux-user: Add drm ioctls for graphics drivers
Date: Thu, 28 Sep 2023 01:52:59 +0800
Message-ID: <20230927175408.495872-2-tanxiongchuan@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927175408.495872-1-tanxiongchuan@isrc.iscas.ac.cn>
References: <20230927175408.495872-1-tanxiongchuan@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXnWl4bBRlRIKBDw--.5656S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww15KFy7ZF48Cw18KrW8Crg_yoW7Cw4Dpr
 yYgr9xJF18Kw4a9393Ka15Za1fA3Z7Zw43GanxtrWUuFn7tw1kGr1DC3WrJFZ5ArWvyFWI
 v3WDuw4Skay3ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLL0UUUUUU==
X-Originating-IP: [223.72.70.217]
X-CM-SenderInfo: xwdq5xprqjuxxxdqqxxvufhxpvfd2hldfou0/1tbiCgYHAWUUNSlxJwAAsx
Received-SPF: none client-ip=159.226.251.81;
 envelope-from=tanxiongchuan@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 KHOP_HELO_FCRDNS=0.001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

This patch adds more drm-related ioctls to support userland OpenGL and
Vulkan drivers.

Signed-off-by: Xiongchuan Tan <tanxiongchuan@isrc.iscas.ac.cn>
---
 linux-user/ioctls.h        | 26 +++++++++++++++
 linux-user/syscall_defs.h  | 15 ++++++++-
 linux-user/syscall_types.h | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 071f7ca253..e6b946ed26 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -685,6 +685,32 @@
 #ifdef HAVE_DRM_H
   IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
                 MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+  IOCTL(DRM_IOCTL_GET_MAGIC, IOC_R,
+        MK_PTR(MK_STRUCT(STRUCT_drm_auth)))
+  IOCTL(DRM_IOCTL_GET_CLIENT, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_client)))
+  IOCTL(DRM_IOCTL_GEM_CLOSE, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_drm_gem_close)))
+  IOCTL(DRM_IOCTL_GET_CAP, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_get_cap)))
+  IOCTL(DRM_IOCTL_PRIME_HANDLE_TO_FD, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_prime_handle)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_CREATE, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_create)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_DESTROY, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_destroy)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_handle)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_handle)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_WAIT, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_wait)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_RESET, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_array)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_timeline_wait)))
+  IOCTL(DRM_IOCTL_SYNCOBJ_TRANSFER, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_drm_syncobj_transfer)))
 
   IOCTL_SPECIAL(DRM_IOCTL_I915_GETPARAM, IOC_RW, do_ioctl_drm_i915,
                 MK_PTR(MK_STRUCT(STRUCT_drm_i915_getparam)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 77ba343c85..be92b5fa6f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1201,7 +1201,20 @@ struct target_rtc_pll_info {
 #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
 
 /* drm ioctls */
-#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
+#define TARGET_DRM_IOCTL_VERSION               TARGET_IOWRU('d', 0x00)
+#define TARGET_DRM_IOCTL_GET_MAGIC             TARGET_IORU('d', 0x02)
+#define TARGET_DRM_IOCTL_GET_CLIENT            TARGET_IOWRU('d', 0x05)
+#define TARGET_DRM_IOCTL_GEM_CLOSE             TARGET_IOWU('d', 0x09)
+#define TARGET_DRM_IOCTL_GET_CAP               TARGET_IOWRU('d', 0x0c)
+#define TARGET_DRM_IOCTL_PRIME_HANDLE_TO_FD    TARGET_IOWRU('d', 0x2d)
+#define TARGET_DRM_IOCTL_SYNCOBJ_CREATE        TARGET_IOWRU('d', 0xbf)
+#define TARGET_DRM_IOCTL_SYNCOBJ_DESTROY       TARGET_IOWRU('d', 0xc0)
+#define TARGET_DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD  TARGET_IOWRU('d', 0xc1)
+#define TARGET_DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE  TARGET_IOWRU('d', 0xc2)
+#define TARGET_DRM_IOCTL_SYNCOBJ_WAIT          TARGET_IOWRU('d', 0xc3)
+#define TARGET_DRM_IOCTL_SYNCOBJ_RESET         TARGET_IOWRU('d', 0xc4)
+#define TARGET_DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT TARGET_IOWRU('d', 0xca)
+#define TARGET_DRM_IOCTL_SYNCOBJ_TRANSFER      TARGET_IOWRU('d', 0xcc)
 
 /* drm i915 ioctls */
 #define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index c3b43f8022..dcc1f14e11 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -331,6 +331,74 @@ STRUCT(drm_version,
        TYPE_ULONG, /* desc_len */
        TYPE_PTRVOID) /* desc */
 
+STRUCT(drm_auth,
+       TYPE_INT) /* magic */
+
+STRUCT(drm_client,
+       TYPE_INT, /* idx */
+       TYPE_INT, /* auth */
+       TYPE_ULONG, /* pid */
+       TYPE_ULONG, /* uid */
+       TYPE_ULONG, /* magic */
+       TYPE_ULONG) /* iocs */
+
+STRUCT(drm_gem_close,
+       TYPE_INT, /* handle */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_get_cap,
+       TYPE_ULONGLONG, /* capability */
+       TYPE_ULONGLONG) /* value */
+
+STRUCT(drm_prime_handle,
+       TYPE_INT, /* handle */
+       TYPE_INT, /* flags */
+       TYPE_INT) /* fd */
+
+STRUCT(drm_syncobj_create,
+       TYPE_INT, /* handle */
+       TYPE_INT) /* flags */
+
+STRUCT(drm_syncobj_destroy,
+       TYPE_INT, /* handle */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_syncobj_handle,
+       TYPE_INT, /* handle */
+       TYPE_INT, /* flags */
+       TYPE_INT, /* fd */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_syncobj_transfer,
+       TYPE_INT, /* src_handle */
+       TYPE_INT, /* dst_handle */
+       TYPE_ULONGLONG, /* src_point */
+       TYPE_ULONGLONG, /* dst_point */
+       TYPE_INT, /* flags */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_syncobj_wait,
+       TYPE_ULONGLONG, /* handles */
+       TYPE_LONGLONG, /* timeout_nsec */
+       TYPE_INT, /* count_handles */
+       TYPE_INT, /* flags */
+       TYPE_INT, /* first_signaled */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_syncobj_timeline_wait,
+       TYPE_ULONGLONG, /* handles */
+       TYPE_ULONGLONG, /* points */
+       TYPE_LONGLONG, /* timeout_nsec */
+       TYPE_INT, /* count_handles */
+       TYPE_INT, /* flags */
+       TYPE_INT, /* first_signaled */
+       TYPE_INT) /* pad */
+
+STRUCT(drm_syncobj_array,
+       TYPE_ULONGLONG, /* handles */
+       TYPE_INT, /* count_handles */
+       TYPE_INT) /* pad */
+
 STRUCT(drm_i915_getparam,
        TYPE_INT, /* param */
        TYPE_PTRVOID) /* value */
-- 
2.42.0


