Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A271824698
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:49:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQtR-0002jc-SL; Thu, 04 Jan 2024 11:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQtN-0002ir-T5
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:48:26 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQtM-0005xx-Ag
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:48:25 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a28bf46ea11so118964866b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704386901; x=1704991701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i3XPwfZkXiBs+DfqpogjjtVnpZRyC8htnBN4UP5uisA=;
 b=RaPfbr4WdhA219I0aCuZwIwfTfqdQkXueBY5GIZNzNvx9wpxeg4jHjkBcdnO6kENce
 KZdT8AS1lFho5Sdzu+HgJKAUy0poCTJ3jeZKauTA+/81Zqi7aR5sWkE1qREjvFM+LnJ9
 4Nc8+wm4gS9DNnmCcBeP3a1k5pm6jSfl295+0dCQnLwFir2MxB6QePTJFsj5wZQCemvq
 jYeIPd1VaGNhayoNxCkZgJocTifFV3XApPiHaC2NzCoUJKXVlCapdUo6D3nCHw4HZAf5
 jc0upRB4IpBUtd1MHzXNux+6T1ctJWvSV4f0TPqlAPAGYQG2APQXfHT1MnrEMTev/WN+
 7MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704386901; x=1704991701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3XPwfZkXiBs+DfqpogjjtVnpZRyC8htnBN4UP5uisA=;
 b=CQD2nz7hhpqr8bj3oEaGCdKB05QfY9wbnISPKZItZtboBkjoF4W5rl8Alp2S6lLc9P
 rzU6v6J2+iYqMTH01woJta5GCfwTXIQX7c1ptelaDj1N4zHsne9aRdKItx2wbSVTMB3o
 Lthx7H3T5j3RN3E/hJKeasMKvk+le3OzMWL+PRt4ry3br3wUr+TUy7IIv/9bFLZENdHM
 Q3q5luGVe/RIu9VNTPezxgZyGyogJf1J3VYB37Zjvj8OMqiCh4aNUHFRERUE5o3MvLmD
 rlePIdymiIFodExYRHC44Id/4eilfmP5SFeiYKmVxDQO7ABeTXdmRG+FxV2yX1FtmOwL
 n9WA==
X-Gm-Message-State: AOJu0YzniavUgzwz/m3KBY+yrhBG0bVYvLdJja7BAkhcTqS4/uTOvZYr
 5VAM1fKSMhNmMP0Rb6X4nIbEJCKSDlComQ0h9zFPEuvK4JQk3Q==
X-Google-Smtp-Source: AGHT+IH7YL7tpcBWM9Z3j+kpQ42GduHP8H/uq9YyzBEqKrwDUqmq3cPaaPIgc6tjKUHzyJlS2ZINlQ==
X-Received: by 2002:a17:906:40cf:b0:a28:e86f:242d with SMTP id
 a15-20020a17090640cf00b00a28e86f242dmr806480ejk.30.1704386901438; 
 Thu, 04 Jan 2024 08:48:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 fg8-20020a1709069c4800b00a26aaad6618sm10709870ejc.35.2024.01.04.08.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 08:48:20 -0800 (PST)
Message-ID: <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org>
Date: Thu, 4 Jan 2024 17:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20231124182615.94943-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124182615.94943-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

If there are no objections I'll queue this patch (fixing
the typo reported by Zoltan).

On 24/11/23 19:26, Philippe Mathieu-Daudé wrote:
> Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
> fields has been converted to qdev properties, so don't need to be
> migrated:
> 
>    static Property sb16_properties[] = {
>        DEFINE_AUDIO_PROPERTIES(SB16State, card),
>        DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
>        DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
>        DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
>        DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
>        DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
>        DEFINE_PROP_END_OF_LIST (),
>    };
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/sb16.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 18f6d252db..be614d7bc3 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 = {
>       .minimum_version_id = 1,
>       .post_load = sb16_post_load,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32 (irq, SB16State),
> -        VMSTATE_UINT32 (dma, SB16State),
> -        VMSTATE_UINT32 (hdma, SB16State),
> -        VMSTATE_UINT32 (port, SB16State),
> -        VMSTATE_UINT32 (ver, SB16State),
> +        VMSTATE_UNUSED(  4 /* irq */
> +                       + 4 /* dma */
> +                       + 4 /* hdma */
> +                       + 4 /* port */
> +                       + 4 /* ver */),
>           VMSTATE_INT32 (in_index, SB16State),
>           VMSTATE_INT32 (out_data_len, SB16State),
>           VMSTATE_INT32 (fmt_stereo, SB16State),


