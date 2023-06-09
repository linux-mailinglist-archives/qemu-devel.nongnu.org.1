Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 833BD728F42
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 07:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7UYF-0004vF-Hv; Fri, 09 Jun 2023 01:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7UYA-0004un-OH
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:20:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7UXv-0008Kk-72
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:20:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso10293295e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686288019; x=1688880019;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V1fhatFi4R90DzO1FR8UFL7D2uGUv5il5EAKuDsgpRo=;
 b=cPDnnUCo09BwGImjI+gt9sEa/2QJW06ZX9iA+SGajEfHsQHdNDz4DlahUX2JB882Wa
 hE2gG1oysA7epLy5QwPQoHw6nvT0YnoUFUOASDFfoPlTTJe0RWEdS05CIGutipEpu2tI
 ZC3snp7k7DFmWZRAbSbbR2pxnwi+Cecb0bIurIh8BFkSE+ksyW9b+SadKoV/ADa1mfjT
 Lf+p/xxxpYBnXHJN8FHJAIyQx6JvA0uWF4x8kAlzH1NMKxe4blS4yZe1sFg9BEP/n1sb
 +FeS7D4XLN6quCpdgMKMNtkUQEujchAxn1NU5BpD6PYm76cQA2JkZKasAEpu0pFQ6v4f
 pM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686288019; x=1688880019;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V1fhatFi4R90DzO1FR8UFL7D2uGUv5il5EAKuDsgpRo=;
 b=VlEC7PI5GVJ9iOHlG0+8Q/CPmCZ2lmA5MiFAns3i7KSKQ+ETqyX/A6qrLBM3U9H2pf
 ujFFcay+cjJgyX9cW2Clb1cW6qFyDIu1kp4CHnDRFU0ysFtZ+C9pR7idlQOAnBgYpnT4
 q4gLoNbSBMxi9/HpXS/9/gqZM3FDF3w8Z1ceO2GL3PVqLggVJRc7g0JvSLrrspB7VVD5
 EES7RwuMokaFb6lp30wAyAf3ofvY08QWeJSh4Nou1bQvYYea9an4i/QIGXyXwucVQfS4
 1TN5DSHvtt3WfUaVQE41iMEqkgbTmBSb/l2UujI0FCSJ8oTtk0V4Mkj0q9hGY+nXGYXk
 gfEA==
X-Gm-Message-State: AC+VfDy0LcUXkdkEtit9NpZejwgPsSmmBRF6ViBmRH7yZOsbo4CrTwww
 0WsAeThGZ1mV/f3NUqSI5wK1bw==
X-Google-Smtp-Source: ACHHUZ4EKaFJ4bAMtAv9RTbWJUeIVsedycf8ZiokLjIb/Oi7UWqg1Ji+knKcJkh9+762Sj7HeyQ1AA==
X-Received: by 2002:a05:600c:1656:b0:3f7:f302:161 with SMTP id
 o22-20020a05600c165600b003f7f3020161mr2956641wmn.8.1686288019686; 
 Thu, 08 Jun 2023 22:20:19 -0700 (PDT)
Received: from meli.delivery (adsl-68.109.242.225.tellas.gr. [109.242.225.68])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c378600b003f42d8dd7d1sm1474690wmr.7.2023.06.08.22.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 22:20:19 -0700 (PDT)
Date: Fri, 09 Jun 2023 08:08:56 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [RFC v2 1/6] build: Add configure options for native calls
User-Agent: meli 0.7.2
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
In-Reply-To: <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
Message-ID: <vz05s.bcqn4thscosb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 07 Jun 2023 19:47, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>+have_user_native_call = get_option('user_native_call') \
>+    .require(have_user, error_message: 'user_native_call requires user') \
>+    .require(targetos == 'linux', error_message: 'user_native_call requires Linux') \
>+    .allowed()


Is there a check for accepting user_native_call only for supported CPU 
user targets?

----

By the way, a question, would native calls be possible on BSD? I assume 
if yes it'd be a task for another time.

