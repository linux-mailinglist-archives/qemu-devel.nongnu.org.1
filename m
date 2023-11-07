Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B077E46A6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 18:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Pfg-0008IR-70; Tue, 07 Nov 2023 12:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1r0Pfd-0008IA-FH; Tue, 07 Nov 2023 12:15:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1r0PfY-0008CD-RE; Tue, 07 Nov 2023 12:15:19 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7H7nls030553; Tue, 7 Nov 2023 17:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=gBgw8gYbMJa1T+8yBdiHT+YCvndNunJ1SPX5GcZfxqA=;
 b=JHvURGUW4mPo+G5xW1o1A55RwM4Wwnf4pL+5UJ8F/uBI88GwkdYMSZx/5V2NbX8sn1TT
 KDD0p66QyCPNwB2CycMzcmeTbYChZ17EgvyJmWvznR4x7/J+U1L3s4ynEsHX4QqmX4hv
 aMRu9sLOrUqZsCGEJq2TmNLqCncsQK94R871RX6ZAQocNeUZijJqO2mXVU8OIckb0DZv
 R9PDJzUqEdHEdPBJwjHslg/xjjO6FMCNwgxfsPy3wKt1Hl3NODkDT3riDS3B6kSfx9EC
 CGEiTbwlUegt1uOkEPxUn7oT/K999ObG3yvP/AfU/royP06fKr9clBKoj1gVCNc9m8AE qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7sbx088v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 17:14:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7H8qWk001879;
 Tue, 7 Nov 2023 17:14:10 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7sbx0886-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 17:14:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7GxMqC016967; Tue, 7 Nov 2023 17:14:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301snmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 17:14:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7HE8Pg32178502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 17:14:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8E252004D;
 Tue,  7 Nov 2023 17:14:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF3252004B;
 Tue,  7 Nov 2023 17:14:07 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 17:14:07 +0000 (GMT)
Date: Tue, 7 Nov 2023 18:12:42 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, 
 thuth@redhat.com
Subject: Re: [PATCH 2/4] target/s390x/dump: Remove unneeded dump info
 function pointer init
Message-ID: <20231107181242.05f20439@p-imbrenda>
In-Reply-To: <20231107142048.22422-3-frankja@linux.ibm.com>
References: <20231107142048.22422-1-frankja@linux.ibm.com>
 <20231107142048.22422-3-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fy-8yiUstvx4-Vj4pQquizPkkJ_5z9JX
X-Proofpoint-GUID: yBhBl9FY56NqlQ7qLzzRSOC7TrCrALxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_08,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=613
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070142
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Tue,  7 Nov 2023 14:20:46 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> dump_state_prepare() now sets the fucntion pointers to NULL so we only
> need to touch them if we're going to use them.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

I would merge this and the previous patch

> ---
>  target/s390x/arch_dump.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
> index 51a2116515..bdb0bfa0e7 100644
> --- a/target/s390x/arch_dump.c
> +++ b/target/s390x/arch_dump.c
> @@ -448,10 +448,6 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>          info->arch_sections_add_fn = *arch_sections_add;
>          info->arch_sections_write_hdr_fn = *arch_sections_write_hdr;
>          info->arch_sections_write_fn = *arch_sections_write;
> -    } else {
> -        info->arch_sections_add_fn = NULL;
> -        info->arch_sections_write_hdr_fn = NULL;
> -        info->arch_sections_write_fn = NULL;
>      }
>      return 0;
>  }


