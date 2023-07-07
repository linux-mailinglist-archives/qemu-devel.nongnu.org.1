Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBF74AFF9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjge-0001t1-CA; Fri, 07 Jul 2023 07:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjga-0001qJ-EK; Fri, 07 Jul 2023 07:31:41 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgV-0006Ur-8w; Fri, 07 Jul 2023 07:31:40 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b8baa72c71so1619261a34.2; 
 Fri, 07 Jul 2023 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729493; x=1691321493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1HJUmepcou8YNKRL7zfbfphizzPHWU+xLkX0u2RLvI=;
 b=osrH/ptxXM+lrtsnfQ37YciVTNyamSTe0vvQLTyGiDLc66KQAsYObaRJhYglLfJ15u
 KLE59QyStI3yLAgcECmAvZgetNmxe2FqLINoggBjy21l+v8ijD0lshnqikRihG47sAqZ
 EefH6Jgrd8nkaWo99hnzahS6MQa6LnseeRusFUxdncHPdqR2ZWfLLMFJ9PxACDCq76dn
 ztf03p9LG9ab0nUePkgtb4a4jZX1WwhfVZSx54uNK0fmqQ3mgQtkdWK8X8b3laIhzs1v
 cbwJjjRKugoL7A5JFyFWNr/gHlS+sVaB+quqPTZKPs7iSOd/GbLhMEVfsE8w1ET9m99o
 KuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729493; x=1691321493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1HJUmepcou8YNKRL7zfbfphizzPHWU+xLkX0u2RLvI=;
 b=T7AWIG24dGZLNVx7oZNDxpo+MFCZ7XLgx7yc5y+dGG1og9TPOHMW0RLJtSLx36Bl7c
 sjBJod54M3OLdDGFbaalZ7a6DnI3PT2ShuE3tLVXCCxgFvOSiMIBxvLxWGjt25myuC/j
 LAKcqW6VdV5OlxDgiSXR/zTiQfFGPycYevhIiXu2sEubycsEcrkg5XnLUp5yjxRFH4QL
 w9peqdZATy8V68Xf/XPO4+MUKucjhdjYB5oeH4/B2gxq6B9bwy35kALZhr9XjJJJZi/i
 +TwXp6H6DgKDdhrMjLfCQ4bsZl5byqj3qdTM9M6SILPKZjHZEeiBROFLyhmXlGAWXp+I
 M75A==
X-Gm-Message-State: ABy/qLZ3x/QP4fi0he9qKAfNkypRo7XkroTI+NhqIgIhK3vn+kwQ+G7e
 +l48k65IecIENZFWa5k/dbiLrzkdCmo=
X-Google-Smtp-Source: APBJJlF5FW/plR13WrffUVQMXxjMQ+S2natNmwpVnYl4zcQR8jgGdIDFgFlwvxKKobpfRgjB7Te+bw==
X-Received: by 2002:a05:6871:b2b:b0:1b4:56ed:eb88 with SMTP id
 fq43-20020a0568710b2b00b001b456edeb88mr1588690oab.45.1688729493689; 
 Fri, 07 Jul 2023 04:31:33 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:33 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 04/60] target/ppc: Only generate decodetree files when TCG is
 enabled
Date: Fri,  7 Jul 2023 08:30:12 -0300
Message-ID: <20230707113108.7145-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to generate TCG-specific decodetree files
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230626140100.67941-1-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index a69f174f41..4c2635039e 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -28,7 +28,7 @@ gen = [
                      extra_args: ['--static-decode=decode_insn64',
                                   '--insnwidth=64']),
 ]
-ppc_ss.add(gen)
+ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
 ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
-- 
2.41.0


