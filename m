Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDEB70E48B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WeN-00020F-SC; Tue, 23 May 2023 14:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WeL-0001zu-OD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:22:21 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WeK-0002xu-9L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:22:21 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d247a023aso59266b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866138; x=1687458138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62Yy7sk/s3L3H6VyO9425vVcfmYgtNvjD4xC6dAWJ3E=;
 b=smDs4rUMn3qBT40WxqC8Ahfs2GHJAkJnJR9rl9/0r5eZtfD9KWl8FRah9bZa7w3+fW
 Odtb9DTbqjTreDN2YQzJK9aDfpyGpmad7qVPbzzCuY8BIDWgn0ZCLmmka1x2Km6dyser
 HH978E8rBlXwBgszMySN+ko+yJDkKY77dQ/kIMEVGc3NJJwUpJkisZsRvmimENEkwTeL
 no5pmU7vdb5TrpaW6DWUgDBjWR1MgplY7Y9ABn5aGLDdmKai1gi47fjTj4RdPzz0iuYE
 s0ZX8NHtpVleBF8UDFIrhwu16//lGfkQUJvBgKW7hrhQipfjnDXYt4iLyWiY5+19yxO1
 x+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866138; x=1687458138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62Yy7sk/s3L3H6VyO9425vVcfmYgtNvjD4xC6dAWJ3E=;
 b=SiGqk4Lfg5f1Yr03sX4MoBTXCg4Jb0TGRY+Flc5F5BAz0ZV1/oVc/yQtdtT44lq1sC
 jXpjHYD3DzU/qtTXTHIdAfGlr660wPh2HO7p9eMuS8ZsxyUZZkDfEHTqLs3pf+8lAlgf
 qz5xyTC5H4tEKWp9jgyZz1WoS5UwGQVT2MjEPqE4I3lXkiiMjasWb17MiT0KDP07YBX3
 WKY3fQhMrLFpm4+YF6IORWKN7m/wudBqYEo5grGa45CNmN128wUDTdZqmIiF+opZobyK
 QCEmf8R6rEoi21lugO3+SnP0Jyf1S3JtMnv61D0+N4O3h7zDEPUZZS9qSDmnmIwrR7U6
 jbRQ==
X-Gm-Message-State: AC+VfDybeVvnVLwTXl6Zo5ErqB8RFVOXeunsvo3vt/jiwhg2yUiISB7s
 SofpEKGBywVoIv7+lqYBOiv9Gw==
X-Google-Smtp-Source: ACHHUZ7PE+J7lNGpPUoskx4GHy2PnTXcSR5RG0GAUAHN8U4I6YlauAhS5RCWs2665qqxDPC6GywCQQ==
X-Received: by 2002:a17:903:32cd:b0:1ac:820e:c348 with SMTP id
 i13-20020a17090332cd00b001ac820ec348mr18927162plr.0.1684866138338; 
 Tue, 23 May 2023 11:22:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902704400b0019aaab3f9d7sm7080373plt.113.2023.05.23.11.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:22:17 -0700 (PDT)
Message-ID: <065202bf-b481-dc94-ac27-03e8f1d1668f@linaro.org>
Date: Tue, 23 May 2023 11:22:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] hw/core/cpu: Simplify realize() using
 MACHINE_GET_CLASS() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230523061207.48818-1-philmd@linaro.org>
 <20230523061207.48818-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523061207.48818-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/22/23 23:12, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/cpu-common.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

