Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A220F7BE6E2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptPa-0005Ne-C4; Mon, 09 Oct 2023 12:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptPC-0003JD-PP
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptOl-0003Xa-Dj
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so2831952f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869975; x=1697474775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAyYQkrKbWdgjPeSFpAKf8LHOxPMb7ttiO+d+H3EETQ=;
 b=J5Lr0jclW7J339kIM66DlxNeLzBa14n1qo/PBMaOl7bsS/yXRn5HTmqlsmNAxv3W3X
 zJsN4TNXJpddqyAfjfSlhP6HeWThSqZpTrrCZX2ucIrOqGMsnaui8L8/DA4yA0Vu/r9P
 M6bksoVSx8CYFS3zgaXaV44EJZ5fY+Dp9agVP9UZNuEwmNwqI2x2p+msvC0luwHe3igG
 VQ1xjqLT4txAGAbGuo+onm7vGMcMdx3VyJa97gRaxtJnfTCYXEtBl6p4VBYXekTzMF5Q
 jf3gqth3dkBEqlt2239J1f8K8RwIUnFFZsvAQrv2HeKFcxaLwqkcY7cZRzDrYp230fRg
 eexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869975; x=1697474775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAyYQkrKbWdgjPeSFpAKf8LHOxPMb7ttiO+d+H3EETQ=;
 b=rPCCLZjrKUTLPwIc5Be6xMAqhrSzQNOiMRtHAOjxhOGvxJbTHJEfwQ27z1t1ykGOko
 Pgtj5TEqhaxSqOA0jTDB0M1ZMaoKaavMucLUQcqixnykCA01fNi2DIa7XpjJ5C4kNj8G
 2dmpuxtOsgPFHBVHuzjvZGO6vmMBczXoVkrOem09DVL836svomBmEYrkZO6pLGgVl1Sr
 mYpELJw1tzKOeYQ67hpUYL6eJXuVFUnf9c2/Azs1FVakLajchg3vIIfQoRmcMxVaxQ17
 QPk4PlyejHWWzP72A2FqfV+RG4xoQCx57Gjn802lSrO6JwHPU3yN3WNy6CBdScxFMnYw
 hG4g==
X-Gm-Message-State: AOJu0Yz7TyhiNVr3JmyY6KUfLO/UgSwcoIXIEhUCfFjmIgyYN5zU1FXc
 TDzcNhCFOj77NAztY38Vd7oNcQ==
X-Google-Smtp-Source: AGHT+IHod6U6EmD0nkVFnhvY4XK4tB1NiixxHOl20O7cWXHyguHNdEJPEGeH5hB5HvD2bZ31su0fHQ==
X-Received: by 2002:adf:b34a:0:b0:329:6c6a:c733 with SMTP id
 k10-20020adfb34a000000b003296c6ac733mr7480553wrd.58.1696869974897; 
 Mon, 09 Oct 2023 09:46:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a5d534b000000b003232380ffd5sm10082444wrv.106.2023.10.09.09.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:46:13 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED3E71FFCF;
 Mon,  9 Oct 2023 17:41:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/25] contrib/plugins: fix coverity warning in lockstep
Date: Mon,  9 Oct 2023 17:41:03 +0100
Message-Id: <20231009164104.369749-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Coverity complains that e don't check for a truncation when copying in
the path. Bail if we can't copy the whole path into sockaddr.

Fixes: CID 1519045
Fixes: CID 1519046
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 682b11feb2..f0cb8792c6 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -245,6 +245,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 static bool setup_socket(const char *path)
 {
     struct sockaddr_un sockaddr;
+    const gsize pathlen = sizeof(sockaddr.sun_path) - 1;
     int fd;
 
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
@@ -254,7 +255,11 @@ static bool setup_socket(const char *path)
     }
 
     sockaddr.sun_family = AF_UNIX;
-    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+    if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
+        perror("bad path");
+        return false;
+    }
+
     if (bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
         perror("bind socket");
         close(fd);
@@ -287,6 +292,7 @@ static bool connect_socket(const char *path)
 {
     int fd;
     struct sockaddr_un sockaddr;
+    const gsize pathlen = sizeof(sockaddr.sun_path) - 1;
 
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
     if (fd < 0) {
@@ -295,7 +301,10 @@ static bool connect_socket(const char *path)
     }
 
     sockaddr.sun_family = AF_UNIX;
-    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+    if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
+        perror("bad path");
+        return false;
+    }
 
     if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
         perror("failed to connect");
-- 
2.39.2


