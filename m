Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4737C837D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFdT-0008Gd-C2; Fri, 13 Oct 2023 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrFdR-0008Fx-Id
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:43:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrFdQ-000656-16
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:43:13 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so6402503a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697193789; x=1697798589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQSrXGI8WWfNCB8RqRvHeoItNk2q4kjZsZss3O25krw=;
 b=Wtl/qc5DNIe3JDLOKwFAK/92bHU5vk7etvByryo4z0vIvjFp54ABt2ozQ4ogKwscLD
 fUAuoeIY04lFsQyqx4Nw6NMkHmgpEhtHqqyAaIidS7JZ76tgxL7LUwtHdXb0+M++B02y
 DuwGKXXrAhNjNVH6PYDjMFfDgbzrHa34ZNKr8bfuV3cCTnlATAS3Q+ZriU+LWPYu7/o3
 aV1imSBMwchJ1hU2hdGSpErkoEuAGiQfL4J4AD7Du2Zd7+rWTC6Gfy3raxWsyPJWszaC
 ldq+2Ytn25VUwLWIow/5XoJAgJhVEJ3yFHXyAu+68Hc3HVvGdIui+sDYV6boVR6offAb
 MPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697193789; x=1697798589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQSrXGI8WWfNCB8RqRvHeoItNk2q4kjZsZss3O25krw=;
 b=PEy6nZ5WcGSHrKYyGGuHC0A/J/n4eygSB/A4FZu+Htdlretf4E/28WRmHgWZJ6bVez
 JSBDtsuU82L9BWRwzbkSZfpAFmzhpVBYv7b9nf8PjmC/4L9CL579cf3LR7XpWj9R0shR
 QEURnguKmsb3+6IEZ2Bt8X90MIcZ5W1JiDOlsb1suY/0Fb7J9JYyjDAPciZPoqtCYUTJ
 5/qeyeO+GiPHVD4zoOUyXk46MKCTzmso+4zHVn/ysupf2BnlCDO0RVrtxHtE2bcfp4P9
 A8eGhKg+wP+Cv6KEDgjIQudaJzySMXY9Fj1k1aZZcS7N1kEmtUbRaQ9Rb3oAKrtFFhqQ
 JlJQ==
X-Gm-Message-State: AOJu0Ywz5z26JYdg1gLW07XhuFTibbjDo1hic1VXc8GpLmvckT4tzKMn
 leZDWWr3/MghuTOZboa6MOlLlw==
X-Google-Smtp-Source: AGHT+IEL/NqzTx5G4VndUWfS7AiALIoWVP+hdeID3LZVyakvWRQUTj0UvHax/gJqCBk6gX8rgjytOQ==
X-Received: by 2002:a17:907:2d8c:b0:9ad:93c8:c483 with SMTP id
 gt12-20020a1709072d8c00b009ad93c8c483mr20436906ejc.2.1697193789535; 
 Fri, 13 Oct 2023 03:43:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a17090628d000b0099bd5d28dc4sm12290422ejd.195.2023.10.13.03.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 03:43:09 -0700 (PDT)
Message-ID: <67f14cfd-b2c4-d8eb-e096-4ab74ed415d7@linaro.org>
Date: Fri, 13 Oct 2023 12:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/get_maintainer.pl: don't print parentheses
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20231013091628.669415-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013091628.669415-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 11:16, Emmanouil Pitsidianakis wrote:
> When called from git-send-email, some results contain unclosed
> parentheses from the subsystem title, for example:
> 
>      (cc-cmd) Adding cc: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...) from: 'scripts/get_maintainer.pl --nogit-fallback'
>      (cc-cmd) Adding cc: qemu-devel@nongnu.org (open list:All patches CC here) from: 'scripts/get_maintainer.pl --nogit-fallback'
>      Unmatched () '(open list:PowerNV (Non-Virt...)' '' at /usr/lib/git-core/git-send-email line 642.
>      error: unable to extract a valid address from: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...)
>      What to do with this address? ([q]uit|[d]rop|[e]dit): d

Eh thanks, this bugged me various times =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> This commit removes all parentheses from results.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   scripts/get_maintainer.pl | 1 +
>   1 file changed, 1 insertion(+)



