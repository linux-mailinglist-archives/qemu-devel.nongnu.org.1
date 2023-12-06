Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494B80754E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:39:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuuh-0005LD-0M; Wed, 06 Dec 2023 11:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuuf-0005Ka-DR
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:38:17 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuud-0003oy-Qc
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:38:17 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ce9c8c45a7so20674b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701880694; x=1702485494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9AvbmtihTcJjOl9FSwWZAcvEuTvbEIlV8usfP6ctkkQ=;
 b=TMfudESoI5qS21ON+7UUd8WRnKY0QxxWLZrMiulsRXpkwsnSFAk0gp2g/zd44PwZWf
 mYU1oTakbVRyX1uS34k/kdYSW4uzLmA1czqoG1SVVO6Mv+F+rrqqF0+GibMDNz6CBNWZ
 jnEnpPgYJE3z1bqpl6fqqIVzRh+9rHK4olML6HXssqMg015+7qNj/U8cCZBs981zXszj
 eHFAnNO3ONGQNX/QNNgx2difESJR09M0ek8cjWpb9rPQJl5oOi2P9rkbw8mjaDsE8Lr4
 NiM9pzIVptKg9tXCNmym5fbQ7fCSFBFTrXr4Wo+PwVkLdfDIwNMYGhHgPij7xyMtDxWF
 Bg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880694; x=1702485494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9AvbmtihTcJjOl9FSwWZAcvEuTvbEIlV8usfP6ctkkQ=;
 b=Owim0Rc+RLdwXV68rf3J99FOM5JDjUk/hfqoK8IaxJbfvZFBzRXPUvp5SYjWeelFIL
 87cB5FrdSYecwJ8HSyT6O+33hvvj5d5t+gzbs5TDrv+S+xpxIUMW/n0hAP7+qM4HE2dp
 Q7iPXpLGxKQpvp3NBY5AyGZ8EiqQLACxRgwC2S+ahHMlHB3J0OYqRq4ucfdqTjhomiiz
 Lko6nP7yGknIpVP5O46UVWoah/+1VzMBoJuo2gclf90KAip6ePCyAg6VUcCEBTOy75RG
 hXIt24bq9ZkvTxX5CytdgmxztfKWQf9+NhS66qOLHLnjxTfy/vF6obetbigAgzKzblBQ
 F1rw==
X-Gm-Message-State: AOJu0Yx8pcOj0R65zgJ3BCarf/GagH+6rQtJNPLNENRsz7/DEoJ54LIk
 L6XkSXfu30vQMYz+bK2os0jIPA==
X-Google-Smtp-Source: AGHT+IEu+F6h4YimJAQ4XoEZYe0DGm6gpI3GXqQRiLZU0BWDw10sC31/ZHs4ZjiMOR8Vx6Kqc+HGTw==
X-Received: by 2002:a05:6a20:5603:b0:18f:97c:4f4e with SMTP id
 ir3-20020a056a20560300b0018f097c4f4emr1025133pzc.90.1701880694277; 
 Wed, 06 Dec 2023 08:38:14 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a63b801000000b005c19c586cb7sm124320pge.33.2023.12.06.08.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:38:13 -0800 (PST)
Message-ID: <d3dce39d-cffe-4730-b1c8-579d442efcb4@linaro.org>
Date: Wed, 6 Dec 2023 08:38:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] scripts/replay_dump: track total number of
 instructions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 12/5/23 12:40, Alex Bennée wrote:
> This will help in tracking where we are in the stream when debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/replay-dump.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

