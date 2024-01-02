Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F082194F
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 10:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbYZ-0002lG-1F; Tue, 02 Jan 2024 04:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbYX-0002ku-OF
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:59:29 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbYW-0004b0-6V
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:59:29 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so5326662f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704189566; x=1704794366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItovUO5eWLxbEammtzFJKTWC25DQHMBuIbrcoYWGoHw=;
 b=PG768vF85J5qMFujlatNFvTzjKXpbYqdjRWZIe44dKuGhNeKeGexZX/T5ZnKmqycfe
 YB8WEmfCka7aMEfLPYQGxYj7YnBJr6l6fd9FsufWMsJDCaq8GSHLA9GvU1/Y6xtLWfQz
 Y/zEwZ6qkEb69V789eM2XeoTSXHdXi1vEsP5fAxe+E2yLLjZc5JGFSyPx2oieV/GtR+9
 gFEPbEzpWD6wCMTDNunVMFS3Df29ER8wfs3GnMNm2DnirnO70cmq34t7eF5GBzmwqohk
 MyVjKjSiVNRJSiukZ6kcRbk4VUOPiE2OGtl5Jupnh+eE1TnqgsIqUBpN+boKrAn4uPOQ
 /REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189566; x=1704794366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItovUO5eWLxbEammtzFJKTWC25DQHMBuIbrcoYWGoHw=;
 b=f0zbZd3roNZvtUyAapAP+vy2zH12/lPZC6QM43LHZMM3r9rMrjuIl1iW6IPCOOcqeX
 BQtfFtOX1SiwC2wQjbUaeFuU70icW0xZtBFfaGISSIQXB07RJ2115C2w9FMpz1wSGuFr
 NVzEEzo1vLrE6fqoa4WYsMXNh+k+krKVQmZn6Tq5KDHOrLwUPJgYSqbFEa8QpsrH+x7n
 f1YY3URdm6U1F3iIx3e0kodtmenLD9aLcFLaNWdN9at5+PqcbWc+S4h6+QCNvMCgwiGz
 1f5lL1KjKr9mB9GlplEomgGGgLGYOe7TeXzp+XneZ3C8YXKOjEuemZutj2w/SRu4Fqev
 vSrw==
X-Gm-Message-State: AOJu0YyfpZNl7LaC1bkf2m5MRt1R+KG7rjsGfPNJ9NZ4OLfzIGIAiUIE
 Q2jDloj6YM2u/VE8vUmNA9FyOJYNLguNag==
X-Google-Smtp-Source: AGHT+IEh45ns8Gd12tpWuK8fetbhH3c91CGcJBKdsjCNjghoVHxHXMRaZQ7C2cM8OzrZ32v12R96Iw==
X-Received: by 2002:a5d:688b:0:b0:336:647c:cef1 with SMTP id
 h11-20020a5d688b000000b00336647ccef1mr8158438wru.44.1704189566092; 
 Tue, 02 Jan 2024 01:59:26 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b003366da509ecsm28030822wrq.85.2024.01.02.01.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 01:59:25 -0800 (PST)
Message-ID: <cc130d98-796e-4e27-954e-d0d6edb4551c@linaro.org>
Date: Tue, 2 Jan 2024 10:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] vga: introduce VGADisplayParams
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093918.239549-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 31/12/23 10:39, Paolo Bonzini wrote:
> The next patches will introduce more parameters that cause a full
> refresh.  Instead of adding arguments to get_offsets and lines to
> update_basic_params, do everything through a struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/cirrus_vga.c | 24 +++++-------
>   hw/display/vga.c        | 82 +++++++++++++++++------------------------
>   hw/display/vga_int.h    | 15 ++++----
>   3 files changed, 52 insertions(+), 69 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(Please enable scripts/git.orderfile)

