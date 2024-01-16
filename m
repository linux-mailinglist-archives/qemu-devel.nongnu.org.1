Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E405F82F58D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 20:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPpGP-00083z-MO; Tue, 16 Jan 2024 14:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rPpGF-00082K-HZ; Tue, 16 Jan 2024 14:38:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rPpGC-0001Ub-02; Tue, 16 Jan 2024 14:38:10 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GJb9T0025927; Tue, 16 Jan 2024 19:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R0OV0b3PDTyf1qbfG8InC0YXFiYixPvXj0CNOhMhcIs=;
 b=Ydn+i+N3BZMQxZUJWWDfk+jiE2hBbV9Tf5hTOkjYrfvTL+DU6txvmX5jKM7J1hBJj4Qr
 b2nt+MMUqS4PC/nXp73Qkm6MkC2JOmAvNn2iSeQF9LrzgRPnTMmlFJMHvr3ZGiAWhY9+
 5Z1N5L6k+BJU2g7d5Q5wqgZzikPySvfXYjX7BggmPa4Fn4B0a17pMFJM3WA+O7NBMBQg
 Gf1XuhAtFWqD4RW7U0wML+9qhnehHEIp5QfBZzLYtezudi+GoaJxZ2cKSn6Zc2MoX+iO
 y9bjHASwdgFH5WaUcKLYo+aK9LAQFlGF+jXjm2pVocRYQgT0Sz2/qzzM83P9HrUCTVIi qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp042r0xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:37:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GJbowi030214;
 Tue, 16 Jan 2024 19:37:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp042r0x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:37:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GJ1l0a019687; Tue, 16 Jan 2024 19:37:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72k0chm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 19:37:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GJbmVF21824096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 19:37:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2E4A5805A;
 Tue, 16 Jan 2024 19:37:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F80558056;
 Tue, 16 Jan 2024 19:37:48 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 19:37:48 +0000 (GMT)
Message-ID: <b8572705-4262-4559-9e6a-d1d74bb3fcb8@linux.ibm.com>
Date: Tue, 16 Jan 2024 13:37:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/9] hw/fsi: Added qtest
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-8-ninad@linux.ibm.com>
 <9f3a6701-512f-4f00-b27f-3a83c55fc24e@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <9f3a6701-512f-4f00-b27f-3a83c55fc24e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pGW1svj_jsMRVcRgl79L7CYBEqdl7v8u
X-Proofpoint-ORIG-GUID: EYaGMa9HHlPAhuJvgzdIEOjFp3jfMiQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=579 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Cedric,

On 1/12/24 10:02, Cédric Le Goater wrote:
> On 1/11/24 00:15, Ninad Palsule wrote:
>> Added basic qtests for FSI model.
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>
> Please remove mu S-o-b.

Removed.

Thanks for the review.

Regards,

Ninad



