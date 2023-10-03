Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E37B751E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovc-0004H2-82; Tue, 03 Oct 2023 19:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovZ-0004Fm-Ho
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:45 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovW-0007Qr-Ec
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:45 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f909071c3so60627139f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376140; x=1696980940;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GmmJ7cOFUeiFT48AhnZ61JPhLUFSCR6i7jpIveL+bg=;
 b=jcg5XqXdj2NNzOqZK/2TjorH0TgUZqT/oEDxkEIvB1HDggN4QS0lvwdWCTSXG5zd3p
 RF4dWl79J/wBAtKM/Jodt1kxse9AlEUkrF5Krl7YGDvkGgc+ltbW/+DQU0bLFL5ks8mF
 4z+uakmLVqJvEMTm9iMIfTCcVGcGdTANOrL7O2cWkKgoxAViGxbeMmAZduQcE8sz6kJb
 LVTcxe1EUOTiBMPZBVJq3zzBd4A43cGI4qUUr5Pfk4pHKQ69veN0W3OuAqEJaCxNyVtB
 kBfSrNr4KVEP72nm0BvO1/4KoDvHwpub3s2V4Et+KDbDmiYF9ti+1glOFwgvQDMOfOOV
 HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376140; x=1696980940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GmmJ7cOFUeiFT48AhnZ61JPhLUFSCR6i7jpIveL+bg=;
 b=D1XmmvP8s6O8eehkvoXVS5FEk45zq+CrVX/1CH+PARa93lIR9UUG3XUFMn/fdghtv6
 +Vdb0Fa7uevmejFfQ4dFxcJ1WOdspojo+SvjrkIPWzl4CsTvpoG4JX2bb8GoQlQ+M2yO
 j6yxK+qMvejOs1PUe6P2J2ewUrWlkBShtAVYkNaUU6p6sRMiKJkAcQyR4FWQ/HlpDgEY
 EVQK2cYOWzSorsif20j2zLf7KUZzv5tg960IPfrJo0uvPxFQ+7RZtB59Ir+4myib5yIK
 LniNly4egOR33GeI0i/LhB8/5iv3shnTQOEXEl/rJBccl8e/fQ0WGBjuR/Q4636QTsdK
 2YGQ==
X-Gm-Message-State: AOJu0Yyz+4XL13NsGdL+KvyIGMMcLSvsiq0HZxqQWBxGmITnFFTOjo+0
 ectElGcE33vdMHKdmzUAl7rPpH4OeWG+e2Xjr6Lfrg==
X-Google-Smtp-Source: AGHT+IFuvLGJBbbrYBuwSC45c6lMiKnZtKLDhd2uYkDOtA+yvnSz3576Z2cSIC3fuO+VieGB44TKiw==
X-Received: by 2002:a5d:9ec3:0:b0:790:bc17:1c63 with SMTP id
 a3-20020a5d9ec3000000b00790bc171c63mr942882ioe.1.1696376140677; 
 Tue, 03 Oct 2023 16:35:40 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/51] bsd-user: Implement ipc_perm conversion between host and
 target.
Date: Tue,  3 Oct 2023 17:32:01 -0600
Message-ID: <20231003233215.95557-38-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-10-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 8834ab2e588..46cda8eb5ce 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -30,3 +30,28 @@ void target_set_brk(abi_ulong new_brk)
     target_brk = TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk = target_brk;
 }
+
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+                                     struct target_ipc_perm *target_ip)
+{
+    __get_user(host_ip->cuid, &target_ip->cuid);
+    __get_user(host_ip->cgid, &target_ip->cgid);
+    __get_user(host_ip->uid,  &target_ip->uid);
+    __get_user(host_ip->gid,  &target_ip->gid);
+    __get_user(host_ip->mode, &target_ip->mode);
+    __get_user(host_ip->seq,  &target_ip->seq);
+    __get_user(host_ip->key,  &target_ip->key);
+}
+
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+                                     struct ipc_perm *host_ip)
+{
+    __put_user(host_ip->cuid, &target_ip->cuid);
+    __put_user(host_ip->cgid, &target_ip->cgid);
+    __put_user(host_ip->uid,  &target_ip->uid);
+    __put_user(host_ip->gid,  &target_ip->gid);
+    __put_user(host_ip->mode, &target_ip->mode);
+    __put_user(host_ip->seq,  &target_ip->seq);
+    __put_user(host_ip->key,  &target_ip->key);
+}
+
-- 
2.41.0


