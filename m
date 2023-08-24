Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811DD7873E2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZC5I-0004qo-3r; Thu, 24 Aug 2023 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZC5G-0004qf-Uu
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:17:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZC5D-0000ks-DN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:17:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3ff006454fdso17947615e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692890233; x=1693495033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yq7UqS/l/JcQ35qk8oMQqTbKbHmf/Ay3qJDZiYjLWmQ=;
 b=RCHZN08eRkTRwmfMmRAAjdZzS0QFiaGVVOe93DTPPiAIozYv39Km5FMwBQsRkRsC96
 M/cR4AknwvmoeMEG7dn+bFeTyTSNE2nwQVfGnl5oLhXKBNMxlE7HwCieBFfpMDDL8mEP
 /S8OA59z/EszZTXLxcelTl0JUxZgIn4yM44TVtTP2qxZJBKbeFPmKEKtuTVbprsNNv+9
 iBaUEEF4P88bQsKoWw9elXYroZtParrQJaLRscHik9ROiE7n2pxc6Ebx3J5ch+c3JXIc
 Pd3BQ8caHyj1BoNyjhuhMzTAGMQGpK4Pp/KT8VzAePYZiPKruQN1DnlMHiAjxoUQWD7A
 AkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890233; x=1693495033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yq7UqS/l/JcQ35qk8oMQqTbKbHmf/Ay3qJDZiYjLWmQ=;
 b=g05PO29K03nM4ZUPbDTEJaGumdhgzf/h36ECafCbUBTFusaqEkZZwEHv7NUv8sM5wh
 atWZy8ZBFhCqFn7IOWiV8ahZ+mNT4cnTXEx3MDY53TkBHANw8txEG2IJzNarksXPoNoh
 xC7XoTcdoSMgM19SuHXWhtrepUadYp8smRUxf7IpZZntdMiUjIqYvmOh3TXqJsU8vX5h
 rp5BkbwXjdxG9ik8kLC7qakAjXDXwMyynVD9kXuXhmJgMwQuN+bikWtLBvIOjqGkMkBU
 xzoNXG4sHMJDHsBtBrpnD8trvRkkjzNeS2wzMI7mXN1o590NaQARYJnh7DtwKUeiEwWr
 VWig==
X-Gm-Message-State: AOJu0YxoZ1h4er0ZZmAcJ/boRuMtQcpqI0Xmz60r1cFXQ1B2sOucvIah
 +t/d2unFfQL0M0BaZve6Z4NiUg==
X-Google-Smtp-Source: AGHT+IH2DkT/mxeTiiQcD7jIHknQSkxf/9xDWPWflAVsIH73C3zeoFH/VqhZ1YO9eMK0c3EKGROZ1Q==
X-Received: by 2002:a05:600c:2157:b0:3fb:ff34:a846 with SMTP id
 v23-20020a05600c215700b003fbff34a846mr12737295wml.22.1692890233507; 
 Thu, 24 Aug 2023 08:17:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b00400268671c6sm3030673wmq.13.2023.08.24.08.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:17:12 -0700 (PDT)
Message-ID: <00b3d6aa-e8dc-1297-57be-00128e0fc85c@linaro.org>
Date: Thu, 24 Aug 2023 17:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/6] qemu: log reservations in fw_cfg e820 table
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org
References: <20230824085756.66732-1-kraxel@redhat.com>
 <20230824085756.66732-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824085756.66732-6-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 10:57, Gerd Hoffmann wrote:
> With loglevel 1 (same we use for RAM entries),
> so it is included in the firmware log by default.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   src/fw/paravirt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


