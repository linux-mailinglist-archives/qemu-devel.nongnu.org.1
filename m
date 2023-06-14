Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970772F1C6
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FES-0003C7-Mw; Tue, 13 Jun 2023 21:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE1-00021M-3A
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDx-0004qc-OB
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-666520247f8so140884b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705780; x=1689297780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaPmLZh7IX6VsqFsBpi8SaIVj3QtnLQdQ1iUNH11NWE=;
 b=W5mx0egRlrAc27HdpYNqRY1H1Cs5DYEv6hOFGDiVNQ1oQrDBv0mfBBR4zNxzHbXhhL
 x78LUWj6aCIO0s/dnEGs0gcJeYbqPV3LnVdZctNcSODCl2xRQWMlD8Grkfne3+8rXY4l
 IKDqQadx29iAxb/h7R7xMJYOPLS4cPXN3tFcgmeVxxc4X1wZb8zKSFyBww9pV9UcGJpY
 Btd6cPUMn29foqklUkUSrOK+J79JmfJMXDcbG3FhStnQhfngyi6iPYg+EXJpYT8hiZ6o
 uM1/Or8N6w4nfaOo3RQq0IKjiC5pd2vKqaKed2ulIdQ/uue5RYOGEkRbHxFS0E3Vw1N6
 XNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705780; x=1689297780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaPmLZh7IX6VsqFsBpi8SaIVj3QtnLQdQ1iUNH11NWE=;
 b=I9QNtSJ55jsDdnpS5CEnRw1AunjTEGxwgjR/tuy7ofBvhK2PsnSwQ5AVLyKEWFbqBS
 /OUk5aZEyu2x1tnpKgq+XgP7ma//hj2fVz1/1QlNSoRG047rvdiUeA89fidwyB/fzA/G
 Wby0QFhG691I/ROcaEgk/O6Sgntq0EsuOz7oXIw7ZAhFXhVx3VTZM0VxWP0kv/9s5NGq
 LVJK5fhnRA+uBd2DB/BPLNfnEGUwoLUvEoCwCvT7BlejzDHRQ2aez2BgUXXI+LmzWDlc
 u9XAo/2fBiow1uKn9xRXPVm5dPi0aHTf8TJwvwVXLM6I3CVmmdOqHpspAOHgCliiiy05
 sHMg==
X-Gm-Message-State: AC+VfDwii7yfzhq5YKlONDdOO/CbvXS9o2xrbA4GVjoI0xU9bau4NCy+
 5TRrak1jiyE9yFfqRWq3DjLAmLFaY4G6vA==
X-Google-Smtp-Source: ACHHUZ4NCSNT6d26dkbmHHEA/eXsN4I/rzbCIcda4E8sMU07aBPAtZpcKi4/Yc1wCkq85pacW1cKeA==
X-Received: by 2002:a05:6a20:72aa:b0:10c:3535:162f with SMTP id
 o42-20020a056a2072aa00b0010c3535162fmr628073pzk.0.1686705780084; 
 Tue, 13 Jun 2023 18:23:00 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/60] disas: Change type of disassemble_info.target_info to
 pointer
Date: Wed, 14 Jun 2023 11:19:54 +1000
Message-Id: <20230614012017.3100663-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Use pointer to pass more information of target to disasembler,
such as pass cpu.cfg related information in following commits.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/disas/dis-asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 2f6f91c2ee..2324f6b1a4 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -397,7 +397,7 @@ typedef struct disassemble_info {
   char * disassembler_options;
 
   /* Field intended to be used by targets in any way they deem suitable.  */
-  int64_t target_info;
+  void *target_info;
 
   /* Options for Capstone disassembly.  */
   int cap_arch;
-- 
2.40.1


