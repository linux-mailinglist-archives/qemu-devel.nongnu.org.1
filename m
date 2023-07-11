Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7C74E7A5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7Pw-0008U4-PJ; Tue, 11 Jul 2023 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ7Pu-0008Sd-G5
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:04:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ7Ps-0002wT-TY
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:04:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66f3fc56ef4so4129963b3a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689059047; x=1691651047;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40LOwnc1UWDl12YW5Q5RKLcgakfGkbBCBb3K1zYDCDc=;
 b=nQP9pqZT6PCZ378cv3seUjxp5wCxsKkFIzkApO6rZTZrT0lTWL1gMe1Zv4jsCYq7mo
 KGjNEqtYISvHAK5MyKvHhTZ8CPDljl94ZEy+ksP2j+MVMJUYv7d2d0ZLjQFBj7bFoGE4
 DMlZj1EnQlqL8/hGUJYwMelN996KbYcPWtaF+Se4Ye2fvtAfWf456reZ+uo0NrJXT3Aj
 jVNj+RNQpwOswRJOAunDM+xKe1OUuKSGJmZk5NEtYPS0wt1aJwWdyE9rt7kmZO1mfT+a
 6GEsdoF8Ck2G60DKhyj5YgT4fXcCEwD6PzUn+thiXZb51ljtSqSNBv26rFw+YazgiAuk
 p9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689059047; x=1691651047;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40LOwnc1UWDl12YW5Q5RKLcgakfGkbBCBb3K1zYDCDc=;
 b=e96/MHd3lM4hz0pM9UZCCtkmpISVK+3NcpwQNM8sUjGo5t506H2rpTfxlAv5bcpVGb
 cc4R3l6k6J28LfJaTqywdMjgZwVU2Bg23QGYt+jOUzsrIHWDseYM5lwXOVuybtZ2QhIv
 7EAjW0bVlGtJaFF3RyemEMsHTreQo/hDIvVu3t72xVGZfG46C4x6NFWIONoAlRZ4cndq
 3SPpyW55lS/dJhwI9MKm4y3j1EvDiMvkrt11Bnx2M3+j2zdCBp91NzwGGhXE6kYevW+3
 XCHBVpwRDJql4Hid5uhgBHh1Vr8upGO1faVX9jnIFkh//q+qE/H4OL6mYDLIgdDHkU5+
 VWMA==
X-Gm-Message-State: ABy/qLbvp4QZ+WiqqmaD7+rl+ZIPtyMeuOcYpyl87KoAGMDCKJG053L9
 yL6+5N1Pqlh34/NFr5zMYyGDl9SdCBzAn89aiyO3JAxuLWNOewSn+30GN73W3Wbu7+UBtARNMUy
 MUKCDkNbPmeetkkVlXwotYZgW8IrXx4A7ub7SvUU5hMtE36F0mO7kk6XlUm2UajdQ41UwOJ8buo
 EKEw==
X-Google-Smtp-Source: APBJJlEPqH5dCcmRMNXhbuIZJJZBSeMscsGg1RU0qJrur/VR31zGVMI3uU/HEnUdnI91l/Te8TCkvw==
X-Received: by 2002:a17:902:d4ca:b0:1b8:936f:c346 with SMTP id
 o10-20020a170902d4ca00b001b8936fc346mr26264404plg.30.1689059046823; 
 Tue, 11 Jul 2023 00:04:06 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001b9dab0397bsm1078724plk.29.2023.07.11.00.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 00:04:06 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v3 0/1] target/riscv: Add Zihintntl extension ISA string to DTS
Date: Tue, 11 Jul 2023 07:03:56 +0000
Message-Id: <20230711070402.5846-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x436.google.com
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

In v2, I rebased the patch on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next
However, I forgot to add "Reviewed-by" in v2, so I add them in v3.

Jason Chien (1):
  target/riscv: Add Zihintntl extension ISA string to DTS

 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

-- 
2.17.1


