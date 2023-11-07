Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFC7E467F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:59:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0PPH-0007I2-UW; Tue, 07 Nov 2023 11:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r0POp-0007G5-U2
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:58:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r0POo-0005Wg-7o
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:57:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B58731270;
 Tue,  7 Nov 2023 19:57:59 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E53B033BF9;
 Tue,  7 Nov 2023 19:57:54 +0300 (MSK)
Message-ID: <64709368-fe12-46a6-89d7-1b0ce96f533d@tls.msk.ru>
Date: Tue, 7 Nov 2023 19:57:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Ui patches
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Sergey Mironov <mironov@fintech.ru>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

07.11.2023 12:30, marcandre.lureau@redhat.com:
...
> Antonio Caggiano (1):
>    ui/gtk-egl: Check EGLSurface before doing scanout
> 
> Carwyn Ellis (1):
>    ui/cocoa: add zoom-to-fit display option
> 
> Dongwon Kim (1):
>    ui/gtk-egl: apply scale factor when calculating window's dimension
> 
> Marc-André Lureau (1):
>    ui/gtk: force realization of drawing area
> 
> Sergey Mironov (1):
>    ui: Replacing pointer in function

Which changes are worth picking up for qemu-stable?

I'm definitely picking up "ui/gtk: force realization of drawing area"
which fixes a real bug.  "ui/gtk-egl: Check EGLSurface before doing scanout"
and "ui/gtk-egl: apply scale factor when calculating window's dimension"
smells like valid candidates too, maybe "ui: Replacing pointer in function"
as well?

(Adding patch authors to the Cc list)

Thanks,

/mjt

