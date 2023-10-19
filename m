Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E07F7D043C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtayh-0006Zp-3z; Thu, 19 Oct 2023 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtayf-0006VL-NG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:54:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaye-0005nJ-5W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:54:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so1306035e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697752486; x=1698357286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLFGITVoqE0cM6O2GE/9JX+TcKx2DZyVQcbUcfhhk6w=;
 b=JOWGNzmvMpPfL2tmffLwfLCwG6KpVhVDF9CQRiwxRVuszocYYpX0f8a0U8FUjE1RlB
 srLqyGyPQCsLIqesv1+yNg3a5pPTXf9LJTD11n/KgOp3FuyJRo34SBJIhVYlKvu34f3/
 zUtFfTnshoJ+f3bkzWlLZZJgnFQHgdK8Z7QydG/w3EifTz+TYP7vitMXwW7zectiysgc
 ITblOrvxMwe7pVDrVu1fnmJlU3qsBQRwxczhJj3Sqq1/O0mo0gtT74U445AZFa7rcnqK
 BRF60orx4a95sG4oKX9KY3/lJyf09UxGGUkrod6gaZFDODZs2E3kpMhci/6QCHxNpqoM
 gWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752486; x=1698357286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLFGITVoqE0cM6O2GE/9JX+TcKx2DZyVQcbUcfhhk6w=;
 b=wLDoBK3eO8hEd4iJYkBjFqfFA0o2inwaPIVjW0pLWEipUMQdhp9egSZwHOHsKlKcAc
 d0v4mrFEHV0whC5Cl5ktI5Ro1XBSgGGwqk/lZaY6rQKbgsSAPuJMB1vNUE1VTsIqT3iz
 SwpXGIob6ROoGmeVHfIIxhiaRVJFBOtSvzeI8xO+DMSmQNtsjcXO4wu8Kz6/jiDi3YOU
 Az9N81xFgsW71lEn+uTq2/53hUiANEaGL4OhR+F7mhOhVvWvV5VuQoBf2khe/yaNit6r
 h0f8VvQGnDfywBztHKvTekizSFD/8QD4Hp3wpC3eQnvhDSxGzdbhqqvw8gFWARJWFFwK
 7CfA==
X-Gm-Message-State: AOJu0YzyOfz43suxX6EOzd0kfO+4iLu/rAsU3pTX2qzzI24xrl/FgPYx
 1PwI4NmePbSKdvzarL89IIBd/Q==
X-Google-Smtp-Source: AGHT+IE4shylXZ10uADI4GqmXdnQi6ntGYBnCdbSg79ErGXy4wPzF9BXzHqMx3cnqz+SvIrhChWBEQ==
X-Received: by 2002:a05:600c:548c:b0:401:cb45:3fb8 with SMTP id
 iv12-20020a05600c548c00b00401cb453fb8mr68072wmb.38.1697752486571; 
 Thu, 19 Oct 2023 14:54:46 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003feea62440bsm552790wmj.43.2023.10.19.14.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:54:46 -0700 (PDT)
Message-ID: <33068d96-cf3e-b201-af0e-cef3f0416d8b@linaro.org>
Date: Thu, 19 Oct 2023 23:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/7] target/rx: Use tcg_gen_ext_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/10/23 20:29, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/rx/translate.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


