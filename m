Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D205271F14A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4maw-00016C-Ea; Thu, 01 Jun 2023 14:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q4mas-00015h-CX; Thu, 01 Jun 2023 14:00:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1q4maq-0005h5-1m; Thu, 01 Jun 2023 14:00:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351HnXrL020297; Thu, 1 Jun 2023 18:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=nr9w0MeK2BLdjFCVRvzFEMcHC14LSHDWOJGwLGvOafE=;
 b=kvx67tZ68IKk+H01q4zII2UJhklz++N5/4ja5axcvedCoZmT/+ksA2q46YdhWn7I4CGJ
 p0HAxYmGLBNZ8fIw4O3LZC/9Pzedx6gQHSNotqbEUgNZAQo6Ld4tuMH3YD8DZMFFUywN
 XkVmEybOIr1nhmTxIPL3oytsBESa0zVbNs2Haq5O7QapS6j8XrYb2agiv/8n6AqKS9Y3
 jvLI2vvdNzrmPqPylpBqS62cAFRUlTd0bYOn+PmeaeOoH8mYuSfQz25OzTBw8ZF5Yd2B
 R2aQQk5jjLmV0EkVnqA9h03sdnalLx7jDooki+musr+BO5fMRFpBskvtQcQ1e41ghaF5 sw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqyd9g7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 18:00:03 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351I02Wx029615
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 18:00:02 GMT
Received: from qc-i7.hemma.eciton.net (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 11:00:00 -0700
Date: Thu, 1 Jun 2023 18:59:56 +0100
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Graeme Gregory <graeme@xora.org.uk>, <wangyuquan1236@phytium.com.cn>,
 <chenbaozi@phytium.com.cn>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Message-ID: <ZHjcnHMWM9/Rl9lv@qc-i7.hemma.eciton.net>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: KvafatApxE1qt8sqafR7ApQvjyoV6luQ
X-Proofpoint-GUID: KvafatApxE1qt8sqafR7ApQvjyoV6luQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=631 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010156
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

+Ard

On Thu, Jun 01, 2023 at 16:01:43 +0100, Peter Maydell wrote:
> > >> Also has EHCI never worked, or has it worked in some modes and so this
> > >> change should be versioned?
> > >
> > > AIUI, EHCI has never worked and can never have worked, because
> > > this board's RAM is all above 4G and the QEMU EHCI controller
> > > implementation only allows DMA descriptors with 32-bit addresses.
> > >
> > > Looking back at the archives, it seems we discussed XHCI vs
> > > EHCI when the sbsa-ref board went in, and the conclusion was
> > > that XHCI would be better. But there wasn't a sysbus XHCI device
> > > at that point, so we ended up committing the sbsa-ref board
> > > with EHCI and a plan to switch to XHCI when the sysbus-xhci
> > > device was done, which we then forgot about:
> > > https://mail.gnu.org/archive/html/qemu-arm/2018-11/msg00638.html
> >
> > Ah, thanks! That explains why we did the thing that made no sense :)
> >
> > To skip the migration hazard, my prefernece is we just leave the EHCI
> > device in for now, and add a separate XHCI on PCIe. We can drop the
> > EHCI device at some point in the future.
> 
> Why PCIe for the XHCI and not sysbus? At the time the board
> was originally added the argument was in favour of using
> a sysbus USB controller (you can see Ard making that point
> in the linked archive thread).

The original argument was that having the device on the sysbus
1) enabled codepaths we wanted to exercise and
2) more closely resembled the development systems available at the
time.

1 still applies, but I'm not sure 2 does. Ard?

/
    Leif

