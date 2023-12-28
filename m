Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658881FA8C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 19:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIvWv-0001hc-N6; Thu, 28 Dec 2023 13:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWs-0001hP-Fx
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:50 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWq-0004c1-58
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:50 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d408d0bb87so45179885ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703789564; x=1704394364;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ViDWw2ROo7d7sEzcN8j3URpXZwtuKLpgDRDMie7TcH4=;
 b=V90kv2BVUe91myRLF3aufiJz+YE0nZe4Ka2MUET3gF6zeSEtBCGKRlktfWMyccKm6X
 csZ3nKRcFqz2oAmMFmbNTPiRpHbK1SvE10mEP59KKicjtVBctrluehEVDLbwGB9MNVey
 xmii7pyLAbC3p525VtAAsucLxL0UgYN6DBRKTi0cJpfFnj0LU2EFj3harKkir/beoELL
 yckkCG6Z5D9L8/sOsq0v/3E5LKrdWi0+79ddbnmdsOim7C9VMsoJfe/2tCYEM113Sx95
 U20B+dPdK4T4M6/r3QQ2RR4GN2w6vvXUyxm99S2GVyDq633ihxsyodvhbPVrNLkkdAlV
 U6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703789564; x=1704394364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ViDWw2ROo7d7sEzcN8j3URpXZwtuKLpgDRDMie7TcH4=;
 b=FCTkWVrInpQpQyviaLLAUbROYN+Spx0gh3SunoAfqJr6UJJVDao9eXOyVsSN1QjzPs
 U2tjaGrfR/PdeYSl39dorRs6N0+Qgx85STKUw+PgWuPrDivwuDXHLx7AF+rInok5sOWm
 AxTipXKDSR1NEXcZXD68CcdjWk5JpKKD9ySKffnpqo3TRXFo6h80GC3uLzU6R5UEcV3B
 VbenQpQo8t33pqPFhSEj+QtzWXYasj+YVkp/VNjHy4SuBhqRBlYmrxuQb2FFVjPRQWtg
 5H6XrTXnGDQ/9/JRh3j6T9j/ol9IpEnmFZVFcw6epw+14nl3/jfxxIB5Tfc8yNWA237Z
 W3NQ==
X-Gm-Message-State: AOJu0YyxkO6F6LPKZ8nwdqs2m0+8FtKg6+pgZYEHCuNNkjr4KQw0gCLw
 h8hKE7SW3KLpEPS5IMEYk14ZMyGPhV/yfStFN461nuRlzx3FCR0V
X-Google-Smtp-Source: AGHT+IGCiiotvX0UT5PfH/0XxHyo+oK+FyPeBtdaMYUhpa7VfSwrPJqfe2tDwU61S6xdlC+i+zVwxw==
X-Received: by 2002:a17:902:d4ca:b0:1d4:6803:7fc4 with SMTP id
 o10-20020a170902d4ca00b001d468037fc4mr5743882plg.136.1703789563223; 
 Thu, 28 Dec 2023 10:52:43 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.180])
 by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001d36dbb22a9sm14312694plr.4.2023.12.28.10.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:52:42 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH 0/2] Adjust the output of x-query-virtio-status 
Date: Fri, 29 Dec 2023 02:52:30 +0800
Message-Id: <cover.1703787712.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset is derived from the series:
https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
Please go to the link to see more background information.

The following points are what we have done in the patchset:
1. Take the policy of adding human-readable output just in HMP.
2. For the HMP output, display the human-readable information and
   drop the unknown bits in practice.
3. For the QMP output, remove the descriptive strings and only
   display bits encoded as numbers.

Please review, thanks,
Yong

Hyman Huang (2):
  qapi/virtio: Keep feature and status bits in the QMP output
  hmp: Drop unknown feature and status bits

 hw/virtio/virtio-hmp-cmds.c |  38 ++++---
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 45 insertions(+), 208 deletions(-)

-- 
2.39.1


