Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFB73B5DF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 13:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCeg7-00066V-G5; Fri, 23 Jun 2023 07:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qCeg4-000663-Ty; Fri, 23 Jun 2023 07:10:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qCeg1-0006MM-Bl; Fri, 23 Jun 2023 07:10:08 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35NB6Ye1024018; Fri, 23 Jun 2023 11:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=XmAZ8cc5b2EXGWieN/PrdrwHPu2qLE4JDYw+z6mv4mU=;
 b=rufKPAjh+x/NP0KfoMGrVB/VVv8SCUhRUW4bUlqdwALTwiD6vPnHcMFynwk0xWlln4L5
 ukH/S2PAcQTNk3IqX84rS/5xaP5tfwVVHyDdg6dKtFNkMbOk2cV5VH3sc3Kp896/RWe8
 KWursLGM/yBwwAjkAdZ9CnSulZaAy0yPaDFVH1vwVbXZpZocVbo9lkCDraOrgNthrJgI
 +bGi7DqXfrmz8/FuqW8PGqhZrUEfRe7K288eyK9jOvVSCbEBJwvbVH/FMOf6vIpYA/br
 AqZ47w6pITc6PnAygtbMsf+RkUk1ivooFtygT1CcS8WrYhNjuK+N5WAai8t59E5Df3T2 XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rda1f08xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 11:09:59 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NB6pt5026230;
 Fri, 23 Jun 2023 11:09:59 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rda1f08wq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 11:09:59 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N3ejZh005979;
 Fri, 23 Jun 2023 11:09:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3r94f5jf57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 11:09:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35NB9uDl54854014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 11:09:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A47345807C;
 Fri, 23 Jun 2023 11:09:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E300C58080;
 Fri, 23 Jun 2023 11:09:53 +0000 (GMT)
Received: from [9.171.59.40] (unknown [9.171.59.40])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jun 2023 11:09:53 +0000 (GMT)
Message-ID: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2023 16:39:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H8KlkDoSrlM7DjXHc6b6kJ2dH8McKSVl
X-Proofpoint-ORIG-GUID: PLe6jNHzTvv30XVJQTnpfrMcJM1dccrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_05,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230100
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEXHASH_WORD=1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi everyone,

I was trying to boot rhel9.3 image with upstream qemu-system-ppc64 -smp 
2 option and observed a segfault (qemu crash).

qemu command line used:

qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none 
-nographic -machine pseries -cpu POWER10 -accel tcg -device 
virtio-scsi-pci -drive file=/home/rh93.qcow2,if=none,format=qcow2,id=hd0 
-device scsi-hd,drive=hd0 -boot c

After doing a git bisect, I found the first bad commit which introduced 
this issue is below:

[qemu]# git bisect good
20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
commit 20b6643324a79860dcdfe811ffe4a79942bca21e
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Dec 5 17:45:02 2022 -0600

     tcg/ppc: Reorg goto_tb implementation

     The old ppc64 implementation replaces 2 or 4 insns, which leaves a race
     condition in which a thread could be stopped at a PC in the middle of
     the sequence, and when restarted does not see the complete address
     computation and branches to nowhere.

     The new implemetation replaces only one insn, swapping between

             b       <dest>
     and
             mtctr   r31

     falling through to a general-case indirect branch.

     Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

  tcg/ppc/tcg-target.c.inc | 152 
+++++++++++++----------------------------------
  tcg/ppc/tcg-target.h     |   3 +-
  2 files changed, 41 insertions(+), 114 deletions(-)
[qemu]#

Can someone please take a look and suggest a fix to resolve this issue?

Thanks in advance.
Regards,
Anushree-Mathur


