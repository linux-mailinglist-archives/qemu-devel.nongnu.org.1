Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB381BFF2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQSC-0005Ec-Vz; Thu, 21 Dec 2023 16:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salvatore.bonaccorso@gmail.com>)
 id 1rGQS9-0005EF-6y; Thu, 21 Dec 2023 16:19:37 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salvatore.bonaccorso@gmail.com>)
 id 1rGQS7-0005PP-JL; Thu, 21 Dec 2023 16:19:36 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso964272f8f.0; 
 Thu, 21 Dec 2023 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703193573; x=1703798373; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PnJAVn4lpc6XTszTsAdWnPgcexKZYozKwhfTNlkprnM=;
 b=Q+Wiery1b8+xgibL1UwIkme6RnsJSx43IqS2v6RBvUikDpI5ncKRrKxz44Vca+D1X1
 bUTAR6U3NajzzkPjTyEbclL/BTEmYsgl8ivZhA3RUctZrSn4ao2g6kKveqo9qk548+Fz
 4E0XXsg3fxckyAocVqrGuHaeGQnI/3z/fk9wFfBHImBxs2+0zsFWipKh+S1ge7QVx6e0
 AE8yDZwFi6zuBnRXu7rKcs3RJg5RorFWp8RI6c1YifibIikDVVRCNHJjTGYAhfSLQdtX
 sS1CPglIZLUNrzNcMrixw9YIRQ+vdf2mkc/+e1es3y1nZipRgjcZqoBbsKK6EeWvqEWM
 DSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703193573; x=1703798373;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnJAVn4lpc6XTszTsAdWnPgcexKZYozKwhfTNlkprnM=;
 b=uT38IVRqyfcv9PGPyP0zhWqovExdiMV9+VtcKsgAgBIu8GZdfn0P1JTVNHxDpvhjCi
 Zxty6BTzDeg4KvMQmjXADfbukz44CQaJSBZXodmkfyRukam14jHB+mfGsm1HXJTm/asy
 aGP9x87MB3sNKduvRY3Cw6NdR9yndC2POfc6jqtSlfORbwoGBRTgJDM7Zl8lgJg+u+4r
 0DLwpjcrxVAcKOLF13VHvAq14I5QkSGIk3IHW0K7BC7RUKoV1oj/ZubSKHjIVnCjIWEQ
 dLHEw3/tnmnuRWSgkfjIlX7GkAYC2CLI1gM10ysDqXCM0HiTM5iVtF1fN4fASPzhIr/I
 NBAA==
X-Gm-Message-State: AOJu0Yw+A/lX8yvk+O66PY6x45AGRusJXrAJ2dla5zR209VCbo/gPNKi
 M3HMyxN0+qv+gGpJdQWDHVQ=
X-Google-Smtp-Source: AGHT+IEnMEb8Y7zvRz55jlC/0w0sfElJrbptNzNzk2ZT8XIC9acKhhV+WZNOzKDt5+aBUCTVt9Es2Q==
X-Received: by 2002:adf:ef43:0:b0:336:7c51:7380 with SMTP id
 c3-20020adfef43000000b003367c517380mr183032wrp.143.1703193573121; 
 Thu, 21 Dec 2023 13:19:33 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch.
 [82.192.242.114]) by smtp.gmail.com with ESMTPSA id
 r8-20020a5d4948000000b003367a5b6b69sm2795502wrs.106.2023.12.21.13.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:19:32 -0800 (PST)
Received: by eldamar.lan (Postfix, from userid 1000)
 id 05476BE2DE0; Thu, 21 Dec 2023 22:19:31 +0100 (CET)
Date: Thu, 21 Dec 2023 22:19:31 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/3] Memory/SDHCI/ParallelFlash patches for v7.2.0-rc0
Message-ID: <ZYSr456CZ0p_X9wv@eldamar.lan>
References: <20221108183352.9466-1-philmd@linaro.org>
 <CAJSP0QVdQ=wTtgNVDChzu5U1ww3SZAa2HfXjuE4z5uOnFeT_bw@mail.gmail.com>
 <CAJSP0QVZ8D59AM_tvgHzdhqF6EUefUgmyD9WMtfPUD=nn54v+g@mail.gmail.com>
 <898348ed-a9bf-5e4a-d389-b60a456ccaba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <898348ed-a9bf-5e4a-d389-b60a456ccaba@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=salvatore.bonaccorso@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Philippe,

On Wed, Nov 09, 2022 at 08:43:19AM +0100, Philippe Mathieu-Daudé wrote:
> On 8/11/22 21:57, Stefan Hajnoczi wrote:
> > I've dropped the SDHCI CVE fix due to the CI failure.
> > 
> > The rest of the commits are still in the staging tree and I plan to
> > include them in v7.2.0-rc0.
> 
> Thank you Stefan, sorry for not catching that failure sooner.

I was looking through some older CVE's for qemu which are tracked
still unfixed in Debian and noticed CVE-2022-3872 . Do you happen to
know if the fix for CVE-2022-3872, the dropped one above, was ever
fixed in another way? Or did that felt trough the cracks?

Regards,
Salvatore

