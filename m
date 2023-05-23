Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974070E475
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Wa8-0006J2-JY; Tue, 23 May 2023 14:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wa6-0006Is-Os
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:17:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wa5-00029V-7a
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:17:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-25372604818so3939322a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684865874; x=1687457874;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bGCjSM9D57rfH+r9bt96oUzjdBdw6pNcVAxOlmQNo8k=;
 b=PQgpGDSoJfFHWAuek40lTFRsJDpgXEmwZu15xDcTZouZbqVuXGeFTDBVgFjv2IedXD
 73GCe3NI3TtwHF/1+hw37Na4rtNo2krmIJGSOKI7e7wNmNnoWPh68KZragZiAzeoPIra
 S6Z2Zx1Q7PQ2BkU7Uz9lepW0hBMrseLhUQgk1l9C9H/frAzVlXH63OsxTPz1Kk2cxifa
 q0cP2KBZeqXk6j+zAf+AoVRz5yV1e7FeNKOokk9RO5YPSztvOc9mvZexahcunRfO8dZp
 VlxwRYqs8bh00C4ltp8nXMAOa7sBSspqfP4vIW+eThJ5aGKq4amdK3xVgNzWcV6LEWKW
 pmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684865874; x=1687457874;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bGCjSM9D57rfH+r9bt96oUzjdBdw6pNcVAxOlmQNo8k=;
 b=a1LZOutYmJ5CVGYyR8vC6eIFmsRJCOnabmqwFWKG9/KJ09pxfTV4lxXTzv3zUEqH09
 Tx17yygvZgmlayfUMDMg5QvN6iesW6mRMkajtVUrfuT5cj1xduE8xFBwLQ50vmbdplYh
 +4+SxCBrcynBvev10gs/dZIGDAxtXQuz/AnZI9JQB0SD9yaIv1X/tXAFMAzeOqeOxPBF
 YMuJFP9DxlJXeBxLl4WI3Cy9s/3ExkpV1dOHmplHjIPF3YZyjfLPxBS8aamZ1DrVfLpx
 1Ncrh/9bdEPM4n15CFfwIpnxcZtWSs+2tJkJoHi33eqRldTseqBQrAyTTIOqpZ6BeU0h
 AZHw==
X-Gm-Message-State: AC+VfDwX9qIygkshDamMxl1N0s11rX8x0+0p0ZvRIMGurP4NjC6Jl89i
 Vwt5X4+529TAe5zUSvDoSvSpkw==
X-Google-Smtp-Source: ACHHUZ6BIvD5pBJL+BiEr+v63WsjnExsBTeesw+t/n4OusaILZhIkZePtN51H7cHZPRRtrWQkwj86g==
X-Received: by 2002:a17:903:483:b0:1ad:eeea:32d7 with SMTP id
 jj3-20020a170903048300b001adeeea32d7mr15212928plb.48.1684865874570; 
 Tue, 23 May 2023 11:17:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a170902869700b001a98f844e60sm7091101plo.263.2023.05.23.11.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:17:54 -0700 (PDT)
Message-ID: <68674803-6dbc-0048-e29b-e2b94c70708d@linaro.org>
Date: Tue, 23 May 2023 11:17:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] scripts/decodetree: Implement named field support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 05:04, Peter Maydell wrote:
> Implement support for named fields, i.e.  where one field is defined
> in terms of another, rather than directly in terms of bits extracted
> from the instruction.
> 
> The new method referenced_fields() on all the Field classes returns a
> list of fields that this field references.  This just passes through,
> except for the new NamedField class.
> 
> We can then use referenced_fields() to:
>   * construct a list of 'dangling references' for a format or
>     pattern, which is the fields that the format/pattern uses but
>     doesn't define itself
>   * do a topological sort, so that we output "field = value"
>     assignments in an order that means that we assign a field before
>     we reference it in a subsequent assignment
>   * check when we output the code for a pattern whether we need to
>     fill in the format fields before or after the pattern fields, and
>     do other error checking
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/decodetree.py | 145 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 139 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

