Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C37745E1A
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK9R-0005f0-Fx; Mon, 03 Jul 2023 10:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGK9P-0005eU-4t
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:03:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGK9J-000323-Pe
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:03:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so4988460f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688393008; x=1690985008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQkmXVVKUzbF6+OR87LtMoCxllrcwffkoSGo6NXeAog=;
 b=lLSmml+LsUgmELhfHKlmBppLRPcP+ic8+Q0VsAjN/fXF8OMrGnJacgSpSX0Ysfckfk
 cdOur8Znhv4V0NMMQrnbyE4haN+N9mtNa8aq/2us83TitQe5Ds99Zfvik0uTVIa8OUPO
 1sXryrHVoKsHhvpoFbrISNOuE+dLk2ADZRzpWgsfRX/M2fioWynULeK9mIkPle5ogci2
 fezhuK6rpxTKlTV9CPQtmW/BPQXz+fTNsP+WMne+VRepBb//Y2X+cXrjcc2uQ2PVlugP
 IgycS4GSov2dqz90qy+wEOsNuSb32ZymiRuvHarBaZEd5QgUvoNCeolHWPowvGsPUwsq
 06fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688393008; x=1690985008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQkmXVVKUzbF6+OR87LtMoCxllrcwffkoSGo6NXeAog=;
 b=RpHbb/hQipQJ73PeVK3n4PZgwVTBZaS5NZDTxrS2MXWsUomuJoo3ncLxpRoGHrPnVi
 LrtfbLcCaKTMSpw3aRBqnrPD8tu2NXthGOtzRehzXzyFztZSZ/vk/9ar81evaLWPbFmh
 LTVERBqj1AIINkcGowgzcx2whSQ/jWjWjnN6P2Q1YYlAJlx64cX+02aaf1prV83YFA5i
 Jtj2QNWKuOc2NS9y5CausIGJY/HcStZ7Q1wxhKdkYowTpyUQXu4aKdINiEwy5Qp2WFqy
 skMhZfgue08r2k+zKKcEvurXwPK2tf6HS5CBspNadvCzZhlokM8G9teJvqQ8HD7NnWmY
 cdbg==
X-Gm-Message-State: ABy/qLbdg1CEm9qkQ7nG30igLYtnJjC6mxGtWgtmCKPRND5busIfOTyz
 ezWf8yroKxSPI5un62GvmfvmLA==
X-Google-Smtp-Source: APBJJlGEDcddN9hwcOZAY2OT5DnGG82JvPvIJIumoLPHCzApyCP3hOtj3AXNUSsSh25qVnSxpOa1QA==
X-Received: by 2002:a5d:58d8:0:b0:313:ee2e:dae1 with SMTP id
 o24-20020a5d58d8000000b00313ee2edae1mr7762605wrf.18.1688393007868; 
 Mon, 03 Jul 2023 07:03:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c8-20020adfed88000000b0031433443265sm4194573wro.53.2023.07.03.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 07:03:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CDEC1FFC0;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 23/38] include/migration: mark vmstate_register() as a legacy
 function
Date: Mon,  3 Jul 2023 14:44:12 +0100
Message-Id: <20230703134427.1389440-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Mention that QOM-ified devices already have support for registering
the description.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-24-alex.bennee@linaro.org>

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 084f5e784a..d1b8abe08d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1209,7 +1209,15 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    int required_for_version,
                                    Error **errp);
 
-/* Returns: 0 on success, -1 on failure */
+/**
+ * vmstate_register() - legacy function to register state
+ * serialisation description
+ *
+ * New code shouldn't be using this function as QOM-ified devices have
+ * dc->vmsd to store the serialisation description.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
 static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
-- 
2.39.2


