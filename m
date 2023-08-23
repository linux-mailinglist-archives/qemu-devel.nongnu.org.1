Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167F78611E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYu09-0003ur-JS; Wed, 23 Aug 2023 15:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYu07-0003ui-1r
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:58:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYu05-0000w1-KK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 15:58:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so40974065ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692820724; x=1693425524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5XoOm7v6pwQLLN/2JefGjpPAICYMqiLSySe8+N1yA0=;
 b=c2NfiQTbnPxqI61XvdEcqDpYg3xd3/Seg8cCtPqghxAxnyLugATf8lDEQB9K9Lktxf
 MAx5boeU1DAu8fU3e8KZ+PnSSfnkhU3fsiMtgYtiXzFGuxEEVqTsu3wJkcGVJCJlCivx
 ovPh9jWENOuW60ys64Xf/jFIW/8jaMOh1CpiX61/aPuaiFwP2QvcdVmTyhw7HkOdQhCM
 QWMePysbat0B2w/WHwgTOiOdcPFJYeoYKFuzmihWZPNx1LRJShXR3nAFXlcC5XUzFrXu
 ZPT8AXtFnYtUh6o2QI7uYSyYLyDWkIN3OPgmYtraR8SenTS0RaBj+cZfJPRXYgosFxMx
 ABkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692820724; x=1693425524;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5XoOm7v6pwQLLN/2JefGjpPAICYMqiLSySe8+N1yA0=;
 b=GRbyP2xc4UoLPxfhL8LkqrP+ub3ydQ2S4x7g4Atart5/iN8fqcnhquxHCAFieOqek3
 K1FWL3CXPrCKVpnXh2VENvHjXzezs5SAx3AhmZilIhEX0K9islTIjI4X8O03f9TXqXCI
 U00MMMmVfoD3vf1KwecuCNj2UvWFbDnMZp61WnbDoOXvzTFrgzN0JkrNZ8xZMwFS2EO8
 OtN+eYMz9e2tChHtN5OagGxxB9frclrynioZCRZ11JFaWSy0ldynP/znRblSA/PmKnz0
 RkKBAhI7mCMI//Rg7z6acRRuhusEJKc1YvbtVpBMuyzRCkptYl6X27QZotzAbaEkEYeF
 BB7g==
X-Gm-Message-State: AOJu0Yxe8vEYCvZ0ob91B4v2cszvsKJ6xyXl9ViqYNGkcC+PcnYqXCYM
 Dev35GpFqXYJPeL5jWFrFzSmHw==
X-Google-Smtp-Source: AGHT+IHf1zxIIxi02ftATyU6gSRH6sefqO3+rttVpht0SojDBRyMF+zvnEWfW30+ojyl2Q3NcKnxEQ==
X-Received: by 2002:a17:902:a70e:b0:1af:ffda:855a with SMTP id
 w14-20020a170902a70e00b001afffda855amr10911163plq.9.1692820723897; 
 Wed, 23 Aug 2023 12:58:43 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a170902f7d600b001bbaf09ce15sm601364plw.152.2023.08.23.12.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 12:58:43 -0700 (PDT)
Message-ID: <2aaf28d0-4a1e-3ed9-99e5-03c2cad5a28d@linaro.org>
Date: Wed, 23 Aug 2023 12:58:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] docs/devel/tcg-ops: fix missing newlines in "Host vector
 operations" section
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230823141740.35974-1-mark.cave-ayland@ilande.co.uk>
 <494b3e93-5dd1-bf18-56d0-a247483f38b6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <494b3e93-5dd1-bf18-56d0-a247483f38b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 07:56, Philippe Mathieu-Daudé wrote:
> On 23/8/23 16:17, Mark Cave-Ayland wrote:
>> This unintentionally causes the mov_vec, ld_vec and st_vec operations to appear
>> on the same line.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   docs/devel/tcg-ops.rst | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

Queued to tcg-next.


r~

