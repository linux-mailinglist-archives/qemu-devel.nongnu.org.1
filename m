Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC5706FC2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLC8-0005Gd-2E; Wed, 17 May 2023 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzLC2-0005G2-1s
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:44:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzLC0-0003aK-DB
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:44:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae52ce3250so9236575ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684345443; x=1686937443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HsDCiGY1KoNdAtDGeTV60sBtRAjP21AK3oIRA+em1lc=;
 b=IIW9NBNACvhtww7Rqo6mTmC4n96B68VkU+p+IwrPtX8xivZ0Dr5VO+irI1aD6ZONG9
 KrgziEfSsJ4yYuFPbJwzSSw/mNlJ/li569+lnS9Ah1pX/QzlBGRepR1h4Twekx2Mp7Yk
 z2G7X1zH43ZwRIrkldAFF/4PA49bTrcpi+JKLzUM+dpsJNysVQsDUPUTKVWwAtzkQKQW
 NoC2pd0Qc4NycdmBh6aQQca+//Qw9Riuz/bevM/gb1yofkN9WIXY1aMk4Fn3hUwe7WuB
 Xe4XUm7gbSnLXEnufxVgGeT+j/OPo8cEnX+fwTDLJM8rjyWiu4sIH3dB+quLUEJ53hmC
 P6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345443; x=1686937443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HsDCiGY1KoNdAtDGeTV60sBtRAjP21AK3oIRA+em1lc=;
 b=YjpCvsX0wdTBVYBYaORlOfXwPxUx2jW8eg0Zox6+x8ZxWMp6hNEl9N37Fbt2oDnph0
 5BeAcbAzyo5Q0/TQ1hzo5M7jQR1xkIuPXDleeUheZWmCKTQYQ99GEIekvqUdZDksd6jc
 YkcovOuqvojRzT9Wbm/xxgs4SU6utPDzBkvGCR/1f7tS6Ht01PM+9/kdmTh76gEK7Ssf
 dH7u1Bvt4gSUdBlzjOu1nrbsacaTG4s+uayj4Ot0HI6hSI8z2jMTMGstTKj+VnOoH4Xp
 OGRLLWBP5VVfOutU3iQQUhi6M0IJvoUZd61A36e4EUXAC2Eb0Cx8XzsTeuTLxY82cRyf
 Lo+Q==
X-Gm-Message-State: AC+VfDyDs5bMwurbJWNoHOmw+Dw0M4Hq7zwwA2D2oVs7KZudAqNbSBTZ
 6jJR8i9AWBh8zIWXQQFIQgccew==
X-Google-Smtp-Source: ACHHUZ7OCCu3u/WKRzDSJR2J2nd9d4tQ4O4aAILBaCnfCgrU0PcKyxltGQJswrK3MFVy1N1/rl9c6Q==
X-Received: by 2002:a17:903:22c7:b0:1a6:82ac:f277 with SMTP id
 y7-20020a17090322c700b001a682acf277mr53444468plg.14.1684345442833; 
 Wed, 17 May 2023 10:44:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a170902dac800b001ac618a6d55sm17865331plx.242.2023.05.17.10.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 10:44:02 -0700 (PDT)
Message-ID: <e55ab13a-7222-8c61-6698-bf7f60f67444@linaro.org>
Date: Wed, 17 May 2023 10:44:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 5/5] qapi/parser: Drop two bad type hints for now
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
References: <20230517152516.1884640-1-armbru@redhat.com>
 <20230517152516.1884640-7-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517152516.1884640-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 08:25, Markus Armbruster wrote:
> Two type hints fail centos-stream-8-x86_64 CI.  They are actually
> broken.  Changing them to Optional[re.Match[str]] fixes them locally
> for me, but then CI fails differently.  Drop them for now.
> 
> Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20230517061600.1782455-1-armbru@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   scripts/qapi/parser.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index acd43cd7e1..22e7bcc4b1 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -563,11 +563,11 @@ def end_comment(self) -> None:
>           self._switch_section(QAPIDoc.NullSection(self._parser))
>   
>       @staticmethod
> -    def _match_at_name_colon(string: str) -> re.Match:
> +    def _match_at_name_colon(string: str):
>           return re.match(r'@([^:]*): *', string)
>   
>       @staticmethod
> -    def _match_section_tag(string: str) -> re.Match:
> +    def _match_section_tag(string: str):
>           return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
>   
>       def _append_body_line(self, line: str) -> None:

I am going to cherry-pick this patch into master, since the build
did succeed sufficiently to show that it fixes the centos-8-stream job.


r~

