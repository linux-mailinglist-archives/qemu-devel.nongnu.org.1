Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A883889B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:12:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBtN-0004jG-2J; Tue, 23 Jan 2024 03:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBtA-0004if-ER
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:12:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSBt7-0007Kw-VP
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:12:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so39563585e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997524; x=1706602324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ODJFQOxBVEWhx9Aa26VlIbHrk+AUrsIj2R+9Cuca0SQ=;
 b=e02agMvqiuBj6P1Biz/wGW97/IZPTD4CK5ld00P84uuYKd85ST4uZHbvmuYZzOy41k
 lALxso2ACZkCj/wEzWB/emCVNGA/OifuGPKLF5Wt7XWusV+7zqu0mEzEvg0tZgcL5aWv
 vdEjM0ZQV18LK77qsdkHO4L6tAHw7jMozPGIRh9y0h3ogymk8hixeB3ETQtt6Yfofc17
 uDMWhpLlk0swhHmQgdzUYS5WmNYLZ2CpJnd3v/DzptFFcnfRfDtWmWHqeWZpObShawec
 Dkb9zdQTXE9m+JAgkBhNfBvhfCnyn8rpxEs1tDfsqhhrnvQeGKU3AyMj1Ud9hbmziPWQ
 yVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997524; x=1706602324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODJFQOxBVEWhx9Aa26VlIbHrk+AUrsIj2R+9Cuca0SQ=;
 b=ZMALunTbDAn+F4a+YNmPIwlVvGboP6XO5A3bej+KUhR62S3A1wjx0MajcJqeTwLL8r
 K0fn1a0epT57ZrbXinTuc7/yGyZd2eg9ZtkArFbBuOdriNcTRUabUr39LLTSZ3iCB1Ae
 3ls5+WEbrZ20UKDH0J2zQtIYi9E856Q6MYcfO/dQEIcK11iMVZFIRjkttPbR5BC+rmvL
 Pk42u8/Y6uyJsWhKQs7JxIjJL/Iv1AmpbAM63c+4TqE1J0sDsVHzB14lSr70jWsRHWrS
 sR3e1GeycaCC/3BTS8AKsdsVU5ZdmigeZQNpVQL7exE7JhtZjswm2wJg/yIq4U/ariZy
 bqpg==
X-Gm-Message-State: AOJu0YwyimhKW0MsHUvX8taGFup07bXkO7yI12yKF37NibnVVwAvdSZp
 TtLt+ZAhS+FZpjL9VTTtcUvJrJpXypFNDYspWe7cmeCtAAwKjgE7lp/nAdNCqic=
X-Google-Smtp-Source: AGHT+IEIwWT7eBNB+sezhiyllqCM+0QFz4VFqa/LG3guvcHFq5vnadSS50mRPbIwU4Ny3NOgW0MFsw==
X-Received: by 2002:a05:600c:a4c:b0:40e:ae0b:62ee with SMTP id
 c12-20020a05600c0a4c00b0040eae0b62eemr263413wmq.56.1705997523717; 
 Tue, 23 Jan 2024 00:12:03 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c1c0500b0040e9f7dadc6sm13862021wms.25.2024.01.23.00.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 00:12:03 -0800 (PST)
Message-ID: <927c417b-d3b6-433c-b63d-335e85df9666@linaro.org>
Date: Tue, 23 Jan 2024 09:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/block/block.c: improve confusing
 blk_check_size_and_read_all() error
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>
References: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
 <e3701762eddf0a58b32ebac7d4c8330e792a2401.1705938003.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e3701762eddf0a58b32ebac7d4c8330e792a2401.1705938003.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/1/24 09:09, Manos Pitsidianakis wrote:
> In cases where a device tries to read more bytes than the block device
> contains, the error is vague: "device requires X bytes, block backend
> provides Y bytes".
> 
> This patch changes the errors of this function to include the block
> backend name, the device id and device type name where appropriate.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/block/block.c         | 25 +++++++++++++++----------
>   hw/block/m25p80.c        |  3 ++-
>   hw/block/pflash_cfi01.c  |  4 ++--
>   hw/block/pflash_cfi02.c  |  2 +-
>   include/hw/block/block.h |  4 ++--
>   5 files changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


