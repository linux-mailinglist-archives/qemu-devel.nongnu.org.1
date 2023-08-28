Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163C78BB99
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrk-0003gF-Sn; Mon, 28 Aug 2023 19:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalre-0003ez-Ra
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:46 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalra-0006g4-9X
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:46 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34baeb01942so13352005ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266100; x=1693870900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zx0CReD3MzsJrQdTZvfAbBcxOrXPzRZaiHnNU4KShl8=;
 b=qNLMexHsuTaHdSA3NhJHbfkyQduVueTCWrEsSr12hsgPTRtbhrBlorYxHFbYY5GLeV
 TfJUaTKweQx0ZbHU1zYQ8L77D8mefKJCeTBwyHOa3CECbdhn142Pp+yJiVcJ75U1+dfh
 7ug9rseB03QwHDeYPc6CTg2peA3nwISIdp5xq/0XawVpoVILKdv1nf1+gLHzFwVR5S4G
 GGZ5pEOn1EQPYad/wIArxhnvlrpdYeBd0GfpdsmU3+bzP8jTXmiPFtuS6habwhPAS4eE
 BoKJHCff3dsjQxE+Kx5ovuAtNHVq1C2Pw9K1PZtxrrzyEklXluOQtkoRGGBtijB1qRri
 hChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266100; x=1693870900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zx0CReD3MzsJrQdTZvfAbBcxOrXPzRZaiHnNU4KShl8=;
 b=F8cOi0IDr4sGAe+YnZ0J806oHxgoOeFcqsSpydHMXe/bLK1qwa4VJ6q7lZSh1FKLz7
 Bgcxz6WLw7DXSfR74fArig29CqYCwsh3hdqGlXzjtauz7T3iTH9u0sEbKO4mP6zL9ZH2
 mwf07Je01AZ6JzD5sufA0XnTW7gnbkCToIi43xswo8x7aYG+SJ7zfpClbr13YMiDl/0I
 uvRzTVxB50ZcpNM4Kun3Tl5j4+B/eWT8o9IiQr7ESAi4OFxjAAJgkbbwnVPG6fbi7jla
 9Z/2bS9t5yomepiyimo/Ycc9cWRlvcsRvi7vH8NRZdMZVmJYq4tRUM9vqrn+BIVIBmsl
 TE9g==
X-Gm-Message-State: AOJu0Ywk97PNqx0MtZ2sIjUxcPz+uU+SEI+VrtgbtFojfpzyce70WA2X
 Tx5sNG/Pln9iTs2KCuR15o/C/ZoCLGNOHQWGWus=
X-Google-Smtp-Source: AGHT+IEkVvyNOLgaB0tjRIiZ2GfNIMOb54q7HETEgYh0Xkj4pl3Qem0wPX9Gq93FpKW/wAbz/aweeA==
X-Received: by 2002:a05:6e02:1523:b0:345:787a:cb1c with SMTP id
 i3-20020a056e02152300b00345787acb1cmr21402577ilu.6.1693266100699; 
 Mon, 28 Aug 2023 16:41:40 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/36] bsd-user: Remove image_info.mmap
Date: Mon, 28 Aug 2023 17:37:47 -0600
Message-ID: <20230828233821.43074-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12c;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This value is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230818175736.144194-3-richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/elfload.c | 1 -
 bsd-user/qemu.h    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 38a3439d2cd..2d39e59258e 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     /* OK, This is the point of no return */
     info->end_data = 0;
     info->end_code = 0;
-    info->mmap = 0;
     elf_entry = (abi_ulong) elf_ex.e_entry;
 
     /* XXX Join this with PT_INTERP search? */
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 178114b4234..898fe3e8b34 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -52,7 +52,6 @@ struct image_info {
     abi_ulong end_data;
     abi_ulong start_brk;
     abi_ulong brk;
-    abi_ulong mmap;
     abi_ulong rss;
     abi_ulong start_stack;
     abi_ulong entry;
-- 
2.41.0


