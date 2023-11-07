Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B113D7E41D6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0I-0004Qu-Ms; Tue, 07 Nov 2023 09:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzu-0004Di-N5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzp-0007YK-IE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:05 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c6ec78a840so75737391fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367038; x=1699971838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KyRQEuJeZ5+LF5Izx85Idqn9Hk1tbv3l5q5snV79uA=;
 b=YDznwLNWe3UKxKoDve/DpMKTNXEehztN4sqOTd8KJ5m+4o/JaMeTYIGETjue5ibHGa
 inwWE0PKXNdNnNIekEqY8wKUh89o7Cw/a69GtRdLV1WEtGRxSvxZgrP9RGMsq4BB6Cvv
 CwR9qnKA3steGP88+75CJ0x4TbUplqAYlC2imlz8RBGYPMT5DlLXFGiz3yYjeQ6C2Xux
 M4uahpAiZNVLLth68Jzxf6MUukrFXMt/vP/FMUgQIbkPsF/yLfEQOqP1Ek4naRXE7A1C
 uSF73su/Z4WVG7Vu3F+XVZmd09KbzEMkUtjgPj0wVDdVK9bSbkaXIOdxN/Ael+qk9wIY
 UsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367038; x=1699971838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KyRQEuJeZ5+LF5Izx85Idqn9Hk1tbv3l5q5snV79uA=;
 b=NWNyeTRW8aHNoqHn51430+7S6zDuwzrAHA33d8JSxYDYyjhtLIVoLtL4yhuILlocV5
 /AKCYgnAKP9LCBrmtfl5gD8fkMxOP96QsY0+MlokhSabN4tCS5kG7+6R5v+MZgnWN6cA
 sKCzxwbZXfMrlFMJbXgko63Dx2x26soMjFxli+QObLIVs0y5xcIyA8MeDkoLvkVJXcfr
 yfuqrntjKuLMaU9JfCiHn2IhZx2pK5zYH8sB9Fh0gTV4hxSrsvpz6w32cAe8r0J2V6n4
 3A5/px77BPecz0r44DSuaJof4tYfD6kzIjOiF0uEGpT91eET5PfQDNxAsEImpx6g8XIo
 0BIQ==
X-Gm-Message-State: AOJu0YxRjvZ3n+LVG9f1UatoUb9va3xaEaA8wK38DYUO1vhYsrJA2P2N
 gBUumAozf/2mQaEBVWFgVYGpnw==
X-Google-Smtp-Source: AGHT+IFvA9EGGAgLalD0baceZah4j7cTIwcT3v5+IgMAvyo8XgYE+tZlS3YChKiO/qfXQHrI0EfEqA==
X-Received: by 2002:a2e:8681:0:b0:2b6:cff1:cd1c with SMTP id
 l1-20020a2e8681000000b002b6cff1cd1cmr24078385lji.34.1699367038678; 
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b004064ac107cfsm15793487wmq.39.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8D786573E;
 Tue,  7 Nov 2023 14:23:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/23] gdb-xml: fix duplicate register in arm-neon.xml
Date: Tue,  7 Nov 2023 14:23:33 +0000
Message-Id: <20231107142354.3151266-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 56aebc8916 ("Add GDB XML register description support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-3-alex.bennee@linaro.org>

diff --git a/gdb-xml/arm-neon.xml b/gdb-xml/arm-neon.xml
index 9dce0a996f..d61f6b8549 100644
--- a/gdb-xml/arm-neon.xml
+++ b/gdb-xml/arm-neon.xml
@@ -76,7 +76,7 @@
   <reg name="q8" bitsize="128" type="neon_q"/>
   <reg name="q9" bitsize="128" type="neon_q"/>
   <reg name="q10" bitsize="128" type="neon_q"/>
-  <reg name="q10" bitsize="128" type="neon_q"/>
+  <reg name="q11" bitsize="128" type="neon_q"/>
   <reg name="q12" bitsize="128" type="neon_q"/>
   <reg name="q13" bitsize="128" type="neon_q"/>
   <reg name="q14" bitsize="128" type="neon_q"/>
-- 
2.39.2


