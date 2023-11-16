Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777547EDBBE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:05:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WQZ-0007fI-KX; Thu, 16 Nov 2023 02:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WQX-0007dL-J5
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:04:37 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WQS-0007SQ-6M
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:04:37 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507973f3b65so641816e87.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118270; x=1700723070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgzoGBjSRDm/DKsUmHXy1RaHuQ2AIBHoGTp6YXudO+A=;
 b=P5zIbQ8+z05CmK48uZUBtDcaoySrIXDWk2SxyP4xSudLpvkvhFCyFaSbiwLvr1djua
 MH+i24bIV0QPfX5nKZUrX9vr/5Rv6zNpGlmXLP4Xh85cy/EvaO1vXzxJSVNqH2JutGGD
 UVTYsrYzDJkVb5CMX2EtGrs9htoIvfEc4cXdv4sKBKheq5ICKWee1ApIV7KDh3s7ZTnU
 FBpcUlM5KVEOKqbP9LA6sdFWCJz8ThE9C8r8D8js+ENt9f7FYO2QNWw/NeddA9bdlD8P
 fIgwF4NolYfUFxOvgn5n2gi3xIbCKTUfkuG+LspJNC5Qtvb3wqZjn4QRBeGqnP7SC7tg
 hZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118270; x=1700723070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgzoGBjSRDm/DKsUmHXy1RaHuQ2AIBHoGTp6YXudO+A=;
 b=RctOVWGtmJkPoKB5cdWoZ/hdNoJkpklAsvB1BJDzUyenW2vAHa2LDws2PccrLiLRqQ
 2CoYuj4Egve517PYDjZB282stpYUMI5hJEMM7vx1uPLxnviI1aXq/m4KWqALkNpzPYo+
 194GGQNV8O+GiebuXvP0zl9r1+ILA9kzl1oGLZ9VqS1nDzz+VXTTXwKh1bi2Qjix9MbX
 HXDSv6BA1HorbCw2WSgo3OfWZ0a4IB58JpA8qO8lsWqWIpXLzyJWpgSO42slfXO2w7OR
 uK6Te0DwBz6TNpx1i3LaHELEuqy+H/+s+ZPU4OhhUfQd+JahMsNuUrvnJa6EOc8J2bYI
 yT2A==
X-Gm-Message-State: AOJu0YzX7KCXFixPzFCDJrGsxGUZ6NdxVgGDKXhVyYfVm8jQ4VFZYMNn
 s1Rpcm2bQYk+ZbI2tn45CXIfWA==
X-Google-Smtp-Source: AGHT+IFV7p9K7A+fOvUvQR+w0ubFOXSypTnS/1OpXXAndJLOzq5whmG+/WLJo5wAVXA/obUMW7s3fw==
X-Received: by 2002:a19:5f5a:0:b0:509:445b:dcde with SMTP id
 a26-20020a195f5a000000b00509445bdcdemr9137281lfj.22.1700118269970; 
 Wed, 15 Nov 2023 23:04:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 ga23-20020a170906b85700b009ae587ce128sm7925364ejb.216.2023.11.15.23.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:04:29 -0800 (PST)
Message-ID: <f9404d14-63af-4c09-8b51-8ad1b78ea1bd@linaro.org>
Date: Thu, 16 Nov 2023 08:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's
 benefit
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-7-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116014350.653792-7-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/11/23 02:43, John Snow wrote:
> We already take care to perform some type narrowing for arg_type and
> ret_type, but not in a way where mypy can utilize the result. A simple
> change to use a temporary variable helps the medicine go down.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/schema.py | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


