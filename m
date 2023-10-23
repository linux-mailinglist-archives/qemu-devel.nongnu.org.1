Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB07D3A66
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwa2-0006ad-Mz; Mon, 23 Oct 2023 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwZn-0006Xq-4Y
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:10:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwZk-0006Te-FO
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:10:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so717167766b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073839; x=1698678639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1BSfZ3HPCVJO8ucVdVcap2gfnIDLmVl3Gh7KHBH7GHg=;
 b=pMW9/7lJ6tLQw9ymU9v34MhKdrnFKYycZjdVY3XCsQ6a+9aPuXdWBbz14mnRs+YWFT
 /HwOopx+G/r/A8tleJjUZ/zvjMO3GQIvSq8RcdXtGTvtI8IdhNHm8Q4DkXIT9SbBNIUm
 P3igHU+wT4x/19vOas8MDAYEvRp70hxGTueal/yX3W0WEhrn8thc1E6l/KDrfLxytRJe
 qs6OnCJxpKjsyrAQC3dxxR5xK1ItFJ5L8TWabSM71YLRceIDnTN2KHZlaorqRdMpK1RJ
 AY3xCoabElD61xNmwKq4p6QcuQnqxV54sfv3XbIi/36V2Ks4S9DoVUv4lGmEwRot+LmD
 2Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073839; x=1698678639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1BSfZ3HPCVJO8ucVdVcap2gfnIDLmVl3Gh7KHBH7GHg=;
 b=cyLzZXAANGI+kQFtq+3w84Xi/upWjEV/8Q57RZ/YIFxqj7/29OtaG16FG58HNk/+2b
 8Av1BBxPOi5kWZmp4ltAQWPNeiw4NaIWg3W2Jj0wAetv6gAxbOv+NnCUC+cZYJG3HLcW
 KAQ22ALW7f+ldPcNr/mXpCsVQ//j0T7d054YTk6WMReur7v6HnbBuZXPcf9QCUEQfRUR
 7eXnOZPcwrSVwKc4vr41Wp3MPENv3MWCLJjEdzXw7NSoEjDjZSV1CkVYoTjFjL/25b6G
 ca+gIzgVKs34zsxKtNR2wfhmhjpxIAxVDSCw6J4GMyROC9dM6aUqiFYrBCiCSUTdt26l
 yggQ==
X-Gm-Message-State: AOJu0Ywjf/SEuEcptc/ehkQOltNAjYYfuO9DUluore/tNxXczTA2hVQs
 +KNFaWH43sgytshcwjwsIYNOkVOJkNwDnX1tF94=
X-Google-Smtp-Source: AGHT+IF6zCHpp0xzeXZU9K/FcVoRbJ6W6zuhiZCiQCJL8VDr9fgQVkqXUli4sCrq5Qr2jRYTiFC0TA==
X-Received: by 2002:a17:907:6e8c:b0:9a1:b85d:c952 with SMTP id
 sh12-20020a1709076e8c00b009a1b85dc952mr9394835ejc.12.1698073838951; 
 Mon, 23 Oct 2023 08:10:38 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a170906088d00b0098ec690e6d7sm6767475eje.73.2023.10.23.08.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:10:38 -0700 (PDT)
Message-ID: <9681f796-b5c3-f981-eb26-e738fb1f52d5@linaro.org>
Date: Mon, 23 Oct 2023 17:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/7] target/xtensa: Use tcg_gen_sextract_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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
>   target/xtensa/translate.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


