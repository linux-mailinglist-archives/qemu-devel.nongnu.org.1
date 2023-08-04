Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F9770C73
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4Mu-0000I4-3v; Fri, 04 Aug 2023 19:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Ms-0000Hc-7r; Fri, 04 Aug 2023 19:38:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS4Mq-000844-AG; Fri, 04 Aug 2023 19:38:01 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374NVOnj010332; Fri, 4 Aug 2023 23:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=be6BlfLnupNe2HFZlSw5L2zllRR4Wz4BfClmXaCfzXM=;
 b=AXT2fcBQJrug4vr0aadJv5KV89TCUkPQbtRxp63rFQfKadn34Ud3Kt4FlY3/l4Qf8dn0
 moUAsAnLxjA9MmcIUc2nJ4qicd0l8ZCRWpwdUNSUcgNwGektzWMYJcKXx6XoMZS5k+TI
 e3Rf1xbfUpzpNeuWSHJMx/AoaG84VSJcsabNWQ+/zV4PRseSizHsUX+YPJOAWdhxKR3x
 sCi5O0dkVp3aii59nlPkTD9vkh6Ucrfb1k7qSH5dTqID+twTfslhGRsadapmc7yB+/fN
 tskDR0yGg3G7EFYbgqo3WL4mQxR864g27KpIPjxoGyBJNiUUdZ8H5cnxl9JlgTx+PyE6 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b3283nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:57 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374NWLAF011531;
 Fri, 4 Aug 2023 23:37:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9b3283nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374Mkale023561; Fri, 4 Aug 2023 23:37:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9sx38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NbsXQ29032870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:37:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2A6520043;
 Fri,  4 Aug 2023 23:37:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6570E20040;
 Fri,  4 Aug 2023 23:37:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:37:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] linux-user/elfload: Enable vxe2 on s390x
Date: Sat,  5 Aug 2023 01:03:17 +0200
Message-ID: <20230804233748.218935-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804233748.218935-1-iii@linux.ibm.com>
References: <20230804233748.218935-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u3mbgNxeze6_5sbPZYQIOq9AQNhxQQ7k
X-Proofpoint-ORIG-GUID: R1zFi5jOkhFdWr5zu8zpcwjMrkbqtGro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040213
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The vxe2 hwcap is not set for programs running in linux-user, but is
set by a Linux kernel running in softmmu. Add it to the former.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abcd..33b20548721 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1614,6 +1614,7 @@ uint32_t get_elf_hwcap(void)
     }
     GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
     GET_FEATURE(S390_FEAT_VECTOR_ENH, HWCAP_S390_VXRS_EXT);
+    GET_FEATURE(S390_FEAT_VECTOR_ENH2, HWCAP_S390_VXRS_EXT2);
 
     return hwcap;
 }
-- 
2.41.0


