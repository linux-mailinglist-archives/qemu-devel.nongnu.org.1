Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8927EDC14
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:37:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WvK-0001kR-BY; Thu, 16 Nov 2023 02:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3WvG-0001k2-LN
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:36:23 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3WvE-00019J-Vw
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:36:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40859c466efso3410315e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700120179; x=1700724979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PeVBVe2R/kykkKpzO6ObLdS+R1638xU34whQnHv43/4=;
 b=jbDKSBDyURz+RUw7kEISjoxMTNuIUNqMsKIAscGRiJoRAvlza+t37h7Z7TaIEzOzr6
 GfJvGG2DZ+75o4yzGXcwoMD3z7+nH6JwyI4uMlG3Z0G0UBWU239roaNd8GYsFuZfF7/d
 ArsYLR91qmp3fMPY170sXtf2jSM2VmEiPuwPaxVervcSQmv4C1Dfy+Y6Rcar6eRt1qGC
 evDijGRzPUzUvkKZ3SONbcIKMRi1IARw30gqZDdW5t4FCPjqz/E8xhZmlMuZk0xHtjhQ
 9aRWeUCp25+m2hC9IA4KPz7EZ4E+1cnma99peLbZJOkThICEATGB5N6ziOnF+v6kTuuG
 5xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700120179; x=1700724979;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PeVBVe2R/kykkKpzO6ObLdS+R1638xU34whQnHv43/4=;
 b=EP0G4k0VgYI4D4TJINsiCoi7mOEYIdPsZaKiyFHRfP7Ae9kZCn9MBzu1tldLbgI1WE
 m/gM8YDVsi1ovG0qgz0JDlYgy9iskCxN1rI3Dd2eABEczI9kDV3k3AwEB44Xn4N7DhwA
 fdfr5Zh1KKT4kymKmWGhCMZGjiTMcvFlEd+7XWkZgQkp7OvAkrNGTSKcVeJP9E+9xKwz
 Svm4MlCmxziw2LhDAeY44ljfH/NEbgsytGAdkrC1I7XSXfi2cmQBdb4e8RIvVbSLIhTk
 ncv52KSImi2xoGvSJBEYl0KEpETw0u28M19jb+g4lv9LDhbZlN+BActV9wqoKq6uoFPP
 35kg==
X-Gm-Message-State: AOJu0Yx2Ma6WhR44ZgQaCOM4nNiF4XMxqyZuH2pnitB6TZG0Nuhp0DIs
 iEU72WAXuu+S2W7YIYWNpO7lNw==
X-Google-Smtp-Source: AGHT+IHEEkfeCGZuxysLGpd95Edm/tcScBUi/JALhnnTsgeZERcRTtyKzrIxMvx27NXo91pk7gn4RQ==
X-Received: by 2002:a05:600c:46d5:b0:40a:3750:46ff with SMTP id
 q21-20020a05600c46d500b0040a375046ffmr11926175wmo.11.1700120178943; 
 Wed, 15 Nov 2023 23:36:18 -0800 (PST)
Received: from meli.delivery (adsl-29.109.242.224.tellas.gr. [109.242.224.29])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a05600c2b0e00b0040644e699a0sm2321151wme.45.2023.11.15.23.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 23:36:18 -0800 (PST)
Date: Thu, 16 Nov 2023 09:33:46 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
User-Agent: meli 0.8.2
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
 <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
In-Reply-To: <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
Message-ID: <47h4g.6wu5d10yw748@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Thu, 16 Nov 2023 09:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> ---
>> 
>> Notes:
>>      Requires patch <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
>
>This is the 'Based-on: ' tag I guess.

There is

  prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4

At the end of the patch, added by git-format-patch. Is it best practice 
to include it in the commit message too?

Thanks :)

