Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C377FD1B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 19:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWgw3-0007aF-5b; Thu, 17 Aug 2023 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qWgw0-0007ZE-BK
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 13:37:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qWgvx-0003fQ-QL
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 13:37:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HHWks7020149; Thu, 17 Aug 2023 17:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5bjTbuPyCO9+W0mvNBOHESjsU9qnBfQc4HhNOck3ul8=;
 b=Mb94bJwVkh1W8Giqm4IAa/nMFLiuG3rzKjmcxycTL8eAvjs8h8oFTZnaUoD8Ubec73J6
 a6xXCoCFP1iFHW+BkHNgZqMMRr5bh+GVD7B7stnz6pER80nQTFHP7zLsGWA4mtCg0rCN
 QzrX0Qj1ZFJgYeDDDO+lRo4xilUwv278cP0CbO1zCetoMk8uIvHGF2tKbHuIgBAXwsFr
 7oL3PJKXToiQHa2aOeekLzF4WsbmIbZ+z9cpISGBg+6/n7Iry/NA3sUeBevvHdjL8+1Y
 KwZTFlvdUyxFoPsQUuM5vKJwAcgBp5Bw3p+ZCMkHvqW1LsSYGi0/3INlVDRHPsfzLk7H jA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shr1xg23v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 17:37:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HHaEta030746;
 Thu, 17 Aug 2023 17:37:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shr1xg21r-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 17:37:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HGYBNd007836; Thu, 17 Aug 2023 17:08:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkqmp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 17:08:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37HH8exd61145558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 17:08:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59E4120043;
 Thu, 17 Aug 2023 17:08:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1326020040;
 Thu, 17 Aug 2023 17:08:40 +0000 (GMT)
Received: from heavy (unknown [9.171.85.44])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Aug 2023 17:08:39 +0000 (GMT)
Date: Thu, 17 Aug 2023 19:08:38 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: Re: [PATCH 0/6] linux-user: Rewrite open_self_maps
Message-ID: <huvkvaxpwvbn6zyeso6apdbfdeld6puh4jabllj763p5cc7son@b65vpdotn7mt>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nV4yJE6QZqto-vYeF3jhvKcuhDieDIZQ
X-Proofpoint-ORIG-GUID: rSqTw-CHtl14fPXjdBtmJ_Tjp7HqOhpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_12,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=949 bulkscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Wed, Aug 16, 2023 at 11:14:31AM -0700, Richard Henderson wrote:
> Based-on: 20230816180338.572576-1-richard.henderson@linaro.org
> ("[PATCH v4 00/18] linux-user: Implement VDSOs")
> 
> As promised, a rewrite of /proc/self/{maps,smaps} emulation
> using interval trees.
> 
> Incorporate Helge's change to mark [heap], and also mark [vdso].
> 
> 
> r~
> 
> 
> Richard Henderson (6):
>   util/selfmap: Use dev_t and ino_t in MapInfo
>   linux-user: Use walk_memory_regions for open_self_maps
>   linux-user: Adjust brk for load_bias
>   linux-user: Show heap address in /proc/pid/maps
>   linux-user: Remove ELF_START_MMAP and image_info.start_mmap
>   linux-user: Show vdso address in /proc/pid/maps
> 
>  include/qemu/selfmap.h |   4 +-
>  linux-user/qemu.h      |   2 +-
>  linux-user/elfload.c   |  41 +--------
>  linux-user/syscall.c   | 194 +++++++++++++++++++++++++----------------
>  util/selfmap.c         |  12 +--
>  5 files changed, 131 insertions(+), 122 deletions(-)
> 
> -- 
> 2.34.1

As expected, this improved the situation with mappings on ppc64le.
Handling the errors from read_self_maps() is also a nice addition.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

