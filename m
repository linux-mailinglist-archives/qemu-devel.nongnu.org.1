Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F272517F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 03:25:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6htX-0000sm-9P; Tue, 06 Jun 2023 21:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6htV-0000qU-8X
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:23:25 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6htT-0003TT-MP
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:23:25 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso5578451a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686101001; x=1688693001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTd8aNS6YdBdG2wLvCVxxB5kDdMaJKmoy/e/w8jpixs=;
 b=hLuFHOBP539F00skl+sau2XmahKf9jRMMUJ1A9uOdKvUf+PwyrZikvD9rvUtdwP1lN
 xbfLc6TVJPx/HMGJX7EVaWx/NztkrJ57/l4uW1Lp3fzGhT99n8aWwFTdcorCeyAs44lW
 xUJOz65E92sCCGzu/UWpwp1zc60xuonzzO9WGnlDMOyf0tPW2/xHpvXlD3hCX8EAVked
 SqBccQB9PgW2NGoPUrf7pffR19wjnweX5XK+eaOCijHfoFq/zfd6LNe7YlyfnoKLhREq
 C/PDQvSjN2GswIzTSgS5it8hylT1e6sVzgpjbnGah2uJdOpaIy1Wa+6XdvZs8v5fYOfQ
 2Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686101001; x=1688693001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTd8aNS6YdBdG2wLvCVxxB5kDdMaJKmoy/e/w8jpixs=;
 b=lHY14PiADH3dLdkUJKfyuupAO3OgGHT8rcXWtlWVyKwfAnrs50eQ7D3ycSmcFRMdoD
 BNEiZeeFB5uWmdptNpRvFcqDDrm9h2XOuAxEM6wMBP0fkAzRPGgHhXzEluas3X9K6L2E
 +NWpDpDxQ713MZOsdw+FjnSU4cIhb0a8wWdD4x6yzOhNfXpftkGPX9hrDFQjwickEYjm
 Bb2LN29KvGdgLAFz4lvREKsCt8uqQJMoGx5gSm2w9ZR1zGKUwa44Ok95R7Uig3racyA1
 MOf2eN5LUAngnOXTXVhQ/jPLxhDi+ixzngS/F92Jz7+UL/tJ0dMVCUAe78t+pJoFMP3q
 L+Tw==
X-Gm-Message-State: AC+VfDwtM+aTuovCqAgVm9PFaZggfktXM/SH54KO7SYJOCrVaEdDDa+k
 GXuA0H8qS1t//V2nHvegUkGU9w==
X-Google-Smtp-Source: ACHHUZ72j4jo5O5eevdDBIf50VXWkEB6cUoIsslzKxwhqfH5CBfh6/YNe0Q61K5+1U5uDs+cLFbMYQ==
X-Received: by 2002:a17:90a:6b0e:b0:255:4f4c:368 with SMTP id
 v14-20020a17090a6b0e00b002554f4c0368mr3208178pjj.27.1686101001663; 
 Tue, 06 Jun 2023 18:23:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 8-20020a17090a1a4800b0023a84911df2sm188347pjl.7.2023.06.06.18.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 18:23:21 -0700 (PDT)
Message-ID: <7427ed6a-fd32-6f58-1648-30d306320e40@linaro.org>
Date: Tue, 6 Jun 2023 18:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 16/21] meson: subprojects: replace submodules with wrap
 files
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
 <20230606143116.685644-17-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606143116.685644-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 07:31, Paolo Bonzini wrote:
> +if ! test -f "$source_path/subprojects/keycodemapdb/README" \
> +    && test -f "$download" = disabled

test -f x = y

is some sort of paste-o.  Remove the -f, I'm sure.


r~

