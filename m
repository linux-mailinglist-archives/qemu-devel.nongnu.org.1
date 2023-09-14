Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEEF7A0DD1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrdJ-0005Ga-0Z; Thu, 14 Sep 2023 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrdH-0005GB-FM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:04:07 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrdF-0000k8-Jm
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:04:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so177052966b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694718243; x=1695323043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIgAuFH+zZRgmWQEgYSlhZfrZzcgQ9BqXmtZsGYyQg4=;
 b=I6VPTjdaB0DyarKT9zQxQ8DhF6JXBROFcVhpMLgE8Qh9AbOADpxhYIi+JbbHhhPK+Z
 eiCBqK6g9Lje5t7tX01IBHVoaOToFRSg02znjh/7FjhHO3YUNejSMLOPTcRGcA8DYvk3
 j3tE8kO1zF6ekFWLxByXAMqoAFOBBjmIX9nZC+cwpsbou95HnUElbRWESYHLAKxEjCjx
 mtLpqGTtB0MqZeG3s3xkScXjS+Smn/pYDdnc3OiP5qgGSHERHdVup1L4D2j56TeTtlw/
 tBwGky4kS0H+rRZWwwo2QKpnFZsmVDbWBWVKg4gPXAsJ13v4rCs0T7oS3W+skW/+mRuG
 W5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694718243; x=1695323043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIgAuFH+zZRgmWQEgYSlhZfrZzcgQ9BqXmtZsGYyQg4=;
 b=oPMMP15OpWP26W/EJDXQLBL+kwd/tKjpAN0ofM43ksLsE+JcCxWJ0W7oCxJAHNh2yB
 zFmLQvZt+nApNODSrm55tDi9Ftg/pKVbx0N2HtDJnqmo6k9wlJx2Bv+iV46DZctSiVHQ
 ShmQlGbSH84HK5ICvpfqnfChnCa7o36ghMavcynpB8Xa+H98PuytRLeOEjEFo+hOypmI
 o0L/xBg4gIDorUuqttVzUq2F1QOuPo+LCq8M11oKX5pHv2wQqSX8ukWAssM19wGJl428
 SsPCCzWOQPPm9BcnrKhAWDzgIik7nTvbFaoOKXy9EMXuBz2QJoBQuX0DwX7ZYRnareZl
 oSxA==
X-Gm-Message-State: AOJu0YwZnz2N93+M4h/TMV7GAen5Y4K1T9wX7aWj1blOc1m248di2HgW
 QOxOsaViQnV0AHkAD1bv8x+wlQ==
X-Google-Smtp-Source: AGHT+IEz2aXON2Mu9GVT/U0FObZjIkrnlt74BWqlrOqJFj1xgW07QioI4/kNQtgWck18W0jhj0z9wA==
X-Received: by 2002:a17:906:53d1:b0:9a9:e735:f621 with SMTP id
 p17-20020a17090653d100b009a9e735f621mr5084389ejo.15.1694718243607; 
 Thu, 14 Sep 2023 12:04:03 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709064f0200b0099bcf1c07c6sm1373598eju.138.2023.09.14.12.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 12:04:03 -0700 (PDT)
Message-ID: <39f8528a-9f95-3bc4-07c1-91f705c7bb10@linaro.org>
Date: Thu, 14 Sep 2023 21:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Content-Language: en-US
To: Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com
References: <20230914175835.382972-1-tfanelli@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Tyler,

On 14/9/23 19:58, Tyler Fanelli wrote:
> These patches are submitted as an RFC mainly because I'm a relative
> newcomer to QEMU with no knowledge of the community's views on
> including Rust code, nor it's preference of using library APIs for
> ioctls that were previously implemented in QEMU directly.
> 
> Recently, the Rust sev library [0] has introduced a C API to take
> advantage of the library outside of Rust.
> 
> Should the inclusion of the library as a dependency be desired, it can
> be extended further to include the firmware/platform ioctls, the
> attestation report fetching, and more. This would result in much of
> the AMD-SEV portion of QEMU being offloaded to the library.
> 
> This series looks to explore the possibility of using the library and
> show a bit of what it would look like. I'm looking for comments
> regarding if this feature is desired.
> 
> [0] https://github.com/virtee/sev
> 
> Tyler Fanelli (8):
>    Add SEV Rust library as dependency with CONFIG_SEV
>    i386/sev: Replace INIT and ES_INIT ioctls with sev library equivalents
>    i386/sev: Replace LAUNCH_START ioctl with sev library equivalent
>    i386/sev: Replace UPDATE_DATA ioctl with sev library equivalent
>    i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev library equivalent
>    i386/sev: Replace LAUNCH_MEASURE ioctl with sev library equivalent
>    i386/sev: Replace LAUNCH_SECRET ioctl with sev library equivalent
>    i386/sev: Replace LAUNCH_FINISH ioctl with sev library equivalent

There is still one ioctl use, GET_ATTESTATION_REPORT. No libsev
equivalent for this one yet?

