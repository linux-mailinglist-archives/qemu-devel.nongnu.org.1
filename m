Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3A67E41D3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0J-0004TU-SE; Tue, 07 Nov 2023 09:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0004GH-Ip
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzw-0007bY-JE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so4126585f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367047; x=1699971847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+uCrfcDLt4fP6JkGcpQPZ8E5/aRDEJ/o5oc6OzqeNw=;
 b=BncrT1aN9J4wtWe+xtgLd4oubu3vZ54lt/OUZjYY2YdbfD7lx3cwctNvHYAxoOYhke
 LNc5vhGRbqsmJDx7VpfsSgwJp0Bk7e7T6tAockLGxNR0ZoqRvchy4x83DmD8arhxuaFr
 LQdYLgIitUz5Aq8dcUouubsJrqreL2JYOg2nsNh/JLl5Xa3K5q5e2hq6NqzM2A7uF3vi
 QQIl8ZbiOzRRtmei8q9b0QvIO9Ny0NRagPdRtXGC8NsxuloIJYvHkRMqcP+zIPqunHot
 YCqegBzUxaziq2O2tDfl3RHyh4c7jciRE7eno75Lmtr+gywhYqu2yNVaI50QOyQGEWIA
 Oajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367047; x=1699971847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+uCrfcDLt4fP6JkGcpQPZ8E5/aRDEJ/o5oc6OzqeNw=;
 b=iM0NYeWeitIU88F9Gr66/xNgkMlLuRTFfn7xLKRJbu+sfM0DWxgd51njZ6g6Tv3OT5
 HtrHn7C+qUpy1Kxtj4UaLYWdYUXNAa8PSWqVWI7os7ofKxFxMpTTRQan69kuCUpFsP/6
 rv3IA4Ov45ai8pmPdPkC9haHpOPT3QVQ6n8RQZHJ5OOcINaYhfN9HCgcr5QTL9GcrpOd
 rdaILUwk87wSzH0NPb0VZA/cEb/XFWX6J6Lv8qui4gTGQGSfFHdTE+47hCttxb2if4r2
 RfExyW/loVRCdYUveVHg2IRk5D0W1PxdY2QbNre+B8F59d8iu0iRdurPkH2h90D9eCAX
 4b0w==
X-Gm-Message-State: AOJu0YwnJb1ipciRSvMs35XTy88Npx2r6NTKsoTa35qvcWzSn83zcz74
 f6hBIgIoygyqBVxGq7xhLDZN/A==
X-Google-Smtp-Source: AGHT+IFyGIq7dVuMDH1EOvoNleUoy+5cFOjmba3M9Lcmq7y/mU25lAAhiCt9//oX/8BhI6QOBPzwQA==
X-Received: by 2002:a5d:4585:0:b0:32d:a4d0:1364 with SMTP id
 p5-20020a5d4585000000b0032da4d01364mr3064173wrq.29.1699367047017; 
 Tue, 07 Nov 2023 06:24:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv12-20020a05600c548c00b0040641a9d49bsm16047254wmb.17.2023.11.07.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AAEB565761;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/23] configure: tell meson and contrib_plugins about DLLTOOL
Date: Tue,  7 Nov 2023 14:23:43 +0000
Message-Id: <20231107142354.3151266-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To cleanly handle cross-building we need to export the details of
dlltool into meson's list of cross binaries and into the
contrib/plugins/ make configuration.

Cc: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-13-alex.bennee@linaro.org>

diff --git a/configure b/configure
index f1456f6123..cd6c521bd8 100755
--- a/configure
+++ b/configure
@@ -309,6 +309,7 @@ fi
 ar="${AR-${cross_prefix}ar}"
 as="${AS-${cross_prefix}as}"
 ccas="${CCAS-$cc}"
+dlltool="${DLLTOOL-${cross_prefix}dlltool}"
 objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
@@ -1659,6 +1660,9 @@ echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
 echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
 echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
 echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
+if test "$targetos" = windows; then
+  echo "DLLTOOL=$dlltool" >> contrib/plugins/$config_host_mak
+fi
 if test "$targetos" = darwin; then
   echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
 fi
@@ -1764,6 +1768,7 @@ if test "$skip_meson" = no; then
   test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
   test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
   echo "ar = [$(meson_quote $ar)]" >> $cross
+  echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
   echo "nm = [$(meson_quote $nm)]" >> $cross
   echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
   echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
@@ -1869,6 +1874,7 @@ preserve_env CC
 preserve_env CFLAGS
 preserve_env CXX
 preserve_env CXXFLAGS
+preserve_env DLLTOOL
 preserve_env LD
 preserve_env LDFLAGS
 preserve_env LD_LIBRARY_PATH
-- 
2.39.2


