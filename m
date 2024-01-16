Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663A82ED05
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:50:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzp-0002So-DL; Tue, 16 Jan 2024 05:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzh-0002PT-J1
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:33 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzb-0007H9-LH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso8064044f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402106; x=1706006906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayx9buhutuCRzyt+CbdSf6ZgOZM90Qy7hXRs4yl/VKY=;
 b=pn36d3dx3yM+gMYSXFdISAojs/q/mypLKb2RwpmnjuI3Xcmsgs5Q1+z6GvKxgdyVUl
 M8dky1GHK1/d2lo8642P1kEph143o6bW2br/3dyu2dhybSd4artU4bsldyJi7vwAbGyR
 Q5xfetAAbXItMYKFpAbRHt+Vzaq/6kxVh+Si5tzIFO8fMjuBNeAA72MiVmR4+djKsdXp
 CjBBQvVrf13/6+/9LcwinBKPBgX7DIHnYqK1iCw81tx54r48Jw1iiL6sjHpooK7qdDHE
 c4P1H9+ECrfNTGOpsHeiBa5Hc4f3j/q3WLRG0BykMXvP0Z7lFWHvn1KtYlss/igSvkia
 oMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402106; x=1706006906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayx9buhutuCRzyt+CbdSf6ZgOZM90Qy7hXRs4yl/VKY=;
 b=We6ndNE76IUwFopSJC8ldpXfrSePyWDy1W3A0CQoSZtuPkI/1EIYdipAn6HdY+IszX
 2O5I3wulo+1aoMvfzstoMa84/yGeFLSosZoIeaaRqpNji1PznlBNmuTSSIpwBmmJbR9c
 dLRo9kg005T9HAn52TeBoECMFRP1eeDhZAtGjPC9zj09es1frbeED5SmUCFpOwJMmNU/
 3ezLKNoWpHhKrthtHcwUpwIllWUDvBPnJY7VqEBxqYA9tk+KvFkVBlxGwbQ9+/esNhj3
 3iArBL+VE1cGMcN7dyk7lN7Jll5jhdiEQGWc6XxJVaUp0Q6EedeeScstUZIlTvtwwnSE
 Y5ug==
X-Gm-Message-State: AOJu0Yx7OMYVKpkKf2QRAogMT2VyOollxink4KWZHDDbvxyxsqIFfsWn
 ym3B82S4CPclDE11aKX8iqKUfxSL5KLPALqAOfxLZGt8sI8=
X-Google-Smtp-Source: AGHT+IGd8486lvvRK1P0jdq+fVOvUOitR1aAgXJlfKsu4/TScx1catYQFEpm8G6Kz/FgSNoYvX/2bQ==
X-Received: by 2002:adf:e3c4:0:b0:336:8012:5ce with SMTP id
 k4-20020adfe3c4000000b00336801205cemr3644745wrm.95.1705402106063; 
 Tue, 16 Jan 2024 02:48:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bv27-20020a0560001f1b00b00337b0374a3dsm2373863wrb.57.2024.01.16.02.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92D425F936;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 22/22] docs/devel: document some plugin assumptions
Date: Tue, 16 Jan 2024 10:48:09 +0000
Message-Id: <20240116104809.250076-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

While we attempt to hide implementation details from the plugin we
shouldn't be totally obtuse. Let the user know what they can and can't
expect with the various instrumentation options.

Message-Id: <20240103173349.398526-44-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 535a74684c5..9cc09d8c3da 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -112,6 +112,55 @@ details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
 exported *qemu_plugin* functions.
 
+However the following assumptions can be made:
+
+Translation Blocks
+++++++++++++++++++
+
+All code will go through a translation phase although not all
+translations will be necessarily be executed. You need to instrument
+actual executions to track what is happening.
+
+It is quite normal to see the same address translated multiple times.
+If you want to track the code in system emulation you should examine
+the underlying physical address (``qemu_plugin_insn_haddr``) to take
+into account the effects of virtual memory although if the system does
+paging this will change too.
+
+Not all instructions in a block will always execute so if its
+important to track individual instruction execution you need to
+instrument them directly. However asynchronous interrupts will not
+change control flow mid-block.
+
+Instructions
+++++++++++++
+
+Instruction instrumentation runs before the instruction executes. You
+can be can be sure the instruction will be dispatched, but you can't
+be sure it will complete. Generally this will be because of a
+synchronous exception (e.g. SIGILL) triggered by the instruction
+attempting to execute. If you want to be sure you will need to
+instrument the next instruction as well. See the ``execlog.c`` plugin
+for examples of how to track this and finalise details after execution.
+
+Memory Accesses
++++++++++++++++
+
+Memory callbacks are called after a successful load or store.
+Unsuccessful operations (i.e. faults) will not be visible to memory
+instrumentation although the execution side effects can be observed
+(e.g. entering a exception handler).
+
+System Idle and Resume States
++++++++++++++++++++++++++++++
+
+The ``qemu_plugin_register_vcpu_idle_cb`` and
+``qemu_plugin_register_vcpu_resume_cb`` functions can be used to track
+when CPUs go into and return from sleep states when waiting for
+external I/O. Be aware though that these may occur less frequently
+than in real HW due to the inefficiencies of emulation giving less
+chance for the CPU to idle.
+
 Internals
 ---------
 
-- 
2.39.2


