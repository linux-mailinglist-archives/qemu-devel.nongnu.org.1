Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335273D061
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 13:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNnO-0007d4-1P; Sun, 25 Jun 2023 07:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qDNnL-0007cu-P1
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 07:20:39 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qDNnJ-0004V4-Uj
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 07:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687692035; x=1688296835; i=deller@gmx.de;
 bh=NBZLaErKoXi6R9lc93us8yxpR1J0eRTsDhds+gIkU+4=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=Tr31s0Z+3b7iuh5D0l6k78qGVabMhxhh/EdYPXLIwcK3sR7zuaEkqa0dJXNERhFl2mSi+pL
 Z03L63zpBF3dD/Tc8qRdU38lt/5X6Bx1Ys7a8S0yooDdbkj0bph3oLoriIMFAIiGNE0Ls/V5d
 FldYlXZG2AaF8obVAzshA60Md6b9g0mSJkUOchhvxeG3Z01HIwrNVJ1wQPNdL8s+Rs/d4C7pP
 XbS3+MDxmcukQu3fUASa/UtdOxNgk3ewkG6wRTwIF3IohX6dHI0bt+Ws065/bejbfbJBqHzSP
 nRnRSdAiTLefE2a5hvMVN3q3wXx9uAJ8ZsgVTYlHksA/OgPDG0bA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.92]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1qC0sq17GN-0036Wl; Sun, 25
 Jun 2023 13:20:35 +0200
Message-ID: <45215ee6-b36f-5c90-6937-9f45277598ea@gmx.de>
Date: Sun, 25 Jun 2023 13:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
 <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
 <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
In-Reply-To: <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KIFuQXMsUl8T6YKWfp+Ni1CJ43Q8issECHzTq/ok7fvL1P/PkKb
 ZqUB8JFc5Yjpno5TNmSfDgAn4DQN6VYalUguR7Dyt1xVCmoZbJGI3XFL9VujCvKKMABR8Xq
 PpL//gixKatpI72QZkw0XZrcVUxKPbDl5cLe3KI6C3BVZck7wTBL+7PZFYPM6OjlhwRvTl8
 ANGlhV88rhLUNW+vDHS9g==
UI-OutboundReport: notjunk:1;M01:P0:G7OghDyHnBI=;2FMoftZf/MZdKLy3n0+BToBTiOA
 UY/oWMuXFI8S3y6IECbzWGz4G7G/Ya6hv7iZM91+7vR0E7BW/f+yzW80OPu2rFRSzBiVS00d9
 AaADbDTu8eYjKZr1f9+VdLWdNvLlNsfcHMC1tKn2iwnxaWAmjFTJzZLqgHgAPsCPw+kpz7cy5
 fcrvVPrIbyVnQazIlOmVWCrdnwOPTubmzNBfwQ9sjHd2yJ1y2KKfE1AdchdRGagpGz6ZI2Y3H
 zTaMY1i7p5yKALgWskYWxdaZ5XmtGHG8cXY87aGzolWXyE++aCW3GDFSDMwn+eucocs7pmitx
 DAMbnyohFXze8yoxWQ/mhqs45KdIHg4ZDP2DxPNp7lqrDF/PL/e4/hd76c+gqgRk9Q0ft66DA
 F5F+GUOjK9b/a24A8GIaudYFpJlcFVHcyxmxQgMJA7pg1pUu/mxZgpwZWRmMjNcUV2oOfqabw
 0uIeTcuxD5frc7N+ThPKN9TNEP2BIWittMrxM6SsorvzPzHmtO/bwgNbAih7AkGdXEmpfZLWC
 qjL1kcemD6K80yXl3EZhYwyvFJUp6Cn1Hx0pyBY1Vg8sn9eYzSaTOzv1M3YnHx31LkPFP+akT
 oMCkZf404Mc+YsqxXHrfIRT4Xlbuasllvk77q1qvIskS/45A2K1QxlIuE8XUoPazbqtMuNA34
 oRMwe0TZRcI3gdxt5cAI7dI7XjxnRrqLL/0dNDGBD+quSjJ2PVAUpkOcSkDMOkeP7jGv9Qe08
 FnPQ/fZUS0LXDS2RV6bN2DIfi/be6UyVCe0/2L2t4UmK7TegxHJdTr/cs6+0g6MxRVsjJp4S9
 QhmtUSmj2j6F8IvEiuSUJEZl9QNJybdkWfnLsBJcmXpX1zT0O+vyew4ITYi5h9NkhYK5o/Ajp
 FYyUkH8Ser/FB8zc27zTPeOR++dzSognUMjvoQcWNEvRanPTHIxUPN7AhcfYFpi0a+KtnFHwg
 1bCICQ==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/25/23 12:07, Helge Deller wrote:
> On 6/25/23 10:57, Michael Tokarev wrote:
>> 24.06.2023 14:50, Helge Deller =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> When the OS triggers a reboot, the reset helper function sends a
>>> qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET) together with an
>>> EXCP_HLT exception to halt the CPUs.
>>>
>>> So, at reboot when initializing the CPUs again, make sure to set all
>>> instruction pointers to the firmware entry point, disable any interrup=
ts,
>>> disable data and instruction translations, enable PSW_Q bit=C2=A0 and =
tell qemu
>>> to unhalt (halted=3D0) the CPUs again.
>>>
>>> This fixes the various reboot issues which were seen when rebooting a
>>> Linux VM, including the case where even the monarch CPU has been virtu=
ally
>>> halted from the OS (e.g. via "chcpu -d 0" inside the Linux VM).
>>
>> Is this a -stable material?=C2=A0 It applies cleanly to 8.0 and 7.2.
>
> Yes, please.
> At least for 8.0 I think it should be added.
> I didn't tested 7.2, but can do and would prefer it if could be added th=
ere too.

Just tested: The patches work nicely when applied to v7.2 as well.
Could you add them to -stable (or what is the process)?

Thanks,
Helge

