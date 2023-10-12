Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD487C6E13
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquls-000450-F7; Thu, 12 Oct 2023 08:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqulq-00044T-IX; Thu, 12 Oct 2023 08:26:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqulp-0003lR-1S; Thu, 12 Oct 2023 08:26:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CBOkQS012128; Thu, 12 Oct 2023 12:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=KF9haHZbYVAj5Ap7V7NXFGuiT7+S1RR3Ap7q5Uo0FRQ=;
 b=VGFvt4/SmJSMfAnf7hMraorCa43h7N8POaw8qUA9v3xVR9vXRrDYl00R4ZkD5yL5/Cvw
 Ia4JzkbHnu+LtZPr3GKoqfRfTjCYaQHUsb7PctynL51Z3ZKmAZWahiOOElj1Huzg6j9a
 O/Y9DLSuf+NOeO6/o3BJFu4TWqubrs2FehMQIRxx/oEA7lVApcMfT10yEvTjcwjXev9q
 6C/uuVZs3xKDhqwEeMQTx9kspLTEhTtj64s3RAEoWi1XZ0rJaueiQK61m8YwxY4WKfMd
 W+y7Iho4vzIQ6zKHfamvUwn+jkaoy/Tg63xTOFhk6iIdesgd8DhRcTyw42a48A91ZdE7 tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpd480cx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:26:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CCQ82U004522
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:26:08 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 05:26:04 -0700
Date: Thu, 12 Oct 2023 17:55:59 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Philippe Mathieu-Daud? <philmd@linaro.org>
CC: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 10/12] gunyah: CPU execution loop
Message-ID: <20231012122559.GE1130358@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-11-quic_svaddagi@quicinc.com>
 <d2287b37-cd40-10ec-e20f-135a9d27e3fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <d2287b37-cd40-10ec-e20f-135a9d27e3fe@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: uDD8Hf-I_jsur0knUDvnyGEjzNiop7zr
X-Proofpoint-ORIG-GUID: uDD8Hf-I_jsur0knUDvnyGEjzNiop7zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=765 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310120102
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

* Philippe Mathieu-Daud? <philmd@linaro.org> [2023-10-12 06:43:38]:

> > -void *gunyah_cpu_thread_fn(void *arg)
> > -{
> > -    CPUState *cpu = arg;
> > -
> > -    do {
> > -        /* Do nothing */
> > -    } while (!cpu->unplug || cpu_can_run(cpu));
> > -
> > -    return NULL;
> > -}
> 
> This diff could be nicer if you define gunyah_cpu_thread_fn()
> in the final place in previous patches, so you don't need to
> move it here.

Sure.

> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index fdcbe87352..b3901e134d 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -240,6 +240,7 @@ typedef struct SavedIOTLB {
> >   struct KVMState;
> >   struct kvm_run;
> > +struct gh_vcpu_run;
> >   /* work queue */
> > @@ -443,6 +444,11 @@ struct CPUState {
> >       /* track IOMMUs whose translations we've cached in the TCG TLB */
> >       GArray *iommu_notifiers;
> > +
> > +    struct {
> > +        int fd;
> > +        struct gh_vcpu_run *run;
> > +    } gunyah;
> 
> NACK. Please declare as struct AccelCPUState in gunyah_int.h.

Ok thanks for that input. Will address it next version.

- vatsa

