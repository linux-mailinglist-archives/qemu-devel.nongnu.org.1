Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E157372C4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBf68-0003h9-VJ; Tue, 20 Jun 2023 13:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qBf66-0003gl-UA; Tue, 20 Jun 2023 13:24:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qBf65-0006Be-8w; Tue, 20 Jun 2023 13:24:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KBq22s015870; Tue, 20 Jun 2023 17:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OURr6F2KjHuxCILclp1JKQeKylPthvogQZg26aOlsQw=;
 b=Y0nkKO+xU2eZeXsm62YcCXThFp2ciiFAjuguW+R8Q4E8afJ09z9GWklXnx+IwSVtSFM4
 by105k9CGFQDkENaLHfThaJj4G51pW2Y6T/rNV4eOPvHbxq4LwTluxZX5JFGnUnLfWwY
 ci8PuN+2QKX/hPNCfi3fbXYFpatGBzo4TpCbOjBnPgr1UBvBzBkxc4VBNR/PF/0Iv/Yb
 DjJWesp/v9/T6o34MHgYFEFBGEL3BzrxTr+MICP8siv3a5o1qfqAnZu/Fx2rE4u5CsLi
 drJRSNHrhjzP9VwI1GGv3hlZ1b2AaHC0CxrrmrNMb6KQFpICvOFBxouCHfJyL1pr0AX1 2Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb6nmspux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 17:24:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KHOlq1019118
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 17:24:47 GMT
Received: from [10.111.133.218] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 10:24:45 -0700
Message-ID: <f1e8edcc-14ed-0e97-0172-292032e61f1d@quicinc.com>
Date: Tue, 20 Jun 2023 18:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Peter Maydell <peter.maydell@linaro.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>
CC: <rad@semihalf.com>, <pbonzini@redhat.com>, <marcin.juszkiewicz@linaro.org>,
 <chenbaozi@phytium.com.cn>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
 <CAFEAcA-B6Pbc2KyTVP9hheGfEecfTbwu-zi7_9EmjJH5opbiYg@mail.gmail.com>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <CAFEAcA-B6Pbc2KyTVP9hheGfEecfTbwu-zi7_9EmjJH5opbiYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: bV2zoUw6hwXtrSVKZjmQJyabrsA6wVDx
X-Proofpoint-ORIG-GUID: bV2zoUw6hwXtrSVKZjmQJyabrsA6wVDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 mlxlogscore=610 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Hi Peter,

On 2023-06-19 13:47, Peter Maydell wrote:
> On Wed, 7 Jun 2023 at 03:34, Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>>
>> The current sbsa-ref cannot use EHCI controller which is only
>> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
>> Hence, this uses system bus XHCI to provide a usb controller with
>> 64-bit DMA capablity instead of EHCI.
> 
> "capability"
> 
>> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> The change itself looks good. We could probably mention in
> the commit message that existing firmware/kernel images
> still work (with no USB support) with this change.
> 
> Is this the sort of change that we should increase the
> machine-version-minor for ? The comment says "updated
> when features are added that don't break fw compatibility"
> and this sounds like one of those.
> 
> Leif, do you think we should bump the minor version here?

I think that makes sense, yes.

/
     Leif



