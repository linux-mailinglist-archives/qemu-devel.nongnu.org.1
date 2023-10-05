Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6727B9B28
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:45:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoI5n-0001Bt-Gp; Thu, 05 Oct 2023 02:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoI5k-0001Bf-Jj
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:44:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoI5g-0000mM-8u
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:44:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405524e6768so5553055e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696488246; x=1697093046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NsytdoxyTg7lrCTpV/Z7569BMo1yJfw+T/C6Wx8fvhE=;
 b=s7siS075rnsQAzwlHAT9nDUe2EZaAAZKy4D6aeg5S7mL0ErULYlmBaN4pazzS0WPU2
 eor8KZFxr6bI9OEqLEB0AzYUyp3R6t0s27PPGFBBNWCFomfYOEMRWfoaYBdwZWtQ6T2e
 Z3Rj/9G1o5ioFWPMac147pdQluU10NyQBTu/eBRuBQkLfBGFIJnZkpLeqnHRMh3ciiW4
 sILBtTQdcvv7q28XJD0OReWD/tjxVNanNGkht9nGlrYI7sNNkIfkY5VArGiO1oQlDd/h
 oHp5E0LjtqHttOlScK7YbCypBtesZ9ZVXdLlLhcnSW5fMJzxjN2BIkX89XRAsWwLj9MS
 EhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696488246; x=1697093046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsytdoxyTg7lrCTpV/Z7569BMo1yJfw+T/C6Wx8fvhE=;
 b=C94c8ajIQzsBSqo0ABnKzH3yXtO9UHLH6ucIFZaEJyf1WXdBD8U3ToIfIMwrdg83yQ
 EhosLOOH/nivQUtolokH2O/j/LoT0ChYNU1RvVXayzrvNFbtartq0uMe2WwIu5Qk2Vj/
 qFN5+SygmzslxuKjBvloYRXh61Jjxp2x413D2jJYeGtai35sgunDEVarGMNXD1NqPabQ
 d98HyVzzwZ18xGx3ouRcERKauVajeQpJdN6kGkVY1l8LXu/VthAKfYZlsEv6LpVoRxrg
 5VD6O/DbQevvI4ueTZNHM0rVypWswrrh6KhvUxb+TqBHZKG2GW315IMQi4i1dr5THSYd
 9Xmg==
X-Gm-Message-State: AOJu0YwVjIAQvqSQbOvfPu4B5jQHwHaaedzJ752tNoSZLvNMTZ2RzPb3
 U+M8s5T7xg75bP0LNjGGNCDRHg==
X-Google-Smtp-Source: AGHT+IHeJ86ecqyjbOb3kigRZczT6ZWNlegCeIS3vMsUCobLWM+3qCdiCbJQsinTILwdFuNFpWc4Vw==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id
 n9-20020a7bc5c9000000b0040302724414mr4283695wmk.0.1696488246393; 
 Wed, 04 Oct 2023 23:44:06 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff850000000b003232d122dbfsm967754wrq.66.2023.10.04.23.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 23:44:06 -0700 (PDT)
Message-ID: <492a9930-eb86-3afd-b291-a3801f3f65e5@linaro.org>
Date: Thu, 5 Oct 2023 08:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/3] qapi: re-establish linting baseline
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>
References: <20231004230532.3002201-1-jsnow@redhat.com>
 <20231004230532.3002201-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004230532.3002201-4-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 5/10/23 01:05, John Snow wrote:
> Some very minor housekeeping to make the linters happy once more.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/gen.py    | 2 +-
>   scripts/qapi/parser.py | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


