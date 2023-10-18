Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E01CC7CDA41
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4gr-00019t-3X; Wed, 18 Oct 2023 07:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qt4gk-000162-Bg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:26:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qt4gf-0005GW-B9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:26:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39I4r2i7017317; Wed, 18 Oct 2023 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ztYggaFHGl6w9Dbt79YOuOKnAymuDSkz57q4XkCAi98=;
 b=UIznMkmMUUeKfmFM+Gb5h6/bDt3Czq1z7Yrq2IF88HFuCU184GJHJ8Z+rGOYkFzAoP3X
 YMW6AXMJzRHveiVdafg/3tWSUtIt8p2t+0hE08auevReWWSAtjqVEvzKprEj0j35f/28
 AF8sBUMzVJXsvdJ92Mw960YfPw4HUfreegYnCQp1kSeI53Su7BfmwGNxI4xrb0L0rhsD
 1SkggyPwOSmJNV5NYEpOAA+3aapj2/gx4dKVoOIRJj4migAHr7QZIwMpJGA29WsfFTVT
 ts2Y04k6Esux+L7H7Ke8hJUq9vxZfkDstDECmExI6bwe8lSmn7uPEaszc8A+vQyVFYHQ Fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt1401n7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 11:26:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IBQ05n013172
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 11:26:00 GMT
Received: from [10.251.41.93] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 04:25:58 -0700
Message-ID: <4e4d1500-e0f3-041e-1972-ebc96bab287c@quicinc.com>
Date: Wed, 18 Oct 2023 13:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtk: force realization of drawing area
Content-Language: en-US
To: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>
CC: <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
References: <20231017111642.1155545-1-marcandre.lureau@redhat.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <20231017111642.1155545-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: gblJB7OT3-WZ4ul9MXBg4d2LyeJqwjez
X-Proofpoint-ORIG-GUID: gblJB7OT3-WZ4ul9MXBg4d2LyeJqwjez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=812 mlxscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

On 17/10/2023 13:16, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Fixes the GL context creation from a widget that isn't yet realized (in
> a hidden tab for example).
> 
> Resolves:
> https://gitlab.com/qemu-project/qemu/-/issues/1727
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/gtk.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 935de1209b..2a4c9b84ba 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2371,6 +2371,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>       GdkDisplay *window_display;
>       GtkIconTheme *theme;
>       char *dir;
> +    int idx;
>   
>       if (!gtkinit) {
>           fprintf(stderr, "gtk initialization failed\n");
> @@ -2434,6 +2435,15 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>       gtk_container_add(GTK_CONTAINER(s->window), s->vbox);
>   
>       gtk_widget_show_all(s->window);
> +
> +    for (idx = 0;; idx++) {
> +        QemuConsole *con = qemu_console_lookup_by_index(idx);
> +        if (!con) {
> +            break;
> +        }
> +        gtk_widget_realize(s->vc[idx].gfx.drawing_area);
> +    }
> +
>       if (opts->u.gtk.has_show_menubar &&
>           !opts->u.gtk.show_menubar) {
>           gtk_widget_hide(s->menu_bar);

