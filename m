Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF07D9DD5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPSs-0004Pq-3M; Fri, 27 Oct 2023 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwPSp-0004PP-Cp
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:13:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwPSn-0007n7-Sj
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:13:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2119760b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698423212; x=1699028012;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yC5na/iyYU6LeLavWOfsx7F5qrkJyOMOjh7da4gf6WU=;
 b=A+WTIQlg8ZG44Pnj9hB4SuqNLkL3kabUlDhIQTqFvKhFXdXntUf+isW4IFS6Jz6/N1
 O13aNSW3PQWzaYTJYnphssvxMY+dhs8Hnu1lFCXyaPIo3hzJnU5At24mUlhvNH6xshkH
 n+WOHifNHjRQ9Tw7y7RGdRroFvS3MXKPMyYycN3LduPX7xKI0HlW8cxRYdJokYpFu2pl
 /TtliqOmmq+SBW91AMMVKR0eexttnXm4piHCeaE8Ccss0VUIF+gDOKimcVMBEIvEoOvU
 dh3kpfq+6P9RQDg1fBDMbInljAA7/oU7vieXs7UVeRWNEMm5gp//PuHtf3eCWh6UJ01i
 IXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698423212; x=1699028012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yC5na/iyYU6LeLavWOfsx7F5qrkJyOMOjh7da4gf6WU=;
 b=S/NlhQ10D4SXwbL319hSFWUs2aKRDhxqUAo3XLF3CsBOPw+zh0X2wErHKhI/95o87c
 YNsm1ot8vEC5vdp1yhdeJ8hbauJ49fgv7QzjMu7dd1QeXlQSmXowvd1T7ktTmD00tlIr
 CY+80sp3movacNqL/EZX89s+o4YM3zRYI+fBvrEeNE2JDrOcYVaC2xg4/JJAD6jmDpPr
 MdPT6SZMezw8qyTM6+pgg3dueDTfYc1OFnyd36+FHWJVrFKPiVWIq9n6S93Z8IXFYQyP
 TCQB2mlJFmoCrYrHcz2QDquq5yspPVSMkFW3jjoLhORL7tB+VrrWJeUmL9lHcM8bl7x9
 OQNw==
X-Gm-Message-State: AOJu0YxZQW1pXv/XfjJz/nCcLBKySuBVwR7Xc/HNDLrWDuSadXNowBAb
 w5IyzYtlGm2F4ytuVfo+eJ1jYw==
X-Google-Smtp-Source: AGHT+IHjHkRvcaGKYKbVeNeQpMtcFj40dGwOXe+eP6Z2edHmUIc2m8EPJCIMYp9AFdyNR33aKuS9jQ==
X-Received: by 2002:a05:6a20:2694:b0:161:2df0:eadf with SMTP id
 h20-20020a056a20269400b001612df0eadfmr2320720pze.24.1698423212403; 
 Fri, 27 Oct 2023 09:13:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa78818000000b006934350c3absm1566937pfo.109.2023.10.27.09.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 09:13:31 -0700 (PDT)
Message-ID: <09a6752e-5dcf-44d9-ad01-03e4863ade6a@daynix.com>
Date: Sat, 28 Oct 2023 01:13:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] ui/cocoa: add zoom-to-fit display option
To: carwynellis@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com
References: <20231027154920.80626-1-carwynellis@gmail.com>
 <20231027154920.80626-2-carwynellis@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231027154920.80626-2-carwynellis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2023/10/28 0:49, carwynellis@gmail.com wrote:
> From: Carwyn Ellis <carwynellis@gmail.com>
> 
> Provides a display option, zoom-to-fit, that enables scaling of the
> display when full-screen mode is enabled.
> 
> Also ensures that the corresponding menu item is marked as enabled when
> the option is set to on.
> 
> Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>

Thank you for contribution.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

