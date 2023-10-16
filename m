Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C57CA999
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNj1-0002bT-Ux; Mon, 16 Oct 2023 09:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNiz-0002bI-Hf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:33:37 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNiw-0001Jy-Al
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:33:35 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b95622c620so798056566b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697463211; x=1698068011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6RgdrQXuBUVPl+vq06JcVuhwAdo9RCxusolf7rvJiRw=;
 b=nbF0o3EChwsDTbQRAirimo7eU3cNzyKTP1WlXUdLmAe/4rtT1wP9zq1SPhd60/wD3h
 5GP+7TNIlOS02xNIpuZA55qQEIQhMDxmtI38p9ILjit5h+O7UuT6GXA+wI5RhxiLjNTU
 wcYk3l9dFcFIzfAeNmULlTCTzL02W74JPE7CNCYNCXzq6La1xBsZyOrrL9+fRzHdeUI1
 nYurWlAHkbz2RuUyAF1TquKhrUsEn5ST5PjkaE6ac0+u86ZGkW4Es67hVyYW6w0q1z+z
 hWMMq2dGjn7GQoprdqfxMrwpebWH3QCyTe05VwknbmFqAhogKE0N7nj3Y7dcjQH3pII/
 vhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463211; x=1698068011;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6RgdrQXuBUVPl+vq06JcVuhwAdo9RCxusolf7rvJiRw=;
 b=eXZwN1KrsPWbsxJpuOVhBJN5WjiqXm2oOTnAY/MjZJG6ScNZpLpyBlbbGLzYSzime2
 uGJmvx7CjlBt6nwyzqkJ9r8GoYEdUkaF35bReU7jxkZwc2bAsleKM6j6l9jCZaMBbyI6
 7FxpInMKACqBO7kSkNAragaDagrwrQAuDQYlwzjDYZNUDy21Nk/wloVmS9hi/QDX647e
 Ii6jSO5Gvp6V2alltHpPOW2mSH+GjP0oqlsnd6Ao3YDXY/WsD+hbuY965SDakyzXhWkr
 da6PjcGb6Jt3omnDuq6ynUiRrYYITNOiLL5XcmLWf5iZ/pFbRI4twTNWt67rRnPHAxtd
 IpYg==
X-Gm-Message-State: AOJu0YyBf2VhUrETOptb3RfgDn602vriT9QNWDgsjAEgzlpP3WboJ5wg
 e97mvaA58C/l0Kmra93q6Hq2c2FfLZh7KFrR+eg=
X-Google-Smtp-Source: AGHT+IENnpcAncOhXImQUOcY+cLHPvGoVQdEVFDDbrxINxt2H4vAyBeCQonRxgKd+UxBZdc/n1wAsA==
X-Received: by 2002:a17:907:3e21:b0:9c3:c2e1:a38e with SMTP id
 hp33-20020a1709073e2100b009c3c2e1a38emr3557890ejc.15.1697463211132; 
 Mon, 16 Oct 2023 06:33:31 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 bo8-20020a170906d04800b0097404f4a124sm4055405ejb.2.2023.10.16.06.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:33:30 -0700 (PDT)
Message-ID: <e8c30d30-4556-3a04-dad7-103708b1eff2@linaro.org>
Date: Mon, 16 Oct 2023 15:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 04/17] configure: clean up handling of CFI option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-5-pbonzini@redhat.com>
 <ba834d5f-75ec-1115-b054-16e807d2c89c@linaro.org>
 <e6eeb599-ecdb-42fd-94ca-8a78e2112e58@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e6eeb599-ecdb-42fd-94ca-8a78e2112e58@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 16/10/23 11:44, Paolo Bonzini wrote:
> On 10/16/23 11:22, Philippe Mathieu-Daudé wrote:
>> On 16/10/23 08:31, Paolo Bonzini wrote:
>>> Avoid that --enable-cfi --disable-cfi leaves b_lto set to true.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   configure | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>>
>>> @@ -1845,6 +1843,7 @@ if test "$skip_meson" = no; then
>>>     # QEMU options
>>>     test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
>>> +  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"
>>
>> Merge as "-Dcfi=$cfi -Db_lto=$cfi"?
> 
> Sure, it also needs a little change to meson_option_add though:
> 
> diff --git a/configure b/configure
> index 3da46ed202d..fd88ef3fec2 100755
> --- a/configure
> +++ b/configure
> @@ -624,7 +624,10 @@ meson_option_build_array() {
> 
>   meson_options=
>   meson_option_add() {
> -  meson_options="$meson_options $(quote_sh "$1")"
> +  local arg
> +  for arg; do
> +    meson_options="$meson_options $(quote_sh "$arg")"
> +  done

Oh I didn't notice. If you had said I wouldn't had insisted,
but since you did the change,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }
>   meson_option_parse() {
>     meson_options="$meson_options $(_meson_option_parse "$@")"
> @@ -1842,8 +1845,7 @@ if test "$skip_meson" = no; then
>     test "$werror" = yes && meson_option_add -Dwerror=true
> 
>     # QEMU options
> -  test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
> -  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"
> +  test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
>     test "$docs" != auto && meson_option_add "-Ddocs=$docs"
>     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add 
> "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
>     test "$plugins" = yes && meson_option_add "-Dplugins=true"
> 
> Ok to squash that in?

Certainly.


