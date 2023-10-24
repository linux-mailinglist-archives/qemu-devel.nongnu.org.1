Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB47D51FF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHc3-0004is-LG; Tue, 24 Oct 2023 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvHc1-0004iP-DX
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:38:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvHbz-0006cP-2J
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:38:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OCtlMJ000444; Tue, 24 Oct 2023 13:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AIig77mZrmZXmg+U9zkjqXaKK2Qh7deFujDAQtxgWGA=;
 b=ODADUpTHaZ/g4NwraPDyGgKeaoj4JXMqjFW5z/WGrjcht5wdAsumxfUBRZj9toETLAKw
 nYArkOQMO+U2U190iVAM3w0kdMfshmSTjAPCqStuahrGtsPEqIT7K8TMz8u1JW2aAhQ3
 90j+ltrXvwXSRCGN0VR7bZWXiEwVv3lWtmpFjljErmXL7RVeI3b2fJyfOlBpFgEmPO9V
 V4vFZIZPRqzeh6xtE1MftW63YtVcHCClEfhG0hOdsYYAxfh7K/dYLPTBrOjMoraeKQpp
 IfsiklZzoFEtZLm8hVE2P0boDrLFGzasD5ChixWLcJFKNDZwAaiMNznWAD2l2mhXOitp bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tx43h99cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 13:38:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ODcJcW007059
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 13:38:19 GMT
Received: from [10.251.42.180] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 06:38:18 -0700
Message-ID: <e89e48d2-f0f1-c26c-79e1-964d41e0afd1@quicinc.com>
Date: Tue, 24 Oct 2023 15:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Burton
 <quic_mburton@quicinc.com>
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
 <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
 <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
 <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
 <e2c97f1f-6dca-fe27-debc-19a3f6dcac8a@quicinc.com>
 <CAFEAcA-zjFQMjrfPuFfA5PC-eXZmRyjtnH_Fx1t+C90ECrO_jQ@mail.gmail.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <CAFEAcA-zjFQMjrfPuFfA5PC-eXZmRyjtnH_Fx1t+C90ECrO_jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 0JRFha4eEQVCOLhe7-UjzlDzPS95q_Li
X-Proofpoint-ORIG-GUID: 0JRFha4eEQVCOLhe7-UjzlDzPS95q_Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_14,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxlogscore=648
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

+cc Mark which has a better understanding of our use case.

On 24/10/2023 15:21, Peter Maydell wrote:
> On Tue, 24 Oct 2023 at 13:31, Antonio Caggiano
> <quic_acaggian@quicinc.com> wrote:
>>
>>
>>
>> On 24/10/2023 14:00, Peter Maydell wrote:
>>> On Tue, 24 Oct 2023 at 11:49, Antonio Caggiano
>>> <quic_acaggian@quicinc.com> wrote:
>>> Given that we don't run into this upstream, this leaves me
>>> suspecting that the underlying problem is that a memory
>>> region this big shouldn't be being registered to KVM in the
>>> first place. Certainly the gpex PCI controller works fine
>>> on the arm64 virt board under KVM, so maybe your board code
>>> is doing something odd when it wires it up?
> 
>> I think so, we use a MMIO system_memory, effectively using
>> memory_region_init_io() instead of memory_region_init(). This is for
>> registering our callbacks with a MemoryRegionOps.
>>
>> So, for a MMIO memory type, UINT64_MAX means "real" size rather than
>> "all of the 64 bit address space"?
> 
> For a memory region, in the creation APIs that take a uint64_t
> size argument:
>   * size 0 is (I think) not valid
>   * 1..UINT64_MAX-1 mean "size is that many bytes"
>   * UINT64_MAX means "size is 2^64 bytes"
>   * there is no way to ask for (2^64)-1 bytes
> 
> I am confused about why you say your system_memory is an
> MMIO region with callbacks, though. The system_memory MR
> is expected to be a pure "container" region, which has
> no callbacks and simply is a place where we add other
> subregions (which might be RAM, or IO, or whatever).
> 

We use an MMIO system memory for our ops, which capture memory accesses 
and handle some of them, even though no memory region is actually 
backing the addresses.

Does that means we are violating QEMU's expectations by modifing that 
from "container" to "MMIO"? This issue is just one consequence of such 
violation and there might be more potentially?

> thanks
> -- PMM

Cheers,
Antonio

