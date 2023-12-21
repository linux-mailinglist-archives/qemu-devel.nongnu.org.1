Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A581AF51
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:21:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDLY-0002pL-Iu; Thu, 21 Dec 2023 02:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGDLW-0002om-1R
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:19:54 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGDLU-0000qP-9G
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:19:53 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d411636a95so1186006b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703143190; x=1703747990;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PyChh9b8cOsRTm+g7900ErTVdcZiUgG3XQikWrab3KA=;
 b=17CjTKbfcbescuIgzjMu+2+zG+pAy1tCaOMETD2Zu69cSPKsmi9in1gFjEWck5C8DK
 NQ1SoXK1i8xodWRFJIALAgh0ht4bcv4oaVfigW/l9DhL3pfSobq1eYld4Y8nqwa309Wl
 DOeOUxVApRpUFFzIAsEh4EjnxWdowIFEzOQLpiVRC2H1urpb4n72Z8cI7j12NgHKujSg
 lL+vgoInldcnq3SW44QS9suiRFC/oMQj4khsi2GyxN7Q32iyFvFmEwkjyCUfN4b3yVit
 ygMDCItYxcJDkZnkF6hI7uOaJO+sBg/57RPE1ZwJ7Q8X0QqrfnaXxuVc1UTQDFp88oum
 RRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703143190; x=1703747990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PyChh9b8cOsRTm+g7900ErTVdcZiUgG3XQikWrab3KA=;
 b=cjloIs63zm5ZhDRSOC9wQcjxX0uaTd4mKHR5S12+WxorTJQMha3rfLf3ZAG4gQ/DfH
 mO+MdHeT7uUtraSxafBPw0+C/90r97TDOZ77NeCS7OrOiTazt7Oh2uEkkTzB/y8LChSj
 RKWpUjWid+CKWaZO5dr5vd5a519M5SDMlLh4SCSbAa2LIdyjZmEQytuVGvRpuz+a7tI+
 5OVOG05JLIOKCOtPrF/yks25W/9Tlz6HDPErztmI73hxPDoSFUmiu1OBwyvke2KObAQ8
 7ZeLQW7RcUK5LHO/3eckoqnkbVGb5UrxaTezB4IJ/QnJST88YDTzCZPczQ97ewEGZU6K
 vN5A==
X-Gm-Message-State: AOJu0YwxKXBE0usG8ozPI5HKqiO6QqKpXQ4zGQkhzKe1KYV4zOA+uCVE
 nxUgN8aIJXhJ4vJqXvjGRA7y7Q==
X-Google-Smtp-Source: AGHT+IGadR1ndrDaRSIXWGHSqYDbDBYyslmEYT3QVKzwmtojOmPjqmaDo5AWZXupEQXJS5aEvcaVGA==
X-Received: by 2002:a05:6a20:4b12:b0:191:e96b:ed08 with SMTP id
 fp18-20020a056a204b1200b00191e96bed08mr283410pzb.61.1703143190604; 
 Wed, 20 Dec 2023 23:19:50 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm894612pfi.168.2023.12.20.23.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:19:50 -0800 (PST)
Message-ID: <6e375f20-161f-4e11-b42e-23746faff02f@daynix.com>
Date: Thu, 21 Dec 2023 16:19:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
To: Marek Glogowski <smarkusg@gmail.com>
Cc: Rene Engel <ReneEngel80@emailn.de>, peter.maydell@linaro.org,
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
 <d73b8c8e-fde3-49e6-88b8-8f9bfa248509@daynix.com>
 <71895f08af8ba9f01dd78da158005229@mail.emailn.de>
 <2a775be4-363a-4e85-ae32-97ceb5927e11@daynix.com>
 <DB8CB49B-092F-4620-B8AE-67ED92059544@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <DB8CB49B-092F-4620-B8AE-67ED92059544@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

On 2023/12/20 5:06, Marek Glogowski wrote:
> Hi
> 
> For me, the problem does not occur if you use the maximum screen 
> resolution available.
> For me it is 1680x1050 - everything works fine.
> When I change the screen preference to a smaller screen resolution than 
> my maximum (1440x900,1024x768 ...) the mouse starts to malfunction. The 
> mouse pointer works strenuously and with a delay.
> 
> Checked on the current version with git qemu-system-ppc AOS4 with V8 and 
> V7 patch and the older version qemu-system-aarch64 Linux/Fedora

Please tell me your whole command line. It is also nice if you test the 
combination of  latest QEMU with and without the patches and Fedora.

