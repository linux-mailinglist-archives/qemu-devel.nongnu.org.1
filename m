Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C87EE48D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eYj-0003zM-SR; Thu, 16 Nov 2023 10:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eYg-0003tV-3k
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:45:34 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3eYe-0002OT-Fl
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:45:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo1423277a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700149531; x=1700754331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Jj4NnL7YeYC3Zdi/4K8uGgLznem3VxCskrV+C79QVA=;
 b=y2T8N1Q8y+3BQI7T22X+nSsEJfE+hbg0eZy07UBMGjjfSJXLoK0EQJtkZFivpOa+Wn
 GgaiHXMcZE+CVcQaJW4+y38/BqYYJQU+hGEMeICKuxr0gsHa/280ist5nEA8rzwou8vP
 gKO36uISSAJ3IC3bCp9nkEizsxBUQKfFlFtOTAgKHqRG2R/QnpUphuOViB3/01Lt+1eh
 svytN2wis8svs08fs2QimEQaiHczjE+qNbHAhv3RosXGR/laDqZu67tJv8U4gMXcD3FJ
 8s87sO/GKxTprUGx2tGswLkfZk+usPGyPVt0wzIpP1tqCvkr2aIxlNHKixyWwZ96FfEp
 yDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149531; x=1700754331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Jj4NnL7YeYC3Zdi/4K8uGgLznem3VxCskrV+C79QVA=;
 b=I1QeuLb1gkmbblomX+vLLQ8fjksxic1ONHtcJ/GBppPtAi02lRKtb0vqGRMXUTekGx
 8WZlLplg57BfnMW6OZJAN0QxySb1eqIin+aXB6h0tZCcoLdkvuljsWo+8xGTQeY6l9vB
 0qKRUXbDxPHyXVTAhU0gsPKPyV99WMzChVQh8ZspcJHzdt10mHAfuyrnIhx1CJgQNzGR
 RP+U0qymrWVJsXZh+X+T1DF/RdrPeCksXGTfkw5v8Y1/xOBJninYcTaRG+SoiIceV6SO
 3450mNLFmgM0qsDhtfpKkQhrMz73X6a4L8OMCjYKgu3ZAgDKD+AEKSfm2p8HRR/+P9du
 NLEA==
X-Gm-Message-State: AOJu0YzHmt038fUE4Skaintssh0FDGqXM9jVB9Zp9yJaQ/t3XxQ3gDgN
 YtD3FTUW8FObk7wOgkt4t+NCKQ==
X-Google-Smtp-Source: AGHT+IFECCDset6mlfYXhUB8WdKQPM9NkAKv58evxOuP50k+ZgpQdNiZXXeEA95ECzmebbQDIdJXsw==
X-Received: by 2002:a17:906:d9b:b0:9dd:4d73:9d44 with SMTP id
 m27-20020a1709060d9b00b009dd4d739d44mr11275641eji.47.1700149530752; 
 Thu, 16 Nov 2023 07:45:30 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 fi5-20020a170906da0500b009e5db336137sm8634527ejb.196.2023.11.16.07.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 07:45:30 -0800 (PST)
Message-ID: <40826328-3530-4c37-a081-3474065f4b9c@linaro.org>
Date: Thu, 16 Nov 2023 16:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] memory: Remove "qemu:" prefix from the
 "qemu:ram-discard-manager" type name
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231116131454.541434-1-thuth@redhat.com>
 <20231116131454.541434-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116131454.541434-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 16/11/23 14:14, Thomas Huth wrote:
> Type names should not contain special characters like ":". Let's
> remove the whole prefix here since it does not really seem to be
> helpful to have such a prefix here. The type name is only used
> internally for an interface, so the renaming should not affect
> the user interface or migration.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/exec/memory.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


