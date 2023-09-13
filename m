Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D779F531
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYdh-0007B3-6E; Wed, 13 Sep 2023 18:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYde-00079y-UA
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:14 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdd-0007nz-7z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:14 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-502a4f33440so497091e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694645231; x=1695250031;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN8akFDSSf8W02hilGYllT6O5qN0jjlxmrGbHu502bU=;
 b=SNbECwfwHKsvUx0n61RtyvAz9oNIax9XmwGZs6jxXOwVXOMdoiaBkWGW2c4vptKhtl
 m/yMaUbCeVdFrJeO3yl1ROjD1DV52gqQ9r8/kZnrkU/MBXmmaeYdy1k4w55pL8HwuUXX
 SWOowGzNs+XUq7/cJCxCxiET9N4dwqJKkYjtGvV+UOgK1s7/N9SnHj1DNwDqU9enPa/x
 eidbcXR9N7/IJpNrLOp6QI37uU4fhi7b8tDC1mfQ6ejhq5k2cS9V0b0OS/qpf6vjn90h
 UFCnY7GGafDBFR4AAXAHQ+DEpOdGhaWegqlYOngrJ8Oin01vv1ipGoGAGbHsBbNNq9+1
 i/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694645231; x=1695250031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN8akFDSSf8W02hilGYllT6O5qN0jjlxmrGbHu502bU=;
 b=rA6+yODYoKa4jjljs3/KHVgLPxIEQYwSQTp9DTPOiGFnM36vcbEcj/bIBEHpzK5hdv
 Qk+p0V4Gw3G5bCKrI5g23BEVtcBSXib9paxgqMvDTVPLT50s05ajLe2sUarxgbvjjCe6
 I/XivKOzqB8HIOYpSQHc5V1vVIUg8LTjbI2j+uxb4p5nqErwWxIXpjyvEBvGDJVzbnVX
 //W/IbR9Mfg1GGPbg6h9YOTiM3sYlUnpHhh46XKhsSuAxrWHcsBK2hUc5rokMXDlLWRA
 /DW6sbiXS0BdFDbCeG4P33Btl2nTPkT9WEROgED1+WQLN63pc3hV+Hs4818HOHdyaKgr
 B1lA==
X-Gm-Message-State: AOJu0Yys4b4HpX6nHMEnKjix+vq9fMT4/e8eE/QDAJvHPkFtUKl8qLuF
 t4lcTUtftHqL9FcGyWjuY+FrVg==
X-Google-Smtp-Source: AGHT+IEXpZYJWXLkxpqVtQgCwhEOl6t6fSB+5E8YNJH8niOH2KifeubyR/i6xiPVIgf1k+UTY0Gmlg==
X-Received: by 2002:a05:6512:b92:b0:4fd:fabf:b6ee with SMTP id
 b18-20020a0565120b9200b004fdfabfb6eemr4003966lfv.9.1694645231565; 
 Wed, 13 Sep 2023 15:47:11 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.8])
 by smtp.gmail.com with ESMTPSA id
 u28-20020a056512041c00b004fdba93b92asm25020lfk.252.2023.09.13.15.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:47:11 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 5/5] elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
Date: Thu, 14 Sep 2023 01:46:57 +0300
Message-Id: <20230913224657.11606-6-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230913224657.11606-1-viktor@daynix.com>
References: <20230913224657.11606-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::134;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x134.google.com
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

PDB for Windows 11 kernel has slightly different structure compared to
previous versions. Since elf2dmp don't use the other fields, copy only
'segments' field from PDB_STREAM_INDEXES.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/pdb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index adcfa7e154..2ef873b13e 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -188,15 +188,11 @@ static int pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    if (symbols->stream_index_size != sizeof(PDB_STREAM_INDEXES)) {
-        err = 1;
-        goto out_symbols;
-    }
-
-    memcpy(sidx, (const char *)symbols + sizeof(PDB_SYMBOLS) +
+    sidx->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
-            symbols->pdbimport_size + symbols->unknown2_size, sizeof(*sidx));
+            symbols->pdbimport_size + symbols->unknown2_size +
+            offsetof(PDB_STREAM_INDEXES, segments));
 
     /* Read global symbol table */
     r->modimage = pdb_ds_read_file(r, symbols->gsym_file);
-- 
2.21.0


