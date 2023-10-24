Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C17D59DB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLNm-0002J4-FE; Tue, 24 Oct 2023 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvLNf-0002IL-0q; Tue, 24 Oct 2023 13:39:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvLNc-0004RS-QI; Tue, 24 Oct 2023 13:39:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OHbSFD014745; Tue, 24 Oct 2023 17:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vfMZwdIrm35c0dizZryvOdf9dD6bvfFlsxR0QCA1KVo=;
 b=tgkru3kijdnREJ0aUl++dj5ZjW+KVsEd/acuRnjZ+Zq+bV46zR8/i5bUTuxGPYvJYjX3
 K6MdwTZFvEKPOkzTN4aLcmtXegYbR81Bchb6Qozmrn32Tf58imFQHA+WmApSRbzKc3HR
 tmPY0Lg0ca8NJDehvK+lK9a7DvQkT7bXrX+Rj6PsJk0CqSN75YOX8iESP9nie5XsPnFN
 5bnljhW2x+SE9PPt4LEFtQDaKAzT/os4FgWHbzCzx36ax9aq1SDCAKmhWkt0y4JgP8ow
 nQ9LtmaOuseN1kOe7gHAWAUktLf0ktF04lMQQPfw9tNLzlbx6XiAusws1aSVQwnYT+a0 wA== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txjg0r338-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 17:39:38 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFq1MO023782; Tue, 24 Oct 2023 17:39:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt1eav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 17:39:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OHda2K11207198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 17:39:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7511158059;
 Tue, 24 Oct 2023 17:39:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD6D858053;
 Tue, 24 Oct 2023 17:39:35 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 17:39:35 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org, clg@kaod.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org
Subject: [PATCH] misc/led: LED state is set opposite of what is expected
Date: Tue, 24 Oct 2023 12:39:23 -0500
Message-Id: <20231024173923.4041874-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2_n11z5Fv_TkGiq8EJlvZWS8WC70wMQD
X-Proofpoint-GUID: 2_n11z5Fv_TkGiq8EJlvZWS8WC70wMQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_17,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=658 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240151
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
the input GPIO of the LED, the LED was being turned off when it was
expected to be turned on.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/misc/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index f6d6d68bce..96cad7578e 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
     LEDState *s = LED(opaque);
 
     assert(line == 0);
-    led_set_state(s, !!new_state != s->gpio_active_high);
+    led_set_state(s, !new_state != s->gpio_active_high);
 }
 
 static void led_reset(DeviceState *dev)
-- 
2.31.1


