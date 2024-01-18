Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C803A831B1E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6c-0005HJ-3p; Thu, 18 Jan 2024 09:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6R-0005FR-7R; Thu, 18 Jan 2024 09:10:46 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6P-0000w3-Aa; Thu, 18 Jan 2024 09:10:42 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cf22a89a54so4397145a12.3; 
 Thu, 18 Jan 2024 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587039; x=1706191839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWk2dgjHndp7FsuzpUD/csXND4J+Krq5hKfllN40/I8=;
 b=hilZ8qIKjhMnPMqIjEmbxV6gw7h/tI+cpRVRtoM6T1Kq1sJydZpGrDvivSUlblxfIC
 ebxGe22CsqrfUEDQ84Mh6JMYD/Lj5Dm+ly6iMht68LtlzkqgvF0Or7+PypvYp/NFsrON
 bdynWJXpMr7KOpI3yYaiPZxolS1xmHW5kU0NZWMSHRq36++WUAN2V5nuDfzTOxHWe4ms
 bRVbeIEun8L/j7OWU6ASXvKpDp1qhTbN8SwBcXmvC824tLEXtNnSErHYjl7yRzUDf5g8
 JOmI3SWg7aGcK/UMkKYvHKw7rT6XSRCstkwSwIkM0asAgq4PhasmH//zYKyw3tjFb1O8
 8LGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587039; x=1706191839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWk2dgjHndp7FsuzpUD/csXND4J+Krq5hKfllN40/I8=;
 b=Tee4NLcurUxHtTFGW2DTSLx9M/127bpGg+i8mj0dJPDaI5/MB5FMPC/minJVeE0rd2
 zcvhgiMY2FR9QJHL0r3xz8vZrGxTs+58sTt59vlkLwvTxH6N0YV5VfaAFBdQrh5Vt86d
 Vcd97aCc+GLobI+YzD3zi+sKZW+nKS4h7w7DHqa+X5DrbRHoFib+OfiYWsGKu0GWeIq2
 ja5QvXoFL9pBY4ibs9ggJvNFzPzq6rkVvtNu6XR20jL2bUcPpDx9GRSpPkKK3jst3i1v
 z7pP1AAC0qiR21MjzOB/ZeOgoAQxmNf9n4bgY+5yekMZu/Py/fTm7gz38NCS+rDDszKK
 8ZwA==
X-Gm-Message-State: AOJu0YztmetZ60bg8gAZ5cix4+H2lt+w2QbtFb2TZtNFQbgGt1aNxL8P
 jHAvD85culdFZ/EBF9jFDXrcSbcTYpk+UWlnT/BtJGPrYlMZUyDPm3Xyp3bY
X-Google-Smtp-Source: AGHT+IG40l8R7daxsLo3FkNMw+NwptleL5xyIP8Hgdm7NW3vkxhFoyYUsooYspb2SfuiNRwfwADV+A==
X-Received: by 2002:a05:6a21:8cc5:b0:19a:9db4:851b with SMTP id
 ta5-20020a056a218cc500b0019a9db4851bmr777598pzb.61.1705587039578; 
 Thu, 18 Jan 2024 06:10:39 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 8/8] ppc/pnv: Update skiboot to v7.1
Date: Fri, 19 Jan 2024 00:09:42 +1000
Message-ID: <20240118140942.164319-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

This includes a number of improvements and fixes. Importantly there
is a change for QEMU platforms to permit the ChipTOD to be initialised
if it is present in the device tree. This will facilitate ChipTOD
enablement in pnv.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
[blob omitted, patch is just for comments]

 pc-bios/skiboot.lid | Bin 2527240 -> 2527328 bytes
 roms/skiboot        |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/skiboot b/roms/skiboot
index 24a7eb3596..dbd5de6624 160000
--- a/roms/skiboot
+++ b/roms/skiboot
@@ -1 +1 @@
-Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
+Subproject commit dbd5de6624d7466bb67d1eb4e57bc3a8e2ad9e87
-- 
2.42.0


