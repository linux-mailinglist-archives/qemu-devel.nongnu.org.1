Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB4E82E268
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:02:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPV1N-0000uw-8M; Mon, 15 Jan 2024 17:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPV1I-0000ui-DS
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:01:24 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPV1A-0000nx-VS
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:01:23 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso3630204a34.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705356075; x=1705960875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8NtanrN2GiBKcgFPIAIElZWymIdztZw1vPYRo+DquQ=;
 b=y0EconADxkOBh5HEVtbH3+27s8zgXZoZJjmSow1XqdzHXFK2WuLM8krtX17o/oX7DC
 aVXa09tKYGfiJMJdvzLRJVavxutl2hPGFPeu4LlX4U4sbG5Tf3+jjzU0U+7c9Cuiod4F
 kwaFTkfyoec7nco9sNpwRWh/LpqO5mWEbJUlvl86Hh8pwxoxJ1u0C/sMUotHQhqln4sv
 QuOzhlHbNdbNOXvFmjWToYYaG64/7t0cpkpB4oyiY2NsbtMZ1R68UUsEmvFfLJlpgH2G
 XlyHpIKHH3Hb/NWHUtOs+Lw/ZMDM6iJ3/x30mqQJmadtBDaihpQ5sn6xKAZpMYdQtBTD
 xOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705356075; x=1705960875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8NtanrN2GiBKcgFPIAIElZWymIdztZw1vPYRo+DquQ=;
 b=RFIAHTA/R8b286knXCt86yvZfPZPdd0DHYLcDlCZvt6CTDxWNUtSo+U4/miF0ayvaY
 VUAjuRKkiZ2ukd4Y+ohjm83mowgIpnNYVQ0rjq+uvALFVgW9ce8tfh21se9CxWehqwJw
 mLKnsHhWmvHh32xj4t6LGLmC5E5rjd8Vw2toB/yEHRCQVw7p1KI9HrlqAaRM3ggXo5/U
 asQLgdM+VAdww7bNWii/25iYrLVG3GO8h8TCrTyHrFsPhb903Tt1Ui6mhG4HWkYWkhk4
 AwjT2AetzMMfi9F0uwXcOie5tfpxGU6zgccdVXoEeH/sMkL/T9ozERvI9WHZpe9UD5X9
 vTxA==
X-Gm-Message-State: AOJu0YyqttBplUn7bKk4WkPYMHcYaN/y8UquJCVq6pmPlvBY2pF402/v
 ansm4va8Ggltg9HWrJ5TKPhMtp0FHz2/tT3dfnbdh2hW1x/Yvg==
X-Google-Smtp-Source: AGHT+IFzodl/wwTRCUNU0A1MCU9W8rtS9ojfA0qtgrAuUu+DmOCx5JOJS20HRystGmv40z+npLKEug==
X-Received: by 2002:a9d:7dd9:0:b0:6dd:ef90:9336 with SMTP id
 k25-20020a9d7dd9000000b006ddef909336mr5489075otn.6.1705356074887; 
 Mon, 15 Jan 2024 14:01:14 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a631c54000000b005cf450e91d2sm6902892pgm.52.2024.01.15.14.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:01:14 -0800 (PST)
Message-ID: <a922c87b-9ef0-4dd5-af76-98e7f44a6026@linaro.org>
Date: Tue, 16 Jan 2024 09:01:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tcg: Jump after always false condition
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
References: <20231219182212.455952-1-sam@rfc1149.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231219182212.455952-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/20/23 05:22, Samuel Tardieu wrote:
> Unreachable code in an error handling block is listed in issue
> https://gitlab.com/qemu-project/qemu/-/issues/2030.
> 
> After removing this code, the `fail` label is now immediately followed
> by a test whose condition can never be true when coming explicitly
> via this label. Moving the label down preserves the fall-through
> case while avoiding testing an always false condition.
> 
> Changes from v1:
> - Add a comment explaining that `buf_rx` does not require cleanup
> - Use a unique cleanup path for the function by setting `errno` before
>    jumping to the cleanup block.
> 
> Samuel Tardieu (2):
>    tcg: Remove unreachable code
>    tcg: Make the cleanup-on-error path unique
> 
>   tcg/region.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 

Queued, thanks.


r~

