Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AA753F2F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKKvG-0004Vp-JV; Fri, 14 Jul 2023 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKKv0-0004Da-Jt
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:41:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKKuy-0005HP-Rm
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:41:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EFeekR018492; Fri, 14 Jul 2023 15:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=SOcSfU1riHLYUsP/h96meuAxCvYgsF8CocW9ku4kcsA=;
 b=ig8oc0j3hlifj1I1eg6qKbnINtUjys7EeOgHpghIJlGRarkHAC0v1kvHb0nLNgrcqRqz
 Q07OJiWf7gLw/fMTk41ekmgj0VrCqun+LZ+qJkRm6egswJ/HgensdDAaxJtL7vRxndLE
 r5nzjmnB7Bse1QndRtp0OZsJ/Z/8nOLsOG9lLZPZ/vT8jFvJgdEZVCwChuzlZgWQtHU9
 R+iZU7I2C0DTPkjXT8YUISFuXkBCJKxKU68yqPVyoZT6bgD3xOf0bxR5s4fL0cBpoT+O
 xcEyKsvuXTRtC7rZe9c4sy4KrYNv6RNJ/0rrE5fp6p/RcEP9+Y8mV2tszwivi4AShRYD lA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8vyrn7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 15:41:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36E80C5t019653; Fri, 14 Jul 2023 15:41:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rtpvthg96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 15:41:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EFfA5M3539616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 15:41:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED8D058059;
 Fri, 14 Jul 2023 15:41:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6A6B58043;
 Fri, 14 Jul 2023 15:41:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 15:41:09 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 0/1] Merge tpm 2023/07/14 v1
Date: Fri, 14 Jul 2023 11:40:59 -0400
Message-ID: <20230714154101.184057-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8khVp6SqxDiylIvfvO9XnadzV1ULaYdB
X-Proofpoint-ORIG-GUID: 8khVp6SqxDiylIvfvO9XnadzV1ULaYdB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=776 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140141
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

Hello!

  This PR removes the 'ppi' boolean property from the tpm tis sysbus
device. It could never be activated since it was leading to a segfault
immediatley.

    Stefan

The following changes since commit 3dd9e54703e6ae4f9ab3767f5cecc99edf066668:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-12 20:46:10 +0100)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2023-07-14-1

for you to fetch changes up to 4c46fe2ed492f35f411632c8b5a8442f322bc3f0:

  hw/tpm: TIS on sysbus: Remove unsupport ppi command line option (2023-07-14 11:31:54 -0400)


Stefan Berger (1):
  hw/tpm: TIS on sysbus: Remove unsupport ppi command line option

 hw/tpm/tpm_tis_sysbus.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.41.0


