Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF143836697
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvo7-0008PK-92; Mon, 22 Jan 2024 10:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnx-0007t1-0y
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnn-0001mp-EK
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40eaf973eb4so7691795e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705935690; x=1706540490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMZ+pFdg1P4n/cHnfp4DZXoxUsYEnk+lXnRUtGdShK8=;
 b=Kpwh4oHNASl9PIBuLCrEMV4LMj+0Pti7VhW5DD19pr+sKWjyF5w2pF3vzG6xmkQPDA
 +c1V6Sh6hLC4FKdsuGE93ouFHATtcHyM0nJWV23ew+7S0YrnyL24+U9XvazOLq6C5NW6
 fzDwW3yfVHNStTXKkiT0ie5ATbrJ8Y3HJIS4S1NAfI/7tF2wogsOsiuAo96+Fd0dK43x
 wKZFDPOhldxjzHsibWlPCoAx9u1uCW6qxhQzSKYzS3h8td9Gt6Ok1ImFr5rf/HQqQ5U4
 I1okAejqVaglzvg1IWuXyuz4OECrUwoXqtT9DqhoHDI8ReHuzX0DgIC6k2/0WuAGz6Ka
 PN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705935690; x=1706540490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMZ+pFdg1P4n/cHnfp4DZXoxUsYEnk+lXnRUtGdShK8=;
 b=H0eeQaOMlL6Ij/aHJMUDePwgJa+LrESaTb0NlsTfXCH+YR6qr5aXtR5cZAKqAcgzO0
 GHd3WFXGofsT4IyMrRj41tpVz9U4Ogz7ycWQdaA+Nlc9kPylopwykFn5eSgPB6rl/VqH
 H0qjd7cfGgpsaLoOKEckBGu+N2yC+ZMVu5fkzd0i8+rX9BXv0nmA6EVK5btcyixZ1B29
 xCFnKilmB+UqI6wQqkPBQzG8QDJ5Mr/oR0k/WeTBK5k6fxBGsuI2XMiWTHIiRgcql1bx
 7taGb1cZl3OhOEUpQqpqxTHXQEz+9reU/iw1pbHKj2uxsZ3dsDhRldMq4c1Dgw8I7Yri
 hcJQ==
X-Gm-Message-State: AOJu0Yza8w0tnvJCjgQiS0kDlh4sHOb/C+EJqZr6tmhhc4Qx7igOViOi
 7I7vMD5+U7S8M77K+w1dEbgsY4UxapoiWdu0MDPkzl5teCfQkOEVoOSJnmKhdjE=
X-Google-Smtp-Source: AGHT+IFPIr2Ee0y73303g5cCda6EprIxJ9AwU9+gItZXvCJzsVuJi+g6jnLnWq7qRPmBEAJUswV1Ew==
X-Received: by 2002:a05:600c:4f10:b0:40e:b0ec:e98c with SMTP id
 l16-20020a05600c4f1000b0040eb0ece98cmr456950wmq.139.1705935688372; 
 Mon, 22 Jan 2024 07:01:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b0040e5951f199sm39123604wmq.34.2024.01.22.07.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:01:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3642F5F9D5;
 Mon, 22 Jan 2024 14:56:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>
Subject: [PATCH v3 21/21] docs/devel: document some plugin assumptions
Date: Mon, 22 Jan 2024 14:56:10 +0000
Message-Id: <20240122145610.413836-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122145610.413836-1-alex.bennee@linaro.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 docs/devel/tcg-plugins.rst | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

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


