Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE07D5B46
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 21:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMoe-00012d-8J; Tue, 24 Oct 2023 15:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMoa-00012F-PU; Tue, 24 Oct 2023 15:11:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvMoZ-0008EU-7U; Tue, 24 Oct 2023 15:11:44 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OJA3Lq003728; Tue, 24 Oct 2023 19:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nI+Cx2vV5POG5zmT7lpf7JazqjGek1jJQe3+LwKtRFs=;
 b=D/QfI6LkVjy3xj+9H9f5GECGZfoXTG0j1ch2uDzZQT38K5qXq6UWHy9fcv/s9zv6MIkq
 fdGG4//22Jra4s706AxWyaBXP7gwottSgMNHKkW2M2Q/3YZUFUM2lJJNaXCZWTGgPHj3
 oI/goa7OxJ4plVB8P6Sd/6DlKizQZ/g35DUBC9i3hpb4JhUfMOGxOBmhe62FTZv0Be2h
 4m0YyK1agtJng/6wqSSVeFm/4kcs3F31mnyQIRyB/HIPcfNzS7+zIYqsEaVPT8No2lvR
 QQIYMY2InrZniXAB7uPSXXrIG66TWDj8U2Uqbk+7ifbO0zSO37ojUJ4DFqTd8OKcIYsr sw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txkuf826s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 19:11:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OHmZ9n023786; Tue, 24 Oct 2023 19:11:20 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt1xyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 19:11:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OJBJvm20447996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 19:11:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6622158052;
 Tue, 24 Oct 2023 19:11:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA92358050;
 Tue, 24 Oct 2023 19:11:18 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 19:11:18 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org, clg@kaod.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org
Subject: [PATCH v2] misc/led: LED state is set opposite of what is expected
Date: Tue, 24 Oct 2023 14:11:15 -0500
Message-Id: <20231024191115.4134426-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FndO5qW3hPoV9tRK8OaGLAMbzFsS4ALv
X-Proofpoint-ORIG-GUID: FndO5qW3hPoV9tRK8OaGLAMbzFsS4ALv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_19,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxlogscore=745 adultscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240165
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


