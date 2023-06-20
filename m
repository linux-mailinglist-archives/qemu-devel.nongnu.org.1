Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D423736886
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBY88-00027e-TJ; Tue, 20 Jun 2023 05:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY87-00024Q-7x
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:58:31 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY84-0002XF-Sq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:58:30 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5187aa18410so4742605a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687255107; x=1689847107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZo9BUmsdQMMVtYnmg9TiTWZiPyjjdRzwmBFivCvqyg=;
 b=DTIooRhBpLLTtXvcIJTxCUNZqGVsbM/7mej5NyXpuz/V2pTm27soeSQVsMPKEa55Ei
 H/vDHYqtrN6c+XqHu/5g8Z3iV3aVo3VLvOIpvy24x3kPCVpYfeVormg8xHWQv6jyW5nM
 2vSnU1M6yCOWc1q4HKlxN3VuhuRO8Yt91x55HhRDzoW8y2R7Ccws/VEwU4bmSnXVT7WA
 keQshw8/KYrNmrbgQcloiyWcxoPRiQU/4QYiUduez8MWVgPRMUeFERd9fbWD7VdT98xH
 K5SfypfiIrumHVqXgz/b8VtGO754uMukDnNEYVfL6aKYX5+HOv6iWp9JUOad2kZsQgdv
 WJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255107; x=1689847107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZo9BUmsdQMMVtYnmg9TiTWZiPyjjdRzwmBFivCvqyg=;
 b=LLdvlpX+BamBo5ZbldZ+N7vGRJM29LFAp6PYiuhLU38mkrlnedjBLxgOCJ6zkwAXuS
 0WVyT5V10UeEoPP+KhgyuTBRNatFjOEtEmgFdU/R9Ka+sRJ+lLoj2Ov9ary4rFMPO2cn
 x+D4lSacZ11FA7LV0/AL0Y/n4Sf/XVXhM+1CjTT5yGtmz9ob8fI9GFx/adSVFnHm+0PZ
 off8xEEcJDEYmonP/dZyBqKj1J31Bml2+NocbIu39DVkwsdpYWpQPZaC4cfxGLpIpqsx
 d9OaJcoJS14Wdzu1sME5huOgzoainZS1gzTWtoOnEKmbHsrpLFakd1vRU/uuIsDEoLv/
 e/yQ==
X-Gm-Message-State: AC+VfDy4VYkGA+ZL20uHCquXRnsNlGdCitzmnh31f91WFMpsi2sD5RHa
 r7BI9KAZAWSL+5r5k53GVXm5PQ==
X-Google-Smtp-Source: ACHHUZ5OT3d79U/xA7mneA2HKQmyKYgRNhYmiUQlBv6Kij/RdQbTbeq2KY/g9/jvO8KIsu/7q/ajWw==
X-Received: by 2002:a17:907:1b09:b0:974:771e:6bf0 with SMTP id
 mp9-20020a1709071b0900b00974771e6bf0mr9953505ejc.56.1687255107063; 
 Tue, 20 Jun 2023 02:58:27 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 ju15-20020a17090798af00b009788554ad10sm1087860ejc.138.2023.06.20.02.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:58:26 -0700 (PDT)
Message-ID: <58a6f77c-ee36-62cd-48bc-4f0e16eee2ed@linaro.org>
Date: Tue, 20 Jun 2023 11:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] include/migration: mark vmstate_register() as a
 legacy function
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619171437.357374-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 19:14, Alex Bennée wrote:
> Mention that QOM-ified devices already have support for registering
> the description.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/migration/vmstate.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

