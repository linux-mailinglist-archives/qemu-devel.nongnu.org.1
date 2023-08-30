Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906278D6D1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMke-0007iK-MJ; Wed, 30 Aug 2023 11:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMkd-0007ef-Bp
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMkb-0003VS-5Y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so55816185e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407895; x=1694012695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lo4D0ajsMtKvDbhb4IOaYfbU7CaRun//ff8fdQJDg+Q=;
 b=zpVNqCd1tcbYbBCWxOOm8+dqm71drQNcu5JYHqGtebkuvKVIuhe7MXFvLGl/oHyp2H
 bs8WC4Q32ksND4M21om+DHCHY2azbI2ZYRdpaWE5xUxp4gGRSNq35QxIzCD0V7p6Cdyo
 qtFPzrtv8jeU99M2pwnFwgen9Fyjsz6y1Mqlrdpqvv4innKpzanHIDeRJ8CpXkjKJftQ
 ePSqoW4AJ7iRi4u9qcoJ9iyYevmxBxKQLcJsw98mjz5aNziRiBrYUiob0YHRZmRDIn00
 eMyIxrPORGHnwq18g1uIwx9EE98VDqd7JmiqSGykeHFOKvwIGOKFVBDfGY5eYN+MwGFF
 /W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407895; x=1694012695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo4D0ajsMtKvDbhb4IOaYfbU7CaRun//ff8fdQJDg+Q=;
 b=FVxxwtIj706wfDQUtyG4zCOvIQwGjgqENfuhsybuMOAEKChCxrIdp7npRy5V9Jcp4i
 Sh7UKn+Pmohz0lppbeRZc4TrFkoZMSzmqokHbDcUwCvsqdald/978Xr4G5dyL4mCc8aK
 N+8GiSXhC80OVfBFOyZYC65GsFvbCj7L02jsFjSjWhJ7TkDRsYGTeel9NgOc+5VQE357
 oVElO8HD3V/DI40uJRG//565UwYc0aMyqfUB+LfwHcq3+7ku9w8cirBDfw49/g9mr8Ed
 eAMaUtflXOgP09hzxdNBlB0iJXAtHFNdMCOk7tDRK05xXnXWWL56VcqhHhL2hFVTjOGk
 rmlg==
X-Gm-Message-State: AOJu0YxqTxGCGCtqpOVsQJhMNzeOhO+rAna9niZPQPqXtd2utKCzLVa0
 39IVGwp73i0D+uB0xC8wfSUV3w==
X-Google-Smtp-Source: AGHT+IHFqa7CJNsaFgnOIeRJbAwBy5O9dLKU0sIN2bt7OMQ51KZCtVbG1p1MouhdgZQ7d5oVJuGURA==
X-Received: by 2002:a7b:c38e:0:b0:401:c338:ab94 with SMTP id
 s14-20020a7bc38e000000b00401c338ab94mr1911745wmj.29.1693407895753; 
 Wed, 30 Aug 2023 08:04:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a7bc7d1000000b003fc0505be19sm2536566wmk.37.2023.08.30.08.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:04:55 -0700 (PDT)
Message-ID: <cd0604a1-6826-ac6c-6c47-dcb6def64b28@linaro.org>
Date: Wed, 30 Aug 2023 17:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] vhost-user: strip superfluous whitespace
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-2-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 27/8/23 20:29, Laszlo Ersek wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


