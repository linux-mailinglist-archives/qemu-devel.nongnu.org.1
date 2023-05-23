Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FD70E9EF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btV-0004BP-6O; Tue, 23 May 2023 19:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btP-0004A4-Pv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:15 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btO-0001nE-8Y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:15 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d4e4598f0so147321b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886293; x=1687478293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NPPUIfqUUProwPvLNu4WRjkBGZQ5T7snCtTOmOPzCQ=;
 b=mMe2ymQU+AX7q8YXfaVoCwnU38b3C8qCz7odieA3HTpQdpDmUeKa1pCKlgHyQ03HI0
 lCmp07XIpW6sA8rCV1JYWKP1orZP8idDSsywc/cDHM49YbzuCYLWwvyyPZsthdDOIQki
 dld6KvkyfZajVxz7K/5+20pevdV/5B11Tl6Q2DQdhsaNXYw3eeFahGYiAGWGWCfZ9kvQ
 xpXbu9VKzUUWAqGU64cM2CdykWloc3t+AclVKnXZkm1I80V2xkz083ab/FdOr0ZrYE9Q
 LASIT3WXAmQSyIdeMJ3TjC9hHhVpVjh8MgHRhe4NQnBtwlU3nqjurgDsc6Y/2xkQvgD5
 QK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886293; x=1687478293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NPPUIfqUUProwPvLNu4WRjkBGZQ5T7snCtTOmOPzCQ=;
 b=UAOZETPbJsbkQYuruwmqJndiaJYEgg6E4VIKUsrUqw0cJ9mCf0WPzNuqgLqTp4TnRf
 2xnbOMEerYBT2KYYmLB+UkGoLg5jiFWy7EwJz5wVuTXSr3G5abje1Wqd0eK9evks+aGu
 urFg1GKbfYK8wrFyO37eF+DS+SOknOpDIsHzEGH5XQeMwhLKqgEewYqIon0R9iirsMvA
 whi+ApPu0D389VwfYBZLhwcp9MDJ8IYmELSzuaoJEcjaEv+j7TJVB5h86qHXReT16Q8s
 6tT1/TBUoORGfto/H+vuwTyX3BR194e+B+lOjaVvkmdpntzvxuYti86XFiS2s10T5mzw
 ncgw==
X-Gm-Message-State: AC+VfDzx2k3tWO1rZzGAyGpPrA2OQyiR153U7c6reypkdqZ3NU+gzyWz
 8qixr5puOpBC0NxNIg3cLHYmDQLyDQj4+z0Encw=
X-Google-Smtp-Source: ACHHUZ7lxihtFkR6tNUjUslTE5MFlDedr0U2hluhkAjWv/2RlVIsid6VsjGwgdJN2SHGlOqq5Gxtvg==
X-Received: by 2002:a05:6a00:9a3:b0:64d:2da5:4d2d with SMTP id
 u35-20020a056a0009a300b0064d2da54d2dmr892279pfg.25.1684886292983; 
 Tue, 23 May 2023 16:58:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 08/28] migration: Build migration_files once
Date: Tue, 23 May 2023 16:57:44 -0700
Message-Id: <20230523235804.747803-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The items in migration_files are built for libmigration and included
info softmmu_ss from there; no need to also include them directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/meson.build b/migration/meson.build
index a8e01e70ae..8ba6e420fe 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -8,7 +8,6 @@ migration_files = files(
   'qemu-file.c',
   'yank_functions.c',
 )
-softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.34.1


