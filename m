Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11249BF958
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Nov 2024 23:37:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8odp-0005IT-Qn; Wed, 06 Nov 2024 17:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8odn-0005I6-Rx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:36:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8odm-0005Og-DM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:36:43 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MA6d7022158;
 Wed, 6 Nov 2024 22:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4mhlvfipa+pAxGA6z
 PLf66uMolrTSoUm2p9Mcz/ybsA=; b=aPyeV3/Ti0T+dLyh2nut+HnKyqW80f7Fg
 gcQ1Xr1Yndahs9MUNpSBOrFPI2EK9zgslMjsAalrovF/3EU52/C6a6gmhWNkLmXt
 RQvCLkV92WG8cWnu99pZk749jP+afWgyFVXiJaUzJgC7wGM+3+GCQ6rKpr7W0oGI
 GZLVz4WQt9W3p+uFS0kd1zyHiOQe0Adii5Zjlo73C63sVOFsA+mvwR30aWeDPJFo
 r7bEHGZTczurvA8rcCQC3/awWdSadkCUtNGma9mThuTcLxl36wCtPj7gd7djE1/5
 ZaNUjUwjCtBxVWOUJqs6TOHBwFi5Wue24SdTLhDDPEzjIgOAn5D1w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rh0rg3ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 22:36:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MONlt024235;
 Wed, 6 Nov 2024 22:36:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyrg43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 22:36:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A6MaWdk29622862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Nov 2024 22:36:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A733C2004B;
 Wed,  6 Nov 2024 22:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05D5920043;
 Wed,  6 Nov 2024 22:36:32 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Nov 2024 22:36:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/8] gdbstub: Try unlinking the unix socket before binding
Date: Wed,  6 Nov 2024 23:31:01 +0100
Message-ID: <20241106223629.2608-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106223629.2608-1-iii@linux.ibm.com>
References: <20241106223629.2608-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tur9UwaPn2Ej6ITIxVnsvdctcacKEtTP
X-Proofpoint-GUID: tur9UwaPn2Ej6ITIxVnsvdctcacKEtTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=932
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In case an emulated process execve()s another emulated process, bind()
will fail, because the socket already exists. So try deleting it.

Note that it is not possible to handle this in do_execv(): deleting
gdbserver_user_state.socket_path before safe_execve() is not correct,
because the latter may fail, and afterwards we may lose control.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index ef52f249ce9..c900d0a52fe 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -337,6 +337,7 @@ static int gdbserver_open_socket(const char *path)
 
     sockaddr.sun_family = AF_UNIX;
     pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
+    unlink(sockaddr.sun_path);
     ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
     if (ret < 0) {
         perror("bind socket");
-- 
2.47.0


