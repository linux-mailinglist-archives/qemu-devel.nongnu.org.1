Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C57C6DF5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:24:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquju-0001ai-29; Thu, 12 Oct 2023 08:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqujq-0001a3-JD; Thu, 12 Oct 2023 08:24:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1qqujn-0002x9-5E; Thu, 12 Oct 2023 08:24:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CC5asQ023011; Thu, 12 Oct 2023 12:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=T1zZW0XYNhBeAxpakTuWCDw1AaGerAKqBy6mtnFsKAs=;
 b=DnqFOj8i2MeiNjXwU8sHDwjM9YUc9bskgYT0Jo4XuQ58FB0mbNQWR8zEhERexkdCSbm+
 38fkcaCZOLRyhWLiQ1PfGB5T9FYPQGRDF22/RrxHdtRRbqjr+v/YNB1vmheSeWbzZNfY
 JGfBkFNUKBg/WNKfEMdM4b9GIsefSSv+1OIt3P6aiXXQvlmmGLgC9QSOzAzY05AO1DkI
 hIA7TLWKsykiynO5Sx7NP7bhNOWa6bfUylwkbjDpZk6aoFqXWGb7LiKlK0fEnENTbirp
 DI1Y9f1ErLfV3JmtHFvlM74TvRvxJ1TrZq9KPcSi0Qcf/RZTh3t3BJAJ5o5ikklaxiXW yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpe4u8ab0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:24:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CCO99u001227
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 12:24:09 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 05:24:04 -0700
Date: Thu, 12 Oct 2023 17:54:00 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Philippe Mathieu-Daud? <philmd@linaro.org>
CC: <peter.maydell@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 01/12] hw/arm/virt: Avoid NULL pointer de-reference
Message-ID: <20231012122400.GC1130358@quicinc.com>
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-2-quic_svaddagi@quicinc.com>
 <b98e4566-56b4-d0e4-adb2-c163c7c26cfb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <b98e4566-56b4-d0e4-adb2-c163c7c26cfb@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 1ycNBDftLwvoECKe9FQQHKmGbIGVk862
X-Proofpoint-GUID: 1ycNBDftLwvoECKe9FQQHKmGbIGVk862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=461 phishscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120102
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

* Philippe Mathieu-Daud? <philmd@linaro.org> [2023-10-12 06:30:24]:

> Hi Srivatsa,
> 
> (+Markus/Peter for QOM fu)
> 
> On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> > Avoid dereferencing a NULL pointer that its_class_name() could return.
> 
> While your patch is correct, there is some code smell
> around its_class_name(). IMHO a foo_class_name() handler
> should never return NULL.

I saw its_class_name() returning NULL for KVM in some case and took the
same route for Gunyah (as ITS is not supported atm):

const char *its_class_name(void)
{
    if (kvm_irqchip_in_kernel()) {
        /* KVM implementation requires this capability */
        return kvm_direct_msi_enabled() ? "arm-its-kvm" : NULL;
    } else if (gunyah_enabled()) { 
        /* ITS is not yet supported */
        return NULL; 
}

I guess I could have its_class_name() return "arm-gicv3-its" (for Gunyah case)
and set vms->tcg_its to false, which will avoid the NULL-pointer deref I was
hitting.

I will drop this patch in next version in that case.

- vatsa

