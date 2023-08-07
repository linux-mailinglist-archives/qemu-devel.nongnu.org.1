Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54C77277C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT14Y-0002wt-0z; Mon, 07 Aug 2023 10:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT14W-0002wk-7b
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:19:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT14U-0006Bk-Gz
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:19:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377EC8jl016560; Mon, 7 Aug 2023 14:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=WXNgn9arFqiHuM+QFBU/7sEzU5TeH+dgy1O+u2uK1Iw=;
 b=EaN190HwojseGNSLqXVE5F5efNW24PcMYBcQFP/8nAc8Jv6gc29KqKF1oxk1hxZf9cql
 stn05pzW74uDgyW4WFpS1xxjjGuXGoJ7E4EnzFVqna9OCS+wlJQKXHyne5qtTVdQZvLm
 2yxXU5hfGS9dkqJ+8Ju/tzP9w/nD3FiQIoPmqB7VD6i34PWilooWO36KZff/Hji6BaDS
 3rxfUb2m0hlF7n7/DWqB0/oMndGlKOsxGKU22oViZJJgrs9ZUCxJ4vRKBDlrlMCantDY
 erQMlvZUOsZzWixPmfA1aq/XCacA6OO8P3oOJpAGz6P4szH9q4on9NGOI96DN/yV7M/b BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb25tg6uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:53 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377EFPfJ030490;
 Mon, 7 Aug 2023 14:18:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb25tg6u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377E29a6001592; Mon, 7 Aug 2023 14:18:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa2yjn9sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377EIorn17891868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 14:18:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E999F20043;
 Mon,  7 Aug 2023 14:18:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B187020040;
 Mon,  7 Aug 2023 14:18:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 14:18:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 0/1] tcg: Always pass the full write size to
 notdirty_write()
Date: Mon,  7 Aug 2023 15:56:36 +0200
Message-ID: <20230807141846.786530-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tVt9TC04y2ekEgJc038VArHTGGSSTOxr
X-Proofpoint-GUID: ryRiM1mQJX05qRh51UZopZkJ0RmAPoY1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxlogscore=714 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi,

this is the fix for an issue I complained about a few days back on the
IRC. Unfortunately my reproducer [1] does not work anymore, so I'm
sending this separately and as an RFC.

The user-visible effect was that:

- If a TB writes to itself;
- The address of the write is before the TB start;
- The newly written instruction causes an exception;
- Then single-stepping the instruction that does a write gets you to
  an interrupt handler and not to the newly written "bad" instruction.

You can still see that something is wrong with the softmmu reproducer
in the debugger though. In helper_vstl(), probe_write_access() does not
lead to cpu_loop_exit_noexc() - which I think it should, but
cpu_stq_be_data_ra() still does, masking the issue.

Best regards,
Ilya

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg01081.html

Ilya Leoshkevich (1):
  tcg: Always pass the full write size to notdirty_write()

 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0


