Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3791471FDE1
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q516X-0002J2-6f; Fri, 02 Jun 2023 05:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q516R-0002EF-DC; Fri, 02 Jun 2023 05:29:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q516P-0005tw-2S; Fri, 02 Jun 2023 05:29:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3528kDM3000380; Fri, 2 Jun 2023 09:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=c5cSQ5eEJMT5gCdHQFyYmtY+Zcu3ctYRoAttPKpmKQo=;
 b=g/ctjAmTJPOCMSl/FCmFrkJl2WU1MU7mbGguajd764GwYpaNpCgDnegZaVM7PhiDqj4H
 kBFTXuMiLa72Lszx7xN2UNva7Xx3d8rXr9OVOUPRC3f1W7d/QMjTfHVH+Rhn9S27ktJB
 R4RpXGraN3/lZTxOD3KMIDvDwBLDInTUxs2rG2txDv/eB5pPDoLNqyR6FOqmkLi12zHw
 y5Zjdfi766wVkUlgoSz9IHN7N+zcHWp4sDSDAyF81VviVhkaJY8PV4LQS3h9KMXQsOiU
 cvErSrD8rMVatCeEBXb0eQqpGVHDVFbNOG8+Ciku1F2V5qn+DF+Pe2jxvRL0C7apn1R8 zQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyb6f0a93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 09:29:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3529TcNf008178
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 2 Jun 2023 09:29:38 GMT
Received: from qc-i7.hemma.eciton.net (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 02:29:36 -0700
Date: Fri, 2 Jun 2023 10:29:33 +0100
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: Peter Maydell <peter.maydell@linaro.org>, Graeme Gregory
 <graeme@xora.org.uk>, <chenbaozi@phytium.com.cn>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Message-ID: <ZHm2ffBNii1tQkGM@qc-i7.hemma.eciton.net>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
 <ZHjcnHMWM9/Rl9lv@qc-i7.hemma.eciton.net>
 <20408f0d.c9.1887a225830.Coremail.wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20408f0d.c9.1887a225830.Coremail.wangyuquan1236@phytium.com.cn>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: CfGCXJLdESSz6ZaL_x231Ue3UllaArHg
X-Proofpoint-ORIG-GUID: CfGCXJLdESSz6ZaL_x231Ue3UllaArHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=473 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

Hi Yuquan,

On Fri, Jun 02, 2023 at 11:24:11 +0800, Yuquan Wang wrote:
> > > > To skip the migration hazard, my prefernece is we just leave the EHCI
> > > > device in for now, and add a separate XHCI on PCIe. We can drop the
> > > > EHCI device at some point in the future.
> > > 
> > > Why PCIe for the XHCI and not sysbus? At the time the board
> > > was originally added the argument was in favour of using
> > > a sysbus USB controller (you can see Ard making that point
> > > in the linked archive thread).
> > 
> > The original argument was that having the device on the sysbus
> > 1) enabled codepaths we wanted to exercise and
> 
> Sorry, for my poor engineering experience, I am confused about the meaning 
> of "enabled codepaths" here. Is it like a code target that to realize the 
> original purpose of this board ?

It is a bit of a convoluted term.

sbsa-ref isn't a normal platform. We are using it as a vehicle for
developing and verifying common firmware and software for sbsa (or now
SystemReady SR) compliant platforms.

This means that we ideally want it to expose *permitted* but not
necessarily ideal behaviours, so that the parts of software that deals
with those situations get frequently exercised (enabled).
It's code coverage for the hw-interacting pieces of code.

/
    Leif

