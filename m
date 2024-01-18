Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5D831B32
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:15:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTAR-0003PF-5N; Thu, 18 Jan 2024 09:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTA9-0003MN-UL; Thu, 18 Jan 2024 09:14:35 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTA8-0002Qb-1l; Thu, 18 Jan 2024 09:14:33 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d70c150632so3907065ad.0; 
 Thu, 18 Jan 2024 06:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587269; x=1706192069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RzJ+FSkCBBpmxypiuqZS3Cj4/KzTzXAtpNL7NtarXAc=;
 b=E0Zep+rL4TP5THOXVyu+KkUvhk8UrcI3vYpBMm39IDFNagFY530zp2FiYY7mUhxT6A
 CBFBUpUSDvVc2h6Qk7wgVzYN49MV12YzyjoH1JZoPwRse+4m1j8ZY1BUyOIoUURFkMQQ
 OQccHfC/8/4qMGO+mP2jyAZJq8xR92niRJrtTT/U0h6oe42TwuqiCjhgTgEunDRL95JT
 VGdLYiQidLDi4le8YyhoLZaXfAL2Dz5JmHUFWC8rx8OxSDubqMV8DyTKgj/Kck40uVDy
 zYW0/skfoBqtPCchm6BecQ8+C3onT3Ma3v5Ifo8EYZKzOnx37DhWa1ZSR834F32+oGa5
 4zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587269; x=1706192069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzJ+FSkCBBpmxypiuqZS3Cj4/KzTzXAtpNL7NtarXAc=;
 b=n5BFazGV++eLjs/kv7CgZ/Moyy7Unr9NeDg8bSugMjza+WbOz89egCxaZWHJyaZs71
 HKBnF7TvpI/2zJ3NmltLir8PjwT4FS+lPWL41Man7h7F/1oD+OGUJYkeRluvlzv8T4OZ
 jgxG77s/PtqilgNQDDEXSax6PIAMiPutW39KwB/ZvRSSaVULMTFQFtxVBaNTfZXQrxY3
 NPoQDZduHSLEES06zotZ0IyGLmdgF+Dk7P0TVnH+8VlsrMu0Eu60P8S7bO6xSNd+xqkK
 tMOtoCwsPREgmLHtESbu8EhOwXDBTX1voZUL48ONCJan0jHircBPAWQNzqNmkLKTKE/8
 YPHA==
X-Gm-Message-State: AOJu0YyVnWds6trXQEGPnN0BUBFmMCaTh4pM1lzke/zY3UjtccCAAeIb
 9P4cBJBKXMYxjDyjJDmfTP0B3UHysMrKSWOJnIO6vNCtaFGjEH6/jZbfToUS
X-Google-Smtp-Source: AGHT+IET5mbNcAfxZVOgJ4JDN9+qgMqeGYr3iWGgAyHoLme+GBYaaDXwQaODmrrliXvMq1TtOezFug==
X-Received: by 2002:a17:902:6bcc:b0:1d6:f25d:43b with SMTP id
 m12-20020a1709026bcc00b001d6f25d043bmr877182plt.15.1705587269232; 
 Thu, 18 Jan 2024 06:14:29 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170902760f00b001d4be72802esm1434781pll.150.2024.01.18.06.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:14:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] ppc: really change defaults
Date: Fri, 19 Jan 2024 00:14:16 +1000
Message-ID: <20240118141418.165107-1-npiggin@gmail.com>
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

Oops, these two should be with the previous series too.

Thanks,
Nick

Nicholas Piggin (2):
  ppc/spapr: change pseries machine default to POWER10 CPU
  ppc/pnv: Change powernv default to powernv10

 hw/ppc/pnv.c   | 4 ++--
 hw/ppc/spapr.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.42.0


