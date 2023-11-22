Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070B7F3EB8
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:14:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hQX-0005uY-Je; Wed, 22 Nov 2023 02:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hQV-0005tK-MN
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:13:35 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hQT-0007AE-LI
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:13:35 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c871d566cfso53031631fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700637211; x=1701242011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C0Gvttm2BT17r/rQ2eWa4G9Pd6giBQyDkIRVvpo/ReM=;
 b=kf+aFrJSLE4UvFS7xcbUpR34xlV5bqqY/jh0bwuv9oo0OLFiKi6lxPBrdO1R8zZcJI
 pk4NOuccGZLkmp1sklPuISI+LgcrVvg1JH4boIXCENGYB0zk8WCWJ53f1N13wXxi/qZe
 az9eqH/PKB4uPZq8fg0BMDoO+h6HhaZdJObpt4j26HaQK0BkDZWvcqXUaty8mkRccr2r
 QzcAJmS/vo5hT2fkKraEk0zQYEImuoiof3bE8Jtb0dybCNiMZd8jlps7NeXQcnpNKsDE
 b3mrQIjrhJrbfiLSjOvQ9EH/kyfeKaC+J4kt0RkQeJCQilWT1A+L3TG08fwnQX9jyoiT
 tRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700637211; x=1701242011;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C0Gvttm2BT17r/rQ2eWa4G9Pd6giBQyDkIRVvpo/ReM=;
 b=faJCaUCyrtxAS26eteTYmmtdAAuFwn1NFyAAzinfzZOQ6y+QkZDjnn+a1ERqk9gUNh
 rOr86+oP4KFny579YfGMvvVfaeQY7iCgjdKf2GWnisZir28RsCfBAL6kSdOKNWW86619
 fKFPJf+CgXD9ly+7hL9A7H2C9YpRJKN+cCccqoiACMhMczmux7x2vj1TN90hUvBdpEg2
 kWytRNR9WGlziHRlMGgB2IbjyCRFDa0RRevGp330G1mLY05BjYqu9nyaEvZC5qKNc064
 semUAAO9bqnwcmxchXqGTfEZSYkrE3fLue2Y0dFlNTpFHZVoGuDLlphBcASntwozg+3F
 CYqA==
X-Gm-Message-State: AOJu0Yx/014uB6L0545R4uhpUfnOc7Spil2Ov1kQDSJkPptBJD1miAj5
 eahunt2BraAWxVfrYoqhZo+vAMrb5+6HVzAjXC8oGg==
X-Google-Smtp-Source: AGHT+IFmIA4a3UnRjJzOGxClEUwcrVuP4EQySEX3ZlqySkQOiTji5LOAQwQHNPRjXJf1pTli2EQttA==
X-Received: by 2002:a2e:b3c9:0:b0:2c8:71c5:d6cc with SMTP id
 j9-20020a2eb3c9000000b002c871c5d6ccmr993141lje.32.1700637211359; 
 Tue, 21 Nov 2023 23:13:31 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a05600c4fcd00b004094e565e71sm1161180wmq.23.2023.11.21.23.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:13:31 -0800 (PST)
Date: Wed, 22 Nov 2023 09:11:05 +0200
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
Subject: Re: [PATCH-for-9.0 15/25] backends: Simplify
 host_memory_backend_memory_complete()
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-16-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-16-philmd@linaro.org>
Message-ID: <4ik2g.hrc8nvnm8q7a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
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
>Return early if bc->alloc is NULL. De-indent the if() ladder.
>
>Note, this avoids a pointless call to error_propagate() with
>errp=NULL at the 'out:' label.
>
>Change trivial when reviewed with 'git-diff --ignore-all-space'.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


