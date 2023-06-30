Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C97435C9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8b1-0007s4-FO; Fri, 30 Jun 2023 03:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qF8aw-0007rB-QX; Fri, 30 Jun 2023 03:31:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qF8as-000384-JA; Fri, 30 Jun 2023 03:31:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U7CTnL012746; Fri, 30 Jun 2023 07:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Dxyl6rXjCI/bt0gbqWnmiZVEjb16oPkT8s8Hc0UgDiI=;
 b=Zc5bTsG+ZWDWNRNFqGFn/GDBymxVeFMpy09/2bf7nOyBqFgZPwGZPN5EhI8VCFk0pGIn
 qRTKYuY4vMGxt1522UYMkorrbnTFG6W54dH5bBAGsquXG+4YtWNjV9yqDusyRMZBcLkM
 ya/52mwy0ooKMUNfVn0ffHhHy5RQ8UhvtyxlrN0rQVOokHcG6Y65UvNoqPFR+hUmgpsU
 vgg3VqWbLFuJCFEuSJAMfBy+hFeuXcfhr1SGg/gCwq4mlGEfcoLQ1QZAIln/z0CGOvnG
 fc6EjIoDRBHtisFs5FSM3midJEHLLYUU8W9RejE2UnJBbfP5AO45rFo8ehEl5gKpneIH Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rht3es2pk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 07:30:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U7DSnp016831;
 Fri, 30 Jun 2023 07:30:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rht3es2nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 07:30:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U7MmMm002236;
 Fri, 30 Jun 2023 07:30:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr4541be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 07:30:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U7UgEh22676016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 07:30:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDC3120043;
 Fri, 30 Jun 2023 07:30:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BD1720040;
 Fri, 30 Jun 2023 07:30:42 +0000 (GMT)
Received: from [9.171.74.60] (unknown [9.171.74.60])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 07:30:42 +0000 (GMT)
Message-ID: <da80494b-0626-62f5-65b7-1e4b0901ee27@linux.ibm.com>
Date: Fri, 30 Jun 2023 09:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] ppc/pnv: Add P10 quad ops
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-4-joel@jms.id.au>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230630035547.80329-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 91wk8FNWi0dfZZvBGuiE6gnXjIRIv7Wj
X-Proofpoint-GUID: IeT032CU4hd1ngaSAZlg3-dwhA2u4XDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_04,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 30/06/2023 05:55, Joel Stanley wrote:
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b9a57463aec4..7fff2fd9e298 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c

> +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
...
> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,

                                          ^^^ reading

I'm guessing we'll need to flush out that function pretty soon, so not 
worth resending.

   Fred

