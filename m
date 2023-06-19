Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4554F734FC4
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB7M-00073K-KX; Mon, 19 Jun 2023 05:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7K-00072I-6H
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qBB7I-0003Hh-I9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:24:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35J9HWax026657; Mon, 19 Jun 2023 09:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=VYJ/Ad+dhUbqQk6jRJYGEh6QKQzIceYRPl3sUv54cGs=;
 b=oIh9Gs0ri91x7XJT938UFvIWmkfCzIRVIFDWwUYYpuavBRWy2kSJpbME+ma92bbF+j/h
 NDeyplLrUghT+klZYfqj7//ZO5qPB6uWCtl5rOuXoWd9Zw8At1VKyhU0Dom0fJCXSH66
 xzDs+a5Y3RYt+XNeXZfDck6709OUa7Y9JAD4ZbrFYTSfoyou3mNHg5JG3c8DWvuygKZu
 wiekpF+GmW2mqfjjLiPXSFbv2DzBA5t+eJGL04bgWhvoJHk0UweMOoeD3MR0S5fai5m5
 ogun3Bw9M5IPKpriA52soGWlY7reVHo03ur1PzX3IE98pJ4+2Gm1vqffJjwuEnjGyrEf Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ram8k84af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:06 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J9O6vU019486;
 Mon, 19 Jun 2023 09:24:06 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ram8k849y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J0ld3H028392;
 Mon, 19 Jun 2023 09:24:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r94f58y1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jun 2023 09:24:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35J9O1Rc25297526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jun 2023 09:24:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 359F020040;
 Mon, 19 Jun 2023 09:24:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CAA62004E;
 Mon, 19 Jun 2023 09:24:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jun 2023 09:24:00 +0000 (GMT)
Date: Mon, 19 Jun 2023 11:18:23 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Zhangjin Wu <falcon@tinylab.org>, Markus
 Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 3/6] util/async-teardown: Fall back to close fds one
 by one
Message-ID: <20230619111823.17960b3a@p-imbrenda>
In-Reply-To: <20230617053621.50359-4-bmeng@tinylab.org>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-4-bmeng@tinylab.org>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: atLrg-zJiCcg9rpaWSVMFZtyV4Hwzspq
X-Proofpoint-GUID: HHjinMoWpLBo-vhEyGXn4NBBgqPOEOrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=822 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306190081
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
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

On Sat, 17 Jun 2023 13:36:18 +0800
Bin Meng <bmeng@tinylab.org> wrote:

> When opening /proc/self/fd fails, current codes just return directly,
> but we can fall back to close fds one by one.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - new patch: "util/async-teardown: Fall back to close fds one by one"
> 
>  util/async-teardown.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 3ab19c8740..7e0177a8da 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -48,7 +48,11 @@ static void close_all_open_fd(void)
>  
>      dir = opendir("/proc/self/fd");
>      if (!dir) {
> -        /* If /proc is not mounted, there is nothing that can be done. */
> +        /* If /proc is not mounted, close fds one by one. */
> +        int open_max = sysconf(_SC_OPEN_MAX), i;
> +        for (i = 0; i < open_max; i++) {
> +                close(i);
> +        }
>          return;
>      }
>      /* Avoid closing the directory. */

a few patches later, you replace the whole close_all_open_fd() with a
generic version, I don't see a point in changing the code here.

this patch is useless, just drop it

