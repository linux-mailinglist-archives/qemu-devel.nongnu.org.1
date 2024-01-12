Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B7982B983
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 03:29:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO7H3-0001pV-3p; Thu, 11 Jan 2024 21:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdna@apple.com>) id 1rO6jA-0003RJ-9E
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 20:52:56 -0500
Received: from ma-mailsvcp-mx-lapp01.apple.com ([17.32.222.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdna@apple.com>) id 1rO6j7-0001Ot-VN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 20:52:55 -0500
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S74003VUI7NKL00@ma-mailsvcp-mx-lapp01.apple.com> for
 qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:47:52 -0800 (PST)
X-Proofpoint-ORIG-GUID: 2ugqIma8oZKBSkC9oNTim7TRyumBpf6P
X-Proofpoint-GUID: 2ugqIma8oZKBSkC9oNTim7TRyumBpf6P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619, 18.0.997
 definitions=2024-01-11_15:2024-01-11,
 2024-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=374 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding; 
 s=20180706; bh=ASJtE8Q+SWIKWcQLJv4zlv/lZvc5aBBGmedOEiq24/o=;
 b=kSc3EAWp9cKOqGgk5r4zUcP5PrGMH/nCbvB0ndJccuc6MjfBobwBC0i+BGGsEIQws1C5
 zQcPGWxXM4u/WI5XmP20PiLonWfnH1lrShwiIC6WzfM8TKq+UXymkVDe6qjjxSjCgW1S
 JrlY0Bw89x6vs8jvQmiC2XBBTD4VqQ21K+7Wh8ZeQciFKNZrEpN6VlqTAE4PeV+6ZCmO
 dfTRxA4XzPLqPzjQtZBn6XfTfLg8VS+PvmD/2kpi1oJoWksY0XROEn9vavL0cWMWAlCY
 0Hj7W3JlcBYFAyafnxT2o/VwSIzM1veHPnFlGZO4wD4wA5NkGfwEhdEnCWjpRm3JSW+9 bg==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S7400JCUI7O8B40@rn-mailsvcp-mta-lapp01.rno.apple.com>; 
 Thu, 11 Jan 2024 16:47:48 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S7400R00I6O4B00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Thu,
 11 Jan 2024 16:47:48 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 51115aee971724d6ddf329fb28aa7ad5
X-Va-E-CD: 943b4d88476a1507b6fae349cad8b2e4
X-Va-R-CD: eb458e80526e2b01821c07b4ac2d69d7
X-Va-ID: b38b6666-3b36-4b12-aca5-8cc125fa2c3c
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 51115aee971724d6ddf329fb28aa7ad5
X-V-E-CD: 943b4d88476a1507b6fae349cad8b2e4
X-V-R-CD: eb458e80526e2b01821c07b4ac2d69d7
X-V-ID: 0d58802d-255d-4b7e-9b5c-9b5c8412d642
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619, 18.0.997
 definitions=2024-01-11_15:2024-01-11,
 2024-01-11 signatures=0
Received: from localhost (unknown [17.11.93.240])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S7400C86I7O1H00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Thu,
 11 Jan 2024 16:47:48 -0800 (PST)
From: Andrey Ignatov <rdna@apple.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Wei Shen <wshen0123@apple.com>,
 Andrey Ignatov <rdna@apple.com>
Subject: [PATCH] vhost-user.rst: Fix vring address description
Date: Thu, 11 Jan 2024 16:45:55 -0800
Message-id: <20240112004555.64900-1-rdna@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-version: 1.0
Content-transfer-encoding: 8bit
Received-SPF: pass client-ip=17.32.222.22; envelope-from=rdna@apple.com;
 helo=ma-mailsvcp-mx-lapp01.apple.com
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jan 2024 21:27:53 -0500
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

There is no "size" field in vring address structure. Remove it.

Fixes: 5fc0e00291 ("Add vhost-user protocol documentation")
Signed-off-by: Andrey Ignatov <rdna@apple.com>
---
 docs/interop/vhost-user.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9f1103f85a..ad6e142f23 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -148,9 +148,9 @@ Vring descriptor indices for packed virtqueues
 A vring address description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-+-------+-------+------+------------+------+-----------+-----+
-| index | flags | size | descriptor | used | available | log |
-+-------+-------+------+------------+------+-----------+-----+
++-------+-------+------------+------+-----------+-----+
+| index | flags | descriptor | used | available | log |
++-------+-------+------------+------+-----------+-----+
 
 :index: a 32-bit vring index
 
-- 
2.41.0


