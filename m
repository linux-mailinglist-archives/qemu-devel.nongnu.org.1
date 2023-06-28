Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33854740C90
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERO1-0005LF-Vl; Wed, 28 Jun 2023 05:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERO0-0005L6-Eb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:22:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERNy-0000kK-CU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:22:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so6886321f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687944169; x=1690536169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=emnx0BJE+HuZGE7aJDVgQPx1CaYevqUan3qDrUs1cn0=;
 b=SGem//M3va1sVQXoMgLcc46TjyjF54dj+E13eIVDZJZEdAfNgvm3mLowhCdDwu7Aal
 tPPeTDvMcPlSY0zBadQeZhUfMYfzLTT6xGtgtMmuS0RSO107F6ekUYN1aol9rN1/eRoq
 ezf7h43HBEq7NXxPOQS/3xDjpNiyL4S2kR1KojEpuai6UbHDVb9EHOSvlBSl4ulq9qQo
 bVYMC4kvUiLk/CqK6EwWpXrsKFerZaby2JcQBvhIytS1ub2mfoPLW/OmNdZkjqnyMWAE
 lUWSs8hqVwLoQ8/JxHKfUQ1ZBxmGtb2nFafsvxLaw4ShLfszs72qc2cWl9nsyIFPRk0G
 BvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687944169; x=1690536169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emnx0BJE+HuZGE7aJDVgQPx1CaYevqUan3qDrUs1cn0=;
 b=jEXOBLorQWoJjPSQ0qa4eoMScElhS9TMlKvICSv230qhG9kEhkg6QrpgByCNBTJSF+
 iwuwzqwm5gCtYmXT4DH0W9JzTaaKH0VhcuA6CmjOYu2w/yUZ3orAEPoPRlr+MNWER/Rs
 z8TNO3qxpqCg/b3pWc2jDTkXGBs6pAVwnLgTg+rcxq465X2MQyA/tR4dKVdgCVduq8t9
 83QEvWaF7CY5Qr94OOiJXwn97f/aQIz7iiGD39WZTNP2KOr2E2FnPYDb+a9+fA81IO83
 CliAXVbTcqitE5Ans+2XS3msgtGv9z51pne26jvu1LQDQp3X+0EJ2oUF1913kwGrZW+Z
 W0MA==
X-Gm-Message-State: AC+VfDxtPFh/O3cpoy0/QValNREi709WanuuD92ulLMEpvtGbVCdcZGM
 mu3AuooT3bTBEzQNVVG4p8+W+g==
X-Google-Smtp-Source: ACHHUZ7X6UmPU/d9gIux1Di9fOrpgTB5I537z19qYD2Jf8rT+1qMeEveLixuwUspL6yynKgOXYxsEg==
X-Received: by 2002:a5d:4d92:0:b0:314:c01:2e81 with SMTP id
 b18-20020a5d4d92000000b003140c012e81mr1219477wru.6.1687944168760; 
 Wed, 28 Jun 2023 02:22:48 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 c15-20020adffb4f000000b00313e4d02be8sm11874271wrs.55.2023.06.28.02.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:22:48 -0700 (PDT)
Message-ID: <21a33693-30fe-2894-6365-5018d1893351@linaro.org>
Date: Wed, 28 Jun 2023 11:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 04/33] virtio-gpu: Optimize 2D resource data transfer
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Keqian Zhu <zhukeqian1@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-5-marcandre.lureau@redhat.com>
 <3798dec7-5798-5703-86f9-fd45787eaac2@linaro.org>
 <CAJ+F1C+RfK-QfSu32rphUqr2oeyCagoh-nYmim4QacT4tr9_jQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJ+F1C+RfK-QfSu32rphUqr2oeyCagoh-nYmim4QacT4tr9_jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 17:10, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 27, 2023 at 5:04 PM Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 6/27/23 15:02, marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com> wrote:
>      > From: Keqian Zhu via <qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>>
> 
>     You need to fix the author for this patch.
> 
> 
> 
> ok done, do you want me to re-send the whole PR or is that enough?
> 
> The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:
> 
>    Merge tag 'pull-tcg-20230626' of https://gitlab.com/rth7680/qemu 
> <https://gitlab.com/rth7680/qemu> into staging (2023-06-26 17:40:38 +0200)
> 
> are available in the Git repository at:
> 
> https://gitlab.com/marcandre.lureau/qemu.git 
> <https://gitlab.com/marcandre.lureau/qemu.git> tags/ui-pull-request
> 
> for you to fetch changes up to de1f8ce0abb8c43d1e6a00c31c6d24dfe0505b92:

That was enough, thanks.

Applied.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


