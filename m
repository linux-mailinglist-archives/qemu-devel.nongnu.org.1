Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E98769919
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTbi-0002Lw-14; Mon, 31 Jul 2023 10:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTbg-0002Lm-K9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:10:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTbe-0006sO-QQ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:10:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-314172bac25so4046875f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812641; x=1691417441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nf5fXEmzoJT0k4tzDMOHLFPPASzYUgmEKNPSaYMd8Io=;
 b=ws8G8OPAFNiqLqhoN4nJJAE9OtgPaxuc928kpKVaiR/3kcPKgmgLLiumKBRgheFS1A
 hJl9K4CtTySHAUrRkAnn1cT05+3MD+Px/weU5WPZxtg7Jn5GbgHlhJHGGD/xMkla57XN
 IFIMoGBQC/QUwQhsH++ht3zbiKvWKHZAGgP1TjuTj3UJFTw8mnpiECOipH9yBQXh95T8
 ZtzXyk95hHbafc5RXPcW6kWNgNbHu6ZkgLF1ox6uQA23mw1kyAhcqf1g2s20RY/higZM
 dgwU2Q2uaflNM3vx/zne4G77bYc0FiEzlSKoZ+o0nUBSFPNj+Sah9oXC9tbhUsWWteHj
 sHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812641; x=1691417441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf5fXEmzoJT0k4tzDMOHLFPPASzYUgmEKNPSaYMd8Io=;
 b=czpYSZdchuUlbMktOpqlSyI/w9Qx8B1z1iK9YuJEmiOZ27wM6CpA6rItoJktVI9bXb
 aIRzSrTJ5BKTVYfP7O/3rabRZETvfL7PitCZVs1EMdtUsJgqItUeFaXrA8GzR/Vq9TzX
 soMJ32aTxxzCGOUgSaX92BKTbSdTGvJOeEMG9dQWZyfUGyIr9rQnBxW60bJPdOd5zMeB
 FCpJEnpvrcuY7ElQ/VbhymAHJhgy/iSQllsCsKs9KghgAHCxIcg1mbNCooXxRalMgLjx
 vR2VPwFtJk6szCVPSULm5Ad6L6NqgaMgeBmW1aHytd47h2n9cLarXwvOl5TEsS2Yy76W
 9Wzg==
X-Gm-Message-State: ABy/qLZ6aCHeFidfOIBBwlrHWjegoMQ2hyWmk1/HVIqXYU287c5JxDjn
 Y7tkV1+HOZMyWc4hgwrqB5mymg==
X-Google-Smtp-Source: APBJJlGx2mTp2B1aza5Jvo07drZ4C57rWk6ZpH90JQz3NMhDEfrgKCW9W2nfIdf3P4mynvo3kZ1nhA==
X-Received: by 2002:adf:f602:0:b0:317:3f64:4901 with SMTP id
 t2-20020adff602000000b003173f644901mr4729644wrp.41.1690812640725; 
 Mon, 31 Jul 2023 07:10:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a05600c219a00b003fe24df4182sm1098391wme.1.2023.07.31.07.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:10:40 -0700 (PDT)
Message-ID: <2ff2a91e-6199-045b-c86e-1023e88eb32c@linaro.org>
Date: Mon, 31 Jul 2023 16:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <ZMd/pdT5DmPxtjYW@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZMd/pdT5DmPxtjYW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 31/7/23 11:32, Daniel P. Berrangé wrote:

> I was surprised to see that we're not using ccache in gitlab CI. It wouldn't
> help the from-clean compile time, but thereafter it ought to help. I'm doing
> some tests with that to see the impact.

I tried that few years ago and this had very negative impact on custom
runners (maybe I wasn't doing it correctly). Hopefully that changed.

See some previous comments:
https://lists.nongnu.org/archive/html/qemu-devel/2021-04/msg02220.html

> Another option might be to try precompiled headers, which meson supports
> quite nicely / transparently. Might especially help on Windows where the
> entire world is declared in windows.h
> 
> 
> With regards,
> Daniel


