Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE47C6E29
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqutD-0000SR-GL; Thu, 12 Oct 2023 08:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqut3-0000RG-RL; Thu, 12 Oct 2023 08:33:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqut0-0005Po-HF; Thu, 12 Oct 2023 08:33:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CBvXfV032368; Thu, 12 Oct 2023 12:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=xIhpmmI5C2VUd4R1fM9PEnaojoOJBcr3d/1t46H8pX8=;
 b=ODW0gUTOUEXbVDSiV2XDERJHxgxk85R9+/pcgNZFHJmfLsSRL4j8Ao5BBasgNxviKp8b
 ZecnJZ9RpRmmbPfJaD+zPiy/uaUQ9QgmBkISSmvje82/6m2mZqzlsXM0jRFPw9Tf5/C9
 2BNzaSSZvWWOaF45kEvfU84jGuhzYA942NtkFznJIB91vbVuGDL3Xc9Xj6iBROY8MQqW
 a4NBz87tPZHClLti80E2+SOGoL0WA0P9Acl4FbwZBlpD72B/aQLocGw+DK4VYmIrXqww
 L1lb0fLEpuHaqISRah3V36Iy3Q2mDGQzpvDlPbpGx5gTJ6EMLuRiba26qfvCICtJTLWe rQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpesu07j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:33:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CCXl7J013068
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:33:47 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 05:33:42 -0700
Date: Thu, 12 Oct 2023 18:03:38 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Philippe Mathieu-Daud? <philmd@linaro.org>
CC: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>,
 Brian Cain <bcain@quicinc.com>, Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: [RFC/PATCH v0 12/12] gunyah: Documentation
Message-ID: <20231012123338.GF1130358@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
 <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: hmKur1IsMjO69xXMxOGHcj06uzUkYzl2
X-Proofpoint-GUID: hmKur1IsMjO69xXMxOGHcj06uzUkYzl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=663 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

* Philippe Mathieu-Daud? <philmd@linaro.org> [2023-10-12 06:52:04]:

> > +Limitations
> > +-----------
> > +
> > +Below features are not yet supported.
> > +
> > +* virtio-pci (support for which in Qemu seems to rely heavily on KVM, which
> > +  needs to be made multi-hypervisor friendly).
> 
> Is QUIC interested in working on that? My work introducing
> AccelCPUState to make CPUState accel-agnostic was done in that
> direction, but I didn't notice much interest in the community
> so I unprioritized it.

Hi Phil,
	We do want to see Gunyah support merged in Qemu at the earliest (as soon
as the kernel driver is merged upstream that is), so any dependent change in
Qemu for Gunyah would be of much interest to us! I am not sure though if Quic
can sign up for the entire "make cpustate accel agnostic" work. Can you point
to your ongoing work that I could take a look at? Would that address virtio-pci
becoming accelerator agnostic? 

Thanks!
vatsa

