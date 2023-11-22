Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2A7F3EC3
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:18:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hUO-0008Ul-Kb; Wed, 22 Nov 2023 02:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hUL-0008Tn-DZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:17:33 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hUJ-00089r-VL
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:17:33 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5488bf9e193so5023403a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700637450; x=1701242250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C68A6TmGxpdDG8NB2o7dqQnjT9klP1QBHnFY4EQLd6E=;
 b=AgCB67ccm2HtzMnM1ef1WrOYRZ61CfPhS5tZBoSyL1smb4hQwrY3v9tPNKuOqo6H0N
 0QCh2FuWfoE8RPtiuqPp625o8HUodTAwZcbLrL9wXJzGd6rZ94OyTP+SWgj7BDlPOkHE
 xdS7P5E55XK3+dvKoxrxDjzMkEt1zgOQBh9GoON7GlaiOJMhRcyE7ox5C4HRDY6F7XWD
 NpfbEJt6OhMF4TUEfWG9l2Hcsc/M7D5+1MaHxB4MgMEvRof6lDEl95Af/KQZ3QCeK6Ek
 6lLuPiUUeh5Ll3dLSwF2OsKQH6trofUowsgDvH+7t7jZkxzbNO5oGPj/dTmRSdx9kuVP
 mJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700637450; x=1701242250;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C68A6TmGxpdDG8NB2o7dqQnjT9klP1QBHnFY4EQLd6E=;
 b=cvp7mXTVQcbKitTMjJ2Ixa5GOc175tkoSWy23G7sZCSx9Rct1U6sYseWDDqLlTTPv2
 RfjS30n+j1Y1W3Eq+Fqz+Vunev49kfmtOkjwHRYh9gm1BBW1Y56C5fBatV7ouQGH0mTf
 eM+qGw0SCL66lrRcoaWNInHOfHrRUeCBS5v5YMK7Pgl+8DBPhMamJEPdFrApaGRlmtDs
 OAV9zo5SWikp4YcIfP2yNfcX6WZ0ZLrUSsaZbbbeEcDZqt3eUeGpHspTZcp9JMDpsPRT
 HP4/hFOebOxXNAQdXdoAfdMGEvZA9xRazwl8U5BDZTDUrZRlzfIkN+6CUnTcu+q/X1rw
 2rCg==
X-Gm-Message-State: AOJu0YwVGikBAKUiqzhf5TiA/+r1BLuctU5jh37rkt8NttvJoXoUKmLf
 ROK7gJz4RqoMm7Fk3CrInah3PQ==
X-Google-Smtp-Source: AGHT+IFUZb+6BCvsvxMHw5yh2kpA8blvU9VBtT+rw7OApRCnUqApimZOnsIZdDCHWWqRICkq5v6Rug==
X-Received: by 2002:a17:906:c1d5:b0:9f8:2b44:7b7f with SMTP id
 bw21-20020a170906c1d500b009f82b447b7fmr798395ejb.70.1700637450379; 
 Tue, 21 Nov 2023 23:17:30 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b003fe1fe56202sm1169178wmg.33.2023.11.21.23.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:17:30 -0800 (PST)
Date: Wed, 22 Nov 2023 09:14:08 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 16/25] backends: Have
 HostMemoryBackendClass::alloc() handler return a boolean
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-17-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-17-philmd@linaro.org>
Message-ID: <4ik94.41xfq4630py@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Following the example documented since commit e3fe3988d7 ("error:
>Document Error API usage rules"), have cpu_exec_realizefn()
>return a boolean indicating whether an error is set or not.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


