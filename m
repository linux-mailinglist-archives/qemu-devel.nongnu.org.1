Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63E7D4F75
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGB5-0006t6-3d; Tue, 24 Oct 2023 08:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvGAn-0006qc-U6
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:06:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvGAm-00027o-3w
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:06:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso32425985e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698149167; x=1698753967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQO0rUS/pYybVIAzOqqSurq5TtdAqwkv8i1ZzBFwBlY=;
 b=OpGTldMkdfj/Y84I2CuqM2UyHABQfOqtrrNY+N58Lbxc10nHXP/ATcpilHy8glMn8L
 QItSYlSnsFSt/+e7Otm/s0Hnr5wqOjL7gFWbp1rgZh9TeAlBBWxLGDJp09K9U3pV4pRo
 jABzljtVxFzITCUUF4AazM968atvPLVWDJo4AWGJgtbI5PNUFDIDjDd9OBZhNJ/IJk1Q
 zHVKJyxL7s17UXozSNfeO392/RVCnttqNgXz4I8Av+sPGDa3DHoOzKXB1WhK90vugtF2
 Bjbab2W7Pw9xadQ/a/7OBJFfIaoN6kFevCrnBl2iz3ojqS4s0s4a1eFbe5n3rCvIC+au
 68lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698149167; x=1698753967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQO0rUS/pYybVIAzOqqSurq5TtdAqwkv8i1ZzBFwBlY=;
 b=KCk7nPMlnON3cSDLxpFPkVv2ZHpuZdO/RVUQ0wsOIb4P2o6ER+C/AXGtOEa9/UKeNn
 o6YZKDU+KOePytkwpQpQVi0pTp3ORO9X5nEd7DzzYH1DFbxYeZ4uz7DYbU/v9luf9GTd
 4x/5XY+fa9MpZiRxe5suIqlVSfGLwn0B/wce0Ll49ZYj3SprEPypRnEgfb3A9/4U4obh
 00DtsFjJgZfdyTETUEECyD3S6j+U/c95vineA4QlIAWi/MznxOUyRgk7pU46LWHotg3s
 cVK4z0uFKmySj8QP667jjymCgdzsuHp2tpam/t4kqe3EifpJspK3Yt5zAYTNgTRmEoX0
 qzig==
X-Gm-Message-State: AOJu0YwPkm6m3AutIvI46MkCEaeev7VDpwY0bk7nUDXoCsVF98wl2ld+
 BP7qZ+AWlp010PdVYN6hkGtnNg==
X-Google-Smtp-Source: AGHT+IEGH00Oac3HwGYYpvBqfNvyLBJcUgWmtvUvBLCh4GtQxf4Sssgcuu5SNppI+Vattiv5iqQFrQ==
X-Received: by 2002:a05:600c:1d8a:b0:406:54e4:359c with SMTP id
 p10-20020a05600c1d8a00b0040654e4359cmr9461121wms.19.1698149166723; 
 Tue, 24 Oct 2023 05:06:06 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b00407752f5ab6sm12057422wmo.6.2023.10.24.05.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:06:06 -0700 (PDT)
Message-ID: <f90ad76f-5a03-0d31-2f7c-4a5cc871d50b@linaro.org>
Date: Tue, 24 Oct 2023 14:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] qapi: Fix QAPISchemaEntity.__repr__()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20231024104841.1569250-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024104841.1569250-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 12:48, Markus Armbruster wrote:
> I messed it up on merge.  It's a debugging aid, so no impact on build.
> 
> Fixes: e307a8174bb8 (qapi: provide a friendly string representation of QAPI classes)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/schema.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


