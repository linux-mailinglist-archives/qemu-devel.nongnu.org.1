Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA98109A8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 06:54:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDIBP-0001qo-8c; Wed, 13 Dec 2023 00:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDIBN-0001qP-5P
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:53:21 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDIBL-0002qp-DZ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:53:20 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b459364167so255701139f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702446798; x=1703051598;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWgbIQXcdrA/bLxmfZj9PU7GKFOW0Pt/l3KkTEW71us=;
 b=f8QIjxKYFdH3eH0jKJHWGVbOd3xZymbn0AdZweGVNKM61EyEIcKNnzP0zz53UV8psN
 zvunrBlAj7wKAB74263p7VqVXGdcmWBOPSXC1FVth4VTsr3goLW4vrX+MwUW/AwxpiaJ
 jscFSI8Z/SYBuQEqZMZtYZ3gkqujRHTuDXZUo+H/K9qq1j+TUQM4CSHFSkzcHFn1zWyR
 UbXQ2RNKopjkkJr+V+L70OEAFTSATQ3jxz1LXCfWkd/2V81/FejG0HJFBZ4r7nS+R0ZY
 2Epfv2vyIY8QLDX5tJOJCn9PqzcLFofX9LPT6WHddxnK8JOLVZTWVBBf+jJYk44MRoO6
 gl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702446798; x=1703051598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aWgbIQXcdrA/bLxmfZj9PU7GKFOW0Pt/l3KkTEW71us=;
 b=OiJSPalinKg1T7QRj/+QYhPzULg2WyYsp+WDNp0f/WmvtNUmHM2yydrWKKndk0vocj
 eG7+q+1T/L8JkGpsvhErBrG5Uf+wbefRUMekM8wrNwKqYj9QPN0FHRWQOAP8hc1aEdUX
 IG/8zhr7Jrbt/x5hauKYZKlWeC+pUA2yMWWDDRRxsMz3ZROFX00XWgUQYX4soQEhpEvV
 eBtcm8wrsPvHzIJt42q4YMBx7FzajvC5LYrgp+FFUgGyIqAiSGyYpIbSRLb/0/Lie4/d
 oVMcmeGCAKIOsywXCpeMqXm3lcEmEGnEMcq+RjJIFWMZwQWfoUHAGeRdYyOlUN3rNA4T
 nRRA==
X-Gm-Message-State: AOJu0YwwCJST9jFlbKhoZby1tfYhbMRKw9ywHp/Vc9uK0VZpatb5D925
 n41AeWlim9ImTvR6YGtX58C2gA==
X-Google-Smtp-Source: AGHT+IFZ4MIy/Tx3uOtwoFvP0Q3UH61uL8xd/sJhzziUwOCKRfge2NXPVzGTbZDMLCcXdSrSzHWkFw==
X-Received: by 2002:a92:c242:0:b0:35d:53ae:a702 with SMTP id
 k2-20020a92c242000000b0035d53aea702mr8222774ilo.31.1702446797960; 
 Tue, 12 Dec 2023 21:53:17 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a170903235200b001cfc50e5ae9sm9556885plh.78.2023.12.12.21.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 21:53:17 -0800 (PST)
Message-ID: <d27f1e22-7fe3-4c00-ad73-1926dabec30a@daynix.com>
Date: Wed, 13 Dec 2023 14:53:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
To: Rene Engel <ReneEngel80@emailn.de>
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
 <5fcbed94a573a1b3bc9968ef9f72b496@mail.emailn.de>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5fcbed94a573a1b3bc9968ef9f72b496@mail.emailn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/13 0:38, Rene Engel wrote:
> 
> --- Ursprüngliche Nachricht ---
> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
> Datum: 11.12.2023 06:39:35
> An: Peter Maydell <peter.maydell@linaro.org>,  Philippe Mathieu-Daudé <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Marc-André Lureau <marcandre.lureau@redhat.com>
> Betreff: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
> 
> Tested-by:<ReneEngel80@emailn.de>

Thanks for testing.

> 
> This patch works very well on MacOs Sonoma with the Qemu Cocoa output. Thanks
> 
> Since you are dealing with the Cocoa output under MacOs, I have a request for you. Is it possible to use the Cocoa output with zoom to fit in full screen mode like it is possible with the GTK output with "-display gtk,zoom-to-fit=on -full-screen"? >
> I mainly start Qemu using a start script that immediately puts Qemu into full screen.


It should be possible, at least with this patch. Recently, Carwyn Ellis 
added the support for the command line option (commit 5ec0898b0579 
("ui/cocoa: add zoom-to-fit display option")) so your script can utilize it.

Regards,
Akihiko Odaki

