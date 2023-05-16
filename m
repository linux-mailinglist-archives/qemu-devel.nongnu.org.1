Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D7870546A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxx3-0004Od-Ef; Tue, 16 May 2023 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyxx1-0004OH-2Y
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyxwx-00007m-CL
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684256098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ca3dQSJb+MyW969LT2Ng1q+RetYHAk4vRlko153CLaI=;
 b=EBHqsSSWuNgFqL4vj9hQ+7hWDWjcm6zzWbaM6aL41fzSoV8g16sRd5nY3craHRI4ZAXh+k
 Ypq0QEdZMKldAs4zKmtv/g6dQOjt2zI9DYwvH7kYJjg5GpqyTDxWi2DqapUpIaqFJznP3R
 GJ41ZuedJVluNtWpJTrdLF873IzpxGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-znPykhoJMNOekz0df0QAiw-1; Tue, 16 May 2023 12:54:56 -0400
X-MC-Unique: znPykhoJMNOekz0df0QAiw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso32046185e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684256095; x=1686848095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca3dQSJb+MyW969LT2Ng1q+RetYHAk4vRlko153CLaI=;
 b=cdcssZDTPyEtIGy7dfJ3uP6bBfP3sp2Zs156oPUdKtH340YmbUHnx9s/KtXKGHZupP
 Ut/TKLmOJFi4q53R4WCQmXYr2+MN/K3X6UgWdK+mzCSHDqRtXlu2j87yLgWIHpmu8s+5
 ceiqs9fqS8V1m5atlCVm99LWd67p+GozF3L8GoID7bwy2fUGTInfZ2kShGBQE++04Gl7
 dihInUSZjGZ8hU1fccqL5hEvkWprJM/60axYSCpmYaFVBrh3RiJRPhxbfgRiR4mMmLev
 87lMD4GVLHH9HN8OeINOHix2o6jUX4w9vtAcqTw/NKdUzJzr2sR4pLSOtouYM5mEg4kt
 SjrA==
X-Gm-Message-State: AC+VfDxwmKpNuwjw7ybSYUnwlhxOYl6pHZhK8GvZ0B3Fx7vI2L8AvwxK
 JKSYqAeW+0karfXkUKhPs2i7QZmYzcKAS6CUAph9azhhozBwwJmQUg6L/N7smFIyUC5e63v++ZI
 vwYbVHZzgwGwnwuE=
X-Received: by 2002:adf:facc:0:b0:306:30e8:eb34 with SMTP id
 a12-20020adffacc000000b0030630e8eb34mr29142635wrs.48.1684256095514; 
 Tue, 16 May 2023 09:54:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5e8bL993DxBZpg8M+LhCHBLAJ0z6k8ecHtNmO0pI3dWnhrBmnEQBn5vrxv2TWJ0VgUll/p6Q==
X-Received: by 2002:adf:facc:0:b0:306:30e8:eb34 with SMTP id
 a12-20020adffacc000000b0030630e8eb34mr29142617wrs.48.1684256095222; 
 Tue, 16 May 2023 09:54:55 -0700 (PDT)
Received: from [192.168.8.104] (tmo-064-10.customers.d1-online.com.
 [80.187.64.10]) by smtp.gmail.com with ESMTPSA id
 e1-20020a056000120100b003077a19cf75sm3174607wrx.60.2023.05.16.09.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 09:54:53 -0700 (PDT)
Message-ID: <48906545-7fdb-effb-8819-485a66226e2d@redhat.com>
Date: Tue, 16 May 2023 18:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: Convert u2f.txt to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230421163734.1152076-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230421163734.1152076-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 21/04/2023 18.37, Peter Maydell wrote:
> Convert the u2f.txt file to rST, and place it in the right place
> in our manual layout. The old text didn't fit very well into our
> manual style, so the new version ends up looking like a rewrite,
> although some of the original text is preserved:
> 
>   * the 'building' section of the old file is removed, since we
>     generally assume that users have already built QEMU
>   * some rather verbose text has been cut back
>   * document the passthrough device first, on the assumption
>     that's most likely to be of interest to users
>   * cut back on the duplication of text between sections
>   * format example command lines etc with rST
> 
> As it's a short document it seemed simplest to do this all
> in one go rather than try to do a minimal syntactic conversion
> and then clean up the wording and layout.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/device-emulation.rst |   1 +
>   docs/system/devices/usb-u2f.rst  |  93 ++++++++++++++++++++++++++
>   docs/system/devices/usb.rst      |   2 +-
>   docs/u2f.txt                     | 110 -------------------------------
>   4 files changed, 95 insertions(+), 111 deletions(-)
>   create mode 100644 docs/system/devices/usb-u2f.rst
>   delete mode 100644 docs/u2f.txt

I'm not an expert at all in this area, but your changes look sane to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


