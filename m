Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A456380D424
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:39:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkF1-00047o-21; Mon, 11 Dec 2023 12:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkEx-00045m-ET
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:47 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkEv-0006Sg-GE
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:38:46 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so29075265ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316324; x=1702921124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LXqUwWzFsa4vbvwFIV3VDVTGU3qr7PnBexZ0cd83jfM=;
 b=XbLE/Hg4GL+8PTdunW9kwNRP3hiAyP3oxcK+I/DCkkzAJhSbTXog/ivppSCMRmwnOB
 4O49tx2engfOq5h1bsxNBRqFpJZ50mwkHCKrWIgWSdQqcFQpN6U0eF5M3pksP4+UD3a4
 9TIpalqq1ZtRBnj3WyP36DDwJQlA4zwFO3ZXoP6TDwJGX16YDv2JDTRZtR7prty/YGgm
 z1ABDnrmJKhR3BfXevwgYhjuJi2wNZe0a4IaJgExz+pOzEGS8h0pbrZoaqj9Po2enfTw
 qapW8rD4HevOLPhvrKdyf4/HRoqaOvsoZVdpuKLTeBrSOQEODMV6TB7WoD3vbzvHYNGV
 6SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316324; x=1702921124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXqUwWzFsa4vbvwFIV3VDVTGU3qr7PnBexZ0cd83jfM=;
 b=b2PsUrUzjyJ+ywlCX5uXxiYew2eBIO+t9IcGRq3I2ntwL3FV83z3xXXp9FOsc1bMzt
 IoNuRL6RcF4k9f1pCTOMIHTUr4EIb/x87zMM158XCLbnCVbgWyY/oxgiMqw6gSnbUZ+u
 eelTA2KdGF0wGcs851VUCPC/8LJll+sLsmk1OxNlGcqhZXlRs02fcPO7Q83SMpnwZdPw
 UntUrETYK6r6bx13zoFIYWtFCoF8kuIskqdun8hmGO7ZpZhSwi82vrC5dppyA3KfOHiI
 bnbRNDI/2l/0jdADRR1UTlK0+XqLlgPZhL3TQjeQ9WN89pvmyKy0If0FfFh13wN15VCo
 Dm9A==
X-Gm-Message-State: AOJu0YyVYiUohCO8ecPFzTIsmKbq5aLK/GHlqbBDZAgU51BwqlDDRUAE
 mLYbRIeuAYbKE39mg8/1eAqrnw==
X-Google-Smtp-Source: AGHT+IG+P8OdRPyZqRh3O7e6x0Sjd42TjSt0R4YtX6v5FvKJuC1L47wIiMBx60yQbr56aUX1rhNdUA==
X-Received: by 2002:a17:903:2301:b0:1d0:6ffe:1e91 with SMTP id
 d1-20020a170903230100b001d06ffe1e91mr2499342plh.116.1702316323769; 
 Mon, 11 Dec 2023 09:38:43 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001d1d6f6b67dsm6926698plh.147.2023.12.11.09.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:38:43 -0800 (PST)
Message-ID: <96165322-43a7-4bdc-929b-91ccb8dae66e@linaro.org>
Date: Mon, 11 Dec 2023 09:38:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] replay/replay-char: use report_sync_error
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211091346.14616-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/11/23 01:13, Alex Bennée wrote:
> Now we have a centralised report function use it for missing character
> events.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   replay/replay-char.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

