Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4A7362AF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 06:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBT8F-0005Mh-51; Tue, 20 Jun 2023 00:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBT8C-0005Lt-Sv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 00:38:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBT8B-0004L2-3b
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 00:38:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso524066066b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687235892; x=1689827892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UG4uBFrRr5Yx1/HuEYwEyUwZPJrE3hLfVveVeJkzMOk=;
 b=m6scL81PQ9Shlf3q56taxksPjGDKpVtcrfbealX2UklFSnPfHv6tqQkaS6byB9RjSD
 EASS/cRR4HPgOB4JcABzfTln6Jp8gCiwm+Zqri9DZJMYaEpd6Lxb24GS+8gUGn96qV9X
 fCxl132scsmsnKWZdM7MuO9lo9881TWsxyn4LjGKhya3ZSmwkxL/hPVd+YXTfSQzoUX0
 PJLU+kKERI+/akG6n1g4miM7b+dwWIxB2+xNp1yZy8TopC/nHnHO5KPIrEYwkZXtXnmD
 rj+9+pmnjyJm17v0y8yBtk48IyXjXnxU9ZjzliHxCA+ucMssC8xqwsKa7nvy8zVsAzsr
 sIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687235892; x=1689827892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UG4uBFrRr5Yx1/HuEYwEyUwZPJrE3hLfVveVeJkzMOk=;
 b=cnYin8x0I6oiGCW2M47HICQyrr6YqyBbMPbo5zv3H3ewp3CvnhRG9//9e5/nphrq/t
 xePa6r1F6vk/NSOdnnHZ8pa472WecE44EOKSB3lG8SCetgx1urGVYvktU9JEhh3teK2/
 zchJxVIyCga1AOle2W9niOUSpNGveT3zRqa73BqKufK+0SCnySMiYaYeIhj/RgebuF8r
 GOh6N55xHJ6PZGT4bkGeAOxtfasawhRJ6xRDrAsvr/weNQzosBkm8AFFMi0qaHaSLA/u
 9f4AH7ZgUW2ms04MUKVYJSeqwA8st67IoNiTXmzSkWN8gRnix5692RTeL/KlVNsrZf4D
 2/Vg==
X-Gm-Message-State: AC+VfDyjL8ngc7eGaymhrYfkO1mf/EIRIqC8rSH2k9uEUUMW/wtbW8GW
 LnWvaEQRqinReAPYSILroc7XQw==
X-Google-Smtp-Source: ACHHUZ5jmVDFTjbkm5082MrLLcANZpyg3OA28xq5sCOeaDnboqMKpVTn0qHYwdShRhXvKVvF06Lx3Q==
X-Received: by 2002:a17:907:7b96:b0:97d:ee82:920a with SMTP id
 ne22-20020a1709077b9600b0097dee82920amr11709906ejc.74.1687235892202; 
 Mon, 19 Jun 2023 21:38:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 b23-20020aa7c6d7000000b005187b5b82f7sm492576eds.9.2023.06.19.21.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 21:38:11 -0700 (PDT)
Message-ID: <8a500f9d-89ed-fe66-d69e-e1ce668d46fc@linaro.org>
Date: Tue, 20 Jun 2023 06:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] docs/devel: split qom-api reference into new file
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619171437.357374-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 19/6/23 19:14, Alex Bennée wrote:
> Lets try and keep the overview of the sub-system digestible by
> splitting the core API stuff into a separate file. As QOM and QDEV
> work together we should also try and enumerate the qdev_ functions.
> Currently this is a little broken as kerneldoc doesn't understand our
> macros.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/index-api.rst |  2 ++
>   docs/devel/qdev-api.rst  | 12 ++++++++++++
>   docs/devel/qom-api.rst   |  9 +++++++++
>   docs/devel/qom.rst       |  3 ++-
>   4 files changed, 25 insertions(+), 1 deletion(-)
>   create mode 100644 docs/devel/qdev-api.rst
>   create mode 100644 docs/devel/qom-api.rst

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


