Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542B7F3F19
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hrg-0006IT-Pe; Wed, 22 Nov 2023 02:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hrY-0006Hi-1V
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:41:32 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hrW-0003fg-8n
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:41:31 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c8880f14eeso29535681fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700638888; x=1701243688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q1xA0FLva6Ni9XLTK68kLIgdBywCtMCb1zB997VOfIs=;
 b=aE6ULhdG/zzRjtRaTCs8B43SDRI0jfoZLZfwxiZ8GIe0qWkDjqUQjqh8mTAbHaw8J7
 dpEmfZQ3glswGEvATMSSpFXbav6UHE2BDf5tJlPDEmLZkXp+77ZonxeWoz7+zeTcjvoi
 fgz8ZTDMrDyTjISFz6S5FSVHOUIokBsd0Csr3CLHGVfheuLYXURUhOU8YPvszPGT30Jp
 6vBh+eDKNuRnVCvgi1kSi87qvPTvyMbOuF+7nV0XyWVdtLerezKFGISU26jzGToWugbw
 ATnKu71Kf0CyySydT6IldNL0iFksHtxXo492p8UhdyUwubxJV2vEmfiX5rU4An8ovI5O
 IvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700638888; x=1701243688;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q1xA0FLva6Ni9XLTK68kLIgdBywCtMCb1zB997VOfIs=;
 b=qdOnfzIJTAdLbWDsydPeW6FA7I8UHzrLWH/IQd2YcwdsLdBGZUU9Glx15GZGvN0Qfp
 u4VwDsa+AW74tC8PczwRMHFV8Y+jB1cw6gMJn6DASxH4BXCddcrhdO53cK74LQWt0/ZQ
 HXP9vZmnoF5mdx9gNqtAREjFMLDvKhXO9ff0rZDHK3A5YYtCGler0/O8zxdSQ7CIHtCd
 /6W8I27gurk+29a94jrpzC6UMQoH76L3Hq/ao90PO/e2QUvOrzDI6FVwg3THOo78SH2Q
 hpRFXNzeF0qCZEkuJmuEWQmoqMJ5LRtmwJvSusWZo1wkO+4x6MwtShcbr5J1DwPZda4+
 Sw/Q==
X-Gm-Message-State: AOJu0YwJpok/8s1g3DY67dBo/twq43uWXXDcJM4VJjdSFmAr7DkJEFnI
 MBVCep+uoIfAkihaaQHJ4Is4mg9DPdIKbPFD1I46WQ==
X-Google-Smtp-Source: AGHT+IGLQTZV267AkdSgkqIyZlhzcRLBVWIZRFop+NGBBxXKnwCKJVHN9WvtPl0ALCJxuiiWSb8PYQ==
X-Received: by 2002:a05:6512:20c5:b0:508:126a:751e with SMTP id
 u5-20020a05651220c500b00508126a751emr837989lfr.36.1700638887775; 
 Tue, 21 Nov 2023 23:41:27 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c4f0800b004060f0a0fd5sm1241172wmq.13.2023.11.21.23.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:41:27 -0800 (PST)
Date: Wed, 22 Nov 2023 09:38:26 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 19/25] misc: Simplify qemu_prealloc_mem() calls
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-20-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-20-philmd@linaro.org>
Message-ID: <4ild1.0v3gsvmc0lqe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---

Commit message missing but indeed there's not much to say

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



