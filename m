Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0B754092
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:39:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMjq-0001xe-FT; Fri, 14 Jul 2023 13:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKMjn-0001wx-Uv; Fri, 14 Jul 2023 13:37:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKMjm-0008Fg-8u; Fri, 14 Jul 2023 13:37:51 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EGk8ZE012952; Fri, 14 Jul 2023 17:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xCJgQ7ZDmctwp7f4Pja4cUFWYct6aADbndtLLY5Z7mQ=;
 b=sndClcbSLhSxshgh/KMccDFtddcYZmVxj66E2i9A+k5sX6RbYg4aymINtN2CRpdLIlXx
 Pj+Xm7rEeWjDW0yl8t0JZFVrHcO2Tza+N55BH9V5HVrSbCIRqLzwE2pMOIWGHOb4F/Wk
 jj8BT5eag1VofTA3ijNX4qo16sBWX4z9bPYobKW/bxAzdrz/iKqRzido/BDhYymj7KFm
 ONmfVOnnkJ6yScRctrptqvtlOaFeVdv29zwvQY0kTzSo2FzalEedGlAfcOSOjIjb5MzN
 qqI0bKF7ST4I4Ko/FMnBNbYGF31Vrwfnhp+v5w/WnMShsP4LbPWQ/MHkGN3sfbbaEBf6 aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rua5uhbk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:37:41 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EHQjfs003967;
 Fri, 14 Jul 2023 17:37:41 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rua5uhbjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:37:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ED9O1t007309; Fri, 14 Jul 2023 17:37:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs2a0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 17:37:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EHbdJu393752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 17:37:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8996B5805A;
 Fri, 14 Jul 2023 17:37:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9880058054;
 Fri, 14 Jul 2023 17:37:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 17:37:38 +0000 (GMT)
Message-ID: <1a394fc6-4a64-5e00-5631-eb5a6aa4ce59@linux.ibm.com>
Date: Fri, 14 Jul 2023 13:37:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
 <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
 <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u0yy88JU8vZuSZDnSPmToMsH-YRRnbW_
X-Proofpoint-ORIG-GUID: 8XwTbcpYsaHdloLntLUAvpfR-E858SXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 7/14/23 13:29, Joelle van Dyne wrote:
> On Fri, Jul 14, 2023 at 9:19 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>>
>> I don't know whether we would want multiple devices. tpm_find() usage is certainly not prepared for multiple devices.
> Sorry, "multiple TPM interfaces" here does not mean "at the same
> time". Will clarify the description.
> 
>>
>>
>> Good for the consolidation.
>>
>>
>> Does moving the TIS to a different address help on aarch64?
> That was the first thing we tried and no it doesn't help.

I would remove it if we don't have a known alternative address that makes it work. If we do, I think we should document it in tpm.rst.


>>
>> Can the size really be an option? I don't see it useful and if one gave the wrong size it may break things.
> It was added for consistency (otherwise we have to determine the size
> by looking at the interface everywhere). Also, it is possible for the
> size to be larger than the constant. For example, Apple Silicon uses
> 16KiB page sizes and we may decide to force the device to be 16KiB
> aligned (not sure if this is needed yet while we still track down why
> the dual mapping was not working). In that case, we would need to
> inform the OS of the true region size to prevent any overlap issues.
> Both baseaddr and size should be provided only by the plug handler in
> the virt machine, otherwise things may break even if we get rid of
> size and have just an incorrect baseaddr.
> 
>>
>>
>>

