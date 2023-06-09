Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCE72924C
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:10:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7XBc-0002St-W0; Fri, 09 Jun 2023 04:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7XBb-0002SS-2r
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:09:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7XBZ-0004NU-BN
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:09:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3597ClvU006904; Fri, 9 Jun 2023 08:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aEaPARqQt7StTRpGwUY7/rCuAF5yUPA8OuzALtuTnY0=;
 b=kH7Bo8EMxlPBM/F7NRE35JNN4StaVhJbgF91/oHu24+EZwR+LvoqdVdLzGZiav4cImWL
 dAee0aB5E/IY/56+5B5fFVYWqribYTHw0wY3rz2yRXKmPl9EmoGZ10Eag7tztS+A+Ljc
 pBvBL4oyQl5C92SZCvxi02C8Q/3I1EjoFe3TAvQscYnC/leCTLqW26nuL4y+qjxpV9yI
 5uQQIan7ZyMDrmO5Ge3TfyGvfUIVyzG64xOWfGAPjY3/SLChRQjc3nMuPcO8/X7xcmQw
 il19sBH8haSB9yzmVb1eE9ubf4R6XtUK5rhT0RNvNtdSJ8rf6kDD2ACLU1tin36ZS6le dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70gkxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 08:09:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359890r2006146
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 9 Jun 2023 08:09:00 GMT
Received: from [10.251.41.210] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 01:08:58 -0700
Message-ID: <548f5337-3763-8c26-1a99-4ba7b724aeed@quicinc.com>
Date: Fri, 9 Jun 2023 10:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] sdl2: Check if window exists before updating it
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
CC: <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230608145512.25970-1-akihiko.odaki@daynix.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20230608145512.25970-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: lAFPtutjVJtcOmywQEpMx0PBSqAvHcxJ
X-Proofpoint-ORIG-GUID: lAFPtutjVJtcOmywQEpMx0PBSqAvHcxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_05,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=680 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

On 08/06/2023 16:55, Akihiko Odaki wrote:
> A console does not have a window if the surface is a placeholder and
> the console is not the first one. sdl2 cannot update the texture in
> such a case.
> 
> Add a proper check for window existence. Such a check is only necessary
> for the "gl" implementation as the "2d" implementation checks for the
> texture, which is set only if a window exists.
> 
> Fixes: c821a58ee7 ("ui/console: Pass placeholder surface to displays")
> Reported-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   ui/sdl2-gl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 39cab8cde7..bbfa70eac3 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
>   
>       assert(scon->opengl);
>   
> +    if (!scon->real_window) {
> +        return;
> +    }
> +
>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>       surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
>       scon->updates++;

