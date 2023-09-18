Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01C7A4767
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBhq-0002be-7b; Mon, 18 Sep 2023 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhg-0002ZZ-LN
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhf-0003iw-1e
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3214de9cd8bso849568f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033725; x=1695638525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ZoC+zlZKKLD3vKwwKU93CJxLjsPwxjC+q3MBAawDhw=;
 b=OGicP7DHVJL++m6SXsOGePvCv3FcL25koISuSpD35ZAeripIbVB6Ci8T+VjvnWuCp3
 V7NGf1xd5Il+Os9Qo+/T9jZh5iCSfnI056UxQUZTdNBbPt5Exv2nyZc6CNzrX5wk7SM8
 1RkjNxLULVFVwrl1zegXT0c37dI1UqjbW1czM64zwaEgzxwe3ywbFUI8Rh55l1k5/h/Q
 Mw1X10AIupwxYJoy5AxiEzWJExvkM0+W6Go+oe+EMdMxTR23MrnOYLDF5vsjyiAaOxMi
 g3hXF5+vQe2M56s9tXPNAo28ECBr4Dv2ox2JO67cZHEgQJo9FZTfnM6UaqKP3wzOjvAe
 Wvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033725; x=1695638525;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZoC+zlZKKLD3vKwwKU93CJxLjsPwxjC+q3MBAawDhw=;
 b=wwxAn1dmn2WXdm7eMkTmdmCAa5/VMGB9BcQTSsXDRZxCcqbdvF+6U6D2Um4rADMA3H
 T7dNOYxk7UzupANUqIaaB+rPVOPED9AYwq92aZyL59K7dv2BVr8HY3fhkPT7atZMxhch
 opdvHQy+fBOlEIRFH/B19LF0O5ncvg49UhMdcaqC0BRJNAuKzue1ars0QcJzyMHaD2et
 bw5fw0Pw4mQFY+/KZ5Wzr/oa0wEzOIAKtcwap7JVGi9zEZxsYj8JY2sjENRVC4gL+gns
 JMxJRD3muawcYJ6kLoB2ktK+xAGGk45YRiRTffQ0O/kryrU6capN+pq8TKrFVdMD/5pJ
 /fPQ==
X-Gm-Message-State: AOJu0Ywd9HA95gyR2d6yZQf5ahuqa/AuLmEb4+2/GCaUFsxZ2/NgouMY
 gPA36dLHGZ8QMgcezyIx+DwG87wnpVqSuewxBMkinQ==
X-Google-Smtp-Source: AGHT+IFpQ+QMnhhiviU+6px8tSW2lc/+Cz4Kj4jqDKTEYAa3mTV3GWmCzpzls5laNZdLtiiSpJmSDw==
X-Received: by 2002:adf:de90:0:b0:31f:a4fa:130a with SMTP id
 w16-20020adfde90000000b0031fa4fa130amr8902198wrl.14.1695033724901; 
 Mon, 18 Sep 2023 03:42:04 -0700 (PDT)
Received: from [192.168.95.175] (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 e1-20020a5d65c1000000b00315af025098sm12263948wrw.46.2023.09.18.03.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:42:04 -0700 (PDT)
Message-ID: <c55cf435-c8ce-c1ff-d639-905ecf721ba3@linaro.org>
Date: Mon, 18 Sep 2023 12:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20230710094931.84402-1-philmd@linaro.org>
 <ad508b5a-6cff-7138-1350-62a5bc513299@linaro.org>
 <1d971e7a-f6b6-3647-7cb7-5620d4f1532a@linaro.org>
In-Reply-To: <1d971e7a-f6b6-3647-7cb7-5620d4f1532a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Michael,

On 6/9/23 08:31, Philippe Mathieu-Daudé wrote:
> On 30/8/23 15:35, Philippe Mathieu-Daudé wrote:
>>
>> This series is now fully reviewed.
>>
>> On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
>>> Missing review: patch #4
>>>
>>> Since v2:
>>> - Added R-b tags
>>> - Addressed Richard's review comment: page_mask = -page_size
>>>
>>> Philippe Mathieu-Daudé (6):
>>>    hw/virtio: Propagate page_mask to
>>>      vhost_vdpa_listener_skipped_section()
>>>    hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
>>>    hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
>>>    hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
>>>    hw/virtio: Build vhost-vdpa.o once
>>>    hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]
> 
> Michael, I have another series unifying virtio endianness blocked
> by this one. I can merge it if you provide your Ack-by.

Unless you object, I'll merge this series. Since we are early enough
in the development window, if something breaks, we'll catch it in
time and fix or revert.

Regards,

Phil.

