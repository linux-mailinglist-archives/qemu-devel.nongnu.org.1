Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5D7D433F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4P4-0000wO-Jf; Mon, 23 Oct 2023 19:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4P2-0000w2-5p
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:32:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4P0-00008K-8J
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:32:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso28129145ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698103923; x=1698708723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P1YtvzqN84BtH88CwTLAcZuKB5YetEKdVg3R/4iIEug=;
 b=VkXpme6vTif93VzYmagj2U10eHZBL/sZMAW+hVWrgJIAxsdhhrHGQqvh8BYQEu6Lso
 ZSKfMr6l2Im8SACvflOTundtT/HU3IrjwGLA/ZBmGRH5njv5jzgUhUjpLKMoufJb3NDg
 dAOvFcZWfVb7SzxdDspRLfPu2CGVkwoX84BZvxCVBUsa/0tnbpKTawi0xiQKV9C+t3p8
 KROiZFyZxGHX1cOOLgOjNtI2yWHR5+LX4DfVmC+KRdtvLyVPWD99Hg0eMK/zu6x++qwX
 sHZs3gyu8La0Q/idVbl9h47C9p1X32WtRUUTF4MBuXzwFzWtZ2Ad3xHhwhUe/td3aVsg
 7C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698103923; x=1698708723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P1YtvzqN84BtH88CwTLAcZuKB5YetEKdVg3R/4iIEug=;
 b=rSIbdAU/aYJAjXM/wFdO1nl6RInWSzFJLcIv8pP1r4Z60iLFKqlAUwtFXKEeF+cwYm
 Rql2mSyr0AFOgSfBOnSnsNEGjm+h1eisstNSfcz2esBv6UH1DQHzMa5lD39cymzEjU/w
 Mr4Yk01Q54vXwBYA3JJ9r+9KWSzU4aIQrUYSb4Hzt/DEk7QHglD+bW/4t8GGRSjBxIfS
 VCnhIVkHWw5FUAWuVkh1fRnRBt7GNIxqLhIFqoR8iUVPI3wmqxFsju9L6f0YCCqVw1wL
 SKJY5Kj5c4LEcgzg8DkPuvGBqxGIHjtxfF/Y8++VeYLABUZzs/epov4JP2kd9nniI4Hh
 yBKQ==
X-Gm-Message-State: AOJu0YyCah8gQZj6n87bfUSQ3+ppM9ZbrdLTfIlhImc8ZQ4Obz8wWfVo
 AVJ4Fp18Vot2QTXJhXo2YTcSBg==
X-Google-Smtp-Source: AGHT+IHgVLdlSvYvUIwQt61O/rSmvKYaZEPX0mM8FOToxxSnf3O0y8eCKKm9lX0RwVPhCIqsJWD7ew==
X-Received: by 2002:a17:902:e54e:b0:1c9:ddd8:9950 with SMTP id
 n14-20020a170902e54e00b001c9ddd89950mr13851921plf.21.1698103922680; 
 Mon, 23 Oct 2023 16:32:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a170902db8500b001b9f032bb3dsm6429170pld.3.2023.10.23.16.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:32:02 -0700 (PDT)
Message-ID: <e978d05e-b744-4663-ab45-5a12e7b97537@linaro.org>
Date: Mon, 23 Oct 2023 16:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/avr: Use tcg_gen_extract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/avr/translate.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

