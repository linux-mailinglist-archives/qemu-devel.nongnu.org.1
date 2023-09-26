Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E17AF083
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:20:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmP-0002hj-5N; Tue, 26 Sep 2023 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmN-0002hF-Dj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAm6-0004qN-IS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOiYZ007480; Tue, 26 Sep 2023 16:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=a5tF+UWGcp6n0yg87GtkxEC8npmX88o9MJ/78XfOWww=;
 b=FB3QI8Z/1qVIuOrsf6zhiTGZfH+eWf2mXlIle9DSTjaK9q/py4ul7w+G9gMcO/44pOaC
 xaUuy/d8mmMwMvcJ/DwAmHi37n1ye9N7njNid4Lo5H8nus0JhLUuW1GJzWKrBmF2cuAz
 dTMsDC/O6bWkKp6MqnIFv6mFCSp8/7HA+3d4ULdvaAPZ/ZWdR1AzuGZ9KlGHkQXBifw8
 85o4cXr3eIcQrgu894q82DUFxzUocV/lU4gT+2Dvx+dB8ggwIm+90P4PSB8PvieWr5Ec
 D2EomFb4WId5Cz11G9wXL8wA9w4tMJymPyYs36o0ASv80fWDSoYM9BDrDexlx4Ne5rH9 zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2745g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:18:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QFa4dr039386; Tue, 26 Sep 2023 16:18:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfceabs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:18:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGIt9p007977;
 Tue, 26 Sep 2023 16:18:55 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-1; Tue, 26 Sep 2023 16:18:55 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 0/5] migration: Downtime observability improvements
Date: Tue, 26 Sep 2023 17:18:36 +0100
Message-Id: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=556
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-ORIG-GUID: EqDUqutL_G9Kip2nwxtgCLihvJHI1Mi-
X-Proofpoint-GUID: EqDUqutL_G9Kip2nwxtgCLihvJHI1Mi-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hey,

The cost of switchover is usually not accounted in the migration
algorithm, as the migration algorithm reduces all of it to "pending
bytes" fitting a "threshold" (which represents some available or
proactively-measured link bandwidth) as the rule of thumb to calculate
downtime.

External latencies (OS, or Qemu ones), as well as when VFs are
present, may affect how big or small the switchover may be. Given the wide
range of configurations possible, it is either non exactly determinist or
predictable to have some generic rule to calculate the cost of switchover.

This series is aimed at improving observability what contributes to the
switchover/downtime particularly. The breakdown:

* The first 2 patches move storage of downtime timestamps to its dedicated
data structure, and then we add a couple key places to measure those
timestamps. 

* What we do with those timestamps is the next 2 patches by
calculating the downtime breakdown when asked for the data as well as
adding the tracepointt.

* Finally last patch provides introspection to the
calculated expected-downtime (pending_bytes vs threshold_size) which is
when we decide to switchover, and print that data when available to give
some comparison.

For now, mainly precopy data, and here I added both tracepoints and
QMP stats via query-migrate. Postcopy is still missing.

Thoughts, comments appreciated as usual.

Thanks!
	Joao

Joao Martins (5):
  migration: Store downtime timestamps in an array
  migration: Collect more timestamps during switchover
  migration: Add a tracepoint for the downtime stats
  migration: Provide QMP access to downtime stats
  migration: Print expected-downtime on completion

 qapi/migration.json    | 50 +++++++++++++++++++++++++
 migration/migration.h  |  7 +++-
 migration/migration.c  | 85 ++++++++++++++++++++++++++++++++++++++++--
 migration/savevm.c     |  2 +
 migration/trace-events |  1 +
 5 files changed, 139 insertions(+), 6 deletions(-)

-- 
2.39.3


