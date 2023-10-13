Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B317C8045
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4u-0003gz-UO; Fri, 13 Oct 2023 03:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4s-0003Rf-Dl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4q-00076s-CS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso21734035e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183957; x=1697788757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbwPqKejPqCfjx3i0hAQng1S5moLMZkGirk9RhHcbns=;
 b=SvCTmXdWKhFiPoxjB8vVc3y5p7mEbGQKUM4L9DPibJPdMHm4UqI3CMIEHfdg0r+W5v
 YDY/+1YZavqYzrxIR/DHYxnL2g43p3p2bQLa4M7ZgdohvXTnIqtlKKeaSJAz6qvYFWyq
 ZaGHWXT38rbWGybDiVFGLjarejwodej43GxGz4D95yUXVDKiEAzjhkMFd0OehoKije6C
 bNV0Xupb59jkJxSyg+0lxJTsbvB7YOKNhzJJH34+Z7hHwHBKh57dMG4Fn02GQ9H3i/sp
 nRx/S6rH2BsJJUQFl8r/OW7aS7SLPW4Yukjd2klHMKRmXgpmvUrjkFJyliMvSBLgJ9bD
 uaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183957; x=1697788757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbwPqKejPqCfjx3i0hAQng1S5moLMZkGirk9RhHcbns=;
 b=Vr+bZHh1+LT08cVHYg9w5e4nfYox6Y0rddD4Ye5U7/hPHQIbUPWEovV/LZx86vFz4L
 JzXLC0EU5DNf4LzuDt2czzjkTxc6a8FQ0UMPBtuHfGDBWV7/6bGkVrwtDUItsY2GF5cS
 yIA26dGHukzwKoK19QQ9uZYWlBqOIfX8Os3espU3Fai5HxUU5k2L2ggcVbOKNpp+Zix0
 YpwN/pPc1Oo8tlBpM3SxWURAdhL7jnpt5WL7sjQsqGvDVJhVcaz5Ibg8yqYKbv4Zyg6m
 2iZRpuIeJ5Ucnzd/Euwk49axz0+2BIBkkHNx3KOt085Jpt66P+lITyzwpMsgXJnTMbwO
 +AgA==
X-Gm-Message-State: AOJu0YzZ6QdTXgj3CNMLLvKQ812Gv8KhTl0xBpGHqfJsgw3GK6nUXaaI
 1Sitz63KS5dPNJx7/oW3GxM45kAkckfBBcKRwug=
X-Google-Smtp-Source: AGHT+IHIiN0iJHKKdR/uopHJPCOZ2ecKj0pjKfaXft1ruct/LPspkVJeIWHRjSo5bEvcIC4fN4go9A==
X-Received: by 2002:a1c:7218:0:b0:401:d803:6243 with SMTP id
 n24-20020a1c7218000000b00401d8036243mr22698395wmc.32.1697183957638; 
 Fri, 13 Oct 2023 00:59:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:17 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH v2 47/78] contrib/rdmacm-mux: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:14 +0300
Message-Id: <79d156347f37b8f4984e52ebb3063604093ae8f4.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 contrib/rdmacm-mux/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 771ca01e03..dda6917d58 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -303,72 +303,72 @@ static void hash_tbl_remove_fd_ifid_pair(int fd)
 static int get_fd(const char *mad, int umad_len, int *fd, __be64 *gid_ifid)
 {
     struct umad_hdr *hdr = (struct umad_hdr *)mad;
     char *data = (char *)hdr + sizeof(*hdr);
     int32_t comm_id = 0;
     uint16_t attr_id = be16toh(hdr->attr_id);
     int rc = 0;
 
     if (umad_len <= sizeof(*hdr)) {
         rc = -EINVAL;
         syslog(LOG_DEBUG, "Ignoring MAD packets with header only\n");
         goto out;
     }
 
     switch (attr_id) {
     case UMAD_CM_ATTR_REQ:
         if (unlikely(umad_len < sizeof(*hdr) + CM_REQ_DGID_POS +
             sizeof(*gid_ifid))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                     attr_id);
             goto out;
         }
         memcpy(gid_ifid, data + CM_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
 
     case UMAD_CM_ATTR_SIDR_REQ:
         if (unlikely(umad_len < sizeof(*hdr) + CM_SIDR_REQ_DGID_POS +
             sizeof(*gid_ifid))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                     attr_id);
             goto out;
         }
         memcpy(gid_ifid, data + CM_SIDR_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
 
     case UMAD_CM_ATTR_REP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_REJ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREQ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_RTU:
         data += sizeof(comm_id);
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_SIDR_REP:
         if (unlikely(umad_len < sizeof(*hdr) + sizeof(comm_id))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                    attr_id);
             goto out;
         }
         memcpy(&comm_id, data, sizeof(comm_id));
         if (comm_id) {
             rc = hash_tbl_search_fd_by_comm_id(comm_id, fd, gid_ifid);
         }
         break;
 
     default:
         rc = -EINVAL;
         syslog(LOG_WARNING, "Unsupported attr_id 0x%x\n", attr_id);
     }
 
     syslog(LOG_DEBUG, "mad_to_vm: %d 0x%x 0x%x\n", *fd, attr_id, comm_id);
-- 
2.39.2


