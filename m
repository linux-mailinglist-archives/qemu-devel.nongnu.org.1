Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302378D6DA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMtD-0003Ag-SX; Wed, 30 Aug 2023 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMtC-0003AU-3g
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMtA-0005m0-00
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so53927285e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408426; x=1694013226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6P71vvJ7ptsd0vmhWYR8dZEDPpDX55u5Wf1LptQc2Hk=;
 b=a1t1a2uTUhfkXNQ0awIV5mLHu05gyYDuHs1XnFTvhCDMvIbdNyRJqbFK/gH2y8+7dF
 8w7VjXWjaP+mQxI4BnFNl1brKxJ1Mq2vUAOmM2ZZNIRLGIMx7SiZ4zjsjfho149EVY03
 T8fy0dvjZQp7kAL/I1knqrgdxA5iU5xkp2FlOiSpFdCzIb6up5P5DhLKlKm+Sx+DzxxC
 7J0espoWhDXd0h7q0hF/ECBPYdMta6ZWX8bWPBMPpcx7/4AEtBmhVVKSPlS06i8B922b
 2TeCfybkjQB64oYiGRyzVwcxf6kaQArLsWkaLgbIgIc9EBR3rATX/Oe8J+rkdEcQXPVz
 LaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408426; x=1694013226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6P71vvJ7ptsd0vmhWYR8dZEDPpDX55u5Wf1LptQc2Hk=;
 b=glZk+PjaZKlX9q3MoeS0Aodh0udTDGGjd3khQukxcN3DItFiuQJk/yJBJyQZbh01hO
 6J/90++Kw73uL2lVe6Hsnr7K79hY8xfrBA3XVMS4qanQ8QCUQEI8FWr6fc/LTeHDmwkl
 Emy7JmNlmtJub5RpiaPNQjsKIyuZ3zCwosqeDL+8B06XM+MgoempGVuBA6zatVGtVFiJ
 f5HXATdNE+N/0uzi0G408ZH/0HXlIjrlRBZnHTeEeeok10LH5UP5W4f6MGQLFbZ0CtQr
 yZMQai4k0G9Ad9pDio5LwCYEHOt01mSid3Sr75X+19jJbCJxP9gxs/khJDPJcXnWyjpi
 NYFw==
X-Gm-Message-State: AOJu0Yz6i5MMiNEVrd8GIzAJKBvAr85V/70MHS8+HbaNq32FZqtdxULc
 IiK20D+KnXcN8944G0lF0Nkdgw==
X-Google-Smtp-Source: AGHT+IELKJ+nNcvOn/IINRYldx6lF7VCthK2xuwwxFLVlIWU3XAgvLiewx1F7XRR5BHq8IJU+E/thQ==
X-Received: by 2002:a5d:69ce:0:b0:317:e515:d623 with SMTP id
 s14-20020a5d69ce000000b00317e515d623mr1793492wrw.60.1693408426613; 
 Wed, 30 Aug 2023 08:13:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a05600c365500b00400268671c6sm2550071wmq.13.2023.08.30.08.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:13:46 -0700 (PDT)
Message-ID: <93bd9139-3a5a-f71f-ed17-aaa8091cb278@linaro.org>
Date: Wed, 30 Aug 2023 17:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_37/67=5d_ui/console=3a_rename_vga=5f_funct?=
 =?UTF-8?Q?ions_=e2=86=92_qemu=5fconsole=5f?=
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-38-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-38-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> They are not specific to VGA. Let's use the object type name as prefix
> instead, to avoid confusion.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


