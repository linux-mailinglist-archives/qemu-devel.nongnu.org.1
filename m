Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76013822E32
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:27:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1Gk-0008Nz-In; Wed, 03 Jan 2024 08:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1Gh-0008MP-0o
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:26:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1Gf-00053i-F9
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:26:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so2808650f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704288403; x=1704893203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sv452OOA1YHAvH4egC8pCNjgvS+mWVxvhFGgNYtEQNo=;
 b=mONyJJhhZwIoN8mRHCNaJNmSPLS1zNNuW4kf6pjSdcH8KrS6cc6T2j4P+3Ah0nLmx8
 6uH/B+uMI9yYzHHNWhMHcTEOFFEv6v+d11b1ojkxKWrELqUuGw516/AChdyTzEp2Smuc
 Dl1y6HoqOBExiBtiis7qcfQPqfIMk3ZsZe4/wSGQBpApuQTvkSuIpYBrf1mF6QyjTgtK
 yR4QFKFYarIFjbBANlFpfy6jB4JPd3wOs6CYbLKXlcinURwaNB0V2sDHDvMc9c0TG9+H
 xT7FbvNf17xs+o4zVajnEmX7EHAQjXX5LSt4N6ZhU5eEWomUi+QB9UyHuipbjsq8xZhe
 wHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704288403; x=1704893203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sv452OOA1YHAvH4egC8pCNjgvS+mWVxvhFGgNYtEQNo=;
 b=bsvoksUSX8kDa2yAlETb2AiL6J+e1k24TAM68fMor4mpPpyDknOPC8JuhK0xPVWeJC
 qHiUsjc4TfkyjFZ1ToiRB6i2CBYMiAk4oRXL5O7DivweD/fHfSDhVWd5mPb/ZokjlmAe
 CsVU+ogIvwk9BhCgd0qUL9py988OzcjAEJCdDLOVxgf8CRcxd27I5Ry4yn1cQUG3nOxj
 w4IH6Kj1WFJ+/XJd0vnGI3FK2dVuBZ+uXzsxu+xDg4tPxGWh4jopWi2zbboqg4xVds27
 CZcwBW9hHo/Lc0zkkcBfhBg3BCw1PikuSe5KwqRI82IGgDRMbRlbFQr7024w7iNdUbs4
 1OCA==
X-Gm-Message-State: AOJu0Yyfp19dUsblUR89YGCwpdS7+jYpfU3nEdp0TTS9GiL2xebZJMIX
 CC1GRFa0H/m/1M0NbrJQBfD5oPqHJAhUkA==
X-Google-Smtp-Source: AGHT+IHNP6NzKRLKlPniuIS1rZZjW6SEXn1CKQoQJr3kWejuXjIklLqYzpTZ0ZsgF6/tEnN/Mf8YRg==
X-Received: by 2002:a5d:4d87:0:b0:337:f1c:fc13 with SMTP id
 b7-20020a5d4d87000000b003370f1cfc13mr3081820wru.215.1704288403386; 
 Wed, 03 Jan 2024 05:26:43 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 u17-20020a5d4351000000b00336f05840c4sm17998086wrr.100.2024.01.03.05.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 05:26:42 -0800 (PST)
Message-ID: <a81a9bb0-4d5b-40bb-b6b2-87c70ba23743@linaro.org>
Date: Wed, 3 Jan 2024 14:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui: drop VNC feature _MASK constants
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240103122600.2399662-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103122600.2399662-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/1/24 13:26, Daniel P. Berrangé wrote:
> Each VNC feature enum entry has a corresponding _MASK constant
> which is the bit-shifted value. It is very easy for contributors
> to accidentally use the _MASK constant, instead of the non-_MASK
> constant, or the reverse. No compiler warning is possible and
> it'll just silently do the wrong thing at runtime.
> 
> By introducing the vnc_set_feature helper method, we can drop
> all the _MASK constants and thus prevent any future accidents.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ui/vnc.c | 34 +++++++++++++++++-----------------
>   ui/vnc.h | 21 ++++-----------------
>   2 files changed, 21 insertions(+), 34 deletions(-)


> @@ -599,6 +582,10 @@ static inline uint32_t vnc_has_feature(VncState *vs, int feature) {
>       return (vs->features & (1 << feature));
>   }
>   
> +static inline void vnc_set_feature(VncState *vs, int feature) {

Even stricter using s/int/VncFeatures/ enum type.

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    vs->features |= (1 << feature);
> +}

