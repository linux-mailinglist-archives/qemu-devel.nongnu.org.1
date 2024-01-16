Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B782ED26
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:52:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzu-0002cl-MS; Tue, 16 Jan 2024 05:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzg-0002OR-ST
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzb-0007GV-KN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e857ce803so3502795e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402104; x=1706006904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zet1F0IXZblv1/B9heIoJ6sflAFrB9ZoscsrKiRyGys=;
 b=bd3ZZFM68Y9JHS8ZTe0L+q42VBR1VjSql3GqlekoW/Bdyt64fXsZrmHFi/2kgUs3gJ
 ea0H8N2PJJnBaufdU/lGsYTWtFnpzSAXKMRm7y7Xw6ostVrf87yHS1Q8QK7zxVRO3B45
 a6hOv3l1hK4r1eDdqbfXexLIlbxSftnonNPfYvMKnOkEOp3G3QNa9yG51BqJpfepm3d4
 ZwzetOmZW6E29VKUhq9AU8ayBTIl+Gng4XFPY4Z0kB9M2ZsdyQgZxX83nuFzi4IPH6HL
 N+/li1eHj5l1us/3XZJ3GjFm2NOJChJLuSITlYONlai3zCreEf2huni7IkQLNRnMZc+7
 HxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402104; x=1706006904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zet1F0IXZblv1/B9heIoJ6sflAFrB9ZoscsrKiRyGys=;
 b=X8WuWg6lbCnOtPfrZq5AHKAEvNUs6iCua1YsqGdvLUr3XYsUo5C8GkKjw5BWkjOepl
 CTPzCugN1bZ/KL/EGLd1JXgQZCAMAmyK8BsOHRwxsz77OYHyubUZlup7MNwTlO1HsiNr
 fGXoOT/BPyKiQTwug7M+dZyK8gcquTuvOoL66fKX6+UxVwMu+6i6DIJt4noH7CJDkQy6
 NWxmv3gOWBdfwK+9rzrlSrZz3gJR1FMy9ZfkwxldUUtT9/MhTGT58ruqSiVVAK8Ei3VW
 Gc3qD7mbjXswb3CSC4zDo8S+RbLjEGH49fpxyNo+0jaEoa1EF/ts8W4lueW2srAHpVU/
 2uCQ==
X-Gm-Message-State: AOJu0YyLHA9nK43ODGxWeVCVk0ojlytDBC9Jd9Ckd1J/ZuOzJikVmmvb
 OZbJ/2p5HwM2ZOlPsS2QCtKeWZNoTJsu1A==
X-Google-Smtp-Source: AGHT+IG6HFyQwwEuRF2vY9EnfqVdg7MEP4vH1vDsA5ZQmcDjY7y4cl7c72vIfLLerFypMaNjBIMeXA==
X-Received: by 2002:a05:600c:524a:b0:40e:4afe:12eb with SMTP id
 fc10-20020a05600c524a00b0040e4afe12ebmr3354191wmb.188.1705402104482; 
 Tue, 16 Jan 2024 02:48:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fk4-20020a05600c0cc400b0040e7efb1ff2sm4562472wmb.37.2024.01.16.02.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D4E75F933;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 21/22] docs/devel: lift example and plugin API sections up
Date: Tue, 16 Jan 2024 10:48:08 +0000
Message-Id: <20240116104809.250076-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

This makes them a bit more visible in the TCG emulation menu rather
than hiding them away bellow the ToC limit.

Message-Id: <20240103173349.398526-43-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index fa7421279f5..535a74684c5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -143,7 +143,7 @@ requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
 Example Plugins
----------------
+===============
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
@@ -591,8 +591,8 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
-API
----
+Plugin API
+==========
 
 The following API is generated from the inline documentation in
 ``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
-- 
2.39.2


