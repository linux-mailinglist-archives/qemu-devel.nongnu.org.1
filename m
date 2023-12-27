Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6C81F1C6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 21:14:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIaHS-0006F7-VY; Wed, 27 Dec 2023 15:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIaHN-0006Ev-Oe
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:13:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIaHL-00062P-B5
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:13:24 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d45f182fa2so16515725ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703708001; x=1704312801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhW6kFKoUH9G67glNXLxRM3kgbXBVukKEneKNtzN3eA=;
 b=l0aBoNZ/gOhHeSj9TYHanCfU6iu4muy8IAS/jwYhIUHgm/0+Xt5Q9ivlEXb9sz41qc
 RFnCMjy5FpMnoJ2OUaFMac+TcFCqYvyWNgTOlEwTFC01FEtelJQzBKPDq7vYP3nNYWVG
 Cc+UfD//qauvbiQSxvAINrUcbYtRMKYUycy0suzzlhMmmFOr0QO/UOEXA+C9qH51wY98
 PJX6Suv5IE6XzSO1GMugVdfZWpyREFjZLBUvG7nZ4aKnuK4GgPlmPUwenPRK9F/fbrdN
 tx0BUym0oSxriQqTQ1O9OCKhmut8gi0NrjRq1oVelVUjG5TjW68MzwLKRlNNfMvhOYZ0
 y8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703708001; x=1704312801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhW6kFKoUH9G67glNXLxRM3kgbXBVukKEneKNtzN3eA=;
 b=twinX2m7gSb1PDA40/R8DBmkGqqOSBOTdCfKGs5TVOOcvL/9IEo5FTI3/U+fbW1eST
 +UO+o7qbxPo9WMcBzyKluwv/o5Glnnj5CipUT+qMr6zaDTEpgZcvUp4DfevvbOhdvJlq
 ZHNl0Csw64hSYvnTHuDg6WO3LepbmSdr/RrYYo5SkJdVDaQK7wwJoL5/nNlakoAUdwIG
 Mo0aUtvkP2EicwSS495EA2tst/b6s+E3LM2nBhhBWRYffIkwYbunfjcYuhEXEvJi3dxm
 EtmBwS54QbGQE3XXEEXu7knB7man6Hm9/pkt67KKMt1zCIAE0TyVHQFesUWjovpstyTd
 Gv9g==
X-Gm-Message-State: AOJu0Yx/WucYHW+EW340pGDtshuY6SqmkyxaxYekKhYR1L0VeSJF9Qre
 idOlWn3du2Bx5JQ8EpomoXDxfWGvEtK2Bw==
X-Google-Smtp-Source: AGHT+IF22obYLtEQx4PEgvuzy8dTf9tdfUCgDpJe0dz37PbawggrRmtIabGv43SXIl980ZSDllfCHw==
X-Received: by 2002:a17:902:dac1:b0:1d4:6275:300 with SMTP id
 q1-20020a170902dac100b001d462750300mr6173413plx.23.1703708001105; 
 Wed, 27 Dec 2023 12:13:21 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001d4752f5403sm3430543plw.206.2023.12.27.12.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 12:13:20 -0800 (PST)
Message-ID: <1110c99f-b441-4c64-9cf5-2a863a14f059@linaro.org>
Date: Thu, 28 Dec 2023 07:13:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/i386: convert add/sub of 128 to sub/add of -128
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221134355.35304-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231221134355.35304-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/22/23 00:43, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/i386/tcg-target.c.inc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index a83f8aab304..4e9f372d4fd 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1332,7 +1332,11 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
>           return;
>       }
>   
> -    if (c == ARITH_AND) {
> +    if ((c == ARITH_ADD || c == ARITH_SUB) && val == 128) {
> +        /* Facilitate using an 8-bit immediate.  */
> +        c ^= ARITH_ADD ^ ARITH_SUB;
> +	val = -128;
> +    } else if (c == ARITH_AND) {
>           if (TCG_TARGET_REG_BITS == 64) {
>               if (val == 0xffffffffu) {
>                   tcg_out_ext32u(s, r0, r0);

Need to check for !cf, because this swaps the sense of carry.
Ought to merge this with the inc/dec block above to save comparisons.


r~

