Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E607878D6CC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMjs-00067O-RX; Wed, 30 Aug 2023 11:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMjo-00066r-FR
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMjm-0003Kz-6Z
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4568098f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407844; x=1694012644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5fyGcThDn8eVH7nitI24KZfXMt3WtriFq0jBiA/nXNI=;
 b=Kj/2ZvvzwGPiIx9F4UDUXj5X8lPcYhckXEeg9El/jkyzY0zeOKU9EEb15t892uqUmX
 xbMS0jNSoau5RKrUY3dhsUKA81qbCPhhVsbkIgaVP1x7Nu/n1GKYZf4WffQjlpoSqGS0
 0nNmf4IFWAl/xANN/rf5qNXmYAh3Ujy5MrTpA37rX/u8hIVlGyc3BcAx8zTPiOYG0gIi
 9C3MEh4HSVWt3uJ/AeOnKcmxTb9/zfX8YfqIwsx6FY7IWdTBA35H5d6eeHKSrkGXiBZr
 qMtQpTbQ8z8D9W4HihGHUstjPlFLLftT8lheiRrnEQAszF2qAeE0hCraRA4CCHddV81r
 661g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407844; x=1694012644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5fyGcThDn8eVH7nitI24KZfXMt3WtriFq0jBiA/nXNI=;
 b=By82V4BzQb+kJyaEDPvQEiU2j3MtcsPZb46G0+Zdwou+JpsbquNSIYluIZ+q1nDAre
 AZ6boWZ9m7CWz4kDXQVd27h+M9n/5JC4NoA4V83Q8TdcBUCE3kKAXcbcGbW5ZiBwHDZ7
 VUhZkrtwUedk4By4HC6O6DVPeU5QWCYb24cwfqm4chQNjHIZSeqDJ/Da/yW/GxL5DF+A
 W0tMehKxImbQwqf+knLPP7IpM17iZpYjmjLn1G0n2wYEs5GOkTksNUHovU2L2EnnDSqD
 Ej5VDOp7MIQKYHTAyYGyjkWxgJh/NPdCIHZfwXWw7vT9IJ82vPQMbZksWlHdZLtEIu30
 UvSQ==
X-Gm-Message-State: AOJu0YwwelXmOt1nUlS07WToz8HvoAiezoXSBCJg66qW+2lsXXIukzZY
 qVpMnEDR8hPRuw6QDly+vLYweey17w8tFd/8ZIK9nGEr
X-Google-Smtp-Source: AGHT+IEh3t+Tje3+S9DuMVvwOZ+BwRGuvlmTAqyVKp1Bzuniy0s1+KMxzgK2GFPNy/iCollIkW/tMA==
X-Received: by 2002:adf:fa87:0:b0:31c:6420:ff4 with SMTP id
 h7-20020adffa87000000b0031c64200ff4mr1904557wrr.36.1693407844650; 
 Wed, 30 Aug 2023 08:04:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a5d6184000000b0030ae53550f5sm17020761wru.51.2023.08.30.08.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:04:04 -0700 (PDT)
Message-ID: <98150923-39ef-7581-6144-8d0ad8d4dd52@linaro.org>
Date: Wed, 30 Aug 2023 17:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] vhost-user: hoist "write_msg", "get_features",
 "get_u64"
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-6-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-6-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> In order to avoid a forward-declaration for "vhost_user_write_msg" in a
> subsequent patch, hoist "vhost_user_write_msg" ->
> "vhost_user_get_features" -> "vhost_user_get_u64" just above
> "vhost_set_vring".
> 
> This is purely code movement -- no observable change.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 170 ++++++++++----------
>   1 file changed, 85 insertions(+), 85 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


