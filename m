Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20775C29E
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:11:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmAG-00055p-EE; Fri, 21 Jul 2023 05:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmAE-00055S-L1
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:11:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmAD-0006zN-6a
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:11:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so1319225f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930664; x=1690535464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MrFtdmRslbDY72kZyGkBS8s7GgtzRF3MN+Vz2yGDNk0=;
 b=SHE9E2G0KPcLWdwZMag5bIJ9ulcb8NauZmG32kP/J6vkCXOQ6fsssY5Kh9H6Piv3hR
 PYV2r1nia532KqWK1UH62C3B1se2+079l0ngCLGCh1wGMm7IdVZ++e8eZ52ImsuSfBAY
 lLmToUeMgyahBpPuntszEKFhlekBMpdwHKlPxXF2Pj5pRAuDc6BUyqXaPKQLEg56Z8xW
 LC/+bO1j3xp5yjQ4QsUd0v32oXT6DDPYq16FisnJpdKtV45kT8GmtZ7LoDzqHuaGhqc8
 NCvPLL59SvIakKxhGKr2DOLDw3iT14iEau+q6pFYktud6Jvtfs14rl2tn7zC1SdHxVzF
 IlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930664; x=1690535464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MrFtdmRslbDY72kZyGkBS8s7GgtzRF3MN+Vz2yGDNk0=;
 b=S6O3M2HiKeT8Pah7a26XU0jswmps34TOsVVwEk2RDM47FQIB1te2KHxp6uHaGVAfZI
 27jaE2g7gAdltsX5TlsE10nVKEX+5wdImhn2pk2RcHkItZN1zUOo2cmupL8zGSDNYoby
 O/FEc8+x4ro/I/mucjK5TMOJ92ejLitIwwr0zghRbyA1fg2FvLvZd+9Er2qvflW0hD3S
 OKZmCdhdPsa9YjgytZbpb1altS6wqyPzLTOo6SLES7Eevfte0PFWD/qGn1x3htNKaVco
 dbBy/bFefxVxeFyuQASkZG92u/kUKVIaRmxIm0mHk5+PQc/GoxKwa1/lzVMKbzQp0raw
 8X1A==
X-Gm-Message-State: ABy/qLYiNp4hsmG2KmZuGXVaibwRFiFeu/gjCWUNA2Sex/MnduLnbb/7
 wPumHW0Y66mBFq6ix27tbcLACw==
X-Google-Smtp-Source: APBJJlGQfYl67ALUxzRDPibN8I4GIZOkH3IwJPMSRXTmnsYnGPRBG4FCBFqvBAuYFx/S23ON1bvMxA==
X-Received: by 2002:a5d:58ea:0:b0:314:34dd:aaec with SMTP id
 f10-20020a5d58ea000000b0031434ddaaecmr977196wrd.8.1689930663924; 
 Fri, 21 Jul 2023 02:11:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a5d554f000000b0031417fd473csm3623019wrw.78.2023.07.21.02.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:11:03 -0700 (PDT)
Message-ID: <d74789ed-6c18-e802-9393-db545b1d7e18@linaro.org>
Date: Fri, 21 Jul 2023 11:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] scripts/git-submodule.sh: Don't rely on non-POSIX
 'read' behaviour
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230720153038.1587196-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720153038.1587196-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 17:30, Peter Maydell wrote:
> The POSIX definition of the 'read' utility requires that you
> specify the variable name to set; omitting the name and
> having it default to 'REPLY' is a bashism. If your system
> sh is dash, then it will print an error message during build:
> 
> qemu/pc-bios/s390-ccw/../../scripts/git-submodule.sh: 106: read: arg count
> 
> Specify the variable name explicitly.
> 
> Fixes: fdb8fd8cb915647b ("git-submodule: allow partial update of .git-submodule-status")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/git-submodule.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



