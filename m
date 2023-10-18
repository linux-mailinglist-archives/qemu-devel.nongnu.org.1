Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 461137CDD59
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6e6-0007rY-04; Wed, 18 Oct 2023 09:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6e0-0007i8-5y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:31 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dy-0004kH-Ns
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:27 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5079eed8bfbso6733647e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635884; x=1698240684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fBk/AjaKXtg/3Cadooq/dQVl7/DOz/dAP5kScFSNmWc=;
 b=of69JM1oVBiO75ATbpKdHXA4eBv8VaJ0MisgGaLLOjgvy29uhJf3v3wQbLowpJ/WsY
 6/n5leuYZzvut3E3Myb+fk60/Gcb9ReYCsrSW6KS/Q20BEW/9y4EQHgBhUnkuk1eo31O
 vGu37exCPbgtoGNnVqrh684Z9IO2Z36Pu4D14o3M4Mq9PbWjG6GieIDJbj0WXrLhIx7+
 yeDa3Dv4PMptbIUj6bq3rcGP7MntbVf/wEZ31LgiRXpTbNIeRNuQpeDGu+BcHWdVspOw
 a00Y6/YkggN6wSnX5qETBhpvqXEVGOLQTKEkWpI8qFTmaJrWpIgSk1TrlawKUdR6ND0O
 MgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635884; x=1698240684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fBk/AjaKXtg/3Cadooq/dQVl7/DOz/dAP5kScFSNmWc=;
 b=igl5TOdPaW0Ruc0Ay9HaDxe8BT9voT4mdDNQkBxhMpj4Et6bI8oaOz+V8iHv+I4Vrk
 qCkmeFl/7Ji8Y4E7CZrPkL4mA/EeTxS9LaxUWFe/WJABpzOTAtb8DiU6bvDRqjP9Q7CX
 piUPhsdbHDw6xyADo/2UNgYmoqziRE008mug2Kw0AuGFEiYIWoLxnW02y2Aoint4KtyY
 HfDlBebzLyQ4iOVJWHa1+2PK+SV0PC956tfDvNdpaENBxqmu24edbB/BuGhy0mxrV5VB
 lTiMrCJ2mb5AiL8X5WqYNZw6LDRy8hof3xT6zT8bdySLnnZ2Utn7Y77XjKSOUkqBW2H1
 OGeA==
X-Gm-Message-State: AOJu0YyPmiD+zcpNLe8oW2OGCrDZ+v/qDPUaHfgu5NuI7DyVOgmP8aWI
 0Q67qbzOpZMtu6T3HDGKM02N9w==
X-Google-Smtp-Source: AGHT+IEjkU6WOf7I/JW3FatBUlF6eEuhf0csyBXUSIjcfWng9BiI7tYYPpRIY56LttAFzQ7ddcNbAw==
X-Received: by 2002:a05:6512:3195:b0:503:34b8:20b with SMTP id
 i21-20020a056512319500b0050334b8020bmr5379788lfe.65.1697635884004; 
 Wed, 18 Oct 2023 06:31:24 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 f19-20020adfb613000000b003232380ffd7sm2105895wre.102.2023.10.18.06.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:31:23 -0700 (PDT)
Message-ID: <fc662ca4-9d74-ca37-f65b-4d852f1eb1ee@linaro.org>
Date: Wed, 18 Oct 2023 15:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add docs/devel/ebpf_rss.rst to the EBPF
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org, Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20231017151740.213679-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017151740.213679-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/23 17:17, Thomas Huth wrote:
> This doc file obviously belongs to the EBPF section.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



