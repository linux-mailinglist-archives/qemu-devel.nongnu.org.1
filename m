Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E007EEA79
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 01:53:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3n56-0000OA-9h; Thu, 16 Nov 2023 19:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3n51-0000Nu-3J
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 19:51:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3n4z-00040v-8H
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 19:51:30 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6c39ad730aaso1322733b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 16:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700182287; x=1700787087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wq/flwwXajlQHXITu6euiqED0XX9fjXWOv9XxLTCQ30=;
 b=eVO2Hb8jZVCdAiL61jxZDlyCLjPi61Zwry6AvYS+3vtkwuoegXLgH5K0cUgE0IxSVq
 MfemCuTJoSTgQ5DsamGLMVGTS4lgG/EyDFx0R5WeIBHKA2fommkRsXeyEBk9w+YGxIQT
 RLpeBTnsCy7Z3Z/zM6qxn8ZahkrPnUpckKioiSaPqqdpGmmdOUqsJgUbFEz51ck/Kd2T
 9nJcRK4iElQbsyVoQtDzI4jv+5CaXK6xu38aLYJIlu49pC1QT+mAjsvNQ25odleGRqMh
 9jtKoFtnh9HEG+6IDTsh+2ubgmVo4byzkKts0vMhXu4PLyVxagIyFP0EF1kA4imcPZxb
 xUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700182287; x=1700787087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wq/flwwXajlQHXITu6euiqED0XX9fjXWOv9XxLTCQ30=;
 b=UYKfSZIfsqmbz0L/DNwWP5V5bXie611la+bSOcFHTkoh8P2503fU7Gew0tdHeU9r9I
 Z2t/ixzsVCjpyHk48YzIKm5UH1ZQRzWpbttHThItBv86OOQWwZ3ZphJv7hCUselwvbN9
 ejLpd4rMgjUfXjHooLAVFYhrjBow+R/R9Z8K2bQwrVEhrmf6BcZVL1tsObKOJzfG2N8e
 splNm10FrWojdPgWswK2E1DjfsCoAonp0MlWawGVv5IH4lAiaM5BCIEfG/QHzzYckx1g
 tTYOcxzUMw8oS/W2K7OZEcov2mDskJvMfHl6lKmb982yBpMNlvi0rocl7i5OUQhK5cd8
 L1Cg==
X-Gm-Message-State: AOJu0YwQG0Boblx4MiEK4AZOlURKdQEXa9x2eGwBoNUtlXas51Bo0EK+
 X7SfUkrdU4+AVRNAz3HT7oV6Ng==
X-Google-Smtp-Source: AGHT+IGvoSUKccYQA6KrcmRXCPYlvUqzIEcJ0sDvl+/bnB9owDcRfBdgWf1ibE8SmRly8L90eYWgbg==
X-Received: by 2002:a05:6a21:3e04:b0:186:11da:59c8 with SMTP id
 bk4-20020a056a213e0400b0018611da59c8mr15663130pzc.61.1700182286966; 
 Thu, 16 Nov 2023 16:51:26 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m124-20020a625882000000b006c03d1ba03asm343837pfb.220.2023.11.16.16.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 16:51:26 -0800 (PST)
Message-ID: <2ba04a3b-a02b-46d6-af30-13bc0f93b690@linaro.org>
Date: Thu, 16 Nov 2023 16:51:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 09/25] ui/console: allow to override the default VC
To: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
 <20231107101524.2993389-10-marcandre.lureau@redhat.com>
 <CAFEAcA8QwVTLRO8eOxRan1Uwd4uCstMXkTa6_eLnfNxAupNy=w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8QwVTLRO8eOxRan1Uwd4uCstMXkTa6_eLnfNxAupNy=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/16/23 09:52, Peter Maydell wrote:
> On Tue, 7 Nov 2023 at 10:24, <marcandre.lureau@redhat.com> wrote:
>>
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> If a display is backed by a specialized VC, allow to override the
>> default "vc:80Cx24C".
>>
>> As suggested by Paolo, if the display doesn't implement a VC (get_vc()
>> returns NULL), use a fallback that will use a muxed console on stdio.
>>
>> This changes the behaviour of "qemu -display none", to create a muxed
>> serial/monitor by default (on TTY & not daemonized).
> 
> This breaks existing command line setups -- if I say
> "-display none" I just mean "don't do a display", not
> "please also give me a monitor". We already have a
> "do what I mean" option for "no graphics", which is
> "-nographic". The advantage of -display none is that
> it does only and exactly what it says it does.
> 
> Setups using semihosting for output now get a spurious
> load of output from the monitor on their terminal.
> 
> I think we should revert this; I'll send a patch.

Yes indeed.  I think this may be why I've seen my xterm go into strange i/o modes during 
"make check-tcg" of the semihosting tests.


r~


