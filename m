Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A381ED0A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 08:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIOkV-00016t-Nm; Wed, 27 Dec 2023 02:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rINUg-0003x6-0R
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:34:18 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rINUd-0000cP-VR
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 01:34:17 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5947cf2a4f6so1542085eaf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 22:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703658732; x=1704263532;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VfN8R8zSYlE0qLIcZonxoq9AhKpNo7T7Py57bnuksGg=;
 b=1MSe9Rk6erNzlDA15x8WF4ZPd7qfVPTrp6zUphJbH9OtItj9JRqOwom4eE8pflP56D
 BzrHQ8KQsvsNv5D4pWT2eFd6HgDsb5QohCu/GJ2a/c9Ijk846d/tgPqjyQMdrt91cAzc
 F3Vj8CRxVjX6LWttchZF3xOAuHNXJAnomWgoPaqLM5X5X+IRDweYlyp15lTThdg3oDnq
 UwOBu5aXev/SsMzYdRL5dxywDxyJFwbyHd37N3of7MF02vNb7RyvNckjVDVL+n4+vbfW
 3pGVg2t8JDlO+7PaN8lPjQzokrp5wUBIgxOnZKShxlZ41paU7P8F2/Q21H0PrlpMChch
 HERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703658732; x=1704263532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfN8R8zSYlE0qLIcZonxoq9AhKpNo7T7Py57bnuksGg=;
 b=NLkXLpHZd0/lAd39iFf1JppL4E7/x8KC6+O2tU0fWR3OhmV0nuMurTsFvsNbcDF1wB
 7fAd6WtUtJiMZvlGV6AjdBYmpbbcFzJpb8ovrSNdZqbmDiuSoUbFWW+hHds9A9b2/xid
 ju3p4IAxEyCkzAdiTj/U9MKmo/B03n+o7aXNmrmiXL596cV/j648hedJRGj5gCqz2AIc
 4gWbapdlpWFIVthBDCY5HCe/78y4clOuF4NpAaE6PF4aSW6P9UmOhnw01Z2qezcirjdf
 g0gVscoxTgpfWAdBv3fVNTAsFuusEo0VHQl4fEJB3drk3Bg3rL9oaSX9Dd6HvL7OSzFJ
 A7tQ==
X-Gm-Message-State: AOJu0YziSATUVjxpk14xZFuAuVlx597TGB0SaSeUuXd4sTjHV5XN+Ny2
 cgTFX55Pk4PGGqUH2OMW1Kk1lcBz++jREmX7RBecoIchV25qvA==
X-Google-Smtp-Source: AGHT+IF6ZyjaB+q+iYy72JmeiaVD2tA3P3z05xcO1UO3IKcLFb7ZN6njdxE4maOlSQeNvtIH24RqQQ==
X-Received: by 2002:a05:6358:4291:b0:174:d923:32d7 with SMTP id
 s17-20020a056358429100b00174d92332d7mr8614410rwc.45.1703658731499; 
 Tue, 26 Dec 2023 22:32:11 -0800 (PST)
Received: from localhost.localdomain ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 qj16-20020a17090b28d000b0028a267a5a05sm6651342pjb.36.2023.12.26.22.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 22:32:11 -0800 (PST)
From: peng.ji@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Peng Ji <peng.ji@smartx.com>
Subject: [PATCH] qga-win: Fix guest-get-fsinfo multi-disks collection
Date: Wed, 27 Dec 2023 14:32:06 +0800
Message-Id: <20231227063206.4025543-1-peng.ji@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=peng.ji@smartx.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Dec 2023 02:54:35 -0500
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

From: Peng Ji <peng.ji@smartx.com>

When a volume has more than one disk, all disks cannot be
returned correctly because there is not enough malloced memory
for disk extents, so before executing DeviceIoControl for the
second time, get the correct size of the required memory space
to store all disk extents.

Signed-off-by: Peng Ji <peng.ji@smartx.com>
---
 qga/commands-win32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..a1015757d8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -935,6 +935,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         DWORD last_err = GetLastError();
         if (last_err == ERROR_MORE_DATA) {
             /* Try once more with big enough buffer */
+            size = sizeof(VOLUME_DISK_EXTENTS) +
+               (sizeof(DISK_EXTENT) * (extents->NumberOfDiskExtents - 1));
             g_free(extents);
             extents = g_malloc0(size);
             if (!DeviceIoControl(
-- 
2.27.0


