Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FEA13EC7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 17:07:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSMR-0004Os-Gm; Thu, 16 Jan 2025 11:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLC-0003Yj-Kz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL2-0001JO-0X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so649731f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043398; x=1737648198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=dEgbu3FokfA0m9MaffO3a8t1kHCv1EECqUvjLvhqEDY80/5qQSNprqJXa31S18tKoC
 xfJyxvNp++7pKEENvcQTIgKnNSJsondO3qVfKgY7hGmd1ipcCynV0+v9OVw/pHyGNoOg
 s+hlQFLJQT20glvjtbbPUMlIO6qS8caajOsTxDQy+U2NvZDVfPO43Y8LA1NJoZwgyZsl
 fhxLVfZ39XYum77dvS+luwkKPi5a6VWEJ7tRZFqAez2RBdJ+f/I0NLDIBSfxuksXgo0e
 8nxSunoYmHU072B3GjUfuAG1ij9M3Jwr888Y8TEzIeKsNUdlqkSUXFN0fzB901Obv/8s
 WeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043398; x=1737648198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=ZE7J4e7OQV7vv1xfB4Xzrk6CMNd7FsRIp31rfQV+hTvCgYmKmFYWWcFZk4v97GJBDD
 1J/X8BHfPexe1NEGFKoG03Bitzyza3MzMcyKFThFO3FsMrzNohXI4wd8lCEguo2+8zSZ
 VvzWdhzyWF4Xdz4ChQT08QNXrN9CRzV74TW/5+v5huOFTYfykShv718flCZW0PrMcg9v
 4ZznK6IuT+mIz3EcPR2tw0Q0Wzb3w2xuVpCUF7DqegdQX8oZLsR2qluyQWcVKcZEG/3u
 f7WtrVg725aESqVjEcOHxkIjPif8US5b/MH08t36qZQarGtLC0zkhYHKyMS4PL7qIthy
 5lmQ==
X-Gm-Message-State: AOJu0Yx0JV9NW1FVuZoutUKOCQDkOfEgUPOli+ozqY62uJoqouY3YB4x
 xZLlKIl4qNFoOXi9OIzxlg7S8yeM/h3XThQYyBVZL2Pvo6lhAEx5kmyi1bpf+DQ=
X-Gm-Gg: ASbGncub3uo3JHHJCW7OqTy1ysrIvE7VHUvBp+dwEJdtTioss71W8bcEUo0ohF4DBIp
 dUkjNs54KtnRKo2WSFRFKFBFIzafE9zWQCNK6NTgDsWlsOuR9K+dML+uXzIMikxFCq2C/+HZaGy
 qw8NFbbDUltNzeGlu1t5Yc3NSGX1m2E+LVxzagg+uHKDMzgaP0trNklxvxI9WdWnZtTL/NxLOKh
 qoxemrjqzL8zi2uZ3CM9b64cOL8BsQhMHRbjcIX9+XCikdF3jxfBR0=
X-Google-Smtp-Source: AGHT+IEf+jMcDIiSTyp3/KHclntN9Pv9FX89yqeQ+3C4E9bbWCt8PvpNz/qd/tJkNisF0RZl21vkSA==
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:10ab with SMTP id
 ffacd0b85a97d-38be32a13a4mr9806902f8f.9.1737043398075; 
 Thu, 16 Jan 2025 08:03:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890462195sm3278435e9.30.2025.01.16.08.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B328360884;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 13/37] tests/tcg/plugins/syscall: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:42 +0000
Message-Id: <20250116160306.1709518-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index ff452178b1..47aad55fc1 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
 static SyscallStats *get_or_create_entry(int64_t num)
 {
     SyscallStats *entry =
-        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
+        (SyscallStats *) g_hash_table_lookup(statistics, &num);
 
     if (!entry) {
         entry = g_new0(SyscallStats, 1);
         entry->num = num;
-        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
+        g_hash_table_insert(statistics, &entry->num, entry);
     }
 
     return entry;
@@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     if (!do_print) {
-        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
+        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
     }
 
     if (do_log_writes) {
-- 
2.39.5


