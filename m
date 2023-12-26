Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19081E711
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 12:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI5SO-0004WB-1g; Tue, 26 Dec 2023 06:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5SL-0004VC-MR
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:18:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5SK-0008Sh-6m
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:18:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5ac76667so2290505e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703589519; x=1704194319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eGaxT+hIN+7zr4UgbUTDj+hMyyEeMv432BZ16B8Mgq8=;
 b=pWgawoErXtu4XJM9ZpVMYGeSxNo7wAOYOha5p3QwwIdzvUVK0Frw9sP2l347OfzCQJ
 EXA3dLLpPjswXUDhklgRVrdrAjjTWSazWOqCeiIXdxEw7ZSoVBQLwPd1Q0zs+jbQmzo3
 vic9NuOadzLGL0/xFmSCW6xB5yVNU7ou0PBOvyFJ1Lbu5OPnTI5CfuDVFf3TMxdBYq1L
 iyG2kkBu/Ic1ipFeDXDii1lRGD5PxW+y2R7ymjBA8KFuvnCUNsITsDVpVurcTRFCUVjh
 K4mBNRuDxuONxoYzTZ55BYunBF7CDOWZJEl2vNBxxzilQeDL5szxPa5d1bJjM7LHy5vc
 jjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703589519; x=1704194319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGaxT+hIN+7zr4UgbUTDj+hMyyEeMv432BZ16B8Mgq8=;
 b=XYdiVzR5wgT6Xolb253GLTNVhSk5baP1VFzC5uarnWJz5d76b2txCvQ0XdaY0hf2ci
 z5ZrstUtGVin3mBg6NLfwCr7FHL/RSvbPH1UeFozpsaq8ULJ8TUfaxKOffLgt6QBaUOO
 fFDjz8I+ibFgqLaO7vZWbpGuvb8cnn3VCtwCJNFaoq4Vs57VB1/knMDB89D6QJCxg7sj
 uj/L+fT+bslQ7LJWT+hwuMhlQC6WlyjEq/8i4mOLiyY6lNOMm14dBIpWsrWMPsij1o9w
 uMSq4e98aKJxSL+F80KR0jm2KChl7iqMaRTaMFEk3WIfmN+IeZ4/Q9UO4JIfPhdp1k0q
 Pzjw==
X-Gm-Message-State: AOJu0YwOKC+UXSSAaBOh5FKWt1aTm73c0qtiuv3/PTcfY/MkqPujz4/Q
 /p48hibn9eRrxFFvXOmC4Yf+K1+WIVWvKQ==
X-Google-Smtp-Source: AGHT+IFMHPkQVk++az1wXlyiblkAtV0ZpnOuezHp3Apsxpq/DkW5B1DXIKsn2vs8LC0byCJYekj/XA==
X-Received: by 2002:a05:600c:3c8f:b0:40d:2dbe:b11d with SMTP id
 bg15-20020a05600c3c8f00b0040d2dbeb11dmr4935154wmb.116.1703589518873; 
 Tue, 26 Dec 2023 03:18:38 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040d5a5c26a9sm1868669wmq.43.2023.12.26.03.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 03:18:38 -0800 (PST)
Message-ID: <66c6a9ef-6dc7-479f-bcd3-497e8eaabbdd@linaro.org>
Date: Tue, 26 Dec 2023 12:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/ui/rect.h: fix qemu_rect_init() mis-assignment
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Elen Avan <elen.avan@bk.ru>, qemu-stable@nongnu.org
References: <20231222191721.414176-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231222191721.414176-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/12/23 20:17, Michael Tokarev wrote:
> From: Elen Avan <elen.avan@bk.ru>
> Signed-off-by: Elen Avan <elen.avan@bk.ru>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2051
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2050
> Fixes: a200d53b1fde "virtio-gpu: replace PIXMAN for region/rect test"
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   include/ui/rect.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


