Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BCD7CA3F8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJnx-0007x0-Ua; Mon, 16 Oct 2023 05:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJnv-0007wX-ET
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:22:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJnt-0007Ql-PV
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:22:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4054f790190so46299755e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697448144; x=1698052944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xHpVlTiWXRbLK5e0Vo4yRlRi00EoE1VP6IQAJAfXyA=;
 b=MWFU/UZXU2KOQiUEeU7lmWQSHVnJvZG+6A7Dmvito9Ah/THOJC4137Lz+6a7wozK36
 7L0Q/+MaFDGcBy2R1GUQne/0izCwmf0itMGDsCOOrjwDsM1/F1JXoCp+JopSvJ/+6eed
 cG4ju62pLXxk+puLfLTmnTCCuAwrGyGLtbbn/d0yZEhT35X265uCI8dTOl7oNK56mkFY
 B8OlZdhk4usFiBXkmvfubOo/1ISYREtS/8bKlr4RnEJqGLnzbK3ewcyDGQu4OkMhrfeQ
 M/vL8DDChDRhjcHejYua5aH/8D1HPBOv4x9rlu3eDoArZHDw6NnUMQxy6zqxdlkI8tZ7
 0xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697448144; x=1698052944;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xHpVlTiWXRbLK5e0Vo4yRlRi00EoE1VP6IQAJAfXyA=;
 b=ceHJKIQWhHYw8NUxXi7omDKpyR6ZfqtbCb5sY0eHM3kc6I4inO/dB7gUlsh7hWOfLO
 1AbE09Yy9KW1RJ+DB8zryOHHf8UADK+0aUV+7ysMW7ucNEDcGehqMm7/V3LzjCcZga5p
 wfXSM7uxuSIroYy1P3v6GuSt0UHtoq8T2Qk2JL3vMlyDrZYxQqGoyXEh6FA+TaiAcdJd
 MbYXtZcoKTIIZUiJ+ERdZmhLDtyLp0f8PDjisGcABy+RclkzdpLmMs4Q9ULYHs1JYhgf
 UgHRh4UyVmfsb7K12kVKURDJqvnf50SygGmMjfi7M2gCvT04GbDGP+A1ZIxhQ/ACgXFb
 0Vow==
X-Gm-Message-State: AOJu0YwDRkhZ34deePRjH9IeEMNcPO12J38LSxD63nCmb1wU2PfsHVCi
 6BW0LjIAkNQW/eC7ZHhqCOT6700MJgWyyVIixEk=
X-Google-Smtp-Source: AGHT+IFPXfuL+7cgouSkBYdxVH3fONpnHnb8JRvia9V4kjRhXeoiwO7fZ59IemlcK01VOsTRbe+7VA==
X-Received: by 2002:adf:f20e:0:b0:32d:be44:f70c with SMTP id
 p14-20020adff20e000000b0032dbe44f70cmr97395wro.7.1697448144431; 
 Mon, 16 Oct 2023 02:22:24 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a056000018700b003217cbab88bsm7808349wrx.16.2023.10.16.02.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:22:24 -0700 (PDT)
Message-ID: <ba834d5f-75ec-1115-b054-16e807d2c89c@linaro.org>
Date: Mon, 16 Oct 2023 11:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 04/17] configure: clean up handling of CFI option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231016063127.161204-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 16/10/23 08:31, Paolo Bonzini wrote:
> Avoid that --enable-cfi --disable-cfi leaves b_lto set to true.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)


> @@ -1845,6 +1843,7 @@ if test "$skip_meson" = no; then
>   
>     # QEMU options
>     test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
> +  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"

Merge as "-Dcfi=$cfi -Db_lto=$cfi"?

>     test "$docs" != auto && meson_option_add "-Ddocs=$docs"
>     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
>     test "$plugins" = yes && meson_option_add "-Dplugins=true"


