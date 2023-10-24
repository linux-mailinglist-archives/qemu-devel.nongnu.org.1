Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACEC7D5B66
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 21:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMx3-0007N4-RU; Tue, 24 Oct 2023 15:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMx0-0007ML-Va; Tue, 24 Oct 2023 15:20:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMwq-0001dY-Do; Tue, 24 Oct 2023 15:20:26 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OJA699003865; Tue, 24 Oct 2023 19:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nI+Cx2vV5POG5zmT7lpf7JazqjGek1jJQe3+LwKtRFs=;
 b=JxDm/e+bXiCXeh+Vhot9V5I+DZQriDwwMxD8INIIXkwYg7qZeCuq1+Kqw1hIyR3IW64G
 7hEDOCFS3jqJCPNjjq2Oseu5dujOUTaxLe7THZsDhvE/T1ZGLgWGKEG4T1lONSXcL/sv
 TOGYxYEj4P9GM8t6sdtW5kvShgsEDELdV5O1lUa3Y/fYGBsbYEGSoK3UgTD6Bj6eI98C
 /ipljOtuu+ZQvacTRBLLuA3V+kzVjViZtNnLD4TRCJKfTRVQLXSp2slcPzWTcVrdQqdv
 l5Pkte3PA94yCNX0M0xhJKRNKD0fy4ihZXKqYCO+iDcD9gC7voapMgn2oI7U5ydCCWGe OQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txkuf8ghk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 19:20:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OJ2PH6026878; Tue, 24 Oct 2023 19:20:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsynspcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 19:20:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OJJxaf48234960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 19:19:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB0415805C;
 Tue, 24 Oct 2023 19:19:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 214B858058;
 Tue, 24 Oct 2023 19:19:59 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 19:19:59 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org, clg@kaod.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 RESEND] misc/led: LED state is set opposite of what is
 expected
Date: Tue, 24 Oct 2023 14:19:45 -0500
Message-Id: <20231024191945.4135036-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7iXcSO3vuTYeD55MLPVx8UkBXHFbN_Nx
X-Proofpoint-ORIG-GUID: 7iXcSO3vuTYeD55MLPVx8UkBXHFbN_Nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_19,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxlogscore=745 adultscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240166
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Testing of the LED state showed that when the LED polarity was
set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
the input GPIO of the LED, the LED was being turn off when it was
expected to be turned on.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from v1:
    - Changed logic for readability

 hw/misc/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index f6d6d68bce..42bb43a39a 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
     LEDState *s = LED(opaque);
 
     assert(line == 0);
-    led_set_state(s, !!new_state != s->gpio_active_high);
+    led_set_state(s, !!new_state == s->gpio_active_high);
 }
 
 static void led_reset(DeviceState *dev)
-- 
2.31.1


