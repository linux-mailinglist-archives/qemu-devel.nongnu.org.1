Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122A739696
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 07:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCCSw-0004f8-2g; Thu, 22 Jun 2023 01:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCCSt-0004dG-Br
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:02:39 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCCSr-00034n-Mx
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:02:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51bdca52424so1520794a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687410155; x=1690002155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXUfc7hGokm3Dbcq5WJbG8+L18bzXjGTIBxT2q6jkiA=;
 b=hcJVgiq0Q9d865B+zFv9mLqkKGtWelENyBa2A7qmTOJnUwQm14s95bd3GWwzGwvdZq
 vU69QTDD+MM3ODQSvVwhPUA4SD5SBCQImdUM4q339eH8c9v3xlpQK0tev8J2C02ZJLun
 z3lXnvXC5o60eKt7s+GPYNVcr9ifp+Q1nMYAeGnGQaEoZBEiRRhepYyO06b/dE3bf5Ay
 ifo+nOxmDWAX4yv+aQFYhNFArmSmm7TDbxILvk69GIUiy6uYLz6WaFxCgAsUlBsuC1Z5
 +0ug0TSQNsPa58JC9+EDqw4iWOp24LEy0S+tQl6Yj9L5JT2abJX+eM9yR/uWzgIqW1Eh
 Xh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687410155; x=1690002155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXUfc7hGokm3Dbcq5WJbG8+L18bzXjGTIBxT2q6jkiA=;
 b=AHcLm1+WTEBniil9/hYQSbgKTqYtiIgF53m+exG00r8U21gvWQaDDYAzRzZY17+4PY
 uKptrOc5t1s9AzUAcG0YGpniatp8E0bs/NcMynMPTt1LMrMn0PVYUC3hg95o0qF6/RXB
 FDW02L0I048A7JR99WEnQkpdPqTYvEky7YcuJnNMiNegvD9zHhAO+sO/kIVaQKfivszw
 Nkta8aKLb6j0QiXRS15nTmYQjS0ss/AMuMXy0QqjVcr+uNU7p3Dm32n10D/3wmXKe97i
 Y8JjtZ4LuG7NNKcxjQbTTeOA3qnt1Wtnr4T0kvrJl0R/5lBnz36ooQs/kROE0JYLquZb
 CCGQ==
X-Gm-Message-State: AC+VfDw4znLjaAZYpcPE1tGG5/nQVC4iMf2zzFP2jpUAVeS2PkgTGBIb
 xsljM1Y9Rua3T3JJAeYp2ow2GQ==
X-Google-Smtp-Source: ACHHUZ5TViKVwoArY+NSkr8hRqu0UV29diLv7JL/HUmhB6qhzwOJkGvClsaxA2d7Onri+WYV0C9r3A==
X-Received: by 2002:a17:906:da8a:b0:97d:2bcc:47d5 with SMTP id
 xh10-20020a170906da8a00b0097d2bcc47d5mr15199792ejb.49.1687410155597; 
 Wed, 21 Jun 2023 22:02:35 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.171.45])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170906c08400b009788d51e4b9sm4093407ejz.130.2023.06.21.22.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 22:02:35 -0700 (PDT)
Message-ID: <1f1d2da4-4402-d92a-c0f9-5f7f06089ccb@linaro.org>
Date: Thu, 22 Jun 2023 07:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ui/gtk: making dmabuf NULL when it's released.
Content-Language: en-US
To: Dongwon Kim <dongwon.kim@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20230621221134.29802-1-dongwon.kim@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621221134.29802-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/22/23 00:11, Dongwon Kim wrote:
>   static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
>                                    QemuDmaBuf *dmabuf)
>   {
> +    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>   #ifdef CONFIG_GBM
>       egl_dmabuf_release_texture(dmabuf);
> +    if (vc->gfx.guest_fb.dmabuf == dmabuf) {
> +        vc->gfx.guest_fb.dmabuf = NULL;
> +    }
>   #endif
>   }

Conditionally unused variable outside the ifdef.

r~

