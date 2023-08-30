Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF878D76C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNkL-0007z4-B8; Wed, 30 Aug 2023 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNkI-0007v9-RB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:08:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNkF-00027t-B9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:08:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401187f8071so7347445e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693411717; x=1694016517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1TMdQLaIg8ffwF4JyQb1ayHCKXpC+iWioIOEfOcZh/4=;
 b=VTi7hhw+aaw2/fW9TLwWt+ne9pSwLUABNumBTuq2WgkWialpJ9pB1IUY5H37XnI+qm
 sJ5I4ykHxIM+DV9Rr5fTiC2avPh4IcQTnOBxV9BwGtUvxVNKT401dOpKBvexRhxsgmHo
 GvcxGEK0NiStG8A8HIaNkaMTn3G2yfyOsZs2+TP1GPivKT9eEwoSEbaPLxNNCeI4UkW+
 nvzo2CTVlxngT/A5zERp+NdB4Jt1KTIfT5+vpzR1vzK65svZWu+CNUM9XYn6ac4Tir2K
 fcRE3xls5E4WYqCtixu7VDiXEjmznLf0RPfDsYlOSSL92M53kE4kYTDNhMeCIzYrric2
 N35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693411717; x=1694016517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1TMdQLaIg8ffwF4JyQb1ayHCKXpC+iWioIOEfOcZh/4=;
 b=MHpAargNQ42c63y1a/2RA/wmj7QN6qA6k+lkNevKoV3f5esoI3dF2LLLdV+krTQoju
 fIhgOFTapBxYBmPtAXqu/UhO36elHOc4jZ76u+5sLCz0NX82mcDgeMgx7QT2143nyTUo
 GlC/Kd3N5Mu4tqScXt4IUA144ncnjVGadBrQRzvxQ4SrOv1GyyAj+ETOucUxcYNB3lBj
 Cws3bWOYwV0H9vxR3vHdjjY4lGE/wk/cFUtUYS1Ik+aG7YxLy1+mfGqBPHLa9aBhUopl
 fnG8TlATDMPVHKAy/OPVDxGBtU/1cbl4xT1pe+ZaRMai0QCYdq57uwnryBrX+osjy0LS
 raPA==
X-Gm-Message-State: AOJu0Yx358bEAOq7iOsDrdISGnKRUXaNE98ufMkdZ16xhZMrv1lYEBjV
 CNqtbDukSJ1OqD80gyO3Cf5IIeeFCmJv7OsGppkyH9Ry
X-Google-Smtp-Source: AGHT+IF5K7p0/lTWOUXZcUVnCaiYWXauetqnKjyqQxrnZdu1OfAncY4tfUd+OuGUT681y+sy80eH+w==
X-Received: by 2002:a05:600c:21d2:b0:401:b307:7ba8 with SMTP id
 x18-20020a05600c21d200b00401b3077ba8mr77679wmj.13.1693411717648; 
 Wed, 30 Aug 2023 09:08:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fe29dc0ff2sm2694814wml.21.2023.08.30.09.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Aug 2023 09:08:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Fix typo in translator_io_start() description
Date: Wed, 30 Aug 2023 18:08:34 +0200
Message-ID: <20230830160834.42069-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Missed while reviewing commit dfd1b81274
("accel/tcg: Introduce translator_io_start").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index a53d3243d4..4e17c4f401 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -159,7 +159,7 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest);
  * translator_io_start
  * @db: Disassembly context
  *
- * If icount is enabled, set cpu->can_to_io, adjust db->is_jmp to
+ * If icount is enabled, set cpu->can_do_io, adjust db->is_jmp to
  * DISAS_TOO_MANY if it is still DISAS_NEXT, and return true.
  * Otherwise return false.
  */
-- 
2.41.0


