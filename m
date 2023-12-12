Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079DF80EA28
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:17:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0jy-0002TH-Ol; Tue, 12 Dec 2023 06:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rD0jw-0002Ss-9E
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:15:52 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rD0ju-0006l1-4c
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:15:51 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d337dc9697so4254005ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702379749; x=1702984549;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNC5oIYKitYvhM6SxXejBnjQpjaOhOUlNNKhPwlYDYE=;
 b=YR/UFHM8Cn8/gFgWoV6Nufid3wWrybe6FtnktMtX8oVSUQe6+MIZKna27dCBkS6b/6
 1KN8SM3s55fOKlHmrEt/X5ySu3fxs84qzRA5X9rarQXH7rHaS1YKGlVdE2kZ1ASqBd97
 KBhoNuWGWhw6o613/hN+AC/Am5lNPH+XJdmBSqDs9TRD2liXYyHCJ+tK/j8DSH2RT0ff
 1ON6fY/lCtzplJZFw8hDvSVUZshM+Ndik8q0ui92patVAJl7qcod5zgc4U+MSqEwhVFh
 khE7q/y9VKf3IPbI0pPP46tgt5XIFE37jVNI/zaCwM6KyCqZGM6J2us4bAgSJc+6EdKl
 1Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702379749; x=1702984549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNC5oIYKitYvhM6SxXejBnjQpjaOhOUlNNKhPwlYDYE=;
 b=V0KWtqOaBdCXi20MMlDDdDWuaijUALglXjwgEHy21yIgmm4+ZnV8SRMkPkn+Rdt0yM
 AU+EfRbGCHkADLV/+bXkk6wEjOeIBkMM5MO1FhHq8bD3UFLv9BGgkIksHMVyhgvm5Mp2
 NjGM56rk0epjwWUd+sQnLNSdXCVJ7bLAuWf80GaSy6xN8Qlb1dPrI7Oaa5dgySsxawWl
 ZzilAab5qmtAnbMjPV+1HvUq5tJCzk455Jtfxlo2jlK6d3vLm1cmzzUa9gtJ8AJUok0S
 VlOIEeuVRs4E6bGDDCMBWonRQw34aUzQCaxQIInMFIPNDHauBi9QwfNXhvjefpovgC5J
 7ciw==
X-Gm-Message-State: AOJu0YyIp6rOy+5wV3uAhn1XeNR9F0eKtNE/EcSdJqWT+CJf07mbI5o8
 uspdUXsxLVt8786r4b9rcC6yLQ==
X-Google-Smtp-Source: AGHT+IHSA2KEDl5IJVrXXQGOThrlNpFe/8P6ud3iTLJrx5UJlDA8RP8cwSJHIITMSdsFGFouxWcHuQ==
X-Received: by 2002:a17:902:ec8a:b0:1d0:d18c:bc5a with SMTP id
 x10-20020a170902ec8a00b001d0d18cbc5amr7031212plg.121.1702379748766; 
 Tue, 12 Dec 2023 03:15:48 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 sc16-20020a17090b511000b002887e7ca212sm8862178pjb.18.2023.12.12.03.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 03:15:48 -0800 (PST)
Message-ID: <b5f8de1e-2a9f-4dcd-90b2-6b0bd8a27347@daynix.com>
Date: Tue, 12 Dec 2023 20:15:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/12] hw/qdev: Remove opts member
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <20231210-sriov-v2-5-b959e8a6dfaf@daynix.com>
 <b2a8fe53-e432-4c61-8cc3-f39c6b650cd7@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b2a8fe53-e432-4c61-8cc3-f39c6b650cd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2023/12/12 19:04, Philippe Mathieu-Daudé wrote:
> On 10/12/23 05:05, Akihiko Odaki wrote:
>> It is no longer used.
> 
> Since commit f3558b1b76 ("qdev: Base object creation on QDict rather
> than QemuOpts")?

One usage still remains and it will be removed with an earlier patch, 
"[PATCH RFC v2 04/12] vfio: Avoid inspecting option QDict for rombar".

