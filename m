Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8587261B3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tZb-0001uW-1Z; Wed, 07 Jun 2023 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q6tZY-0001uC-Oh; Wed, 07 Jun 2023 09:51:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1q6tZU-0006uB-AT; Wed, 07 Jun 2023 09:51:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357Dj9nh016993; Wed, 7 Jun 2023 13:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5mlYdVz3VMTfxFuVyOHu7K4tjNRYRKR6RUzJF6wZj+o=;
 b=PfmxkGXEdcqDNMZqcE9AFoHWnSMdFeSPsapytOEfQrNk7XfTBsJeCHkZJxRcnPLlmlmT
 KLhk2xfynYthbxYBlOV0QgxTTK1OdVdgT4nH5HFe5eFFI2nC7djGipTOnVsQl68+6yQB
 SPNxytRAWqyqja4SLF/Bvk+wSO16LCfbM9LvinwHOhejvkf1NyRS/TSpOVtfW4QTuOoN
 M7gAlJSvbzMnIKFME0ApcWvaix2bafIOaC1MFf0Tdimx1dPmGPkvj/AHs1yMtWQaNDWt
 Msy7A1vb5azhftNPtEqifZL4O9Hdn9KsfQPcwegTPPvOsM4sioBUvQEE6SczWuyVdnrF 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2u2285rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 13:51:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357DlJ7L023353;
 Wed, 7 Jun 2023 13:51:19 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2u2285r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 13:51:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 357CBitI022008;
 Wed, 7 Jun 2023 13:51:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3r2a77uw4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 13:51:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 357DpHjd21299908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jun 2023 13:51:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E2B05806B;
 Wed,  7 Jun 2023 13:51:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A025558059;
 Wed,  7 Jun 2023 13:51:16 +0000 (GMT)
Received: from [9.61.27.227] (unknown [9.61.27.227])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Jun 2023 13:51:16 +0000 (GMT)
Message-ID: <daeff323-6df9-f7c7-07fe-b4af30a6ab73@linux.ibm.com>
Date: Wed, 7 Jun 2023 09:51:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] block/file-posix: fix g_file_get_contents return path
Content-Language: en-US
To: Sam Li <faithilikerun@gmail.com>, qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, stefanha@redhat.com,
 hare@suse.de, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20230604061658.49004-1-faithilikerun@gmail.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230604061658.49004-1-faithilikerun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8j17LgjpdT6f5azzHFCzAf9r_bbpSso0
X-Proofpoint-ORIG-GUID: 6tGBNF0KkJ9RWLlDnarI-mDwpeoPX7Jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070114
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/4/23 2:16 AM, Sam Li wrote:
> The g_file_get_contents() function returns a g_boolean. If it fails, the
> returned value will be 0 instead of -1. Solve the issue by skipping
> assigning ret value.
> 
> This issue was found by Matthew Rosato using virtio-blk-{pci,ccw} backed
> by an NVMe partition e.g. /dev/nvme0n1p1 on s390x.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Also tested to verify that this fix resolves the reported issue.  Thanks!



