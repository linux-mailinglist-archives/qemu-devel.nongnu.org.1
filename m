Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F6783AB1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLcm-00050n-30; Tue, 22 Aug 2023 03:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLcf-0004r0-3d
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:16:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLca-0003S9-Tg
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:16:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so40053815e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688571; x=1693293371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppgiTDo9CBIUYONGHjb2ceEiPZgD+DqVFKBZUdEts/g=;
 b=DtJnalGNembHfQjyHup10ZQEGE7bFAZviXKxQ6t9xLFSF8lGAja9DxY/AV2XsyinC2
 j5dLIQKBy5futpqa70o/ZhvD3RVhF4mtihi6NmCXOySRkOgFCM5C7S83fzJpX/sXNWc3
 b6IdCX9dYdu/sz9BUtBAe2/QIgNLNI1uJUaTNe8gYWT14t1iq1zZxO87gcvzhYjBHOoY
 k3v61aFGq8fk+6sUX4CQSFmenu52s0hVJiC83s3liyIjAHHL/jgvTR0jDenfemEW/yz7
 WnFOej71Fzh8arMl2KlqfVhnQdDGxf12vxXw7P51dYpTSa36+8A+YBJQv2/PBip6tTT+
 tyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688571; x=1693293371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppgiTDo9CBIUYONGHjb2ceEiPZgD+DqVFKBZUdEts/g=;
 b=gnxUjbSU2jCDcwSckdBP8f/szLXmWd7TqL6rqAa42jEu3oXAyu+ik1TBaslyExlYbo
 kd8LPpu8iXmep6AvkwBY/bHF3JpaqF/m0eU4LuyUp9gAFNwzq8z7sLlw630VlvNZ6Qko
 5vt/Zrg2uP2Bq45Fydj6KbpPEg5gx4HDMw3CB79TPQBUQS+bbGyfBwAtncqz9jvBd+6f
 +8EwV2s4+jf1s9E9mGJJWS/K1AzWCqAX2TeM7CuhE0F/lCkStrbm75smrgjynIyJVEyn
 MAZUopFB9VsNqHzm0Z6SsW33LNU+RcK1T/FNt6YWIOMwTwNvoF+On5x+9/S2b30iVBBw
 u2VQ==
X-Gm-Message-State: AOJu0YwnUYKMJtIb3iND509a4mXvLsHRqsF95Z6yNY1moO4YPEKt6u4I
 M1Bwm9cAj5HexasmHxX/xgvotp030n92pO1pe1Io/A==
X-Google-Smtp-Source: AGHT+IF98KiT7o4L5je0N8qgzGnrnAp7Fdfd4zmN5631iAN0Ia2LhWJUW4awktghpzSbkL0FLibF0g==
X-Received: by 2002:a1c:7510:0:b0:3fb:c9f4:150e with SMTP id
 o16-20020a1c7510000000b003fbc9f4150emr7128778wmc.14.1692688570713; 
 Tue, 22 Aug 2023 00:16:10 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 u1-20020a7bcb01000000b003fefcbe7fa8sm56702wmj.28.2023.08.22.00.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 00:16:09 -0700 (PDT)
Message-ID: <153460f1-582c-4e0e-0e73-1b2d89daf540@linaro.org>
Date: Tue, 22 Aug 2023 09:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 00/19] Based-on:
 https://patchew.org/QEMU/20230821125959.28666-1-philmd@linaro.org/
Content-Language: en-US
To: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230822071013.34884-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 22/8/23 09:09, Philippe Mathieu-Daudé wrote:
> (all series reviewed, for Song Gao to pick whichever v4/v5 is preferred)

Incorrect subject, and SMTP failure, so disregard (will resend).

