Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA20704250
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 02:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyiZv-0002YJ-IH; Mon, 15 May 2023 20:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyiZt-0002WR-T0
 for qemu-devel@nongnu.org; Mon, 15 May 2023 20:30:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyiZs-00054q-4i
 for qemu-devel@nongnu.org; Mon, 15 May 2023 20:30:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so1710391b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684197006; x=1686789006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UapGSEkvKPnVTfbxD9E394XMi9ZiyqcTrl5BmMK4py8=;
 b=JYNCfnYG8EJt8rMqJNayPayXz+u5yGmFvvPyUhg/cTuqeNd/AjKIGuxelQfPKv4F7L
 GilZMBI/tLaNy2owS56LhPlVU4x+7Yj4kqa9sVW90+BFRUaWWnSuceQODJ+zeg0rVrr1
 j+hFMm8TqjXrDn9FzSRgJlijsS8MB4X5X9kZVtqzovn9yc4hDAAoYug1YonxHG82FNlf
 cPdIfPhe+5Lp2fOAK1HCgkSJwnEuEpLf+wMmz3RlcIfzbZnGWNpJtqXtHqNrVwQyFSa2
 InDTiaAlmNBcb3Nw1gfNryZv0RpABSjkUt9+qjfshk9Q9MDXmpF4QA+53+LSaGZrOjGj
 v9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684197006; x=1686789006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UapGSEkvKPnVTfbxD9E394XMi9ZiyqcTrl5BmMK4py8=;
 b=GTlQomxCnb/oLpVY/NCF55HuHQEmb8ZIdDSXJacbmBMwi4s+OllHQW67xCv2YjE8Kf
 pT3Q2ry9QpSMAroLFE3NMH6dcgkMgwDn62dv/4tnMMqo4TP+BMjPG5ZV+aeBuxb1dhRD
 qu+X1T+JxPvdN48+4eZxgunXpTNGwrgDCVVBzU4a5TUPP3kwIB0a/Fioacb43yfiQCtY
 tMgLQbm2scGCNkLbTbX7H35eMZjVCgn6/UHa0sapTJL/TVgHfi+8L3S0JEPU+rMo8fX0
 JtUxrNPyvt8mmrX3cBS3OjBLID3jT9a1alxppZvnM1jHHW89omk2F5vgKkTRQ1rR2Jvu
 +H+Q==
X-Gm-Message-State: AC+VfDymlDlAgSHwPFA7b6D5Rejub1DauP34Y42WuOttwaQTs0/FZf9j
 nXVDu2GjeNyp3jFR59c32HxNjg==
X-Google-Smtp-Source: ACHHUZ6kzCGm5L//lg0nWm4n/kGzoDOgJnqQPmZ9PWSFwkPJzENLuLgkt2PMojtSizwDIuY9MgERsQ==
X-Received: by 2002:a05:6a00:448e:b0:643:4608:7c2d with SMTP id
 cu14-20020a056a00448e00b0064346087c2dmr44362013pfb.12.1684197006216; 
 Mon, 15 May 2023 17:30:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 z15-20020aa785cf000000b005a8de0f4c64sm12336319pfn.82.2023.05.15.17.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 17:30:05 -0700 (PDT)
Message-ID: <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
Date: Mon, 15 May 2023 17:30:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qapi/parser: Fix type hints
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com
References: <20230511111709.971477-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230511111709.971477-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 5/11/23 04:17, Markus Armbruster wrote:
> Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/parser.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 4923a59d60..9315412ab2 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -563,11 +563,11 @@ def end_comment(self) -> None:
>           self._switch_section(QAPIDoc.NullSection(self._parser))
>   
>       @staticmethod
> -    def _match_at_name_colon(string: str) -> re.Match:
> +    def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>           return re.match(r'@([^:]*): *', string)
>   
>       @staticmethod
> -    def _match_section_tag(string: str) -> re.Match:
> +    def _match_section_tag(string: str) -> Optional[re.Match[str]]:
>           return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
>   
>       def _append_body_line(self, line: str) -> None:

Doesn't work:

https://gitlab.com/qemu-project/qemu/-/jobs/4289613692#L574

   File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
     def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
TypeError: 'type' object is not subscriptable


r~

