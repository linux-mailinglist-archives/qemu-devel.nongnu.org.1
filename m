Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4617B379B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 18:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmG6a-0007FT-TY; Fri, 29 Sep 2023 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qmG6Y-0007Eu-UB; Fri, 29 Sep 2023 12:12:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qmG6W-0005Qm-80; Fri, 29 Sep 2023 12:12:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38TFeFmv025357; Fri, 29 Sep 2023 16:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=pIq3FD7Dbr+IjX8CIVWaFGOYQHXu1/x9M3jr3G7SIHs=;
 b=HtvIfcB4aAmI08bOmoy8grVLucJmmY31nliXQpR9AxgB70Be/tVtcGVBf2JNDojP8Mmy
 cHOej7fnAmZhdZ0IMK9rdifIRfYn71Yu0xtKkAxUqXVbyeBpauF5z1F+WTDjXjE2RE42
 Cve4TCM/WBog0ePiSQ+w9A6HtiMYYBjT4xJkuN1WXUo3OaL0x6LVTJAAKkJV8wRPLtL0
 UMPIopOGRtxKjqPxVvDzI7MWNGJ65s9JBYfq8B0/fdR9skV2dCuEPjX8f9oH0bL3cW2l
 uWSRV1PN+6kJ51Nfj9Pqe9L9w2qsc72AvLqlvOf8f2ef0IE/Uqz0S/Ww50K9gBgO6heb dQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tda4c30n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 16:12:31 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TGCUYG017756
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 16:12:30 GMT
Received: from qc-i7.hemma.eciton.net (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 09:12:28 -0700
Date: Fri, 29 Sep 2023 17:12:25 +0100
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: Thomas Huth <thuth@redhat.com>
CC: Radoslaw Biernacki <rad@semihalf.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] MAINTAINERS: Add some unowned files to the SBSA-REF
 section
Message-ID: <ZRb3aTLxBSnVGGr2@qc-i7.hemma.eciton.net>
References: <20230929141918.397096-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929141918.397096-1-thuth@redhat.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 6OXX3-a83h1mQ2qJ9m6X6ePdxQhafEh4
X-Proofpoint-ORIG-GUID: 6OXX3-a83h1mQ2qJ9m6X6ePdxQhafEh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=769 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 29, 2023 at 16:19:18 +0200, Thomas Huth wrote:
> These files belong to the sbsa-ref machine and thus should
> be listed here.

First of all, thanks for this.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 874234cb7b..fc415d3cea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -954,6 +954,9 @@ R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/sbsa-ref.c
> +F: hw/misc/sbsa_ec.c

Yes, pure oversight, sorry about that.

> +F: hw/watchdog/sbsa_gwdt.c
> +F: include/hw/watchdog/sbsa_gwdt.h

I just want to clarify that this is not "the watchdog for the SBSA
platform", but "the watchdog defined by Arm's SBSA specification"
(and belatedly the BSA specification)" - the specification that
sbsa-ref (intends to) provide a compliant platform implementation for.

Another such component is the "generic UART", but since that is a
subset of pl011 there is no real value in providing a dedicated model
of it.

Which I guess is a long-winded way of saying: this component does not
necessarily want/need the same maintainers as the sbsa-ref platform.
I'm still happy to maintain it, and it may make sense to keep it under
this header for now.
(In which case
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
)

Regards,

Leif

>  F: docs/system/arm/sbsa.rst
>  F: tests/avocado/machine_aarch64_sbsaref.py
>  
> -- 
> 2.41.0
> 

