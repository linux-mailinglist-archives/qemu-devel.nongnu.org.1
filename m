Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D52827B60F2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZAU-000586-Kj; Tue, 03 Oct 2023 02:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZAO-00057s-Rj
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:46:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZA9-00059R-BT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:46:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40652e570d9so5862305e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696315542; x=1696920342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzC8QZ+mEUuaWC5wpyqRIw15/n6pYmAOvjM9DFVsUOA=;
 b=vB9mUWso7dyKCSezIfVKv6sEGE1NCiiQlFQhOxOvYN1Bg9vLeCmmGDi9s+Mj/SIKl5
 VbmhR3si1/61SdMO4dpIUAt7evpMZ8A+XGMRJ7c9lBgko95wjACJDzvvTDeThjmq5GZg
 ZwAysQoHa5RwDB3tfol/G3H+jiXCoym53j9/JfrnIO+nVVmbZb9grsJSVU1w+az9rUC5
 jzVyDAuoo5sqG8diKojr65vos6LGW0woPizuBFqaHLe1QAh/Btb/mLCVvdtUy1S4fv4h
 T58nlAYO0OLNBYJ/xAH+PxO4oI0Pq8+c73RBnxn/vXM0kcpkGoMFjujO3hwhWpQEkHig
 A2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315542; x=1696920342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzC8QZ+mEUuaWC5wpyqRIw15/n6pYmAOvjM9DFVsUOA=;
 b=mf1VHE52vb2NUfAa5WGYZ4ThzUbzt3cG8RS3z0xbzXZlCZ2AlmJaiuCRb45iBmjYmo
 e3SrUoowtTVvtExHMh20sxE8DGuPGs7e6FVwoW/0CDS6TdcZ3VBIIlXgSlkSdyHXJlwH
 WSlMkRYGv4E1ZwEx6y2YJsY3tUKfQuNXXOxxPW+BL4SUjlWrkzcpOCiy82+151+QCp8i
 Rco2dxT2X1pdeNxJWoE66NQKNRyoeKhSS4kgi/Ah7pQGapPQYR0VUrjjoQMs2VQ+dXjh
 2Hngi3LMfFUlbS1tnthWqtqHE5/8Ha9V1Rox9LSkIEjR0bagCG7Ct5x8isExjSCPkivk
 HBTw==
X-Gm-Message-State: AOJu0YxL0buINVIBKt+bGBQkBdPGQY4x4cpyWLi0HeTOqYUJXwft1UBy
 OIug8UHqYj7e37oM0UBfLCZN1dZ8pxtLGtyB7hwtfg==
X-Google-Smtp-Source: AGHT+IFbnh1wjCsY0gGsO4uKVHTMA2CywI5Zs3lmQEv0wc9kc1COY1znu+z+RUHhAs7kCuu3x/sgvg==
X-Received: by 2002:a05:600c:21a:b0:405:3d04:5f4c with SMTP id
 26-20020a05600c021a00b004053d045f4cmr13261334wmi.38.1696315541833; 
 Mon, 02 Oct 2023 23:45:41 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b003fe1fe56202sm514803wmb.33.2023.10.02.23.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 23:45:41 -0700 (PDT)
Message-ID: <f4da7efb-f31b-8dc4-7076-320019e30163@linaro.org>
Date: Tue, 3 Oct 2023 08:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] hw/intc/apic: QOM cleanup
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow
 <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20230915162042.55890-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915162042.55890-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 15/9/23 18:20, Philippe Mathieu-Daudé wrote:
> Minor cleanup extracted from a bigger series
> touching x86_cpu_realizefn().
> 
> Philippe Mathieu-Daudé (2):
>    target/i386: Only realize existing APIC device
>    hw/intc/apic: Pass CPU using QOM link property

Ping?


