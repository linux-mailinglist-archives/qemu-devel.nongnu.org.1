Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E419840258
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 11:01:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOQs-0003A5-9X; Mon, 29 Jan 2024 05:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOQq-00039u-E3
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:00:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOQo-0005eR-SC
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:00:00 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9g7D3019797; Mon, 29 Jan 2024 09:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=03wkN6EQoZpbYSLsXxpQp9roDCK7mf0oaZ//LxPzWTg=;
 b=bELTXtxbPhEJK4Fh6ZUdrnegYik2W30Rg9+G7y33vHmmw+F7GHlwlB7hgP8Z+wiQljph
 YLChOVtPPvYr+e4TeRDIGCwMAdhSf22GUerNid/LBBgGP7TKnUgCS0YRuwLU/wT7O4EB
 YUHPnPGICynLVEvNE/aqp5NQYBSfN+USvpYxIS70pwzkdMm5ValzdS7sUq4V0AIh9MV6
 r6K4XoJI8HGFKMKiLttPtDPlkbu1VXN52/udc2wx8Knp+QRzMVO5uf2f1q2s6AeuW99E
 gvWdHlxAqAsw/B13PKcAED71XVYhWLDmr0QOmMhYd5/gSxpOzx14QFQQ3aLoyaLqO13A /w== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx6yxm10u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:59:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T6o2S1007200; Mon, 29 Jan 2024 09:59:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev1y0cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:59:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40T9xoEH29229682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 09:59:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E8892004B;
 Mon, 29 Jan 2024 09:59:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3297820043;
 Mon, 29 Jan 2024 09:59:50 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 09:59:50 +0000 (GMT)
Date: Mon, 29 Jan 2024 10:59:48 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/33] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Message-ID: <z5xle4tpdzdkt754fswom3t3dug4ewmwogj5ah5mzoxrsjwifg@6ljvhbskmtpq>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-2-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aVzJVwCtYMwCwpFeAsxXHCDp0eTxbc28
X-Proofpoint-ORIG-GUID: aVzJVwCtYMwCwpFeAsxXHCDp0eTxbc28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=873 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290071
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 02, 2024 at 12:57:36PM +1100, Richard Henderson wrote:
> Use qemu_real_host_page_size instead.  Except for the final mprotect
> within page_protect, we already handled host < target page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/user-exec.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

