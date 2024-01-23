Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253768386D8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:46:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9bh-0005pB-I9; Tue, 23 Jan 2024 00:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9bb-0005oj-LE
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:45:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rS9bY-00082P-Ii
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:45:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337d32cd9c1so3511430f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705988747; x=1706593547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u0CzfWu6++n+Y4l47J4vwGZsnDw6KzO9m/V4A2BAU7A=;
 b=HncPOaR+liyX++kMViANrpjhmfqL81sBWNuQ0JlaD1ZC2YNpKLHQydtCgACoa+YtCt
 PUIqAwklPRRLQ4HeDx0u/lIxk4K4t1uCnAje94CWlGXfDE5nr3+37gHto0Limv8bkm8g
 AkdDdGMMeQC/jtxpUDCJn/pyAdY3Po2ZpLZknn00bByI9nGJviDRZxDub8rWnyw3acgc
 MpUBnt3NCCmQCR8ZUyecXF6GfzEVE63psnVFkazcWs/MlJ9loPkgCIGBccAYqufHLZBD
 Vu98duI8orEhj2j4H0tH9CQkzXxBaMVkYsahllxuw0s+K3T6vDwPh5NK2BuubQcDArPg
 dIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705988747; x=1706593547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u0CzfWu6++n+Y4l47J4vwGZsnDw6KzO9m/V4A2BAU7A=;
 b=pvKCMWrGk6yRdnIT2fQYVwDMDmg78NUJ9IBGB4VYoU+nm0SzWp/aNS/7PnuRWaa10S
 nMRzsuYJwY+AJwLfNkhcmF4LMrmEkqlNHmPbKOYED3GYz9EGra3yJn8gPmwLr1KcbnEa
 NMg14Gs6mm78xerem05UTCJDDs/w7WhVQyf0foYDj4o0dlrHdJbSjbZEKyop2aQJp6vf
 yK3kTwYB/uLFuxUHsU5kU3OxOFMbMKJkn8KRXanHv+wnqFEq6Ot2X8yCNMzxWWuOYxEa
 IOy83pPW6j68S+MnvKXJwlXcvliH+ZSzZjSOlwzbTbTSvFXY7PC4BeeEKZaRUI1tpx5L
 BAmg==
X-Gm-Message-State: AOJu0YweqNPuJZ8+t5qFPvw39tB0V9dW7KkuMvnNU2PN88TXan+E/vox
 KxgDhBARBSdxWvJGJxCSlo9zwjxfP5anJb6Qghisd5ABQhW2kTo98ZLGXzaI8zE=
X-Google-Smtp-Source: AGHT+IHYWRmWtBvWk5R6JVo58e4fkJaafnFf98triQDL1mkHjxQgXUd1vXnhYk0NICzL24nTQpcc3g==
X-Received: by 2002:a1c:790f:0:b0:40e:45b0:557f with SMTP id
 l15-20020a1c790f000000b0040e45b0557fmr169981wme.140.1705988747064; 
 Mon, 22 Jan 2024 21:45:47 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b0040e541ddcb1sm41322468wms.33.2024.01.22.21.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 21:45:46 -0800 (PST)
Message-ID: <d2ddf8af-4d3b-4c0b-832b-1ba6da0ed199@linaro.org>
Date: Tue, 23 Jan 2024 06:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] util/uri: Remove the unused "target" argument from
 uri_string_unescape()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org
References: <20240122191753.103118-1-thuth@redhat.com>
 <20240122191753.103118-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122191753.103118-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 22/1/24 20:17, Thomas Huth wrote:
> All callers pass NULL as target, so we can simplify the code by
> dropping this parameter.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/qemu/uri.h |  2 +-
>   util/uri.c         | 32 ++++++++++++++------------------
>   2 files changed, 15 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


