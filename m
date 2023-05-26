Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5171232E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TXj-0007SV-Pu; Fri, 26 May 2023 05:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TXi-0007RF-5D
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:15:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TXg-00029d-Hm
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:15:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6a6b9c079so3561325e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685092523; x=1687684523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PfoGayieKw5/sD44StzWS//YErReMrlfOIYAOd2iBlE=;
 b=ca6wr6NR6EoDZxPKisNDr1gGpBG5tN8RAzbgsLV1IY7ANp4r7dmJscYGL+50W/ikkZ
 9lq/Vbc5OWJ5J1o8dlmHKS163V1Lf3Pz0An5rJCu+v6SYJJoOBQT8rm8MO2cbejyfqA5
 npfAO2uUn2iUnC4FkqjL4RsiY95E4mZhUerboxFQNa8wIcYCqtiPjRtd4UGxf33Z4B4v
 93Fs09HHPA+He1kZQ52ObZLVgNee8BLDJ42Y9aRjR2vIH0qx2J4d8SIyygtKeWeCZ8HV
 xLYCwiK2qCqNUJSeUvJq+0KDRV4bAL7Xi1XYRj6BJY2yI7MUA/cvczRCerx7T/31/E+U
 YBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685092523; x=1687684523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PfoGayieKw5/sD44StzWS//YErReMrlfOIYAOd2iBlE=;
 b=Ltiq31CA8hR5MbuEkBVscJzhJHv36b+rxmYKfhbfqeSKlLYGn+2r7V8Hfgq2CeNijm
 PDhrCyXFIjwDewDVz1D8uUO7GbKqLQUorh9daMtz9dLiPijcKQAoQeFn2Sa0PnCImH0K
 /X2iiIbaRFJ/JK0C/mCOYiPYwAMlmuDRt4rBjxRTOB3r+6WK+4mwNdqhBGEfU9pd8qOp
 aFNyBlgBtle1OBCSGtPLSnOO5HhvfXmxYkgbaZvpKUDSXoliTeU9srdvqwwuH9K3v/Gt
 YmJXNPkTRcDg7vf2uF25Gez65SIUgORSmbDLC8b5o/0yo7dVaF8e7eW4qYCMTqlFXsWO
 3f9w==
X-Gm-Message-State: AC+VfDwOjRXsk0BQsk9Gja+mqPKwIvPvCUypXm/hNYeDIl3+c8g6VD+7
 ZL1Lug94b+kKOG4B1VlZjUCX/g==
X-Google-Smtp-Source: ACHHUZ4lA3KVqlJyqk54qypXnK7ZH2uNnQUfbFMArjMRbV7z8Sa5gsPAH4JFX3CJ4hYDQFFeQNTdpw==
X-Received: by 2002:a7b:c407:0:b0:3f4:ed25:8aa9 with SMTP id
 k7-20020a7bc407000000b003f4ed258aa9mr942519wmi.36.1685092523144; 
 Fri, 26 May 2023 02:15:23 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003f6041f5a6csm4553582wmj.12.2023.05.26.02.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:15:22 -0700 (PDT)
Message-ID: <dea2e42e-b710-c7dd-a6fb-c770e65b1ac9@linaro.org>
Date: Fri, 26 May 2023 11:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/27] tests/vm: Configure netbsd to use Python 3.10
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, berrange@redhat.com
References: <20230516105908.527838-1-pbonzini@redhat.com>
 <20230516105908.527838-13-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230516105908.527838-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 16/5/23 12:58, Paolo Bonzini wrote:
> From: John Snow <jsnow@redhat.com>
> 
> NetBSD removes some packages from the Python stdlib, but only
> re-packages them for Python 3.10. Switch to using Python 3.10.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230511035435.734312-13-jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/vm/netbsd | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



