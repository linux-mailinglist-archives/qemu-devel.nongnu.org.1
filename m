Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195D3832DAE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsIL-0001mF-I1; Fri, 19 Jan 2024 12:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQsIE-0001lM-OW
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:04:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQsID-0006ED-24
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:04:34 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337c5bcf79fso908963f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705683871; x=1706288671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qc2Peb2JtOjy+B1gVthMdZe/szYQ6eQYqtZctt3o1nc=;
 b=lNS+VttqYQ5HIDcFniUzxe+kC5P+DjqKsmU+v7+JIi/otOxE9foTJlXIV9GiEM7M7S
 WsJjnA3oABHZZTxHmfNxZTlnPBtqTu+B8qi1fjFpZZeTZSCmv9ToUqw8JixDXy4LOXNs
 4vToF2Tcvg1WY3XtTmZuuE88Rsr0R8vulqLH26cu19Sw80A5iQKdsul0XoiIVc/SO6xG
 4V69r5jbiWkswoVYYQ+LQvPHETf7kF4LXBsbNfi5u2lA1Glgo7WaNVNxvJxanZfpcb+P
 A6QdQovzP/buhlEl3PrrBbMKh17g3YGW9abI7GlvasBbolQSVhWxAIIAPGL6mJs+h8f9
 +SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683871; x=1706288671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qc2Peb2JtOjy+B1gVthMdZe/szYQ6eQYqtZctt3o1nc=;
 b=pAuD6Ywvymwc06ff/0YQ8CD/T4Ob7EsiCizs6GlA0n8ehxMnI43Sn5gE+3MNo/ndHg
 yg0jSawYIOjb4KIqJki7nDFIPTmmAHauCo+Eb71ICWch6u86Hlt7h8Hb7c5TwzDuCNoU
 2NfNL+L+9RjBXTgAHekWHCbz8K2dd3Th3hRMKGxDWf3mqqk9Qz1PlDjioIiDS7MJlDYn
 BHaB6PHZ7OBgQL6y2/h6aDaZieApH96fAJpccU9P3ekJdYJgyw/IFcw15kTHMsuvDUQA
 TL8MH2Y/qVPaPedoeMqzkl1sArznt1C8vxYyfct4RNFB5iBdNMZ2rbOF/yPNd3/A26Yj
 FvwA==
X-Gm-Message-State: AOJu0YxSjaqZ+LjNO/juVofE9q/4DrRK+Dz1hxsD/GB49vz5ms1W+cZ9
 4UPrTMe2vO/Lf2tCpA5q5wKFpoc5BVmyHdfcUqT7mTqMTUt06TEfd4fNCUcSPYo=
X-Google-Smtp-Source: AGHT+IEDul5qUywMEJN+jSpZ6HXwnoasyUWK6xBsr0YM5aaNwbaNPCRkpy+8DrtQEvcE2bjVbOg8uw==
X-Received: by 2002:a5d:654d:0:b0:337:a7fb:90d6 with SMTP id
 z13-20020a5d654d000000b00337a7fb90d6mr5721wrv.79.1705683871090; 
 Fri, 19 Jan 2024 09:04:31 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 o9-20020adfe809000000b00337bf81e06bsm6914635wrm.48.2024.01.19.09.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 09:04:30 -0800 (PST)
Message-ID: <e25f2ede-1264-4c74-bc10-df7d9f874d47@linaro.org>
Date: Fri, 19 Jan 2024 18:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] hw/xen: convert stderr prints to error/warn reports
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
 <bf5504369023dc115f0d7a756c4c5254fa9cd10d.1705670342.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bf5504369023dc115f0d7a756c4c5254fa9cd10d.1705670342.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 19/1/24 14:24, Manos Pitsidianakis wrote:
> According to the QEMU Coding Style document:
> 
>> Do not use printf(), fprintf() or monitor_printf(). Instead, use
>> error_report() or error_vreport() from error-report.h. This ensures the
>> error is reported in the right place (current monitor or stderr), and in
>> a uniform format.
>> Use error_printf() & friends to print additional information.
> 
> This commit changes fprintfs that report warnings and errors to the
> appropriate report functions.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 12 ++++++------
>   hw/xen/xen-mapcache.c   |  5 ++---
>   2 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


