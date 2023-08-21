Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D9782468
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzEa-0008Pm-Ko; Mon, 21 Aug 2023 03:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzEW-0008OQ-6z
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:21:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzEU-00027z-04
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:21:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso28572805e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692602508; x=1693207308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DMXpivqqSTWqZNeFx1hT/I1Lyu90Li+ESWiQfQy0SY=;
 b=V3BMQqevFnpz74nuJ6n/9u7BiU74JRfxw65UQ3PEsCEfyDF15NeuUzpHMDEBVXy0kT
 6J1lSIVO6HK5P+wbu98YG8OYkp2AiviOltHroxaD/Z+mC8IUfYXfDDQ3FVJlGlxBCDt8
 BE9X7QEx0d2ZZzuoDxfhYn0jTjE5yO0l+kM20fVWIPPHe7PkLT5ag7ulDgsmAqWGpCmy
 XpcXcrJ0PPfNUM7j5AIEKI6ipifi63XibdtdjGoz/6kWJrNN1qvkLAVQh0zX1j1G6vb7
 LNBobcWrd62jnxy/6VuEjwPXlJUzbkqOcJSYwluAdgl4gn8CDQ8p+qa+0IxfeamdmvQa
 U9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692602508; x=1693207308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DMXpivqqSTWqZNeFx1hT/I1Lyu90Li+ESWiQfQy0SY=;
 b=Zz/zthRDszBp8kmKRw4Rp6x7Jrx4QTUMxOMInfxnwyv8Mo3jnDF3vCvgYIMyvnprrn
 GkC1yqxXesDDKkBbG7e4etlEHAOTbUUBKw/7W4o9ANXldxgbUX0PouA8WRaOEOhjsukH
 SxJVf94Behi15NCaFnD9cl4YR7WS55NMFCeyoeTW8uQYNFIiHB5W7+1FyyPxMohIhAZ2
 LhDwAdQG3F1GG9JuSxg4oLtL9nNz1CJMj9/lpaoHNq+WQNfs6VVZJGtwRqVObXsU5kV1
 XEPHdU6VHWIIUEXjTVacoFP30+4w8dVEV8w5FVIV2UMiDCwtPPQ7tiMCHtij7dN756NF
 ltNw==
X-Gm-Message-State: AOJu0Ywn5X/1+DjIKx+US5dwom6kVVP8siBIsU1IKq7ufMz8puNpPpjW
 G6l/WWBfs/Uw8czuKLB6DwQRBKiblHVTUDQIrUQ=
X-Google-Smtp-Source: AGHT+IG1iTuQ5Ne7o6qZgLT14MVxTqdDQN7oihODzmg0TOIml6pDu9V09QNPn9Py/djxOnBDiOpLtQ==
X-Received: by 2002:a05:600c:2046:b0:3fe:2f31:8bf7 with SMTP id
 p6-20020a05600c204600b003fe2f318bf7mr4624695wmg.26.1692602508474; 
 Mon, 21 Aug 2023 00:21:48 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 u4-20020a7bc044000000b003fe2bea77ccsm11706898wmc.5.2023.08.21.00.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:21:48 -0700 (PDT)
Message-ID: <e5a99b8f-34b6-3c6e-818d-6c9ecd2ce1c5@linaro.org>
Date: Mon, 21 Aug 2023 09:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 17/23] tcg/i386: Merge tcg_out_brcond{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 00:13, Richard Henderson wrote:
> Pass a rexw parameter instead of duplicating the functions.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 110 +++++++++++++++++---------------------
>   1 file changed, 49 insertions(+), 61 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


