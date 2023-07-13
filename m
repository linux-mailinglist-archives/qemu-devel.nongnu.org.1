Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F1752A6C
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK1IH-00081t-Du; Thu, 13 Jul 2023 14:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK1IF-00081U-Es
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:43:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK1ID-0003h0-7s
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:43:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DILk3t000484; Thu, 13 Jul 2023 18:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DMZ73jwF9m2Bg535ojeQrVRcl6w9XWA0TbtuE+McojU=;
 b=iW2HEI/If/zCgP2tgOUtLN5LuCb8IuCj2A6JbVNtwpme8s3JGUQ3la+abvwZ7cVNsnjQ
 7oQx8S5rcS/FwTus4xnVIeDLFD9fDCkrT9Kgjekc+BjqxI8PRqw0dASNsuHdPO+lg3pn
 vV3WgO1qDJTt0i3rj3NrySNrn+tvAIlwGc2kP2v+pX90TDWndb+xbSVVwdRolDJ9qG1f
 qsl56yEoM53lL5/KDyZlNtknyw1EoFoV9fB7NAqaXljCT43G312dGAhi7KXFPBjtYwwM
 CvZwtjgyqUmFLFlnfn1PY+CJGYu+wCxZyclaXpdduIuinjguZMcOX9sbJAdOLr35Xh1g eQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtpfx8hf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:43:52 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DH0CCt014052;
 Thu, 13 Jul 2023 18:43:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rpye61ucv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:43:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DIhorb41484764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 18:43:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 169DA58056;
 Thu, 13 Jul 2023 18:43:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C529658052;
 Thu, 13 Jul 2023 18:43:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 18:43:49 +0000 (GMT)
Message-ID: <de9befdf-82ea-6cff-e300-7a9edf3e867b@linux.ibm.com>
Date: Thu, 13 Jul 2023 14:43:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
 <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
 <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OJhv8vMcQZ6JJUEzoJ1G3PK9OP5eBHbb
X-Proofpoint-ORIG-GUID: OJhv8vMcQZ6JJUEzoJ1G3PK9OP5eBHbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/13/23 13:18, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 18:16, Stefan Berger <stefanb@linux.ibm.com> wrote:
>> I guess the first point would be to decide whether to support an i2c bus on the virt board and then whether we can use the aspeed bus that we know that the tpm_tis_i2c device model works with but we don't know how Windows may react to it.
>>
>> It seems sysbus is already supported there so ... we may have a 'match'?
> 
> You can use sysbus devices anywhere -- they're just

'anywhere' also includes aarch64 virt board I suppose.

> "this is a memory mapped device". The question is whether
> we should, or whether an i2c controller is more like
> what the real world uses (and if so, what i2c controller).
> 

> I don't want to accept changes to the virt board that are
> hard to live with in future, because changing virt in
> non-backward compatible ways is painful.

Once we have the CRB sysbus device we would keep it around forever and it seems to
- not require any changes to the virt board (iiuc) since sysbus is already being used
- works already with Windows and probably also Linux


    Stefan

> -- PMM

