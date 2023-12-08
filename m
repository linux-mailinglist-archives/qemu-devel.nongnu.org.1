Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E180A544
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbg6-0005pk-EX; Fri, 08 Dec 2023 09:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBUFC-0007nl-EY
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:21:52 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBUF7-0000Q2-2U
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:21:50 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231208062140epoutp02d5ab9467e42fa10d40fe86ab6b11125c~exv1SjWqc0059900599epoutp02e
 for <qemu-devel@nongnu.org>; Fri,  8 Dec 2023 06:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231208062140epoutp02d5ab9467e42fa10d40fe86ab6b11125c~exv1SjWqc0059900599epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702016500;
 bh=/oUHa5D5McJvgpsJoL1q2msPaWi0JVoTytyZRDHtkBQ=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=nj3XhyxjFTRMQS+9oVlXjIZTbuGLQlDOHmmC50SNjcoQSUILLmgDW0QHkI+QQNbXe
 Cg4/hUlXc2F0174lS5sHMh0So+Tb8dhovOKP3/J7dL/NoT+likIsqbjAjlFwapUe2/
 6FTewrkQaqIQ+wVpg5ILDXSfeq7lUzSWmO3e9LC4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231208062140epcas2p2857c08ad9ae41ce4296dd5b47d06c29c~exv03rONa0880008800epcas2p2J;
 Fri,  8 Dec 2023 06:21:40 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SmgyW3T0Nz4x9Q1; Fri,  8 Dec
 2023 06:21:39 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-fb-6572b5f3abc6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 80.FB.18994.3F5B2756; Fri,  8 Dec 2023 15:21:39 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/3] hw/scsi: add mode sense support for zbc device
From: Daejun Park <daejun7.park@samsung.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Daejun Park <daejun7.park@samsung.com>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Yonggil Song
 <yonggil.song@samsung.com>, JinHwan Park <jh.i.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231208062038epcms2p4d1783b8366059c392b0e8ea7a7eb4c9f@epcms2p4>
Date: Fri, 08 Dec 2023 15:20:38 +0900
X-CMS-MailID: 20231208062038epcms2p4d1783b8366059c392b0e8ea7a7eb4c9f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTTPfz1qJUg+bfkhYvD2larHoQbnFl
 /3lGi/tbrzFa9P9rZ7HYv+0fq8Xx3h0sFqs65jJaTD1/hMmB0+PHuXY2jyfXNjN5vN93lc2j
 b8sqxgCWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
 HKBTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYG
 RqZAhQnZGRcb17MXtPFV9O9vYmpg/MzRxcjJISFgIvH51hnGLkYuDiGBPYwSK9fsYupi5ODg
 FRCU+LtDGKRGWMBZYtufs2wgtpCAksT6i7PYIeJ6ErcermEEsdkEdCSmn7jPDjJHROASo8TS
 29vAGpgFKiWOXbjJCLGMV2JG+1MWCFtaYvvyrWBxTgE/iSU/JzJBxDUkfizrZYawRSVurn7L
 DmO/PzYfao6IROu9s1A1ghIPfu6GiktK3J67Cao+X+L/leVQdo3EtgPzoGx9iWsdG8Fu4BXw
 lej7/A3MZhFQlWhdsBVqpotE44Fv7BD3y0tsfzuHGRQmzAKaEut36YOYEgLKEkdusUBU8El0
 HP7LDvNhw8bfWNk75j2B+lBNYt3P9UwTGJVnIQJ6FpJdsxB2LWBkXsUolVpQnJuemmxUYKib
 l1oOj9/k/NxNjOCEqeW7g/H1+r96hxiZOBgPMUpwMCuJ8Oacz08V4k1JrKxKLcqPLyrNSS0+
 xGgK9OlEZinR5Hxgys4riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNT
 qoHJ/+S3JT/2HK/f7Dx758pdx1ediMn4uKPumr7MBy/7jz2Op9fdmufC97r9Icu/+NCJ++Yt
 0Opybvui/vb5mhUXYiYL3z/ieaFqmfAHa4OK3c5T45auEFBIa/wkzrxg8ZdVmjU9E3ODd0zg
 F3Rv3JIovnlRUTOznljXYp07H/cwTVmbX6bUMIdV5OWX/GPB3XdmcvWdmZR299LVq3UtN0/d
 ZKniqJP5zF6weO9Xcd+Nz5o5484ZlXM4m53x5vVf9b6iPF2h95ze2ZflehXnFBX6r6bIhbcJ
 B4erGV86OVv9QHSBX71xsfW7nkur596TvFJ3a7G0hm2qZMp9m8MzXq8st9HxL+z1UdtzadvW
 31wpSizFGYmGWsxFxYkAYoMEKCEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba
References: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p4>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Dec 2023 09:17:30 -0500
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch enables mode sense for zbc devices.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/scsi/scsi-disk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6691f5edb8..f1ecb77317 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1083,11 +1083,14 @@ static int mode_sense_page(SCSIDiskState *s, int page, uint8_t **p_outbuf,
                            int page_control)
 {
     static const int mode_sense_valid[0x3f] = {
-        [MODE_PAGE_VENDOR_SPECIFIC]        = (1 << TYPE_DISK) | (1 << TYPE_ROM),
-        [MODE_PAGE_HD_GEOMETRY]            = (1 << TYPE_DISK),
-        [MODE_PAGE_FLEXIBLE_DISK_GEOMETRY] = (1 << TYPE_DISK),
-        [MODE_PAGE_CACHING]                = (1 << TYPE_DISK) | (1 << TYPE_ROM),
-        [MODE_PAGE_R_W_ERROR]              = (1 << TYPE_DISK) | (1 << TYPE_ROM),
+        [MODE_PAGE_VENDOR_SPECIFIC]        = (1 << TYPE_DISK) | (1 << TYPE_ROM)
+                                                              | (1 << TYPE_ZBC),
+        [MODE_PAGE_HD_GEOMETRY]            = (1 << TYPE_DISK) | (1 << TYPE_ZBC),
+        [MODE_PAGE_FLEXIBLE_DISK_GEOMETRY] = (1 << TYPE_DISK) | (1 << TYPE_ZBC),
+        [MODE_PAGE_CACHING]                = (1 << TYPE_DISK) | (1 << TYPE_ROM)
+                                                              | (1 << TYPE_ZBC),
+        [MODE_PAGE_R_W_ERROR]              = (1 << TYPE_DISK) | (1 << TYPE_ROM)
+                                                              | (1 << TYPE_ZBC),
         [MODE_PAGE_AUDIO_CTL]              = (1 << TYPE_ROM),
         [MODE_PAGE_CAPABILITIES]           = (1 << TYPE_ROM),
         [MODE_PAGE_APPLE_VENDOR]           = (1 << TYPE_ROM),
-- 
2.25.1


