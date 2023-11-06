Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2BD7E2C64
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04h8-00068q-EW; Mon, 06 Nov 2023 13:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h6-00065O-4F
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:28 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h1-0000zh-VY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:26 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c6ec78a840so64525641fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296682; x=1699901482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfrStN1bGPF7+o1NbmLsld1y0X5EN7/qz8z3IXc0LBY=;
 b=q6M2wFtV/7SEtWNC1A+fm29z6+plCopQwgBljfLhXfjaUR7StfozVf3sjVrEvtgS9u
 xZ9q2IlCFxE87FjAUOWOy8P9+er0XgnIzXRN3jCMDXVVnEs9MV54uaffaX7be48MHna6
 7eTnqL9N2VEAvWH1tnWhyJa/rVQ2bw9hY3mXaXDVIOw0el5NzwDWXVsdnthkbhV9yVJx
 poyuToEtQH/ShpLrXAi4+sbIn32rFqpvERwX78brHDUv3PP6/APE5KIgT+OYT0g6EnHh
 Y4eecrsU/bWNHiLy5/Hec/h648QxTzro0HhSG1jrfRR/Hw3N/C5rDM/Z1xF9a7z22CHc
 ckZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296682; x=1699901482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfrStN1bGPF7+o1NbmLsld1y0X5EN7/qz8z3IXc0LBY=;
 b=VUvdBUvSmnjuJ0k0K7BM+1usl5UkP/R8WZ/xmXdVcLJ7U1CZ9oywfUP7uz+wCGBkeg
 TPSnPhDR2g3r9kb8V+dwZqHKWll+MXwieLb4iSyB4Yjk5EG8ZAalktWx8XKeif7FjoeP
 7Zux+Zre6mKmAiSQaiBI9W7FilOBjVEEnLcB1lin8bwbDDt5+cF8ekqU39Gl1PNBcOJ9
 FoesW6fkejqIiDyUE9oEB9i3jqP6HeBt9DZGpZm83y0Ke9lbBQwGgzD1o1g0vKxFq7X3
 mnXWQrTR5FD27DpXP5CvZom/fRaNZEmxGUSCSq06Vc6xCIfrI4ewJCY5pzT7NYu2HLB5
 pQvA==
X-Gm-Message-State: AOJu0YxPFDsC5WkiZKbqbumgllR8XmTygNFsN5JNo8Qx3fEwdxSM0qLx
 J50zDBsNcymu/oIcXewfkj6JXg==
X-Google-Smtp-Source: AGHT+IEr9kRags2L5GCipbuODWIvzl3MyxkqFIa4cKYyfIQDFxgeAMBRCciz8io11OFDr93WplqkIw==
X-Received: by 2002:a2e:b4ab:0:b0:2c5:3139:2d04 with SMTP id
 q11-20020a2eb4ab000000b002c531392d04mr23139936ljm.47.1699296682423; 
 Mon, 06 Nov 2023 10:51:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040836519dd9sm13208168wmf.25.2023.11.06.10.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8AED6655DF;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 12/22] configure: tell meson and contrib_plugins about DLLTOOL
Date: Mon,  6 Nov 2023 18:51:02 +0000
Message-Id: <20231106185112.2755262-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Manning <gmanning@rapitasystems.com>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

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


