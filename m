Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC737E2734
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kZ-0007Xm-5S; Mon, 06 Nov 2023 09:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00jr-0006yX-Ru
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:05 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00jm-00011Q-1Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:03 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9dbb3d12aefso645191166b.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281476; x=1699886276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnhhMk/onsazliMF0ePO1fqzsIFf7smiMaOT4UT9vXk=;
 b=A4Yf6UioTam8xKOkcIxXKI8XkQydZkPoBp3iMHLWoM9zxMykh8QfmQiEbRnsd+cQ2E
 x+qMQeCrkQSgnjfpIyIIjAxxnB/nJkFZTVeEVgp+6rcx/v90cYifj4yKL5tG9air03kU
 hQOdkbhOk8vqlJXFW442cvqt7LQzwyLfIxDxztUaCCRvuxwEdF9mYQnJoZyCnoD0wcuf
 NzSPKPYG/HIRLA0uXNcvkVoc+YTjYZqU3AIwjMsFHmdbPN1x6YnVDsgny+RbAmZ24Dr7
 UqK4ga/X2n9hz96eG9kUOvg60H3FuKnlR/kBxmjlg1QqLSVXIdgUcJZlLHqW7u2GzpC6
 CutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281476; x=1699886276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnhhMk/onsazliMF0ePO1fqzsIFf7smiMaOT4UT9vXk=;
 b=kfdRhBHUB3J/bTUeRDlNr04j9dL7hHRzUmIfrcbWMMiWYFZQVE8q+Esht7uQIX5Iil
 /EVEuIsXrgv/LjRvBjLDvS0+LvNY5Fe8IpvamOoxz2ZFdU1BRfTEOqAOOvejvCLJgMR8
 KD22oy6Rfd9fueEnvcPKTJxdowABJyMhHeSTXXsqZxt4d09De6G6I0t1ukJkP5QlfSum
 xTzCpwS8LJjI1VSu+V+Ix5prqdU5el7ZdpYyhwCSa6wto2TGWC6YZUNXJ+mrEAPjKCXv
 ZKf1cI8WfFKCKwR8Vvtrb9GFzesK9qt5Ada/s1TbDcOBIhlhPwhT8wkgwu0GMXN3awPM
 Nf0w==
X-Gm-Message-State: AOJu0YzIAFg2liJKzTjFN3ogJckvQto2CKzGOlYAD83+vlEOjeL5cUvN
 7NmB/3RG9E//QL0CUl82UYCrCQ==
X-Google-Smtp-Source: AGHT+IEUT9KYCIjpez3/wIkEBSiMo4inVRo4dM+5sIDbH/JgNQH9oiTRdeAElFuQOddjcPsqyU6E6A==
X-Received: by 2002:a17:907:3e20:b0:9dd:8b5b:7873 with SMTP id
 hp32-20020a1709073e2000b009dd8b5b7873mr7950657ejc.52.1699281476247; 
 Mon, 06 Nov 2023 06:37:56 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 m25-20020a17090607d900b0099cd008c1a4sm4208150ejc.136.2023.11.06.06.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:37:55 -0800 (PST)
Message-ID: <e1f44fa8-2538-5d18-4c80-d31f0e240216@linaro.org>
Date: Mon, 6 Nov 2023 15:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] tcg: Canonicalize subi to addi during opcode
 generation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
 <20231026013945.1152174-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026013945.1152174-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 26/10/23 03:39, Richard Henderson wrote:
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


