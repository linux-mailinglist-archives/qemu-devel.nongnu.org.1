Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C8A21875
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 09:00:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2zo-0006Qv-LQ; Wed, 29 Jan 2025 03:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td2zm-0006QH-38
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td2zj-0000ar-Dw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738137618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k6U0L8438dCK4pNfU/omhvYd2yRE8ufXDSaTOhtLdY8=;
 b=EOBt5vtdG5ly++wvNiJTqsSg8Oz7voQ14QYWHo21o8eKcGQc0DWNDW3iAPNHU6hFjM9RCN
 qv5tLiqVq0M6v6nkn6j/kVhSoc8aS8s5ITN8mYx8auo048MY7ylNi3MGXCqKCTCu2hcYHK
 j2l7OKdTYgl5213uK3WDnD4X8ogLp2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-qXy7YAblM5qcKrZosN6cTw-1; Wed, 29 Jan 2025 03:00:16 -0500
X-MC-Unique: qXy7YAblM5qcKrZosN6cTw-1
X-Mimecast-MFC-AGG-ID: qXy7YAblM5qcKrZosN6cTw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so33049055e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738137615; x=1738742415;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6U0L8438dCK4pNfU/omhvYd2yRE8ufXDSaTOhtLdY8=;
 b=BHcFXjtxcAtAde82e6QE6kTc/zjSh19mvH+hu0xQ0j1RQvPHeSNJxorIu35OpSq+in
 +2LRhjBTKybQ9mfxmjehHj9Tomn/+bkQdYzOhdq1ONqw1nm9GnC2CGDRsqyks+U0E++e
 TW0kU34FVZzTu/e601xNlSTEpPYdYOZWocBGfeYADxHQ5O45EaUSRFBOJ1LBuNxKOHw+
 PjwieI5t++KeUDrnium51dy82fmS20cfu+CIUva1tYBVo5M3p7Yqa6hDYyWyyRDgzjvx
 0vtkUNW7k61uQvprUGNQTyhwfdVfH9MYJnpLzdPeDUe6avR/6XDVhHAJldtWd+aYBjcA
 dd2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8IzQoNYdvoMam1/pSjg+5eBeQkmhBWxvINC9/uOTL+M8uV+5qaeqsgwcAwZo0JwXM97LaxkfMWVjM@nongnu.org
X-Gm-Message-State: AOJu0Yxn+xjBEQYMUJr6VlWsNVV5mDWqzT7+3y6jpFBXIvq+1Uda6myv
 36ByN39DgFqiWUQ6J1li+nAEixcqq0NiPP6SABzVta/yukn6XakzxJPgkqRgj2tqTU/vpZXFWVG
 ofSqjLhIg9RNb33xQ/+fQFpWblqVKpAGRDWVG3Rj08kKrlojDg82UKFFD5ne9
X-Gm-Gg: ASbGncvPMN8l6PYWEWqgBhXtQw+S70zdjnNuK4ZGKvikpdU7ArvRxIBafiZNbgjMbEl
 1kItuovDwaCeXKRzlr4wyEzBDpvl2gIdf13LZI9OwZ2rmLPi57GdwOeDDhtALSRr/+BeKu/i+Vm
 hWZAZ9ehH1WoQ/yTC2XNUM4nD6hUbHWi4C7u+4cAqMJhOOJWDrY8FTCxynUXDdWm1ss+8EAoNwg
 iZR4M0SRkLrnLD99m+UHp/CHESFA5At/LnropLZQTp5MyxEy0UevGpa79acAQ3jKPJzM1b7eao1
 BZFGzUr3NI9tIFpD+ZPUziuIJx3IMbyLDsGn
X-Received: by 2002:a05:600c:1f8e:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-438dc410c6amr14851485e9.23.1738137615572; 
 Wed, 29 Jan 2025 00:00:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmfniMQgsjRJNKUe00ebJtI1hRjY8gq6KgBwR+jeqUWfs2aKQuHXy6O1hqfHMxdpWPJQeXww==
X-Received: by 2002:a05:600c:1f8e:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-438dc410c6amr14851225e9.23.1738137615257; 
 Wed, 29 Jan 2025 00:00:15 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc3401fsm12989685e9.32.2025.01.29.00.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 00:00:14 -0800 (PST)
Message-ID: <e7111bb5-c2b7-4d38-b7a2-3f196e4a5da1@redhat.com>
Date: Wed, 29 Jan 2025 09:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional: Update OpenBMC image of palmetto
 machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-3-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129071820.1258133-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29/01/2025 08.18, Cédric Le Goater wrote:
> Use the new do_test_arm_aspeed_openbmc() routine to run the latest
> OpenBMC firmware build of the palmetto BMC.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_arm_aspeed_palmetto.py | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
> index 6588c02aad79..815d05a0e5c9 100755
> --- a/tests/functional/test_arm_aspeed_palmetto.py
> +++ b/tests/functional/test_arm_aspeed_palmetto.py
> @@ -10,15 +10,15 @@
>   class PalmettoMachine(AspeedTest):
>   
>       ASSET_PALMETTO_FLASH = Asset(
> -        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
> -         'obmc-phosphor-image-palmetto.static.mtd'),
> -        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/palmetto-bmc/openbmc-20250128071432/obmc-phosphor-image-palmetto-20250128071432.static.mtd',
> +        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81');
>   
> -    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
> +    def test_arm_ast2400_palmetto_openbmc(self):
>           image_path = self.ASSET_PALMETTO_FLASH.fetch()
>   
> -        self.do_test_arm_aspeed('palmetto-bmc', image_path)
> -
> +        self.do_test_arm_aspeed_openbmc('palmetto-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0x0',
> +                                        soc='AST2400 rev A1');

Reviewed-by: Thomas Huth <thuth@redhat.com>


