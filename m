Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9384223C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 12:06:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlvv-0003AW-VQ; Tue, 30 Jan 2024 06:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlvs-00038V-Mk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:05:36 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlvr-00006G-54
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:05:36 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6e112826395so1837735a34.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706612734; x=1707217534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iXhQVeZdzqbCpuyHxG5h7qmq6LkWPktQfS5633Q7nko=;
 b=CezVWANtKOtRlqhHBIXmgKT6NiMPLtVU6OZCPhSzrSeibTVgRpF6cWGMZ0I5UDwqPa
 3DB+zJMoChh1OLkbKlnLJuo5tFdRQu2S0osbcGvJ8tGb9dzg7Pm39H7piNvfz8wQqQiX
 qs6nY/+PRijP49PDKHQCTFlUvQMENZt+ZiZQbUch3NGGJUZ1rUNIQLp9e00s46y3I3tb
 MuxASKBdQzua0jwQZeFr3kXELIzPeo4UgZ4GXbpFvv8BFOI7Hr+4sWuAVqKu2Et61j78
 x4GqK6gWKFOIqfuktJzo38CkTzBLiM/xyWRYem0mvzJajXTrqcg0VZDv4PSNnZGprq2q
 ZfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706612734; x=1707217534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXhQVeZdzqbCpuyHxG5h7qmq6LkWPktQfS5633Q7nko=;
 b=Q3Ow+vfedSfUubRjfmkdh9DXhTRQh3aUm0o+3ESiI6Tg/mUM9Yvr11JNP4WECWS9Fd
 nOTiCbIHMOpWCLnlB57EtCuVKNjbs60axFuB8t+WYjxW3/CjGEqNiXP/pc+SK3wa6rYN
 IwghBCWZVnUqPbMtP9czgIihTXHZSAkJchMT6L8aRcUyhVj8sRchiANk4m40jeDb1aJF
 6sgvcPGYHQWXRvXHpXF9/RxfwN2GQlJeIV0HY6Vc0gaamJJ99NJ7gFFrYrcpyiH085pn
 H+0IS69SioG00WxpbJy6hfZUiBUSFUfIRFq/hSKV41V9PHVAeV2CBPVEgcFDZ0KID3xL
 YGIg==
X-Gm-Message-State: AOJu0YwgTZ6f6qnOoIgvWTCLjyL5X1v0LNAUSKtEzXSL9lAbK54L39Kl
 nznPZp3IjEc5TR1zZTbuMh4WFOQDbqMaAvspcs+Qyppi723OTOGmHCszwGpE2h8=
X-Google-Smtp-Source: AGHT+IHpuhCxQuR5qb+3C2XH0C0xmqVsoI0kKxG/3NjkiK5s2Ecfhqu7lOO0Rruwf3EMMK6Zwn6rKQ==
X-Received: by 2002:a9d:7413:0:b0:6de:6ad0:d34c with SMTP id
 n19-20020a9d7413000000b006de6ad0d34cmr7668575otk.9.1706612733809; 
 Tue, 30 Jan 2024 03:05:33 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a63e650000000b005d553239b16sm7719589pgj.20.2024.01.30.03.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:05:33 -0800 (PST)
Message-ID: <f62596da-6ad8-458a-a917-bef072647630@linaro.org>
Date: Tue, 30 Jan 2024 21:05:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] include/exec: Change cpu_mmu_index argument to
 CPUState
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-34-richard.henderson@linaro.org>
 <51e69a4f-9003-45b0-9350-24728d952d86@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <51e69a4f-9003-45b0-9350-24728d952d86@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 1/30/24 18:26, Philippe Mathieu-Daudé wrote:
> What is the rationale here? (I'm trying to generically understand
> in which case one is better than another).

Didn't you ask Anton why a generic cpu_* function was using CPUArchState?

Anyway, I think we've generally used CPUState more often with generic functions, and this 
should follow.


r~

