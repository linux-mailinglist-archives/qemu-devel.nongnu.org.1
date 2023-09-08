Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A77988D0
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecVp-00010a-LK; Fri, 08 Sep 2023 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qeXwa-0005hy-Dv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:38:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qeXwX-0000MV-J0
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:38:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3888pStr030342; Fri, 8 Sep 2023 09:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : mime-version : content-type;
 s=qcppdkim1; bh=0INLlobr04Ag/I75bHAvI82xtr9bU6I6qcfC6+5/iew=;
 b=hNzHAhb9d3Ui6gVnbTlO3kf/Iiksvk/xVDFRLnRjvS7bRQU5lUByLHYtpa2nxqDKwHIE
 7PatYjO8lco/Jv1jbU2ptCnHA1lNuAPKVxi3q1jczt8HN0jd4x/39oJ3Ug/gWWWMkX0r
 ryyjMtfgOHxss7JOyRTSbaPgye4DltWn4bSLMnleMfX7nHGX4bL5QpKTUlRP6uOct244
 ddKm6UohhaGsQW4q5A2053uHZuG25BtJrkuVpDXn5HQSrN2QLxCcYu7d7tV6ELOdx2wA
 DbHIWJXfMirHZK+H+wxDSyv24Gy0eIbkzpRf9Z4+zP/4iGEfeet1FXkB+vR0PfaQn5Q0 pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy7m0ka8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 09:38:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3889cLI6007817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 8 Sep 2023 09:38:21 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 02:38:19 -0700
Date: Fri, 8 Sep 2023 15:08:16 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <quic_tsoni@quicinc.com>,
 <quic_eberman@quicinc.com>
Subject: virtio-pci support for non-KVM hypervisors?
Message-ID: <20230908093816.GA552050@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: AzS4R3GydN-Qlns9PbH6r0GLgE3sSuxF
X-Proofpoint-ORIG-GUID: AzS4R3GydN-Qlns9PbH6r0GLgE3sSuxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=482 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080088
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
X-Mailman-Approved-At: Fri, 08 Sep 2023 10:31:05 -0400
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

I was looking to add support for a Qualcomm hypervisor (Gunyah [1]) in Qemu 
and intend to publish the RFC patches soon. I noticed that
hw/virtio/virtio-pci.c seems to support only KVM (esp related to use of IRQFD).
Is there any efforts underway to make it support other hypervisors? I wanted to
refer any such ongoing work (if it exists) and build on top of it for adding
Gunyah hypervisor support.

Thanks!
vatsa

1.
https://lore.kernel.org/lkml/20220223233729.1571114-1-quic_eberman@quicinc.com/

