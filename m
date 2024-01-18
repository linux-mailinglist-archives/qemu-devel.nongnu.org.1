Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4328311C1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:25:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ15-0003Y5-Vo; Wed, 17 Jan 2024 22:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ10-0003Xo-FC
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0z-0002bw-0D
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e90163be1so1817385e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548262; x=1706153062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=qAhhsCA2CZUSKteNTjSg+gDJiQClJLQd45gcyC10Opq4y7Py5HWBvSb3ty88OEVvki
 H0OQHV3LO82k8cPFRoKJSbRuMowOCu7YCsNU2j49GMEJTU6Wh6lo6mLwTvbJuz5AiJwP
 /6YWVtNpooAm/3pr8P4YSsDGPhOFpzMpB6tgJMaE67CWlGHIbCbyx7mZmPhr/M5EBExv
 Ge2lLdSx5flJOY818uStiiy25cD8PBt5gcJ/UH3Lh9LYy+Qg+faNt4qUAii7q08n8xX9
 cjjKOfbpQdFXCP2os0e/wP1rhVzN9RY1BUesltjpq8utM9kDMGagIvg6BGc5gOldpBnd
 yCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548262; x=1706153062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCiv7Y34jUunl2R1CBjG/RVHjCXAnByZwR7nxj0vfkc=;
 b=fTk1fjzM07vNp6j9shgMuseXwNUIypmy/CvM2n1BxfzeIT9r7ZiHyt9lNBzVbQZ2sO
 V5k5YIR1wSleNKHp+qOZEUQaW3GBk/sghClfDcxwRlDbzyuizYVuC6VoGs3OXc2YjTej
 5yzvwguc6gkTelUNCEulcR1a/OxqyZRFieRqk2h1pswCHDdrDdGB1fMqRy9UFx03nM/g
 hn4zxAqxiZzEdytw7xwaVzK65byn3hlXD9zmrpUZf4THyrJRHTH7XDEUg9jMlfCE3qFP
 LZAm4Z3/sr6w3FCtkWulLYijE3qGTtnEZlp5xX7nBPnoGyUaCHCvQTC1BU/TLQnz0hO7
 Jenw==
X-Gm-Message-State: AOJu0YyaQgMF4uZZYdqSe8qIOU3C2rElLFwCTI/Cf2F8+rQ/z7n81i11
 CUw26JuL1J/DI4UP4Du5MmrDRZki89Ud3MbX1JimEaAhYrGQYrW/FwxCvxT4kci65Mudt3uoGCB
 rZo0=
X-Google-Smtp-Source: AGHT+IHpyWGs8Lq19lXKZXnpYoxZta6Xry7pR0X3v/TIrjAy3c2Ax6YxKkjqRjtW3Slc2U5pPrgmrQ==
X-Received: by 2002:a5d:4a42:0:b0:337:c558:805 with SMTP id
 v2-20020a5d4a42000000b00337c5580805mr44130wrs.88.1705548262246; 
 Wed, 17 Jan 2024 19:24:22 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 03/14] docs/devel: plugins can trigger a tb flush
Date: Thu, 18 Jan 2024 07:23:48 +0400
Message-ID: <20240118032400.3762658-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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

When scoreboards need to be reallocated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/multi-thread-tcg.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7302c3bf534..1420789fff3 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -109,6 +109,7 @@ including:
   - debugging operations (breakpoint insertion/removal)
   - some CPU helper functions
   - linux-user spawning its first thread
+  - operations related to TCG Plugins
 
 This is done with the async_safe_run_on_cpu() mechanism to ensure all
 vCPUs are quiescent when changes are being made to shared global
-- 
2.43.0


