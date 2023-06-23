Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328AA73BB5D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiUQ-00066R-Gk; Fri, 23 Jun 2023 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiUP-00062O-0v
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:14:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiUN-00035c-14
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:14:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9c532fa45so8588675e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687533256; x=1690125256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnnKEbUvj74y6swt1Yen5ynIV0kpGjzEKPfjFjq0Wh8=;
 b=k/rjukvsLyYNZDYRZmqpjkibMcZK5loRr4qfUGqJJfcVivIw9OelHpuBRHyIhkZEW7
 S9QscsGXp9eFAhLtH4CSpSwskf0NgzK3/ARnYVPVsZ3VqAprjF6TOrvpgVjpxby+FS03
 kX1hgTowCMXS88QhG28zeyhn6LXmpVQ1ExQmnyZ4g/ncPacgG405Bv54glCJsR8ercDK
 ln1hWXAHTDq+kComd9dKyiEkRqOKBZap8jAVet6PYncRtpnLzL4SXKIC/iKE5A1bctSF
 L1Rx6Wrs1q1NsDD+zvG7lIQtxwHiDJouLgm7FZcfehqHGJnD5oDl1bDr2eFU9Exxoi+s
 jWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687533256; x=1690125256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnnKEbUvj74y6swt1Yen5ynIV0kpGjzEKPfjFjq0Wh8=;
 b=jg5jOFEqh10KCmoDIQbJAb4kBme8GZDDMh8mN6ZuopIhmp4kxogFuUjm49HWoRf9pJ
 s0evTYPwk+CQCMVhT+bUJ5Uwq/Q3DLFGjCyQghj5FoeG2mYgEjzdKsYCaRk5yIpdfRTs
 1FRCq4FkZkZ7l/p/79YwjStBFRG1h+7bHAU2SUkMiMWZUTbL9Xf4ZKWhVSXC2bSOHdyd
 sMA2wTSeyWzSEp/pvPK0aC30ZRagJZSYKP8kYL7e5aN1+YlNYkFYiM/dYoAV0QgJjfH9
 apLtovnKwvKx0veGz2M97TRt8JWqpZ/5w2nbh+7CsSyQw+28ltKWvm60PEib40s0EHUN
 UPhQ==
X-Gm-Message-State: AC+VfDyK9QNpewv7Sngc1f7v59zm97frD7m3CSCXXs3x1/Ib92NZPX8L
 WDl6X5a+EPFuHog6f1zD0Mdf9g==
X-Google-Smtp-Source: ACHHUZ4qreyV1AcIE3FHgVDqR7ryKxuELlgnep9l/AqSEERbTkINCRebEkpcqvT4QfBqWWkNlzHB7Q==
X-Received: by 2002:a1c:cc15:0:b0:3f9:bf0f:1cf5 with SMTP id
 h21-20020a1ccc15000000b003f9bf0f1cf5mr5812632wmb.20.1687533256577; 
 Fri, 23 Jun 2023 08:14:16 -0700 (PDT)
Received: from [192.168.93.175] (94.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.94]) by smtp.gmail.com with ESMTPSA id
 u2-20020a5d5142000000b003113dc327fbsm9788630wrt.22.2023.06.23.08.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:14:16 -0700 (PDT)
Message-ID: <93fb759a-e66d-cf2b-984c-59cb3e074bd5@linaro.org>
Date: Fri, 23 Jun 2023 17:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 17/26] tests/avocado: update firmware to enable
 sbsa-ref/max
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623122100.1640995-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/6/23 14:20, Alex Bennée wrote:
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
> Update prebuilt firmware images to have TF-A with FEAT_FGT support
> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
> machine.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-Id: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)


> @@ -150,7 +150,7 @@ def test_sbsaref_alpine_linux_neoverse_n1(self):
>           """
>           self.boot_alpine_linux("neoverse-n1")
>   
> -    @skip("requires TF-A update to handle FEAT_FGT")
> +    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")

Same comment as v1, we can remove the @skip* tags.

Similarly to v1:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

v1: 
https://lore.kernel.org/qemu-devel/579fb938-dc8a-5f85-143f-644ba1f1db40@linaro.org/

