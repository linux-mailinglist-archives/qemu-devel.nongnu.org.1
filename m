Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388078EECC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhuU-0005vf-Pb; Thu, 31 Aug 2023 09:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhuT-0005vL-1u
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:40:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhuP-0002jy-6s
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:40:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso93225566b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693489227; x=1694094027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UaQvh2TWVyrDTmtA7qg5xUugr3sGI5yfCdQY10inEKg=;
 b=R3DdLEVsXkhai+d2hvfQqtvaUgurQiQ+7frV2q+34LsuzkS6857+YkKDmdySnCBS34
 /W09ZAN6fYomVj8lHD2LOQce3TjxxlGj0ALhwjIytIWe4jFNiqUlsOgIv47wkpoQ8v/u
 2qIX1Kcyusltj8/eLjSxYk2UiIYTeVIZ5qrhg3HeyF1n2zLsrCSwqKQGsjy1kiW5xvjE
 UH5zEDICM9C7Bw8qOwkqHDRvWWJhX8Pr//UPlytiKlPajVdWrKN4dcXV3H8BQUwQRBb2
 z2lbVrqzQqaASMU+rVmjXVZzeoKT1plnhcMqSOdcJmMITO+tEVYn4k2bMbc+92qwl1Uo
 POZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693489227; x=1694094027;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaQvh2TWVyrDTmtA7qg5xUugr3sGI5yfCdQY10inEKg=;
 b=Q0qN1JCLm0/7FOIF09zBPcHmke5lhWn01YMDHd2wHG20+aqD2owgzZQ78uypn3artJ
 SgjWS+2BRVfLM42L9KVuhuKrtbxCLjsjCUcvDPC1+ht4lOHiuAGeL+S59ggS9tOj0x5u
 Y5mCnNMyHU5ahsuRoRKeEPAXjIHaPa0/fIU6gaxchu0Hy4nl76aGnco6W6bgvyFnl0tO
 nmUpilqH9n8I5aLPztY7QDFldvfPW6yGUBvgBdi5EsL2s8uWg43Sjn5Y2ElsTxXhBCH0
 Q5vhquZBQimm8/J4JLU8qNfrVuii6XqjM7trgPCxN6tsHDWsW+qJU6PaGBWSJX1ZlpoS
 uadw==
X-Gm-Message-State: AOJu0Ywy+1I+r4Hu46sR4PgRjjHLfkyp5xLSYl7386QlOqSZCgqSl6k8
 mvx9eQ1d4hYaE8Z324NRW4oddg==
X-Google-Smtp-Source: AGHT+IFY9wAYl/ayeavrQZSVJYIZmqIpwcdpqs8eQPxDartuHQw70FwgJN3JVc/flQgKYys/OTUiJw==
X-Received: by 2002:a17:906:4c1:b0:9a1:8812:a8a6 with SMTP id
 g1-20020a17090604c100b009a18812a8a6mr4036094eja.73.1693489227063; 
 Thu, 31 Aug 2023 06:40:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 qw17-20020a170906fcb100b0099d798a6bb5sm783069ejb.67.2023.08.31.06.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 06:40:26 -0700 (PDT)
Message-ID: <cb2807f0-fc7d-fc03-376e-09c3d5f10a7f@linaro.org>
Date: Thu, 31 Aug 2023 15:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
Content-Language: en-US
To: Bug 1863025 <1863025@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
 <169348611423.1472917.10027704436078423318.malone@juju-98d295-prod-launchpad-3>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Mauro Matteo Cascella <mcascell@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <169348611423.1472917.10027704436078423318.malone@juju-98d295-prod-launchpad-3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

Hi Samuel,

On 31/8/23 14:48, Samuel Henrique wrote:
> CVE-2020-24165 was assigned to this:
> https://nvd.nist.gov/vuln/detail/CVE-2020-24165
> 
> I had no involvement in the assignment, posting here for reference only.
> 
> ** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-24165

QEMU 4.2.0 was released in 2019. The issue you report
has been fixed in commit 886cc68943 ("accel/tcg: fix race
in cpu_exec_step_atomic (bug 1863025)") which is included
in QEMU v5.0, released in April 2020, more than 3 years ago.

What do you expect us to do here? I'm not sure whether assigning
CVE for 3 years old code is a good use of engineering time.

Regards,

Phil.

