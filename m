Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E13E831C68
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:26:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUGv-0000mN-My; Thu, 18 Jan 2024 10:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQUGt-0000kB-Ed; Thu, 18 Jan 2024 10:25:35 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQUGr-00073y-Sd; Thu, 18 Jan 2024 10:25:35 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d70c3c2212so3929885ad.1; 
 Thu, 18 Jan 2024 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705591531; x=1706196331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=06E1WVu/iA2u2ECeKDEWJsbgU3hA4RoKcVzgnH6qY9g=;
 b=CHQYTTq1RbB0uHPvO4ZAp/NMU3jsw3N1Umlear31jT++6rtXo6TWje17oos2yWVt9c
 8Gm1/iyDCz1Gru4fX6ovemeMo17hmg3Q+Y2M6kdplRC9gQvfYr0VtoWvEinCr3oRAWus
 h3Djg/ygN5BpePpXMM9J+uiiWPjba3EIkIqiCgTZdHlojdbMzMZsXBSsVB1qcq4ZdaPd
 0fcmcyoWoj7NdKe1cuhJ2+hPBK9/cIYF9S1OlmmVOcnKdUKFMNA1zwA9nMZj5R799dKz
 PJx5ff9cHfS8xJ3MnMFDci4GgV75IqzcQ26ThEAV9XfUfishVXn4wIKpAXIKeDuRoo+L
 z6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705591531; x=1706196331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06E1WVu/iA2u2ECeKDEWJsbgU3hA4RoKcVzgnH6qY9g=;
 b=ksnbmUocXxzzie9QCNKPjABDMcrjfGpll7XJr9OnZl5ZLtdf2Vd4ESTH8yGnfSdxHq
 EFvOMYbPGwPSzoYD+0q+inOSLwzFdg/eNlGuKEDj+OMu+2pnXhcZCKqN4aAz+fY2pS2M
 fgLEt37FdHv753S+xY3+OvUfXUVcs2BnNdh++OKAP8nY72+bp94vcFyf6yipeqJRIWvY
 O5j+/PcgLMdwq3+Jf9jsSvWQ88kuzxy0giP2FWXaPPVdhGgE8ejk5+p2LJZNdWcIOAZn
 PZJyrUYALbGf5O1UHYdP2oKMuddXhU8gZzSZ0txJGnhhP5kmOIZ3j9BqOLjbYhtfNNz4
 7vew==
X-Gm-Message-State: AOJu0YxjGiNRtFTeNCmKhSIcNqkAKUjx1NOqC7QvE1/972FiC+FOMNLH
 8tNNz6ar2D7VrXCIsEUShb3EOt09EO1Vns6NtB7G6dwiSLpjKBRfmaBTTprK
X-Google-Smtp-Source: AGHT+IElJui8vq8H4MjkPNQFQM0FwgYXPwMy5/OKg4OplZinwCnMWJd11oger/2tNpStMuDPRKtI0A==
X-Received: by 2002:a17:903:234a:b0:1d5:ecfe:4d69 with SMTP id
 c10-20020a170903234a00b001d5ecfe4d69mr1694805plh.49.1705591531223; 
 Thu, 18 Jan 2024 07:25:31 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 ky12-20020a170902f98c00b001d4c98c7439sm1527067plb.276.2024.01.18.07.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:25:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] target/ppc: Fix checkstop and add attn instruction
Date: Fri, 19 Jan 2024 01:25:21 +1000
Message-ID: <20240118152523.178576-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Try these again. checkstop fix is mostly unchanged since last
posted, but several fixes to attn. Seems to work well enough.

Thanks,
Nick

Nicholas Piggin (2):
  target/ppc: Make checkstop actually stop the system
  target/ppc: Implement attn instruction on BookS 64-bit processors

 target/ppc/cpu.h         | 16 +++++++-
 target/ppc/helper.h      |  1 +
 target/ppc/cpu_init.c    | 82 +++++++++++++++++++++++++++++++++++++---
 target/ppc/excp_helper.c | 52 +++++++++++++++++++------
 target/ppc/translate.c   | 11 ++++++
 roms/skiboot             |  2 +-
 6 files changed, 145 insertions(+), 19 deletions(-)

-- 
2.42.0


