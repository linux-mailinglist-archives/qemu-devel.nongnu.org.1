Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FB76A556
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 02:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQcwa-0005jk-7l; Mon, 31 Jul 2023 20:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qQcwW-0005jO-Cq
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 20:08:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qQcwR-0003XD-Vi
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 20:08:52 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230801000833epoutp045ed3610ff712a35aa86a178545c93fc4~3GcPPhZgM2484324843epoutp042
 for <qemu-devel@nongnu.org>; Tue,  1 Aug 2023 00:08:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230801000833epoutp045ed3610ff712a35aa86a178545c93fc4~3GcPPhZgM2484324843epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1690848513;
 bh=5TOtPP96n6JmEO4oQpB3orDKyWhRe4tXbI+NoRJzMhY=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=FPUPl7GT1FmHJZw3GEMzlbN50TxZX4mcFq743oEZR+Rp0MQgPmmrNQGL/k9qG9OAQ
 uHxMMouNsROZCF7qoC8F6fj7A/yKM5kH9jcdsVamt0ddskfl+nLyvpvUZvg3lpuVJn
 EXpCQyM+JXcO5LwVM3IMpWziqImizWKyDWghdIXc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230801000833epcas2p28531555c4d0debc0086595867adb0210~3GcPD9l_m0101801018epcas2p2N;
 Tue,  1 Aug 2023 00:08:33 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RFFnX6bqdz4x9Q2; Tue,  1 Aug
 2023 00:08:32 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-b1-64c84d00ad2a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 BB.2C.32393.00D48C46; Tue,  1 Aug 2023 09:08:32 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 0/3] hw/ufs: fix compilation warnings
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Mike Maslenkin <mike.maslenkin@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230727233405.35937-1-mike.maslenkin@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230801000832epcms2p3aedd0841dc7355c2462f17ad3677145a@epcms2p3>
Date: Tue, 01 Aug 2023 09:08:32 +0900
X-CMS-MailID: 20230801000832epcms2p3aedd0841dc7355c2462f17ad3677145a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmhS6D74kUg4svFS1eHtK0+L32MZPF
 8d4dLBavJ/1ndWDx2DnrLrvHk2ubmTze77vK5tG3ZRVjAEtUtk1GamJKapFCal5yfkpmXrqt
 kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
 Rn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG5dO/GQv+M1d0HlzP3sC4lLmL
 kZNDQsBE4tWlBiCbi0NIYAejxN91DaxdjBwcvAKCEn93CIPUCAtYSuxt28wIYgsJKEjM2dbB
 DhHXlJi+fiITSDmbgLrE6YXmIGERAV2JySf7wEqYBZIkjq2YDbWKV2JG+1MWCFtaYvvyrWAj
 OQXsJN6v3s4IEdeQ+LGsF6peVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjwczdUXFLi1LfHrBD2
 dEaJBf9NQd6SEFjAKPGreTpUg77EtY6NYEfwCvhKPDg0kQXkfhYBVYldP7kgSlwkjr5vYYS4
 X15i+9s5zCAlzEDvrt+lD2JKCChLHLnFAlHBJ9Fx+C87zIcNG39jZe+Y94QJwlaRWNx8mHUC
 o/IsRDDPQrJrFsKuBYzMqxjFUguKc9NTi40KTOAxm5yfu4kRnPS0PHYwzn77Qe8QIxMH4yFG
 CQ5mJRFe6d/HU4R4UxIrq1KL8uOLSnNSiw8xmgI9OZFZSjQ5H5h280riDU0sDUzMzAzNjUwN
 zJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYJq/8YJ+9cvLaQd0mI3N55eejO/VEzc7Vmp9
 7ULgHnVD2Ts7a2YWzGtyls198WTizbSzxhM0v3bvEuWM5j1wWe/M1FVM++Q7Dj6y1mCq5Hlk
 083V15NVs61pO/t5+f4NzH/6r6wUMtg0Y17+iUT56Z3bzRf9T04MLgtpYpoVxRv5u8XJeYnD
 8mYey6kB/Zv3m5yNPrfw8mo34d+zNk5bvNc56tbEnduzFm7oKnVbfMqz8mt5+P3VDV2mVj/c
 Qt7ZabVv1RIQ0nFdtfSuoMXf8o7GhHdh/98slDaSDZC60vjWMO1j1kXz7i+MWrsen151ac52
 xwDLjsK318O6eH4+3/e897zUk7fpjLzTpvv+uK/EUpyRaKjFXFScCADMgZ9nAwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230727233426epcas2p42f9a359efad22cda0b6ae6cf5c200ea0
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
 <CGME20230727233426epcas2p42f9a359efad22cda0b6ae6cf5c200ea0@epcms2p3>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/28/2023, Mike Maslenkin wrote:
> This patchset contains a trivial compilation fixes for UFS support
> applied to block-next tree.
> 
> Cc: Jeuk Kim <jeuk20.kim@samsung.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>

Thanks for letting me know.
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

To Stefan,
Could you please add this patchset to the block-next tree?
I haven't prepared a repo for QEMU UFS yet :'(
Thank you very much.

