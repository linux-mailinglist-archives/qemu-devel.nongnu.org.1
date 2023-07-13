Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A699752A55
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK16M-0000Qb-W4; Thu, 13 Jul 2023 14:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK16B-0000Pf-D6
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:31:31 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK167-0007wg-Fw
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:31:29 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-579e5d54e68so9912987b3.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689273085; x=1691865085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iM6iGb0VSXlSYidrU73fgZKyui1oYUgUqirpIs+TBmY=;
 b=EEzmKowvzYAU7uJ+ZjUyLexY90DCdQubm2uhbpxl9CJy4TgATy7mlkTGcGfGwAzFTY
 SfOhhmY6ili3HQirmSfvZggPVpxZ5f2sXn+uX4Vhuxsc1m/AxN66KMdWMrC0ApkZuNwF
 Ew21LyK4HG7P9hc0yv17OMiJpNt8Azqfxg9f6eGxig/pnPpEnw6Y92C3SGjFCy7rfJY5
 qjMC99eHdQJA5UqLAxMqHrZXZMgcbt+8mZqWKNdCSE0QL+EFwnH/C5gcCAAW3ThuOfKD
 b9J0htEuP4p5dkmBp2qhaJ2fiQ8bLOaWLkBivQwc8sEYUTp1Gc8wxmeFTrwGo2C2cztt
 0avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689273085; x=1691865085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iM6iGb0VSXlSYidrU73fgZKyui1oYUgUqirpIs+TBmY=;
 b=WLelj1fdL66A3Vk+gbStVPyQlH8hjc23ke3pdBnTNgUOYV6jb0mZRWJasrmmWe052t
 cNYI6DnCSEi57egSuOKkf7V4nxGEQwl6zwKF+khUTFkxw4faxtRldq7xadrp+AhEVUdg
 2Sj4YkiHwzJ021aN6Vr32wCbAi+a5G4nuxWzb82+6eoGpnmYRLP2zYD33UKld334uqxC
 bnal93p5Hgjg/2KBYVi1C0De+GqWtDXcS3eXOfBzoR9LrPfwejCRBm/l1Dozm7m5Zf6M
 bjJX95aS/TyO3543ToZOBdnhRK6I6kxvtcjF6ku3ybMpAAm17L/F5/hnunhBRxjebprh
 BpeQ==
X-Gm-Message-State: ABy/qLaor6ztWKBDTpvNbPHkHfJQ9hpALa8aW1YNxAC5jE6bKdk7DaRe
 zCnmGs8gmXhAd/RMt4phfK/gxw==
X-Google-Smtp-Source: APBJJlEXG8Hh06JJ10JMtoQGOkFqJlwHKcJp94L6dbEbS5v8aFgZHfXy8ZOda0kNYFGvQ9RCD19mBA==
X-Received: by 2002:a0d:c1c2:0:b0:577:bc0:2d55 with SMTP id
 c185-20020a0dc1c2000000b005770bc02d55mr2846453ywd.33.1689273084971; 
 Thu, 13 Jul 2023 11:31:24 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.139.107])
 by smtp.gmail.com with ESMTPSA id
 v72-20020a81484b000000b00569ff2d94f6sm1891030ywa.19.2023.07.13.11.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 11:31:24 -0700 (PDT)
Message-ID: <fa2d89b7-8bfa-997a-dcf3-75fdb2ad3b46@linaro.org>
Date: Thu, 13 Jul 2023 19:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 3/3] target/arm/ptw.c: Account for FEAT_RME when
 applying {N}SW,SA bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
 <20230710152130.3928330-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710152130.3928330-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 16:21, Peter Maydell wrote:
> In get_phys_addr_twostage() the code that applies the effects of
> VSTCR.{SA,SW} and VTCR.{NSA,NSW} only updates result->f.attrs.secure.
> Now we also have f.attrs.space for FEAT_RME, we need to keep the two
> in sync.
> 
> These bits only have an effect for Secure space translations, not
> for Root, so use the input in_space field to determine whether to
> apply them rather than the input is_secure. This doesn't actually
> make a difference because Root translations are never two-stage,
> but it's a little clearer.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I noticed this while reading through the ptw code...
> ---
>   target/arm/ptw.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

