Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC780D22F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 17:39:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjIg-0006BC-Ob; Mon, 11 Dec 2023 11:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjHx-00069j-E5
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:37:50 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCjHv-00024u-Mk
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 11:37:49 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1e116f2072so965569566b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 08:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702312665; x=1702917465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aZ9XXmId1yzNKbpMkkoAkMgLTFP9oyzkyWQqbnJsHh8=;
 b=NmZFQP1JQ6hgzpZYgPp0riPxbIklt0zkQ9Dl6iLaRnNiYGgIoymGWOXaGZZ4elfMzd
 0u2yUD/oWF4/kgRugqmxsl2tvrVpceT4vzGlec3T3KoMTIECXrNZe9SYdQfBNehnadet
 RIkOWItaaEvJDHIoz1GS2oS5Q9nJPKQFFyIBS/r+q6EXB2jOz9Bx0+JuD9qia5ariytu
 Z9qgFTuock9PiPvAYn/sryLuByo4IAOrBcU5BBwER7KJTkYag/qubiYHLTSMROOSc3+b
 vEJ6mmQG0+YGLIFe9k72MWKv2V5y9SNZPuLkvjV2uuXGWESbgim6Ytv052Na8B2X+NA8
 cFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312665; x=1702917465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aZ9XXmId1yzNKbpMkkoAkMgLTFP9oyzkyWQqbnJsHh8=;
 b=d7a9gdQzKpzloqkY1ICpcMc8hnIBkp8K1XkyYRiHQydliaDUYJs8CnZcQNdcistkWv
 +KIR56UGvyIA1HDVJcBNpVjc0RyyEkrc6aeDniCMm6b5JvL/ljpTp7xYf/vFQvnPju1h
 RMJ8NpUXgb2Uro8Yp2q9LJVnw89tTO6k1XHQJwFSom/vP1XzO9pIvji6VlGMdbw0WtGy
 8UGYzIr6nMHL4YPDaR6N1Ot1XfJj2YC8NQ52rAmMyqjOP3P8Qh+WNOYW8BY2tYEXcqJQ
 qyskZ4IfA1Wu6gd5qtUH8BOI7e2GHwYdzEGjDKP6py+h60VmnE6RnS6hUeADG6+opnfQ
 RXrQ==
X-Gm-Message-State: AOJu0YyUcvbhxYdsF+LRSbQjGeR1mEhJAdV+e8PjDoBeR+ViR4SuqDqX
 ukmp7RImFSSgH585FGchW99B5g==
X-Google-Smtp-Source: AGHT+IGuPhejSEsdQBopcEBi2QQyqELHJP5rBS4xsF9O6h21RXEDalMYKXGwzBhKJWBGWOsAMrAilQ==
X-Received: by 2002:a17:907:60c7:b0:a1c:4c3e:99e2 with SMTP id
 hv7-20020a17090760c700b00a1c4c3e99e2mr5132099ejc.22.1702312665779; 
 Mon, 11 Dec 2023 08:37:45 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a097c5162b0sm4995159ejc.87.2023.12.11.08.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 08:37:45 -0800 (PST)
Message-ID: <fecb9b5d-caa3-438c-aa78-4775c2ef2002@linaro.org>
Date: Mon, 11 Dec 2023 17:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] tests/avocado/boot_xen.py: unify tags
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-10-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208190911.102879-10-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 8/12/23 20:09, Cleber Rosa wrote:
> Because all tests share the same tags, it's possible to have all of
> them at the class level.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_xen.py | 26 +++++---------------------
>   1 file changed, 5 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


