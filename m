Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B17E374D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0I9b-0007Kp-7O; Tue, 07 Nov 2023 04:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0I9a-0007KR-3g
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:13:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0I9Y-0007ZC-L3
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:13:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fb1d757f7so2916138f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699348423; x=1699953223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=00ZBeN9Bjl0x3wRZpRS5xdebTagoVBTCBMvXv31VmQA=;
 b=czXdycmMRoMfok/jWCvknl0XAS/MAC1uP9lsrJ9ODaZkUCl00U+MAGhlqJvksnylLg
 zsxBbhPXL7CuZBHMtFhzTloKw6dLdu74mhPQob0pC8JhIkTchQUItUN9flakjIvScRqi
 GcF4CGxBRCjOtP8OFl2VysouZLY/kjDhtU19ygRBFPBZJFZu+3uPMOVbI/Pqo6o5dGcI
 nMHo6gy700vqyy2i/P2VHt5bqJeDIw1Ry1hR2vS+bIvtlau7ihg6UjVz4q3cxMTboh/e
 Y956FRaM+OgjVYZ3d2NDN1zK+xA6GVEbTnyRheZAeqn/lSf3GBYLTtFYQ10N28OD4uU6
 xZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699348423; x=1699953223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00ZBeN9Bjl0x3wRZpRS5xdebTagoVBTCBMvXv31VmQA=;
 b=BBkequAjoXHxtjuUutdA502uGbqk2NMCyjFPoeRCOrzURLK/PP38Y6jG4M34CZDlfR
 9HLzUIyRdr2NQATY5sPdQhcaeNp6yjwxfIBAlbqrgsSa/zwk22tt5Cin2uKx2mVO+bS9
 83bT7sIJYxkWTn3cct/gJ04YG4xiFuuG3Y38K/NqcOjQKbCxxYKn545F6eXmceI0WVay
 3A5v/y+DfaklMUQRGQNFCDADWQRZ3mZc9+ysVuX1ym092nXEgUKbOVByT23JtVhA0gNR
 OIwXkPCgEcrhehs/aHEZyCxi8c8hNLR5NJci3aCOEQwD6oVD3weSHdQn/ZSduRmQucg+
 tehQ==
X-Gm-Message-State: AOJu0YyMzlRcTNfUsDrS0SIWJTcg58a0aXGtyuMnvo0wqNglzEm4Wl4/
 lI0n5rBrwd5rmf6U14cdzNFEgg==
X-Google-Smtp-Source: AGHT+IHJkrp2z1htEKeqRSQb3psQKIGk19FV0SV2l3aOEcrJPuTM8jcHGqlPCC1ZTSVsJ5JEEwTCWA==
X-Received: by 2002:a05:6000:1864:b0:32f:9696:c3e8 with SMTP id
 d4-20020a056000186400b0032f9696c3e8mr19581545wri.51.1699348423146; 
 Tue, 07 Nov 2023 01:13:43 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a5d5688000000b0032d9382e6e0sm1781375wrv.45.2023.11.07.01.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:13:42 -0800 (PST)
Message-ID: <bf6a5c22-1ac7-4468-9474-55197b6b5766@linaro.org>
Date: Tue, 7 Nov 2023 10:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/24] build-sys: drop needless warning pragmas for old
 pixman
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, stefanha@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107071915.2459115-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/11/23 08:18, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since commit 236f282c1c7 ("configure: check for pixman-1 version"), QEMU
> requires >= 0.21.8.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/ui/qemu-pixman.h | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


