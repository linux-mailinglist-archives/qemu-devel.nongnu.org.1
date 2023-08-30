Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771AE78D501
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbI2g-0002Kt-B4; Wed, 30 Aug 2023 06:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI2e-0002Ki-2u
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:03:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI2b-0006Kf-Sw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:03:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so47632785e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693389791; x=1693994591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VikBQNk4x9z1E6zjThugeLcas3G1uXQg6G59NfSVcaY=;
 b=kVj1CB7fSmh329PpAwYb8kV/yXVAPrKIW8r16vv3o1q3GVmKPvy7sBxSYi7zUYX8AO
 cqx0ptAW1MnQew5M7+Cqk85ii4RwPQ5Jr9N43eSCk33dzp55jhv5yYQjXl/dbf3cYkSw
 wjEVUYPkJqiRsmamd8MoDLWcJsk9M3ZKA5FHZ6nvrRG4iUQ7oP6mEz/W+MG6z+odYwuy
 6tj2dRDlp+NIXcWhFuY9VwRVwk/NSH1BxyjFKgJLaF6RhhVoWdICPeQmNQJCReaAwElx
 5GGMrdl1gx/IbZwX56ec2UYXlgTFN8NcZh+1JeYIUV06cpUI/yjhUB6GAOhp2QDRwu0/
 rEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693389791; x=1693994591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VikBQNk4x9z1E6zjThugeLcas3G1uXQg6G59NfSVcaY=;
 b=HkkRBzmh8CvU7lAghniWMq3ZKA+x9DdiayVTl/gZwrNsyAt+wqTjCCWk3sFd3xeI4P
 c8fnGFcsE3ySXGa5V1HbH1P+RZZxD/XDFlfwm9x1os41y+/VSgAF8zSVPq0D3cEZqaDv
 QjNbhxWGKT6o+X+c9+OF0RnYfCUBx+sREFCHF+rOjsaG14CjS8iwgk5Yo7ibc349AKG7
 /lWb8rDS8GudTmJqcUf690tzqUaRE/6Tr9j8Wa5zqS95OKGr40jvMzrNw7tYm4ceZcBE
 ToWRCU0CGXf+rgHAu3cuLjdAr2r99v3rRQHl73XnlTqqUqiXRA8h8tdDUpyFEXYokAme
 wEcA==
X-Gm-Message-State: AOJu0YwgO9zXTgVI9DGG/N1NpYqv7fOYytRC+37P804GhOwM23O8+DX8
 D0bmsUn2ydKQ2VItNyZJqkN0VA==
X-Google-Smtp-Source: AGHT+IHJ15dOzJBV+4qabphcH46tI/St2+MLkyvBr+osdZID8mpXCy337pMVy/hUBA5vtFx4oQYn4w==
X-Received: by 2002:a1c:6a03:0:b0:401:b652:b6cf with SMTP id
 f3-20020a1c6a03000000b00401b652b6cfmr1481919wmc.13.1693389791381; 
 Wed, 30 Aug 2023 03:03:11 -0700 (PDT)
Received: from [192.168.18.115] ([91.219.21.246])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a7bce12000000b00401dc20a070sm1757976wmc.43.2023.08.30.03.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 03:03:11 -0700 (PDT)
Message-ID: <6a287daf-0ebd-1cb3-417c-19eee300b2da@linaro.org>
Date: Wed, 30 Aug 2023 12:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 01/67] ui: remove qemu_pixman_color() helper
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-2-marcandre.lureau@redhat.com>
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

On 30/8/23 11:37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Usage removed in commit e27bd65a72d ("console: switch color_table_rgb to pixman_color_t")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/qemu-pixman.h |  1 -
>   ui/qemu-pixman.c         | 11 -----------
>   2 files changed, 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


