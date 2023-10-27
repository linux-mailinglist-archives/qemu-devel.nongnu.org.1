Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B07D8E98
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGDa-0004jk-St; Fri, 27 Oct 2023 02:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qwGDY-0004jI-NB
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:21:12 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qwGDX-0004kE-5o
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:21:12 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so2353692e87.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698387668; x=1698992468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fWiot1xxhS30niO6atC+EfWIbbTfv5hFa4dJhCJq2rs=;
 b=E13SNPQfCbhwBWuCwkyXjBHBkSo2UZ0i1+8QdnQtWEIWHtanIeqyirxx0auZR+PfRB
 P2kp1aKHmzuXFM72bVu/hA2hEwxTlIG4XvMZL7KRQE2JO1GjIyzffChtv6LkQkmPuSTT
 7huZod/w9xYBFszWOIERvKcv54tEQQuKBKtfmtFvIxdAq4j8C2u/xKcHcy0bTCBbxNzo
 eFa0pw4iCOJZV9ADOT/5eKrYAPAv7xgdr9NBjrMDRbOYQZMNa5Flm3PukHN9M73eo4AE
 Axf91XDtyEm9jO7DTPUfyYk7OM5vj/ks/wEW6W83IlJLMaeTWtA3ccm/ovmidx/LfC39
 B8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698387668; x=1698992468;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fWiot1xxhS30niO6atC+EfWIbbTfv5hFa4dJhCJq2rs=;
 b=fXywyperK/yQnvq87qy9WUFAvHshPAplYwUXqQG5SpHxF9w8yHeh9lCR3ISRaC3cyS
 0MKpwTVdivLKxcDtXihPmewjrV1S+ZRm7m1eoJtWseeplZI128VnSjxcH3K0hjMlsq0U
 gubrrPCgudz11Z46I9D3uyEJhG1bNCXLRMgkm/XARE+J6wnF2JUzyOtYGWQpBoU23FDJ
 F/xbHjrJN74H4MZIzgOC1+IgDduSbpYj4xknS7mZyWhcAdXxObryBCIbORXhOS9DKgQt
 KxA5JQKX/1Q9HvxyDUMOCiD/dOfgx3+/dPovIPa3SjOFw7up0NBwfLMr0x+5hbjwIO74
 zwAA==
X-Gm-Message-State: AOJu0YweWudBmqtUYfO16VVtkj/G463ToLn38ywD5QstK4QpGSonecab
 R6fpzriC7abZPjd7JgL/9Nxymok9/cNYTnf35I5FCw==
X-Google-Smtp-Source: AGHT+IHAJe2ua7nhLWFRobxwuxA5Ea9jKVaWBpC0EOc6jpmifbw021zviHsn8lkN3Vbr5qsFENpxrg==
X-Received: by 2002:ac2:4ac1:0:b0:507:a58f:79b0 with SMTP id
 m1-20020ac24ac1000000b00507a58f79b0mr935937lfp.9.1698387668144; 
 Thu, 26 Oct 2023 23:21:08 -0700 (PDT)
Received: from meli.delivery (adsl-141.37.6.2.tellas.gr. [37.6.2.141])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a5d44c9000000b0032d9caeab0fsm1013790wrr.77.2023.10.26.23.21.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Oct 2023 23:21:07 -0700 (PDT)
Date: Fri, 27 Oct 2023 09:20:36 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add the virtio-gpu documentation to the
 corresponding section
User-Agent: meli 0.8.2
References: <20231027060808.242442-1-thuth@redhat.com>
In-Reply-To: <20231027060808.242442-1-thuth@redhat.com>
Message-ID: <36cb5.zjk9zvxmauvb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12b.google.com
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

On Fri, 27 Oct 2023 09:08, Thomas Huth <thuth@redhat.com> wrote:
>Add virtio-gpu.rst to the corresponding section in MAINTAINERS, so that
>the maintainers gets CC:-ed on corresponding patches.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

