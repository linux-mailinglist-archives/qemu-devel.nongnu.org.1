Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50853752C16
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3pd-0004tq-W7; Thu, 13 Jul 2023 17:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3pZ-0004rT-GI
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:26:33 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3pX-0005Xs-Od
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:26:33 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DInO3f006085; Thu, 13 Jul 2023 22:26:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=xW3GCjcs6HVx0g5Ra9JycPpbngXBhjC83FXKgFvxecQ=;
 b=R6Rt+skDMmNiiveM8qsNHhChkIVD8z+phyapnf9bO+6iSJFSM4sGPlwivOY31D9b43PL
 gEuMjLAk+eUYivghFsTKW53qgbxHxuwn4d/ynlDMBTcMTMNSsv3ReJV2vhhkDzQBRoZV
 MQnz870S+9WHIDBDeGgPwDV0/ZMDHZzH3K7p09rdU45Qww/VluML7H4xjOV6YqfqsCuS
 i6+e/B0qCdqYSZTWPI2mdcWVZY5rGF+kAdglk4hGjrrfieRuBFmLA3I+FqoBrE1NaD6W
 0BEu3HLcMzkAxWY5Z68NHuRKV+3OERpdUOqwwodCy21QnLU9jF0auklCpyhlFQ4cWTLt Pg== 
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3rtpvuu2g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 22:26:29 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DImX9L007213; Thu, 13 Jul 2023 17:26:29 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3rtpv4gn1f-1;
 Thu, 13 Jul 2023 17:26:29 -0400
Received: from [172.19.65.70] (unknown [172.19.65.70])
 by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 7C3D03D7;
 Thu, 13 Jul 2023 21:26:28 +0000 (GMT)
Message-ID: <98ec3d30-a3d3-6b52-13bd-566672373819@akamai.com>
Date: Thu, 13 Jul 2023 16:26:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 0/2] migration file URI
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=936
 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130189
X-Proofpoint-GUID: KMprWxlIFm3kA2iQ-nwyhCuoWagHMu--
X-Proofpoint-ORIG-GUID: KMprWxlIFm3kA2iQ-nwyhCuoWagHMu--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501
 mlxlogscore=823 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307130189
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>

On 6/30/23 09:25, Steve Sistare wrote:
> Add the migration URI "file:filename[,offset=offset]".
>
> Fabiano Rosas has submitted the unit tests in the series
>    migration: Test the new "file:" migration
>
> Steve Sistare (2):
>    migration: file URI
>    migration: file URI offset
>
>   migration/file.c       | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
>   migration/file.h       |  14 +++++++
>   migration/meson.build  |   1 +
>   migration/migration.c  |   5 +++
>   migration/trace-events |   4 ++
>   qemu-options.hx        |   7 +++-
>   6 files changed, 133 insertions(+), 1 deletion(-)
>   create mode 100644 migration/file.c
>   create mode 100644 migration/file.h
>

