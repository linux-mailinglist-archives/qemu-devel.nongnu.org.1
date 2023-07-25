Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE6761C5C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJTp-0001NP-Dc; Tue, 25 Jul 2023 10:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJTl-0001Hw-Ew
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:57:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJTj-0000qX-Ka
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:57:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31771a876b5so202151f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297053; x=1690901853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rohruD2ujv/VkBtKXN6/T8koRSybSLmT3S7+wgJpmV0=;
 b=qGBfhf+/i/9wmI3g5+0HQ2++AwvrX4FilH0gykCGaz9tBNzo4bVcvkaY2QxIW9uqxu
 HJzaU45d3jrb4qPIUP6QMbnMMi+b5V5C448aKTagZXkKU5rt97vbSMQuNm2FU1YEvC3v
 mEfzVZ7JK02IfZ93lN2Zd7yTHAPRK1qRTRe6xJiMORxdTF3lZuVPyYIEKxDSMrrnKi/P
 X4fyiq+qA91XO0wB93C54gKOoMtLeqWM+QDC9zP7NR8xpbcxk+Z7LqrHtUQvWsyLIRTl
 TJ1OMdrQzyWNo9pnJxeCpLno9n1L1SfFk3E53q9c1wRNti13A4DynVSQ10YnIDHpVd35
 hlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297053; x=1690901853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rohruD2ujv/VkBtKXN6/T8koRSybSLmT3S7+wgJpmV0=;
 b=KkPHdNQwZsMULvB4StFvJ88wRzBrnE9bhy9RO+v9UGlTh7z2JkPP7c9aLbUV8OGl1W
 Ln213eyKGAaGR0nyDRt41TD8Z9x/krD2WC3u7t6UA5iBjDda+AhlGUIDowYvzAiKXUTN
 PIXs/WzRgsD5Xx1/8DvwOBU2o+/mviKc5d8sf6Gk0umiA9FARMKL797HdS/Aln9x6tJV
 7olhQg1WBpwfgca5V2FSVcFmzUeFULyLnaVPxWWYVPj6I92JIz0wT6/rMkF71/VNAZPn
 4otj2TX/AQQ6/OPPycwOgiMLknebya8o6W1lTCh9U2bncmAszu7DYVqYwOd2t7DYN4PW
 vytA==
X-Gm-Message-State: ABy/qLZHEw/Rt5+9UQDVxgx6VVJUM+UoKW+rT9SxjEjenBVyf5+G7EVj
 DEG+3ZL/3TOnSZg/j33CRaeFlA==
X-Google-Smtp-Source: APBJJlHqayxxDv7HnylvbLD7g+nmEP9XcEL9Lj8C3FHD4VvHh2qAD8YNm8EGfa3ea8gQyE6H0mXAXw==
X-Received: by 2002:a5d:5511:0:b0:317:5a71:9231 with SMTP id
 b17-20020a5d5511000000b003175a719231mr5937509wrv.51.1690297053360; 
 Tue, 25 Jul 2023 07:57:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 j16-20020adfea50000000b0031424f4ef1dsm16788331wrn.19.2023.07.25.07.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 07:57:33 -0700 (PDT)
Message-ID: <3f544852-15b0-512d-136c-d92712d31682@linaro.org>
Date: Tue, 25 Jul 2023 16:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/char/escc: Implement loopback mode
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230716153519.31722-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230716153519.31722-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 16/7/23 17:35, Thomas Huth wrote:
> The firmware of the m68k next-cube machine uses the loopback mode
> for self-testing the hardware and currently fails during this step.
> By implementing the loopback mode, we can make the firmware pass
> to the next step.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/char/escc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, queued to my misc-fixes tree.


