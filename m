Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C798C78C785
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazha-0003u1-4R; Tue, 29 Aug 2023 10:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazhX-0003ss-5C
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:28:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazhU-0005dc-Uj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:28:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso41634975e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319291; x=1693924091;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJfzW0yF1qfo03dZD+w3BZuR4j3eM2q4DA2BnsiOmdg=;
 b=CotFzDf9Qnl/wKD/wpnVTe9jEn3GbYYqn8v7Fg68gc5X1a8QG386oX9h4lJlHHO0d6
 h8nIIT6rz+pAl8JrLF+oVCaCQXpEkWaTvR9xy5q2G5uZg36UZdiAYQK9L31D09zP78yj
 UgZl+iyt5ahNO15f6WIGXtuU7wRYsI+J7R/ado6rG3EJvJ4j6YjZaVdvqAMLiQHYWZPj
 2B7GN7u1T0ZDTkRr/bj4yIiEbxvRP9bzbMdYDVep1H5yyHZuXDfj6JL69RmkyMqFv5wx
 SD5LZp9RjUsQpYiEPkc65nDpY1XaCfJJm/HgOv8GOOsPJgwWlXl2dpjmhALA3uY2PSbS
 Zx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319291; x=1693924091;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJfzW0yF1qfo03dZD+w3BZuR4j3eM2q4DA2BnsiOmdg=;
 b=OoDrpgDWM5OZp/0ZYzdiEoALZnp9otj3XCzF/hog+XJzfXDhsagz4e0fTYDA8jPVxX
 pngrf70m9E0yw6X0+6Mg3JavgF82h/HcaT9x1VmQKr87nltFhxkl+Vbq9vt1WsS1UY4C
 auxRLytpTUV2JeSmrQZ5PmZM9ydylsdNegUKRovSI6H9j0iWJg7nYMIxBQ8xJifbMHbQ
 LD0QenqpgwkqNNyBsj9Pe47gfdR7Sw2iSvERJHrVWNfeXqJo+So+/sUf8dllWzEQVPGE
 Nw2DeFOBT2jY4x3dpJr4fmZr6InKhjRM9tlrfOCny3WUbXTc8ZPJVtarW+yWOBHlNhCK
 8Cyw==
X-Gm-Message-State: AOJu0YwIZ2Xr259h7lkLzW6vD/nnW6Uo7mFE3K2p5SE95lw/0FmxqEaK
 42EyE8ijR24w8E9ixHWUJ2mBd97q3PcIOKVOnlc=
X-Google-Smtp-Source: AGHT+IHT49DXdnt2LWJZLS1W7TVLk0jihzbeMGrcRIFnDc91RXMKmfoqj8MBsanYA+zaz1G0ttfRBA==
X-Received: by 2002:a1c:ed04:0:b0:3fa:9823:407 with SMTP id
 l4-20020a1ced04000000b003fa98230407mr22012275wmh.18.1693319291423; 
 Tue, 29 Aug 2023 07:28:11 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c294800b003fd2e898aa3sm1465552wmd.0.2023.08.29.07.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:28:11 -0700 (PDT)
Message-ID: <98dc092a-b5f9-088c-4ae8-45ea3ac7a071@linaro.org>
Date: Tue, 29 Aug 2023 16:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 08/10] configure, meson: move simple OS definitions to
 meson
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-9-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829082931.67601-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 10:29, Paolo Bonzini wrote:
> CONFIG_DARWIN and CONFIG_SOLARIS are only used in C sources.
> Move them to config_host_data.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure           | 12 ------------
>   hw/9pfs/meson.build |  4 +++-
>   meson.build         |  2 ++
>   3 files changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


