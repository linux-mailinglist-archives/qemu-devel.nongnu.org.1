Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE47E207C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:54:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy99-0005LB-Qw; Mon, 06 Nov 2023 06:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy96-00054Z-Gh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy94-0006TZ-Pq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:51:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso31028385e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271513; x=1699876313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4PkhJ3xY+799I5y4lupj4ocNerUgAnzPbQWBzcAdCqo=;
 b=LIzTWz6SdmZU1abOzgH9JunfSmQZ6OTkZpZ92n1pFJo+7k7tL7kNRCGJSaQm4bb0V9
 fcCYakVUeKuzuF+nXw9d0I48kQg/Zgb1J5k+UGZ2DUIct7N0MJzAiOtXWJ4nV1r6WRWO
 yVVloGZlP0gnA1sm74y4hl51/gvoTKxN0ASLVyv5tIrkj6SBf1BnWR3zpZrgVNcIHStA
 fY6t9DCYOtqGzsqbdOiIz4DN2WfT3oKxWa7gGBk5rTaFAllkX255Czp3YI2shIN9y3z3
 nGfh5UXvuHKBRVkpdZtnZxj8YXnsjSplnlc/OgTtF//Ec4C84bcd268QB5Dl/wJ8PCow
 QWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271513; x=1699876313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PkhJ3xY+799I5y4lupj4ocNerUgAnzPbQWBzcAdCqo=;
 b=Q9z57mZdeytJ4AHnPQ8Ord11JRPVWSiOxFT+yjHY/7jfBFTW39tNM9Thf2LHdywmOQ
 uWNDuj1KYnzPcmUM8ROziPN937UbRSW+0kNNP/6CkQbBVYWuElttGVAI5beP6ijteaBM
 fnCAy/uK1RGkUSVsfI9nBpRf48AT9kGNwjYUpB0Y1NiHqc5AFtv+7N57RTrq6rhhG4K3
 MssjXpKA/vPMwCzMLtiCjTBbIy7TQshDZrjWC6tu+XWE1TABOvELAlv+gHdEbyhlNzU1
 upItDGe+0LUsXB9scjd79eMNLw7pGa0X6MnpO+LP4ynGSHHDS7/S9NsruexF7FSTndw2
 0GNw==
X-Gm-Message-State: AOJu0YwizPQMuwsPDd1HG4HZ8Kn9yCRpb2fiCkKcRl7yqf3luloZdOJn
 IWgBPF1oNjsiSCXYYIXolw2kMQ==
X-Google-Smtp-Source: AGHT+IGUWWdkgvRXUcd+bme8DoWFQY/wcq68dgAuQdQpkBE20SUX00XOkWFpdExaZ2cltdWw6+iu6w==
X-Received: by 2002:a05:600c:1381:b0:409:45e6:f8e9 with SMTP id
 u1-20020a05600c138100b0040945e6f8e9mr16210222wmf.14.1699271512928; 
 Mon, 06 Nov 2023 03:51:52 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm12243021wmb.41.2023.11.06.03.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:51:52 -0800 (PST)
Message-ID: <bd500dd1-bef6-10a5-9496-bb17d0ed579f@linaro.org>
Date: Mon, 6 Nov 2023 12:51:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 71/71] docs: Constify VMstate in examples
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-72-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-72-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/devel/clocks.rst    | 2 +-
>   docs/devel/migration.rst | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


