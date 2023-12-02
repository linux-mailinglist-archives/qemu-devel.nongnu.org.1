Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AF801B65
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:09:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9L3C-0007Kw-3X; Sat, 02 Dec 2023 03:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9L39-0007K6-Qk
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:08:31 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9L37-0000F8-SM
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:08:31 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b85dcecc62so1055606b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504508; x=1702109308;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQPMqVoM84cdEJIS2oBXYDn/8Ps1tjqa86r+oMitaBQ=;
 b=yc6RZ08kqkfNrIPQa86TmFzxV82abVJxtEn8l7YImLz2sNP95WMzwYjScsAig1hXds
 SRJDMbo0CsnEZJF+Nm/UYHcm030bLlfOuu5T3i7Kd0MfLRqXyPeJpZ38A1UNZq0brJ/N
 eWq9tCso/GVU9tSHPDvgtz3+1yO0fiIODSkbnxLXFjeVjdezKU0Mb2Qfl6A8QbyHjPHc
 8abLRGblGTaQ2//5moqsYQRN041gg5PWaXjpKxiKZCm5hlq4dNMa29/FnSWZqwC1JHC3
 fsyv59W0mT5NK8OyRuqJaAQfy/0GZfH7cv4YjrQ7xNcVIDOazvFurlUaNMxr7DO+MM0f
 pjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504508; x=1702109308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQPMqVoM84cdEJIS2oBXYDn/8Ps1tjqa86r+oMitaBQ=;
 b=BDxwqQ6/sq3SDQ+GCBsa1zHnwumEdUFRTwyNzDtAMyp8R9jdx7uuZGNjByaBV5+IYe
 B49RHPu0WOmoZsaJsDljxhD1ziDJfhpFaq+V+MBcDOL5Du5nu6SkaWmihuq8ddnuXSek
 UlQY425U6IPF2ij9zBzpsIv2JdJ8ChBsFA1ugz8wV0nBG7JizRqGpulxq5tzmtp9/4A3
 u498K3nDy3kKb4fate4qHUmnHuWYOOGbJSN2Ys0p3OLXodIa9yeO4a+4wnQZW82iaqQj
 OWjUe62yHcVyg4gaj+gjc/QPfGwdo5te16BZl+98og4E3ExlxIFKzfUlQd1g1ccdE+7B
 tPwQ==
X-Gm-Message-State: AOJu0Yz68qKiuGoW4ZQzQWEOeVaz6EgSWFZauhaDNt+Ubss1TsbVSkXU
 zSbDKsnpQVx1YpBUn8oZ0ujHCA==
X-Google-Smtp-Source: AGHT+IEN/XSeaQASyoTS0Nq2l6SMq8bUCNiFeJ12509dTUSBU9oAGhDNvnDOnH4FcYfH0Kyzmkaw6A==
X-Received: by 2002:a05:6358:c6a0:b0:170:17eb:3787 with SMTP id
 fe32-20020a056358c6a000b0017017eb3787mr865183rwb.47.1701504508447; 
 Sat, 02 Dec 2023 00:08:28 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 28-20020a17090a191c00b00285dfa07befsm4687926pjg.34.2023.12.02.00.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:08:28 -0800 (PST)
Message-ID: <f7527574-1c16-49cd-adcc-9a7ffcbe4826@daynix.com>
Date: Sat, 2 Dec 2023 17:08:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] virtio-net: add support for SR-IOV emulation
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/02 17:00, Akihiko Odaki wrote:
> Introduction
> ------------
> 
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
> 
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices in a
> VM. vDPA devices can also provide L2 switching feature for offloading
> though it is out of scope to allow the guest to configure such a feature.
> 
> The new code of SR-IOV emulation for virtio-net actually resides in
> virtio-pci since it's specific to PCI. Although it is written in a way
> agnostic to the virtio device type, it is restricted for virtio-net because
> of lack of validation.

I forgot to prefix this as RFC. It is the first version of the series 
and I'm open for design changes.

