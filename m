Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41067691AB
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQP9L-0008QM-Gi; Mon, 31 Jul 2023 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQP9E-0008OQ-CN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:25:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQP9C-0004kj-2y
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:25:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso29276965e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690795500; x=1691400300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sQdmhbmAOufhj8OS+LKDN30TTYsFhvN6R6Yf4flY2HQ=;
 b=kTSHfAKS9n6A2uW+2DolFQh0kJhIWD6MnnZAvVP0WaXX7xd6E/XFE4DoOl5AmHhRYC
 H+xiEv6C3kIEZ4qASyLyyU2oKRJNOILn25rQGEqCFI22rEpmAwSzsi89GTqHSTh5AtXh
 Ubw1uzN0NTsZHE/W8Osry23MuUdVfwyvf+YNDBtXtWH7yTM0COG9an3HxhTbJbgaBUg/
 KSPiUQOokk3npZZU4166nOc6nsdLzGWmkEAR6c+GE4+NtXf/ew/ljySvbZaQg6ghLx23
 m3LrFibs206yoiJZZWNmeO8t8YQj9qo/C4EPf+v8FPoOgqmzSPZ4q+lKkWwxBU1kLFu8
 vZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690795500; x=1691400300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQdmhbmAOufhj8OS+LKDN30TTYsFhvN6R6Yf4flY2HQ=;
 b=CoCEvsnaSSNxzkihoWAUr6OKGBFOpTjiA+pEwLeNP7JV8I77kR91D1hK8u5wT1a67Y
 8eMBy88ByPpJS8LHz8sqQrBCCyxprMiBf2ElnjTCyvH3uNxYSxvruubuvML7FvHNGAU1
 aBgkGRxh5YREOz4h1xImy7bconsZ/UcCHj78T7tIS0zJAycGWmWb3igqGIvN2IfSdWD4
 4ZMvKcBF5ch+wH/E4ejirejILxhEJqQ1ctlNNZ5y2ZHmfLBPPflh+IHJfK1y+ExJ+vWv
 sA1N7SsGj/r0rGJSih3yR/0pzQ+pIIVhaZT+15FNsuCveUdgSxOx7SHJWY/d2dbojk3F
 0o3w==
X-Gm-Message-State: ABy/qLbqliCb83fwKNR8CzaYvPKbqxjFxjdrYxiJqavyOb5E5fip+sNa
 6G3YgSde1LpEBsz4ZBMSE8cIQQ==
X-Google-Smtp-Source: APBJJlHhevSq6vc7/Oi/yy9eRUAsqNjVQGaf8KS4+q3or7+VYCwb7JtU5NcQQRhwqQMbW+Y3LA7h8A==
X-Received: by 2002:a05:600c:3d13:b0:3fb:e1d0:6417 with SMTP id
 bh19-20020a05600c3d1300b003fbe1d06417mr9982669wmb.19.1690795499862; 
 Mon, 31 Jul 2023 02:24:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 l7-20020adfe587000000b00314172ba213sm12479392wrm.108.2023.07.31.02.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:24:59 -0700 (PDT)
Message-ID: <041b51f7-936a-084e-e25c-8d1ca769f07d@linaro.org>
Date: Mon, 31 Jul 2023 11:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/dbus: fix clang compilation issue
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20230726151221.515761-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230726151221.515761-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 26/7/23 17:12, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../ui/dbus-listener.c:236:9: error: expected expression
>          Error *err = NULL;
> 
> See:
> https://gitlab.com/qemu-project/qemu/-/issues/1782#note_1488517427
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



