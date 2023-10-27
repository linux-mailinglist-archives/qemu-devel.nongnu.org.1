Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9917D90B7
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHsV-0000jH-S3; Fri, 27 Oct 2023 04:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHsS-0000hv-RP
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:07:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHsM-0003Dw-UL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:07:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-280011e94ddso1030478a91.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698394045; x=1698998845;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFGOxRvp86pFFhgzmrint86sZnXr0mAeWAFFTj6s0cE=;
 b=wLYdYVjuwPtHhlPpnjhfZgMEpJHCaDhAoIcH2PyBWGCjsehCI7rVFVft5r3fqdAVSE
 NjeVyX/6UjbeglLjsbHNAjLeY2HcNVpwG+HChRs7QIw8Qt2mCvUpzIXiEpeLUdZVbAlR
 fydF+r8PO0hHS0z0UeUWhpydwWtjfufE5I4d/sWF3kWPYbFXaferiIahHlwcUND9T6RJ
 V17p0TfTbVh52LAGfLWCpariyiEo4AwhOhmeA+NHWhlqmibudBo9p1FyfyIb/6sXv7U7
 gAqqUvqBSTqlMHL8I+RcsMOwXK8ldQpy6SFQ75hPFQTcYEuZacgRB/Dawu94x6ARfPs1
 4MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698394045; x=1698998845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFGOxRvp86pFFhgzmrint86sZnXr0mAeWAFFTj6s0cE=;
 b=lth/jotXh1m9TpqgjF7p5e7Dsl6R8Mh5hq46TGX+OqJjSyqLX5yi6wjWkbXDmqE1gY
 neg1EBBcU6tzpm0bCKLyMkr+YtV82+CUck71vMKiJiSI+P6sHT9kgSmhwanCEOmmHZqp
 z11vJ3yQlX0jQXeiZgzXGOjo9gvRTz1FSbnyKbGVvKrlUtJI8lmXQndZIBMSkpSJ5j0X
 3UgRfJfgZ+UCkf05qyrAUgakZAlRsFcCmCqGlR7SEm4EgFnjNLWHCIeFXCpFph7i2ccX
 FNb9wkM+Umq0bEbsgpn74roT8pXG1ZW4+Yom3Ik5bY+aH8XmNMHHA2xskHanygwSiFYn
 dDMw==
X-Gm-Message-State: AOJu0YwLTnvIv1MQen4FoBEg1SWdx50EZhMLicTDvztMVUMkEb4XvWq4
 a4bXu2ONc5VP1MWDXCb5gSB8JQ==
X-Google-Smtp-Source: AGHT+IH5o3hmI9GbLBBlntfP9gr3/puo7lVjFBmp6KgbA+px0TOx3BXC61z01JgpkoeMhPOn5R437w==
X-Received: by 2002:a17:90a:69e4:b0:27d:98f3:21a7 with SMTP id
 s91-20020a17090a69e400b0027d98f321a7mr1966591pjj.8.1698394045220; 
 Fri, 27 Oct 2023 01:07:25 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 10-20020a17090a1a0a00b00274922d4b38sm799781pjk.27.2023.10.27.01.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:07:24 -0700 (PDT)
Message-ID: <8247b828-fc57-4f40-8320-a1e2c494f216@daynix.com>
Date: Fri, 27 Oct 2023 17:07:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-16-akihiko.odaki@daynix.com>
 <CACGkMEuA5azGUQzyCe=4xq+YfV60PuiOajhJ=1HOXoG9Gege5g@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuA5azGUQzyCe=4xq+YfV60PuiOajhJ=1HOXoG9Gege5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/27 16:14, Jason Wang wrote:
> On Tue, Oct 17, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net can report hash values even if the peer does not have a
>> virtio-net header.
> 
> Do we need a compat flag for this?

I don't think so. This change actually fixes the migration from a system 
with tap devices that support virtio-net headers to a system with tap 
devices that do not support virtio-net headers. Such a compatibility 
flag will revert the fix.

Regards,
Akihiko Odaki

