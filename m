Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42473A1AF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:14:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK8R-0000OX-5F; Thu, 22 Jun 2023 09:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qCK8N-0000Nd-3K; Thu, 22 Jun 2023 09:13:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qCK8I-0008MR-9X; Thu, 22 Jun 2023 09:13:58 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MCCIIF030984; Thu, 22 Jun 2023 13:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZGSoIy25pJnqEOpdC8Ut6k6utPGKAdGoUXQioCoWhfs=;
 b=sNxeXYOH0FeEvXqOH5TsTaD5yhUiwR5xNauVj5sf8YXIAbJlgkM9qeqJf2PxQkLSENcA
 Ljb/1yJ2hXOvaQrml7KoBEZCs/pxkZTl2NrEDOApKzR/5dvY5IGvQpxtYUpS9ahLhq4D
 DQMVk9DNIVsZwp4myREf6/UF37ucCYBE5ABLiMzEkbH5Pyyo8ka4rYPdXOcgUy/RZ5f+
 /EPVl9w/5prOamSsrF5UEwhaNS00EsULbN+zwXNhOMSe5Yu+mBrWymNcSgLo+5WJmm3r
 CyBmchumEv9bgigXyMO/bnx+5CgQP3Cuhtushv3qWrI1pPnDwfduTBUU8pXhkxewJqh9 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp3jhxp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 13:12:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MDBdeE017269;
 Thu, 22 Jun 2023 13:12:43 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp3jhxjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 13:12:42 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M2IchL030142;
 Thu, 22 Jun 2023 13:12:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5bfqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 13:12:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35MDCXHR8061562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 13:12:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFF9B20040;
 Thu, 22 Jun 2023 13:12:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F97620043;
 Thu, 22 Jun 2023 13:12:33 +0000 (GMT)
Received: from [9.171.62.26] (unknown [9.171.62.26])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jun 2023 13:12:33 +0000 (GMT)
Message-ID: <7609d599-88e6-00a6-3ee0-fe203194e12f@linux.ibm.com>
Date: Thu, 22 Jun 2023 15:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pc-bios/s390-ccw/Makefile: Use -z noexecstack to silence
 linker warning
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20230622130822.396793-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230622130822.396793-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wKPdKtTC7NNRKB7v1di4NYm3suf9_jAd
X-Proofpoint-GUID: cxHsv_s4oJHbhToi4h0ud9BE6hpnDA3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_09,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Am 22.06.23 um 15:08 schrieb Thomas Huth:
> Recent versions of ld complain when linking the s390-ccw bios:
> 
>   /usr/bin/ld: warning: start.o: missing .note.GNU-stack section implies
>                executable stack
>   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in
>                a future version of the linker
> 
> We can silence the warning by telling the linker to mark the stack
> as not executable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 2e8cc015aa..acfcd1e71a 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -55,7 +55,7 @@ config-cc.mak: Makefile
>   	    $(call cc-option,-march=z900,-march=z10)) 3> config-cc.mak
>   -include config-cc.mak
>   
> -LDFLAGS += -Wl,-pie -nostdlib
> +LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
>   
>   build-all: s390-ccw.img s390-netboot.img

In the end this should not matter as the resulting binary is not loaded by an
elf loader so this should be fine
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

