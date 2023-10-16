Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 526197CA7BA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 14:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMLI-0000GS-Jc; Mon, 16 Oct 2023 08:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsMLF-0000G8-1t
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:05:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsML8-0007CZ-6Y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 08:04:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so3837012f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697457892; x=1698062692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QJwwo7axorxaD0Zq68y+dVYzMyVwfgVYRlIQ5K1/SRU=;
 b=bRQk4bbkOuqi1DVU5i6ROvt/fKGzLuOKK5jMBqg4juVmac1ghPSsMp2qRWkqvtQifb
 6SB9AO+f//2K4vk6CgQ6BGemmQBMxzqkHd2sF7HwOZKLVnPEA3664+7T+TvRiVy9SrHu
 XvGgunLhb+UG9oL6FjDWmQzQMQd2z7qpN6erEUwQdsDb+JJ4YWR84nZFYVkJvsxiWMyr
 PaJd6J7MJh1cgNCklRDdYZ/J70GPhLQVVkyRTabNZ1fXkX5zjRpnhL7/r9O0UsHLywG1
 liSQ5z8gvj4T1cM4R40AMQTzWlu8i2+zPJzB8jYbzZwJ5tI5CchxxD1ODCIXrRvcPWCG
 VbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697457892; x=1698062692;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJwwo7axorxaD0Zq68y+dVYzMyVwfgVYRlIQ5K1/SRU=;
 b=kGK9RqI0IC4tk1qMN2jq4o20XHvgNcpiPYe74WjA2Xw05s7QbfAFwBzMledIFIHrrB
 z25DLug9b7A+2aEEZvOk1tXmR0ozIAuRZiJHpy8+OYxJhlKT96hYtsv4yCBvCN0hxz/u
 F0MHaP2YAWgtwYcGiRsXfb1sIlme1pLXsakjMrMiGE7iJQoA1AorBNHaUyXiXl2f4gMu
 6OPM2vmjWq0ncvF48CiURHwr9UvbXz19Ya+EvLPjPuabHAqoacprLpGOfwok7yzWbcpk
 KLMEAEq5RA4+qXcjGdnA7PmFtt7ftZPUi4yHiItikFTVBBz6DdivwbgiurITRTAVHfWx
 aYDQ==
X-Gm-Message-State: AOJu0YwnXcMiOSVQvKIdEbaaD+xACpXOQy/8BvkwZM1/gJwefEkgvPew
 84IYD5Dn9ks4t2lLPzvgNWe6WQ==
X-Google-Smtp-Source: AGHT+IGFlDQFGxTOBaG9y6z33SuaA9xx/L/xMryc7Iah5GBUkrCJwxbSHPD3HeXU2yHrvJgDT6rOIw==
X-Received: by 2002:a5d:4c8a:0:b0:32d:8f5d:c6db with SMTP id
 z10-20020a5d4c8a000000b0032d8f5dc6dbmr8729272wrs.16.1697457892327; 
 Mon, 16 Oct 2023 05:04:52 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 bq6-20020a5d5a06000000b0032dbf32bd56sm49242wrb.37.2023.10.16.05.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 05:04:51 -0700 (PDT)
Date: Mon, 16 Oct 2023 15:01:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
User-Agent: meli 0.8.2
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org> <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
In-Reply-To: <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
Message-ID: <2mew1.gewqf1fewie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 16 Oct 2023 13:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>Perhaps because we will never use it from Qemu code ?

It'd be nice if downstream users of the vhost-user protocol can fetch 
and use the header verbatim. For example, for automatically generating 
bindings.

