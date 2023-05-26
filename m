Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B7712B22
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahj-00030D-EQ; Fri, 26 May 2023 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahe-0002wX-0F
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahc-0002Fx-Hj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6e72a1464so7300515e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120048; x=1687712048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=golKvSYvzbphYFdgYW/zJabTWZL4ziquNJ4trhfkWb0=;
 b=oCwIk+laqcSOtGlRZG7VY8yeKFEWgrFJ4jzEvqD3tRy6CVakzzOQB4NWMBv1dM7LKf
 xQfUxfjyyozshUu+52cprOvMRRqyAESN7yg3GhYmgJ53B0xxrzy9iW9MkWloi+K49E2Z
 0on5l72S6N41dGwb2l+kO/1mmAmN+4I+GVMs/yWKsMOpUO3aYAzOfSVK1RGlUI3HEjTN
 4fxl1ppHFu9kHJeuqYAGUfJr8+NNaTy1n2YjPtaukHywWnXjmC4S1l3eYYqRehBfzorb
 897B9kAFSBlEVb4LLC3/Pz2Ck6gDryWs7zNbb10ps0K5d/rZirSZWimPoZK/rZ2Opl51
 3hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120048; x=1687712048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=golKvSYvzbphYFdgYW/zJabTWZL4ziquNJ4trhfkWb0=;
 b=kmSVVgP3Fqxqra2leKc5eQ8bQK5Ngjdh2ogw8/FSLPqGJj3wdtauwpb7TBx5IyNM0w
 ons70NNnf64EJ/W8AEBUv8kb/kShURz1+V+9jtuD9Z+76f3ehbO74XK173F9/gtO5O0B
 XmrSCnsNYtWbqJuPglmvl5vBYRqawrYpjpoud/7rsbIZdQKnwdLCOhB0haLotheADdne
 QEfwEwh7e7QsPHPrbIc1nQwIrnanzdkD6dy9GbqShv5DqqKr/aPfK+6vcLdc/01iqcxt
 NCcHkaQXw5kWCy+Ul8tMluUQ0LMMpFcCvwwrCYGeaEyQgGZKDQn/sKU+rogQni8yumOE
 ievA==
X-Gm-Message-State: AC+VfDzCph+rzvSPLmH63PqdA+UZBzmCBSzW0nOTFs4D+OMnzyvSmb5I
 gogaj1JoBtofnIWDSKZiruuIAw==
X-Google-Smtp-Source: ACHHUZ6F5q9SvNedgHzyeqmemDnGRPcRknN0Xj8QLvd7rzWrlB+KP0j2pvGD7a8R0KJJ+BF/60vABQ==
X-Received: by 2002:a05:600c:d2:b0:3f6:536:a4b2 with SMTP id
 u18-20020a05600c00d200b003f60536a4b2mr1892054wmm.27.1685120047859; 
 Fri, 26 May 2023 09:54:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a5d54c4000000b002c70ce264bfsm5609626wrv.76.2023.05.26.09.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4948A1FFC0;
 Fri, 26 May 2023 17:54:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 10/11] hw/9pfs: use qemu_xxhash4
Date: Fri, 26 May 2023 17:54:00 +0100
Message-Id: <20230526165401.574474-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

No need to pass zeros as we have helpers that do that for us.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230524133952.3971948-10-alex.bennee@linaro.org>
---
 hw/9pfs/9p.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9621ec1341..991645adca 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -738,15 +738,14 @@ static VariLenAffix affixForIndex(uint64_t index)
     return invertAffix(&prefix); /* convert prefix to suffix */
 }
 
-/* creative abuse of tb_hash_func7, which is based on xxhash */
 static uint32_t qpp_hash(QppEntry e)
 {
-    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino_prefix, e.dev);
 }
 
 static uint32_t qpf_hash(QpfEntry e)
 {
-    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino, e.dev);
 }
 
 static bool qpd_cmp_func(const void *obj, const void *userp)
-- 
2.39.2


