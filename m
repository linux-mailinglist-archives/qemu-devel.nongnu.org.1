Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051647E9979
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:54:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TdV-0003ZF-Nj; Mon, 13 Nov 2023 04:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r2TdL-0003Yu-HM
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:53:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1r2TdJ-00052Q-QO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:53:31 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AD9l5B9014626
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WYWLwYJRoaHB1Z7eaFd697PkmoH8YKaGw0bx6/tcAKo=;
 b=WuTsxsXhxfmu/fOBvreVnm1WSCZYj41PiDJD6G8Q9rOLOQVjSBdR0s45Vzl+e2Z3dSAe
 GFwS9yoJO/I6rsU1J3FZJZ/N++DaK4voGiy7egjwIp5n5Z9y8iTEh41PzxDs9x4Q9XHE
 BfVMPUvs+WutwZmdhZO9WeskmNcn/j2BbZIzgsw6PAa3lLLf2UaHjVd6sf5aoOWedRQF
 EvaG8mAP0Tg82qF+p0Q3ln8kPGz41kmotIfC9k7AZBukO3nyXmY5OY39dRyjIyKNTTJh
 p/FqvLXTSwQHQWXH0rovMcTEZ73o/j9WuDSz5CXz/9bOiIzxzyF0Zb9wXk915r/Rbw7U /Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubge803s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:53:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AD9rPx9005583
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:53:25 GMT
Received: from [10.111.131.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 01:53:24 -0800
Message-ID: <ab3af7a2-76c3-397c-ce19-859ddf0d5f06@quicinc.com>
Date: Mon, 13 Nov 2023 10:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 8.2] ui/gtk-egl: move function calls back to regular
 code path
Content-Language: en-US
To: <qemu-devel@nongnu.org>
References: <20231111104020.26183-1-vr_qemu@t-online.de>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20231111104020.26183-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: NUQPZdL60m5EO_zURm0V5RF_x6-YVkyS
X-Proofpoint-GUID: NUQPZdL60m5EO_zURm0V5RF_x6-YVkyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_24,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=857
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Volker,

Thank you for finding this!

On 11/11/2023 11:40, Volker Rümelin wrote:
> Commit 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing
> scanout") introduced a regression when QEMU is running with a
> virtio-gpu-gl-device on a host under X11. After the guest has
> initialized the virtio-gpu-gl-device, the guest screen only
> shows "Display output is not active.".
> 
> Commit 6f189a08c1 moved all function calls in
> gd_egl_scanout_texture() to a code path which is only called
> once after gd_egl_init() succeeds in gd_egl_scanout_texture().
> Move all function calls in gd_egl_scanout_texture() back to
> the regular code path so they get always called if one of the
> gd_egl_init() calls was successful.
> 
> Fixes: 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing scanout")
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>   ui/gtk-egl.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index cd2f176502..3af5ac5bcf 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -249,14 +249,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>           if (!vc->gfx.esurface) {
>               return;
>           }
> +    }
>   
> -        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> -                       vc->gfx.esurface, vc->gfx.ectx);
> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                   vc->gfx.esurface, vc->gfx.ectx);
>   
> -        gtk_egl_set_scanout_mode(vc, true);
> -        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
> -                             backing_id, false);
> -    }
> +    gtk_egl_set_scanout_mode(vc, true);
> +    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
> +                         backing_id, false);
>   }
>   
>   void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,

