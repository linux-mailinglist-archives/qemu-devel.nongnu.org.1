Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51B7C65A3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpFB-00017b-2n; Thu, 12 Oct 2023 02:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qqpF4-000175-TT; Thu, 12 Oct 2023 02:32:18 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qqpF3-0008B0-37; Thu, 12 Oct 2023 02:32:18 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57b74782be6so337999eaf.2; 
 Wed, 11 Oct 2023 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697092335; x=1697697135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rbnNW4aTZ3zGnVnGVrKDK59ktqJ9qZ/3V996CX6ob0=;
 b=Cw6XNzXo9hbUYIZedJS45bYfr0w/Te7ucWAiP3UqE1DXv4eDwjcPA2z1fuLx3+ToVi
 A429x43w6qbKN6EQoBZSmENZCmbxmkl5Vw8pjRKbI0xtqPoQ4gYxUNj1X0AbzDv8zBMW
 HhH3mQmYzYH6NZmyrCbGqYP0R996V1Je8fL+IGYto3Hqb1ELPzKSyQcc5seNaxBKLzz8
 yYABiaK4K61bQBJKyvrUhev/33aVSnncbc2ZU5cWqbSl6J50v/C5NMzgnfSOaFwsprvg
 8x9X0xFXzrxu77D9Vlg/HEoqnL0RqsfoL980qfmIllrFUeRu5oPYrDaJvOCXnbTIPIcp
 knKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697092335; x=1697697135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rbnNW4aTZ3zGnVnGVrKDK59ktqJ9qZ/3V996CX6ob0=;
 b=pHcVrbfQHIXOYIOhXGvoJymeYiRtFetSl8Ti7blsvrGaze3W4U2FE2ji3M0Dovy4uf
 DiaJBz1Wl3vHkwIpNUHn6E/kB7IcXiQtziBKTd6ue3CR2VFqcHqsAM2Lf5EEUnUkRkB2
 gG13Bo7pnz/NzvrWs3n/1qT9qvhUvildw+MPTfswQ6QmqwGS6MgIGkttRxCFGk70o+wZ
 DKjkRBNz0abGNI6mSmF4HlH3/QB71Dzi1LZgSkucJuV0seEP8PcvMNRy/K0vS5TUflSv
 hhme/M6IBHCEwzpEtARzZhC21O1LtXvQuprGEV0xzjN8TO1LBZXANklHm9claras2wLZ
 0cng==
X-Gm-Message-State: AOJu0Yx8yL/WEOdr0VYggTScx3qoMYuNqxAjk/bi0fkFhDNiHEFTXrdS
 E9sXTojiyn8nKufSXnsfWOk=
X-Google-Smtp-Source: AGHT+IH2abVqqngNG3c4tyY/54rUnsSCnEEGd6gE1Cc4ph66uzbsDFe20Pa5vgztIAVycWjWPGdF1w==
X-Received: by 2002:a05:6358:429e:b0:13e:bf50:73af with SMTP id
 s30-20020a056358429e00b0013ebf5073afmr20216096rwc.18.1697092335142; 
 Wed, 11 Oct 2023 23:32:15 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a63b213000000b0059c3ba41db7sm929558pge.30.2023.10.11.23.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:32:14 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 bmeng.cn@gmail.com, Bin Meng <bmeng@tinylab.org>
Subject: [PULL 2/2] hw/ufs: Fix incorrect register fields
Date: Thu, 12 Oct 2023 15:31:57 +0900
Message-Id: <8466aa53d623377e114895c6563face25370d7da.1697090890.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697090890.git.jeuk20.kim@samsung.com>
References: <cover.1697090890.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

This patch fixes invalid ufs register fields.
This fixes an issue reported by Bin Meng that
caused ufs to fail over riscv.

Fixes: bc4e68d362ec ("hw/ufs: Initial commit for emulated Universal-Flash-Storage")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reported-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Tested-by: Bin Meng <bmeng@tinylab.org>
---
 include/block/ufs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index fd884eb8ce..7631a5af10 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -111,14 +111,14 @@ REG32(UECT, offsetof(UfsReg, uect))
 REG32(UECDME, offsetof(UfsReg, uecdme))
 REG32(UTRIACR, offsetof(UfsReg, utriacr))
 REG32(UTRLBA, offsetof(UfsReg, utrlba))
-    FIELD(UTRLBA, UTRLBA, 9, 22)
+    FIELD(UTRLBA, UTRLBA, 10, 22)
 REG32(UTRLBAU, offsetof(UfsReg, utrlbau))
 REG32(UTRLDBR, offsetof(UfsReg, utrldbr))
 REG32(UTRLCLR, offsetof(UfsReg, utrlclr))
 REG32(UTRLRSR, offsetof(UfsReg, utrlrsr))
 REG32(UTRLCNR, offsetof(UfsReg, utrlcnr))
 REG32(UTMRLBA, offsetof(UfsReg, utmrlba))
-    FIELD(UTMRLBA, UTMRLBA, 9, 22)
+    FIELD(UTMRLBA, UTMRLBA, 10, 22)
 REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
 REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
 REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
-- 
2.34.1


