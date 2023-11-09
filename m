Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5AF7E750C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1EEM-0003Tp-BB; Thu, 09 Nov 2023 18:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EEE-0003TK-6n
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:14:26 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EE9-0005ju-1Q
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:14:25 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b9a7357553so1188089a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699571657; x=1700176457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ceg2Dzo8VRvIyHBrb/SMz9XGS/wJULWIHZFuGmktZ3c=;
 b=PRVg0vH44Vi22SQox+e0/i4+HX3scZ3dBU0T4bgjExIoAmgkkyLBZw77I/qQudokeF
 ikS9VLxOzPCN++cJkJU8E0ofnC6Xn1GLfi97j4ZMSoDBBBMFx3K8Uo14wpoZGzdXf/lH
 JOIsU5fXNIVOIu3QWy823IVQ6HqbFPM0ZBwNbiTFm4xF/oB0XFSA9e/deXv4142vlt2v
 vCbDpHZ8QaEypgWWhegZWpsW10MYJG10UJ1I78pnUs7XDboTvzS5VVNWVfLUxWNF5pSV
 JSaNTgXjt8C+W6+N68pwBn1bE3yDp73pBBV/MDOEGh9XmBjipf8PsPJUuEAJ6CfPP/9p
 OdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699571657; x=1700176457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ceg2Dzo8VRvIyHBrb/SMz9XGS/wJULWIHZFuGmktZ3c=;
 b=p/3vCGFPR/KAnVSTUvps3zfoGPcYxyKtNVDM3L9VhssmRpR0ImjzovIpJWJo/U02pA
 G/rL0sl4BnG4eMp+hfVHWgTYYPL+FE4rtQH+1Oml6OsogBNPlFj99VqPdKBwzPiPESuB
 NYXyWX+zc30xO8CzbML6m4z6lmOSFFHTnShdgLo7lh64eznyZWLxqWhnZ9qpeKviuZfL
 av7c0v5Wx8i/vsfGBv8DfBCS3sOdWuggaZOx4iUkBtGYkHa8KDMTAXMyhPYspgHoXtYx
 7QOxBvzBXzwh59Haor9pghDwYm1Bh4utdHcwgms7zR6hZTqFX87eolFXI6jh/IGKZ5i3
 16+g==
X-Gm-Message-State: AOJu0Yy5YbKWN+ZPDuh5+T5aSzWYd4/agooyP9ZRZTByUG9nlpeUjdu1
 AYJ2WeEhq0OuUH1V+aBw/23wug==
X-Google-Smtp-Source: AGHT+IEyw/cC4BO5AhJ0LhrdJcSCCN86OVeksnyk16ixEBibhDyOQkl/FE67Bw9WXrVSPs1tNGiG5g==
X-Received: by 2002:a05:6a20:12c7:b0:185:6854:3908 with SMTP id
 v7-20020a056a2012c700b0018568543908mr2864414pzg.4.1699571657543; 
 Thu, 09 Nov 2023 15:14:17 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ee6:29b:6626:64c4:1b48:c565?
 ([2607:fb91:1ee6:29b:6626:64c4:1b48:c565])
 by smtp.gmail.com with ESMTPSA id
 y16-20020aa78550000000b0068e49cb1692sm11237476pfn.1.2023.11.09.15.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:14:17 -0800 (PST)
Message-ID: <569f8c12-3e96-405a-a29f-009d5cc80e7c@linaro.org>
Date: Thu, 9 Nov 2023 15:12:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 01/10] util/fifo8: Allow fifo8_pop_buf() to not
 populate popped length
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109192814.95977-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
> There might be cases where we know the number of bytes we can
> pop from the FIFO, or we simply don't care how many bytes is
> returned. Allow fifo8_pop_buf() to take a NULL numptr.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

