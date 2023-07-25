Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0246E7610BB
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFEa-0000KD-V8; Tue, 25 Jul 2023 06:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE5-0000Gc-ML
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE3-0007VC-Fw
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso53871935e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280706; x=1690885506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=41mRUnFQ63Ww9Yf+9V896kHykCP+IOApwo6ThctCswg=;
 b=KcgvwJwJxFBsRZs3JzMUJP6BI9LNwdYnMiL/ogUeqirQH8im3pWDE5HA4BWBgeGJ2y
 q3MzNn1gMxx0XyUBiixhgcSiVQ3KLAT/Qw1R6GWbIMppjtJrI1GPkd1yaGR9A90HrJFA
 lPo7DxZEW+7yu0sKNt1BYoDatzuHUXYBJslHAP1uwtCE+yDtVJ5YGp7hyUwrKdDzjd+X
 JqmzrHtGBucgRSUBOBPFS0BID8tdrq7VZtrG+pyj4qeGoKEGck7JIhxaQR3aY+lmPx3i
 NC1Gk4/T9pAsjk2qfVrPRblJ2d4snEsFJVSDHlfBFP1lve+lMmgyA3Ld56aDAY2Tmspx
 kDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280706; x=1690885506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41mRUnFQ63Ww9Yf+9V896kHykCP+IOApwo6ThctCswg=;
 b=PCHTJGRH7G8c0VQfx08eDTRZf4+mndEynqLKlddejBlmckM1hjC643GQ9I63pHSdG+
 VOUX5/Dpi8i4ulRVB3X9CnDoYL/OKaxMXs439HGaXrDhFrA4HT3lSE+L2s+n1AbmrjHt
 PEcmKzbXxqV3Yyv0upqKD6Dui1gbT4ymH+HAZT6HTfIjO+G+TMj7C5Dz4DZqJ8Ag4CID
 Sx9qMrSaoc9+p83Jv4GJPQL3CkMndIp2ivU2NirRWCs7SFr36VKusI8E1j/mtVRdpxqV
 anV6GkR3O/76j8DgzEoi0a1F16P+A1yAlaN5pgz/jKZ/uk+rZoqJiJsq3XqWokdDElyE
 Cc7w==
X-Gm-Message-State: ABy/qLYk+YeTPvC0b8s8Iyido3Sg0jiAVGw5gxwBEq9WHdCrAsJTUauM
 dZW8PAFJKP2VEPMo3VWll894kpWtWqlb6XFuaDU=
X-Google-Smtp-Source: APBJJlG3pHS5QdDZXVF9VV8+RHghde6bddXH/eXtDBOka6ePAp3jw1IcTTm1TYfcanw2ylTesJQvAg==
X-Received: by 2002:a7b:cd1a:0:b0:3fd:4880:2aa5 with SMTP id
 f26-20020a7bcd1a000000b003fd48802aa5mr5986334wmj.28.1690280706044; 
 Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] scripts/git-submodule.sh: Don't rely on non-POSIX 'read'
 behaviour
Date: Tue, 25 Jul 2023 11:25:00 +0100
Message-Id: <20230725102503.2283907-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The POSIX definition of the 'read' utility requires that you
specify the variable name to set; omitting the name and
having it default to 'REPLY' is a bashism. If your system
sh is dash, then it will print an error message during build:

qemu/pc-bios/s390-ccw/../../scripts/git-submodule.sh: 106: read: arg count

Specify the variable name explicitly.

Fixes: fdb8fd8cb915647b ("git-submodule: allow partial update of .git-submodule-status")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230720153038.1587196-1-peter.maydell@linaro.org
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 335f7f5fdf8..bb1222c7727 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -103,7 +103,7 @@ update)
         check_updated $module || echo Updated "$module"
     done
 
-    (while read -r; do
+    (while read -r REPLY; do
         for module in $modules; do
             case $REPLY in
                 *" $module "*) continue 2 ;;
-- 
2.34.1


