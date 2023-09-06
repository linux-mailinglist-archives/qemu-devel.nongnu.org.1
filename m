Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDC793564
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:33:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdm5C-0007IF-Ps; Wed, 06 Sep 2023 02:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdm55-0007Hx-GA
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:32:04 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdm4w-0000hH-SY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:32:03 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-500c7796d8eso5270128e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693981912; x=1694586712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbJ3B31mT7QVAKybkYJocxFvR5YfB2qUjPbHDxZikT8=;
 b=P6qrye7JAr72bLyuhyWdlX0oQwYXOgkZxJVcVd3Y8WSYLQ+Wk8HfY8IGHvwc6uD3gO
 6u8Lek/IaCxUbVB8MxL7FNx0OlvX8b9R7waDTBH+7PQKFXOyBs9nm9gW7m25CqjaVHYD
 jSF+DtAvdCG0HnyPeDdAm2unILaHAfhBCNAIGZv0Wnd3ISpASenZYqvCZc1jHelUV4bM
 MaI2OZ3WfXRTrKfPU2SHXpsC678GF6LaH2A0ndlkujeKZ4UT8RlQVf1oUSODoJAXTk/v
 hC4H32fHfuJPYTS7dpgSVWS49X8f+TgaIAvDE/lBqEZDKYdKmnB+ZmVn6bD9D4O3itBS
 KpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693981912; x=1694586712;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbJ3B31mT7QVAKybkYJocxFvR5YfB2qUjPbHDxZikT8=;
 b=Nh1iUb6jzjbzQJN4RWDZL8Ov8om1BTTeCKFvpOOKTjlUhlmAt1bdjWZ6bbSRvjReRw
 QK6tFGzoy0Fu0ngFA7CJCof0EYW0tfjgGD5uoCTbZeQ3R6BV928kcS7BvNZL6q40PCk7
 IuCpIE3w03iREiUlgwU4WJ/zOLSa4yQJx46w5AEpPLZd7RBY0+4aNUz9WS7le0q63xCG
 zuBpARAQUbC2CksQQdZOXIg0BUQJe8kQp8K9L7XjWLnjck/gnvLW057ctlj0KlBC8Wuw
 dR5hYvF5Y1k8wDYX1gxEZGJrP4tgfgeB2SaQHQdNeH3JIiXBrCo3h5dwdvpfjOuHA6zQ
 Yy5w==
X-Gm-Message-State: AOJu0YwZQexuMjAU4eSPBxrWPIfvl7iMz/eTp2Abs+eJ9zkn4HEmg23H
 onTY9XpFGlnf59WsNikJLAWSXLCkfT42xBv4mCY=
X-Google-Smtp-Source: AGHT+IFMAf3niq96MOY9rO2HkyQ2usk1VSyzWy4uqwm9w0sF01dywAsDrIl+/dCnL8QH0hf2xcp1/w==
X-Received: by 2002:a19:3850:0:b0:500:b8a3:1bf1 with SMTP id
 d16-20020a193850000000b00500b8a31bf1mr1269251lfj.43.1693981912075; 
 Tue, 05 Sep 2023 23:31:52 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c214c00b003fbe791a0e8sm18891600wml.0.2023.09.05.23.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:31:51 -0700 (PDT)
Message-ID: <1d971e7a-f6b6-3647-7cb7-5620d4f1532a@linaro.org>
Date: Wed, 6 Sep 2023 08:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
 <ad508b5a-6cff-7138-1350-62a5bc513299@linaro.org>
In-Reply-To: <ad508b5a-6cff-7138-1350-62a5bc513299@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/8/23 15:35, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> This series is now fully reviewed.
> 
> On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
>> Missing review: patch #4
>>
>> Since v2:
>> - Added R-b tags
>> - Addressed Richard's review comment: page_mask = -page_size
>>
>> Philippe Mathieu-Daudé (6):
>>    hw/virtio: Propagate page_mask to
>>      vhost_vdpa_listener_skipped_section()
>>    hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
>>    hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
>>    hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
>>    hw/virtio: Build vhost-vdpa.o once
>>    hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]

Michael, I have another series unifying virtio endianness blocked
by this one. I can merge it if you provide your Ack-by.

Thanks,

Phil.

