Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C964753A37
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHMi-0001CO-3t; Fri, 14 Jul 2023 07:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHMe-0001CF-32
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:53:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKHMb-0002h8-Ty
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:53:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EBm12i020017; Fri, 14 Jul 2023 11:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lOd1fLUHFSpSJmjtIdUXv4Im2AVdaqCFSSsYRsVMv04=;
 b=FUQJyEsNipXMnq+M658XEM8JCVX0rw1iPDFMNjNmoyfp1+PgzI5IXPlH5np9HzfANp04
 s2Y0Rrr2sHmwSzoJZcGv/hW0xnlWTYoPWbIgEP84Y3BNPielGT9/oikdx7Pi6MF4sfH9
 II1lb+pvf4Jf0+xX933hE4tITa/dwD9qD7z95td+iVfeXpw5MOPmkCxIQe0a4borGdQm
 IE0PJqjyTBfo9xHRM/StdrwvXZBW+9WfsuZbrVwwSsRjSbEsXD1xYdwCQPsEvnCVuiNA
 1kdywPVra4mnTaARddh6tapdxYaokugH5uzNdKDiFLA5BsgAdEQxWpzFTnz2cuItqx51 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5tbg4m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 11:53:31 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EBmMSp021336;
 Fri, 14 Jul 2023 11:53:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5tbg4kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 11:53:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36E4LhDK007309; Fri, 14 Jul 2023 11:53:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1kbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 11:53:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EBrUoW20120262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 11:53:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27B385805D;
 Fri, 14 Jul 2023 11:53:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80A9558053;
 Fri, 14 Jul 2023 11:53:28 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 11:53:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eric.auger@redhat.com,
 ard.biesheuvel@linaro.org, j@getutm.app,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
Date: Fri, 14 Jul 2023 07:53:25 -0400
Message-ID: <20230714115325.248930-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ITmHBEijTePv-efO8EfUqzR72gu6-nYt
X-Proofpoint-GUID: IO7Z0wYQw7cTpEfKnvBoePzfZhGq9yej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The ppi command line option for the TIS device on sysbus never worked
and caused an immediate segfault. Since it is part of the state of
a VM we cannot remove it but have to intercept ppi_enabled set to
true and display an error instead.

Reproducer with the ppi=on option passed:

qemu-system-aarch64 \
   -machine virt,gic-version=3 \
   -m 4G  \
   -nographic -no-acpi \
   -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
   -tpmdev emulator,id=tpm0,chardev=chrtpm \
   -device tpm-tis-device,tpmdev=tpm0,ppi=on
[...]
Segmentation fault (core dumped)

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_sysbus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 45e63efd63..4319d31c88 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -124,6 +124,11 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    if (s->ppi_enabled) {
+        error_setg(errp, "'ppi=on' is not supported by this device");
+        return;
+    }
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.41.0


