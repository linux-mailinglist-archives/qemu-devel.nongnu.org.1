Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBC744531
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNRv-00046R-1Y; Fri, 30 Jun 2023 19:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNRs-00046F-Vn
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:22:45 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNRr-00084e-26
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:22:44 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b69923a715so38930581fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688167360; x=1690759360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=htgVKtpLDLhCS28PIyOsGhdeoGACYFc2tJeAaT+mzp8=;
 b=bzI4exEATTVmcmr1geyVBHV6ZZJebUA97WnRQ1PVWFADA0ZE6hWoIamySHviz4N5Kq
 hC94fr3IyQyX1raY0PLCAi2cQxXOFjmUVY6FBoxBq3KuLc0ERuGfO7V4au9/py6JV22N
 buaV7QkkE7N9WmLNb2vPLgrzN2TBAVXlI4kgppD2/PbFkSUE51Xxn/cFeRSbRMPu2LEc
 oxzWLLhbbaWjy+ViSbnzBSVJiD6tl+afvBsDU1l2BHvh5wAhn9EyJmUHbvoiiSJr3BPK
 ZO2g0KheswaLj4tW0n8Sm1+yX/yxhQ8Tq570a8jjOXn1rfFFnuXw2h4yL8dji2R1qL7N
 Mx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688167360; x=1690759360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htgVKtpLDLhCS28PIyOsGhdeoGACYFc2tJeAaT+mzp8=;
 b=EovOdqC43j0trwsnx5QYTs1gKH17LpIqcCsdbvS8mNY1tSJ2d1tXZoMJ2giDFWkhuw
 jrka13d0kpiqI5iOEMVJv8SoaMcuv6pHA/n3CnA3L7lu6dK8Goc7+NrA+vTEeV7QJfcr
 9IddIraD7vn6wAmVKAtsOhkgJXo4xD0GTPVKme58CXttTAMUXEV04de5bRYDIw3+Gz4X
 s+iOloSoF+PP8GU2Rb9BTVj+1NYF3M9KcUABlJJr22CeAmNCBs9+mleK9U9NP/kA/yOb
 AkOiAE1klOTehoabvEi7e4THeQcYlgfun3rs3nDwwWlQi05n8ZAVFIfpSF5xFrgq5P5Z
 LXtA==
X-Gm-Message-State: ABy/qLZJ5osep2NLqNR4G3v7vJ2Qf3Tlr1FXAh25FBykrtCaclRZKvoH
 B66WL07xNArn9HuaCXfvirCqbQ==
X-Google-Smtp-Source: APBJJlE3kL4iNxUDXwuEvl3OQvqhi8EgUIQtiIxjDpokecojGcC4Q0okZTnM8zJUnSQUGc8FDi/FXQ==
X-Received: by 2002:a2e:9603:0:b0:2b5:7fba:18ac with SMTP id
 v3-20020a2e9603000000b002b57fba18acmr3673079ljh.48.1688167360065; 
 Fri, 30 Jun 2023 16:22:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 re3-20020a170906d8c300b00977ca5de275sm8733562ejb.13.2023.06.30.16.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 16:22:39 -0700 (PDT)
Message-ID: <d0aa20ca-92a5-5321-99a9-c5bd961686fe@linaro.org>
Date: Sat, 1 Jul 2023 01:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] tcg: Make tb_cflags() usable from target-agnostic code
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20230630203720.528552-1-iii@linux.ibm.com>
 <20230630203720.528552-3-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630203720.528552-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 30/6/23 22:36, Ilya Leoshkevich wrote:
> Currently tb_cflags() is defined in exec-all.h, which is not usable
> from target-agnostic code. Move it to translation-block.h, which is.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   include/exec/exec-all.h          | 6 ------
>   include/exec/translation-block.h | 6 ++++++
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


