Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D773F871
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4jt-00020a-3a; Tue, 27 Jun 2023 05:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4jl-0001yL-Mc
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:11:49 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4jk-0003AM-6h
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:11:49 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51d9695ec29so2295096a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687857106; x=1690449106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Qy7QLQSqhvcq0q1tQlUl0s1/TCR194acpUQnHkyy8I=;
 b=KDL6Hp2qkdVJSpJ//0tnYxPtEAa8jTwGb8qVV9kMA1I7ujAysfcgs2JIzwrtOEzqcL
 0AIRD330oHXKTxZ4fmXTPxHO7iLkIwmIhDcuPLWtGmC4QoaYBcTU88ZHH0Nt2SNopTpJ
 W4NoE3rsHdOuQGx5k77gToeW7z77C5EVV4PviyT1oordhi3L5k4QMNbRvE8CGweGFiZ5
 60vvNVUbOF0eB2XVxIWulxdxGAYYDsqUKNfRG5mPyKYAbWhYjsN2aROPP6FxLpi5z8A3
 +qNOhNKNEHtaMOdXj3gT+hQLFBgusPjAg/OrrH0KOcelccaTrJjvpQKJls+VasLkp0FS
 tZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857106; x=1690449106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Qy7QLQSqhvcq0q1tQlUl0s1/TCR194acpUQnHkyy8I=;
 b=Rtcn6GncK6iOBzp0LHtY7jxDBFjNDBJqcuRGOlL2XMvE0w3ZDF8jqKoEvrphnpsGR3
 uqIGQzbuKsWMPrtf0+e8soKiV76EHBRfqnLw3C6h5ZT41s1xfImZ2x85fUDEoMLdTKUk
 HDv75mtSkGREQ8JsfdhLcfMpKe9qZHrZopD1863JKwTqMNXtlBZvphIW9iBRCy+XZl/s
 zTkj5L+eke4GI/zXFPzeDLClNHH3w1Al+oyWkpRXp9W9FQACZ9fO9YvmwKaRezTYj0q1
 vVFNI3Ud7JI+rOchXCXAFHPHGzx4W2IDvle61cG32GBLVbVhBdgeicdqXqr1SdtiRDtF
 j5PQ==
X-Gm-Message-State: AC+VfDxwnySXIduM68uWJOVD2gNoLQ5gnIaZQE0FAgw7C7qtx1Khlx31
 YRidlVMCzrNXkfKAaS01cmW8JYdme2PllVF3bE4=
X-Google-Smtp-Source: ACHHUZ4ctK2CQExx92mfkBODiuFAWzV7nqHLs9x32mquIvebP6VDmpIEWLiOKkzgRpSzomrLCZfjfQ==
X-Received: by 2002:aa7:d04a:0:b0:51c:dd99:a211 with SMTP id
 n10-20020aa7d04a000000b0051cdd99a211mr4515214edo.27.1687857106599; 
 Tue, 27 Jun 2023 02:11:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 bc23-20020a056402205700b0051d9dbf5edfsm1573529edb.55.2023.06.27.02.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:11:46 -0700 (PDT)
Message-ID: <48c63f5f-aaf4-9bdd-99c2-8bb0493676c2@linaro.org>
Date: Tue, 27 Jun 2023 11:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/8] target/sparc: Fix npc comparison in
 sparc_tr_insn_start
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 20:06, Richard Henderson wrote:
> During translation, npc == address, DYNAMIC_PC, or JUMP_PC.
> It is only the encoding between here and sparc_restore_state_to_opc
> that considers JUMP_PC to be a bit within a larger value.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


