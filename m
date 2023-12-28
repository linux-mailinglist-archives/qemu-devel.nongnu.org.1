Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75781FB69
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 22:51:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyGd-00065k-Gd; Thu, 28 Dec 2023 16:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyGb-00065W-H8
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:50:13 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyGZ-0001gl-TK
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:50:13 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35fe8245d0eso20553795ab.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703800210; x=1704405010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7/Lv7QDO5BpzaXr3vID8Gvz5FL3s1PhWmrh0+n+XRw=;
 b=H60vaDg56VlVkxb4/wo7epQttwLle3TolkdXBBoL8ZsYjPg2WDccFR079PnB3t7rGR
 L5ScIl4/4H4KcchQTLfo9a/KlYTmSjcXVtOcrDHKD6ftNOCepQ9MhrxfDbWkgWT1xmL7
 4Deep2d7vvWSmE/MUlyD66UnppDDEckR8/cchTbSpT6XR9Ooqk2txWKNUhfYU/9ol5+T
 0750aL0sBHYkc8bB08bYQp/VzqtN36n2Ms4jUzguK9rt3v5LApUbscGdSYoG5dLPFf9Q
 ibMTcEgai+2kQUYs5sF6dtZDNgfXqIoOEr6y5axqDvDYfYxQfgE9c7ioqgc+okWPwvk7
 Ht6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703800210; x=1704405010;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7/Lv7QDO5BpzaXr3vID8Gvz5FL3s1PhWmrh0+n+XRw=;
 b=SjfJdaGdQqquK8cd991/Rz5AJF6uf4j/GI1d0qxEhir+Z0FbKWIsZyZDdSsbI0vljI
 +CMzUSVjE1/dPDhMoq09PtVYhRRVbqZ23FPwfSLPgQVM/KxroZKjjKKzEJKON/M6E+d2
 elpIRiNL1h2dNucawX5oKdmdI8xzliH8c+nqZ7uua/iA3gh6p9fdRk/vLONIY/QncEGz
 UTow+ou8qaltmiWU/TUGW3QqKmK2lEkFQdoc1sQlJhsKGfGrgaQnoNtEYjwLNfseLrDk
 JVj7IzCI/0r76BK6MXeZzmq4LP4FWnjiFDdsZoAyCr1OXEwOZFK36upMhmgeBOKi3MHZ
 V7cQ==
X-Gm-Message-State: AOJu0YyBLgURbmqb7wkT7/ZQwKJkh/eQsyplIfZuGslhkDHmQSZMVHUn
 F/yiGN4aY25e12ezP9TvtsklA1Xr1adZeg==
X-Google-Smtp-Source: AGHT+IFUirQXVZnODIYZ0nfTSt0FE5pQ9dGfkdPKi/TEY2eVK6LXcDXgaL/LhoF///C2VKRk28hzTQ==
X-Received: by 2002:a05:6e02:3285:b0:35f:f025:a88a with SMTP id
 bk5-20020a056e02328500b0035ff025a88amr11354247ilb.30.1703800210292; 
 Thu, 28 Dec 2023 13:50:10 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a63dd0a000000b005bd627c05c3sm13623885pgg.19.2023.12.28.13.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 13:50:09 -0800 (PST)
Message-ID: <29d01ff9-6f45-4a82-9e2b-36ad7ebf8087@linaro.org>
Date: Fri, 29 Dec 2023 08:50:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] target/i386: avoid trunc and ext for MULX and RORX
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> Use _tl operations for 32-bit operands on 32-bit targets, and only go
> through trunc and extu ops for 64-bit targets.  While the trunc/ext
> ops should be pretty much free after optimization, the optimizer also
> does not like having the same temporary used in multiple EBBs.
> Therefore it is nicer to not use tmpN* unless necessary.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 37 +++++++++++++++++++++++++------------
>   1 file changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

