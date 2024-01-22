Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46B83666B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:02:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvo8-0008Uw-8f; Mon, 22 Jan 2024 10:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnx-0007w9-GE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRvnn-0001ml-Fx
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:01:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so39455465e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705935690; x=1706540490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZ1nEd8NJNCNQAO45v/M0dXLXOT0Wd7jVxF+jov+Saw=;
 b=oBYV3ioTnLMX77Inn4NkF/S5eaRmjdDyEc7gyjwT3Lwga8ECk7yoiVFnoroY7RXfD+
 naMtYfH//+Y1jbOtG5mUTD1HUFlrPS82fmXyc+EtKPSnhOiapF1GMtHeB0OSyMPyXGPx
 1kZLNZ8JbnFQ8ofNGnYQ/oHWYMsp5uKIYfBo/lKSii6jFEybxfksrWGtRv65X2KulCP+
 DyTEvkphJS/DhvQT4ecx4u0o6n0qYjSVmuWSWE9VM6CB23grH+yZ8kn8rHTyjjeWDYR2
 1Tiq00FavXxfej8xNePv3mrN3kIeJknwrGVhm5U5evrGeOdYV9aZfqOfQ7jhGxb7XG+5
 yARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705935690; x=1706540490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZ1nEd8NJNCNQAO45v/M0dXLXOT0Wd7jVxF+jov+Saw=;
 b=ZDYZ9Zd/yBqB3OhlbBzcNuA4dnn7L7LMr8JEsaiVNyGjqasNbuCz0lIglOjIFRlob5
 Yi4RiVdSpNW1ScTOxZ0E8hi0wHahWq86O9Wm3kriYksjDA8min0RKDipfy5vRPgmnA9o
 WL51Lo+0YFmY7fzQEgdhh4A/bjzQGiAElsUfJe9rFPNhgMluO/Lxwv/PS1GF0YVg4s0O
 YFw5vll7UZ9QhQlAhO2xpKG2KvxYt08n0sPkSVCs/tgHetAwUPfx4AWhQWIDLmQn7J7k
 BtkYuGNYD8RTyfCu0IvRH1e0MI4vkNFptcP+ojIYaTR4AxxCGy37nbRt3eEE46fUG9bj
 7okw==
X-Gm-Message-State: AOJu0Yww9YXmpmH3f8CK4SKa3bigPIha/cg1NBep48GlUn5vmFfereVE
 1Y0q+2EbYwsL7FpksVZwJMu61bVF1PIVPXmjltcL8hcwFKCTDyv/koxdAKDoLiY=
X-Google-Smtp-Source: AGHT+IEwv0U3gluOvjzxJUPlNZ0yWsCpKsoao62m327xZ8POdVEwgy/zDswLP5yfB02fCPKJ5stsXQ==
X-Received: by 2002:a05:600c:5403:b0:40e:a666:4729 with SMTP id
 he3-20020a05600c540300b0040ea6664729mr1258496wmb.278.1705935689716; 
 Mon, 22 Jan 2024 07:01:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39534890wmn.35.2024.01.22.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:01:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E12235F9D2;
 Mon, 22 Jan 2024 14:56:12 +0000 (GMT)
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
Subject: [PATCH v3 18/21] contrib/plugins: fix imatch
Date: Mon, 22 Jan 2024 14:56:07 +0000
Message-Id: <20240122145610.413836-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122145610.413836-1-alex.bennee@linaro.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

We can't directly save the ephemeral imatch from argv as that memory
will get recycled.

Message-Id: <20240103173349.398526-40-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/execlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e2..f262e5555eb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -199,7 +199,7 @@ static void parse_insn_match(char *match)
     if (!imatches) {
         imatches = g_ptr_array_new();
     }
-    g_ptr_array_add(imatches, match);
+    g_ptr_array_add(imatches, g_strdup(match));
 }
 
 static void parse_vaddr_match(char *match)
-- 
2.39.2


