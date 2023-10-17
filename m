Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA207CBEFC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 11:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsgHC-0003AF-Dk; Tue, 17 Oct 2023 05:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qsgHA-00039k-GB; Tue, 17 Oct 2023 05:22:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qsgH8-0007uR-QF; Tue, 17 Oct 2023 05:22:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39H9FfxN011546; Tue, 17 Oct 2023 09:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=1qeGk3zhOotevqJQGHJ9RRK/VZ2RvlFuBdV8SDV82vQ=;
 b=P/tZAmraBZnlOxmOAwLMD0aYomCiuHVY18xgpRWpaI/yQ4pP7V9vTEi1oCZSbIHgJSCj
 YkMXOKNiohubfDSGTljHokY0Uo7pctzv3y5nksFg375ljZU1He2eLJJx+3jI+qRngwih
 66tMirlSUjX/MPeujnZSzaCeoL5gp/UCSMFsf0KaM0FnuezLHwPet8ocnBj+u6Q4Ua5m
 Gc8EtcwuFGr8JIP3oTbzyT9nvdtXrt55NhtHaHXgu9CjC59cn7tbTJOBXzMIDgOIgGf5
 vR7MZ3/zu1wR7aIGMJ7ySqqgUFdngQyPuN6rq/9ooSiRSw9PP58OerkOwr11kX21M4NH 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts85ft5m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 09:22:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H9M1bS006999
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 09:22:01 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 02:21:56 -0700
Date: Tue, 17 Oct 2023 14:51:52 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Alex Benn?e <alex.bennee@linaro.org>
CC: Philippe Mathieu-Daud? <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>,
 Brian Cain <bcain@quicinc.com>, Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: [RFC/PATCH v0 12/12] gunyah: Documentation
Message-ID: <20231017092152.GA689217@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
 <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
 <20231012123338.GF1130358@quicinc.com> <87ttqvnazo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <87ttqvnazo.fsf@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: r49WL8qdl2RfA9U_0HwWVH1AxBB9rjzK
X-Proofpoint-GUID: r49WL8qdl2RfA9U_0HwWVH1AxBB9rjzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=518
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Alex Benn?e <alex.bennee@linaro.org> [2023-10-12 15:55:59]:

> > Hi Phil,
> > 	We do want to see Gunyah support merged in Qemu at the earliest (as soon
> > as the kernel driver is merged upstream that is), so any dependent change in
> > Qemu for Gunyah would be of much interest to us! I am not sure though if Quic
> > can sign up for the entire "make cpustate accel agnostic" work. Can you point
> > to your ongoing work that I could take a look at? Would that address virtio-pci
> > becoming accelerator agnostic?
> 
> Why wouldn't virtio-pci be accelerator agnostic?

I checked usage of few KVM APIs in virtio-pci.c. I think most of them are to do
with use of MSI and IRQFD. If lets say we are not supporting MSI, then I *think*
current virtio-pci should work just fine. It would use virtio_pci_notify ->
pci_set_irq -> .. -> qemu_set_irq, which should land in
gunyah_arm_gicv3_set_irq [Patch 7/12] AFAICT. Let me try getting virtio-pci
working and then I can update this thread again!

- vatsa

