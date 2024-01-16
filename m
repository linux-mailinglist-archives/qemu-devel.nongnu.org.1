Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E682FBE9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrZY-0005Gt-Kd; Tue, 16 Jan 2024 17:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrZV-0005Ga-Ei
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:06:13 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrZT-0002dK-G5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:06:13 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso5758562a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442769; x=1706047569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IndTjM+NCdfE3ZrvERYselbTt1n+AFE/+fQQZVJuU0E=;
 b=D6aeDgMhyq6k7pDGnlovnf1JLEG41M3HV+yMRnJ42gE8hXB0kAqLifl34v8PNO4EOU
 RvfBj6aW0A2uwEuSEtjY5ElgCtpJAXOTjYWOcEYGpXRjJ5uOdFR92A58SRrJ8AQMLvmO
 SCDa/mhU9TdMpotaRk4ruVyZ9VzAvu2vFS4YFJc0k/B4G6P7Rt0Cn1I+YahmQnB06Xwb
 PjfG8GsMPoCgb3Ao6lc2OanVhtMAgvid4U0E2UxdQoCJySpCL8+Twux7R3D5K+9FZc+d
 b9p9WDPX1tfHH3ZdVbiWnOA5paJ18KYAV1tkZsdWxfYWnk8Wl4xzN6KjczhqnZRl8vMQ
 NpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442769; x=1706047569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IndTjM+NCdfE3ZrvERYselbTt1n+AFE/+fQQZVJuU0E=;
 b=SGvTifXObjiV0IyK3KnceVXH2lEeadaN6auLcW2sABe0ei/wJIh8STl8rxFHM0aF8Q
 qIXBWzlMEvW+OLOkxBa/gf1haQfqWtUnru1B9E23dP0AlwVvY9s+hyCB8MyH3Araly7I
 JEZblkwjk+f469QJ7H47i4fztGGi4GRfgcRCAid8ZDtpgu3m683ffQADRn12NyP0EFgP
 6i8TDO+/geg/CIlMn2kyXYWCRpxXXwnoodxoDdvLgTfo5b+svMmqdLlyhCdQdBnXXFm5
 T/Jf+Jtb5UpG9FqTn4i2RY8n4oi3SZ2sxWqzNYYrtQ+v/sgvvlQ9qpdb9XdikxM6qVFW
 kmKA==
X-Gm-Message-State: AOJu0YyRppSzozgtlWcCqBshkx3vEKqtGN8klwA6OdNHRJAJ0fym447/
 RmzAZrGbg/4H/WlXOo6WFD2+TpQWeaoMZTmk54Ic28voOr4=
X-Google-Smtp-Source: AGHT+IFOOUzAviZss38HyhLVqys/APuPixx7pYQqhQWA9MENtJaqW7lQzjAN2gKKpTJbR2cId0koRA==
X-Received: by 2002:a17:906:b04d:b0:a2c:30ff:f762 with SMTP id
 bj13-20020a170906b04d00b00a2c30fff762mr3718975ejb.42.1705442768911; 
 Tue, 16 Jan 2024 14:06:08 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090626c100b00a26a63346ddsm6966557ejc.87.2024.01.16.14.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:06:08 -0800 (PST)
Message-ID: <8c0cf47c-4df2-49e0-bcd9-20f0ae4b55a1@linaro.org>
Date: Tue, 16 Jan 2024 23:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/38] target/m68k: Use TCG_COND_TST{EQ,NE} in
 gen_fcc_cond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 74 ++++++++++++++++++-----------------------
>   1 file changed, 33 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


