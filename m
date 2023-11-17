Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9D7EF649
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:36:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41oM-0004IX-EN; Fri, 17 Nov 2023 11:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41oK-0004II-Co
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:35:16 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r41oI-0004vl-Qq
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:35:16 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2f4a5ccebso1373679b6e.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700238913; x=1700843713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExnoCM3kGSclMQ6jIwehtuIudNL3fgD7kQ0zy2FwzlU=;
 b=Ec4vE3DUAPBOoS+VIvZu4VRjhSYRGwqP4Z5aNU3BsPOWcTVyeoCFl19w/GsDJeqEWS
 dYNm86UePB1UUaD8xwRn/RiR/SbJlMMNa77aDkfjXOmRAE0+oqxO0ldGpkrZJIgvA23y
 tmfFz+M30gGwqnyRZXQ4qQHQL2ps+Od+fYgxDDBIy59Yi1VLut7M1cPn1Ahj9aaGwnRj
 Jf/z1KkokBAZQgCKX7GM7YqIizA7H6PBDZj3/G0mpJK3A7x3KaN1FzHGVBrQ6DKm8Q3I
 LN07cfWvJly3zyaTxc7YrSTSYd3BKHktu71aX9mnCMcSNbBJfAEXIoVYEIEOq+LgD9/O
 OT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700238913; x=1700843713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExnoCM3kGSclMQ6jIwehtuIudNL3fgD7kQ0zy2FwzlU=;
 b=AcpnXaeV1JtXOAVJ8NnI5QrjrQn/zkBwD3DGL9OWQ/vuZ6GEN95mC52SYOHBBWxwME
 hMeUNtdJsON3KfnlDcQOItg3zAmcs6Okb7bTv0Nr4hQZ73Cg/r0zG7PF0IzNmpLiaNCS
 B4fBcjCOfc+yY6zRuWhjUaVddZlSunsllaQbhaEJOUck1EN7LjbjsR6weMo6HsBIr6qJ
 1hMdtvFDGQXWmpsf7vGbYo+c1zMcCVJR8ShuMSa9hYqUUkLvI1ze1nF6aPhSxwET3VJV
 3iuAHtWXjXRu3xIhVNiLGECandydLkKcVioDHFcs88ou4YawGJ+JFiLfHSzbY4GrQ1W2
 f2bg==
X-Gm-Message-State: AOJu0YzSVM6BPDUvVARYVXMXoIme3/JOWWH+noOytTEts18zWVFW5J1r
 aLlVFb5uEJAs4Z7C5ZvVHc+9VA==
X-Google-Smtp-Source: AGHT+IGnNCivF19GXPSjZU8WuPdwA4mNT6ddhVaMf1UBG/WPYfNXvDqGglqvoFeEREUOVTG8WieCzA==
X-Received: by 2002:a54:4d02:0:b0:3a7:aabc:738f with SMTP id
 v2-20020a544d02000000b003a7aabc738fmr21789461oix.39.1700238912731; 
 Fri, 17 Nov 2023 08:35:12 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 20-20020a631054000000b0059d34fb9ccasm1597481pgq.2.2023.11.17.08.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 08:35:12 -0800 (PST)
Message-ID: <e5b4c97f-5af9-4fb8-b719-65c9492e35f2@linaro.org>
Date: Fri, 17 Nov 2023 08:35:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] target/nios2: Deprecate the Nios II architecture
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, devel@lists.libvirt.org,
 Sandra Loosemore <sandra@codesourcery.com>
References: <20231117070250.32932-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231117070250.32932-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/16/23 23:02, Philippe Mathieu-Daudé wrote:
> See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
> last contribution from Chris was in 2012 [1] and Marek in 2018 [2].
> 
> [1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-crwulff@gmail.com/
> [2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst | 15 +++++++++++++++
>   hw/nios2/10m50_devboard.c |  1 +
>   hw/nios2/generic_nommu.c  |  1 +
>   3 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

