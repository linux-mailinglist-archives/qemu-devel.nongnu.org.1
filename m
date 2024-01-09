Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2171828619
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 13:34:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNAwS-0004Sl-Or; Tue, 09 Jan 2024 07:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rNAwP-0004Sc-Ln
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:10:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rNAwK-00025o-Gf
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:10:43 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so12660835ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704802239; x=1705407039;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6ir+3Wi7H2CHfZB3kNsKg2DQlRpOysPuzImzm3HQK8=;
 b=m1gA+7MAXx1r4HeD5RgjbkgopC0KXdy7Omrn1HmfVy1yOW4s6RVWgzn2pHFCFmXcgz
 dCLKhscn+HofkA7dpsX3jqSGMMxN49/SQqYiuXl27pQ8iC0NkYYIVpVwyN6myB1AwTBR
 Bn+UGltPFrmNI2vG0+pMgHfoumWGP3yt9SspGYpICUiLiGqMsBeuK70Y0PLD4nijPRve
 2GjtSX7YXxz0TT55p9DySn20vykoKQDQZ6lf6S1ZBHV2sTvDYFXCm+66LOgxv1ShY0MR
 MAgYMkI/Tz2+Ro1ZFEgUWUvW2Auu7d0Sb/sxGMdKUui8xwk4vgeUGjjZSAAfk+L8l6hh
 pm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704802239; x=1705407039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6ir+3Wi7H2CHfZB3kNsKg2DQlRpOysPuzImzm3HQK8=;
 b=I+vThXsa0lNE5aQbIvYSkJFjZ3KziPrZcBxWrl3CFJ8pqU6OAj9WtK+lMIIpgIRvy/
 QQJV7lA7w5wNi4m1INZOPIQL5A9IFDRydkpqX/oWgRj9+HdbEgvAynE9vY5gfzLJNwX+
 XljN13M4jlakCzF4qzpTQQ3VTIHWwYGT4iYc215tR5VMB8tWHocRvnAcCM8ZFGa1IBnX
 FC96G3ATVtZ/+/F2n/+B21mWv7GmI01eVY5y4jHY9Vhj4SZbuXEMPdUj0UUIIHlSCW1f
 jrnJfJ142V7/uedVO7BgCe1eyw0vBL1LfVI4OYHcR88E/YgphnVAMFzxTosbWbvmYoe3
 VgPA==
X-Gm-Message-State: AOJu0YxAC8UTFMM76oR9/4Qi8DLCcgYHytnO4Qwd7M5lfEKFOeE2lv/L
 TTPB/rrgIBe/i4WtTSCKaVK4L037F9zumw==
X-Google-Smtp-Source: AGHT+IGlbPwYT6UmUbESh0ZGnN4kTPeggKiKKvYrVjv2VqXsguHfCwZxlZjsXJP4Mxi2XhlyDw5/hQ==
X-Received: by 2002:a17:903:2b06:b0:1d0:711b:c926 with SMTP id
 mc6-20020a1709032b0600b001d0711bc926mr3184423plb.110.1704802238629; 
 Tue, 09 Jan 2024 04:10:38 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a17090332d200b001d491db286dsm1644942plr.259.2024.01.09.04.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 04:10:38 -0800 (PST)
Message-ID: <be9c6262-dea2-4ecc-a7ab-9ee66c0e98b1@daynix.com>
Date: Tue, 9 Jan 2024 21:10:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/eth: Have eth_pad_short_frame() take void* arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Jason Wang <jasowang@redhat.com>
References: <20240108154123.53680-1-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240108154123.53680-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/09 0:41, Philippe Mathieu-Daudé wrote:
> Any kind of buffer can hold an Ethernet frame, no just
> arrays of unsigned chars.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

