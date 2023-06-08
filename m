Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456607280C8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:02:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FFc-0006d4-Th; Thu, 08 Jun 2023 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7FF4-0006b9-Nt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:59:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7FF2-0004nl-Rc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:59:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358CVxic021840; Thu, 8 Jun 2023 12:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SXlTQNeYm6Vf8/n+3cueF7hYxvJQoPQNpj5bYSYEfTk=;
 b=WqIVdmV1hNSOZzl3OoXvPHzkLgUZM51jvlywHWUg59tn+SzVBhpg1gGLAlLb+fuUF1yl
 Yv8EKFxMqFbY3dCxhO+wuzvcRUOw4/6PWW1GHeRFv4PzZjzNpKaWRFQzBoa+HjDJ/3xI
 5fzkMb4yEQl+lxkfIlophQtUXicPRcsSDeBVEuC5JcMYdGGSSshnXwxDoXJSb5aZH3zU
 5WzCqLsxTnCL1renmwci/wBRLfP9ux5qhlETvx5UAzhilJ2Vo+E/USbJHrldNisowmEd
 dhxp8XrM9ya0VNhrRWhK8v1VxKgp5HkwRz1AjOufGvL/OkrXMElxQ5pZ5rkTggKKzpA0 LQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r341c18cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 12:59:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358Cxnhw020156
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Jun 2023 12:59:49 GMT
Received: from [10.251.41.210] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 05:59:47 -0700
Message-ID: <528605f9-6599-16d7-175e-240c9e72f58d@quicinc.com>
Date: Thu, 8 Jun 2023 14:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] ui/sdl2: Support multiple OpenGL-enabled windows
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230607091244.55270-1-quic_acaggian@quicinc.com>
 <CAMxuvaw88g9RPp_Om2Z9dJSmsrFMZ9ieKx8uJmSNgfsOYyQvSQ@mail.gmail.com>
 <48b15972-ed25-0adc-2d18-910504673bbd@gmail.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <48b15972-ed25-0adc-2d18-910504673bbd@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ey-Crih2wEo46QUQX0par52LURGLtWui
X-Proofpoint-GUID: ey-Crih2wEo46QUQX0par52LURGLtWui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080112
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Marc-André and Akihiko,

On 07/06/2023 13:24, Akihiko Odaki wrote:
> On 2023/06/07 19:29, Marc-André Lureau wrote:
>> Hi Antonio
>>
>> On Wed, Jun 7, 2023 at 1:13 PM Antonio Caggiano 
>> <quic_acaggian@quicinc.com <mailto:quic_acaggian@quicinc.com>> wrote:
>>
>>     Multiple graphics devices can be defined with an associated OpenGL
>>     enabled SDL console, hence make sure to not destroy their shaders and
>>     windows.
> 
> I guess you meant multiple graphics devices can be associated to an 
> OpenGL-enabled console and a switch event from a device destroys the 
> shared state, but I don't see anything that associates multiple devices 
> to a single console.

The idea is to be able to run qemu with OpenGL-enabled SDL windows and 
multiple GPUs [0], e.g.:
-device virtio-vga-gl
-device virtio-vga

[0] 
https://user-images.githubusercontent.com/6058008/244386705-54654833-903e-478a-85f5-d951b7c448b4.mov

> 
>>
>>     Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com
>>     <mailto:quic_acaggian@quicinc.com>>
>>     ---
>>       ui/sdl2-gl.c | 2 +-
>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>     diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>>     index bbfa70eac3..795fb1afc9 100644
>>     --- a/ui/sdl2-gl.c
>>     +++ b/ui/sdl2-gl.c
>>     @@ -89,7 +89,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
>>
>>           scon->surface = new_surface;
>>
>>     -    if (is_placeholder(new_surface) &&
>>     qemu_console_get_index(dcl->con)) {
>>     +    if (is_placeholder(new_surface) && !scon->opengl) {
>>               qemu_gl_fini_shader(scon->gls);
>>               scon->gls = NULL;
>>               sdl2_window_destroy(scon);
>>
>>
>> This was introduced in commit c821a58ee7003c2a0567dddaee33c2a5ae71c404 
>> by Akihiko.
>>
>> Why should the window visibility behaviour be different whether it 
>> uses opengl or not ?
>>
>> If you are fixing a GL/shader crash, maybe it needs to be done 
>> differently.
>>
>> thanks
>>
> It does not make sense to check scon->opengl here; it should be always 
> true when this function is called.
> 
> The condition qemu_console_get_index(dcl->con) should not be removed 
> either. This keeps the first console persistent and makes sure the user 
> can always interact with QEMU with the GUI SDL2 provides.

The problem I encounter when adding a second GPUs is that its related 
SDL console gets its window and shaders destroyed, which are definitely 
something I need for rendering it. :D

Do you think where is a better way to avoid that?

> 
> Regards,
> Akihiko Odaki

Cheers,
Antonio Caggiano

