Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4507E5259
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:04:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0eTL-0000bE-Am; Wed, 08 Nov 2023 04:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r0eTH-0000aq-A5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:03:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r0eTE-0001iv-Jf
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:03:35 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A887psG018961; Wed, 8 Nov 2023 09:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qB26D14MNsz4kPUNllRMeyOW9ZZ1NSrOdLhUnOa+ysQ=;
 b=QffMNFd3MPJZllixUtZr038Vb2OQcSRBvjvJlp1hhvrzd53skcjxkgINBE4GzQGX1zSt
 Tz0x9iYoV1m+ifBf3xAfWzliKAPfecYK9K6n5O1rU/RBUQan2f2/zj1Nd38Q2joalGk5
 uedtknImIGIpIAX2ggf4cv7YNAIqD3ZMJUY5XrGtPJEFx1K4Is+PoFZsCx6qWZ2haXpo
 c3U7evFO6HZTspMQmBuY159PTKobByzvJwI+zLqW1o0Giu/i+e1C/SARCYdAN8v1TVbt
 QJYLR4dBTcoUKMpmiqLuN2hKmqPE/KssQ47a5EjX6BhZGr53hqdm0iXKHzoUnYtE8/in kA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2bs5bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 09:03:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A893BBw016668
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 8 Nov 2023 09:03:11 GMT
Received: from [10.111.130.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 01:03:09 -0800
Message-ID: <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
Date: Wed, 8 Nov 2023 10:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Virtio GPU features status & roadmap?
To: Hans de Ruiter <hans@keasigmadelta.com>, <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
Content-Language: en-US
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: FvOqA2mJcin8-ewtq6oZAqWPKSpWHY2H
X-Proofpoint-ORIG-GUID: FvOqA2mJcin8-ewtq6oZAqWPKSpWHY2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=455 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Hans,

+cc Gert and Dmitry

On 17/10/2023 02:48, Hans de Ruiter wrote:
> Hi,
> 
> I'm working on Virtio GPU drivers for AmigaOS, and would like to know 
> what features are currently stable enough to use. Looking at the master 
> QEMU branch, both Virgl and blob resources are supported, but NOT at the 
> same time. Is the ability to use both simultaneously coming soon?
> 

Mmh, well, they should be compatible, I'll try sending a patch.

> Also, what's the state of Venus/Vulkan support? Surveying various 
> forks/branches, it looks very experimental and subject to change.
> 

I believe this is quite stable now: 
https://gitlab.freedesktop.org/virgl/venus-protocol/-/issues/5

Virglrenderer 1.0.0 has been released as well. I wonder if that requires 
any change in QEMU. Gert or Dmitry might know the answer.

> I have the added difficulty that the AmigaOS Picasso96 driver API 
> expects direct CPU access to all of VRAM, and likes to peek/poke 
> directly into the bitmaps. That's clearly not possible without blob 
> resources, or shared memory (not entirely sure what the shared memory 
> feature is for). This is why I want to know what features are stable or 
> coming soon.
> 

The shared memory feature is just a requirement which enables support 
for blob resources.

> regards,
> Hans
> 

Cheers,
Antonio

