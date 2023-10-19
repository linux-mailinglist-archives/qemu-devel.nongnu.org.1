Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A77D01A2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXnS-0007Op-Kh; Thu, 19 Oct 2023 14:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qtXn4-0007Bb-EW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:30:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qtXn1-0007Ri-Kl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:30:37 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e07e5f3aso589551b6e.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697740233; x=1698345033; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuthpOigFifRr/eHyXDcT5XPHzWWa4DDEoVevQxnJn0=;
 b=avCUMLSvlyOh6AstLFu8mSvuXAJ5WBmRr8hvNsrRN28I7Dwsr3GhjMVfxCI0w0gjUz
 lYl9lgYns4xQlodwL7+ZDUObBzjc6AvlXANdtPA2YLDfh9C8sMxRGLUZ3NOu1o2xAWhb
 XDTvY7Mai3x9crtrJOPnOArGSX2KDeg4/ndqRkXdr+GDY5Kxr/j8TFQGivKUo4baeyyN
 DERcFBwDPXLb0wDMVsgeGbzcd7mZqJ75bbs37Vqu0SzddKx5190ZF6x4W6kCEnongRow
 /MCkFYgdT2u5D4UwBPC2Jd4EYbk/fgYShtdR0yFsq+9oid5o96Yi8H9HkF7JTziYIuTP
 gZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740233; x=1698345033;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuthpOigFifRr/eHyXDcT5XPHzWWa4DDEoVevQxnJn0=;
 b=LwcpfaYqPPl8U35obrwT86Y/CcUwcDcQEBYOsFZ92q95hnOqwz707N1Ei6PQG0QBjQ
 FaQyJwR8Nh7dn02z+qcEBpGTHF1UpBxjxFg7WbIzUGLzdV3samBhn9o97MrMiZi24tKg
 NyaLETeD0xC6xbCxyvJzVpoYLDRXFcaZdZRsYfkZYMqjftaila1nX4BhIvFqUTR3BN26
 MBflbJVva6fJ8JVgVQBDkaawfYntz43aJ6mxNIWz3QTZ7QhJlBHMeZIEkMinq2lBWLIV
 wGJQAECMLbc5BB7cEiYLd3SOT4vnO+h/L6HXCQruVCWfYxGFZ4VDUWU9FtA1NNiMZvhb
 fHHA==
X-Gm-Message-State: AOJu0YxYnRFbmrrbZTZLW+MHF8QoWw/LCGzNjo499krIWwsuKgSLGq7o
 AD20kKTLylk8ARIIAgxzB8s3YhyPLA==
X-Google-Smtp-Source: AGHT+IEywnFJzb9QSldYxlemYqMmBEcvXlqcx6HKVHTFmWpSc1aOyWfNHxDrmVh6avYs9LKFEXi1Fg==
X-Received: by 2002:a54:4501:0:b0:3ad:fd04:87eb with SMTP id
 l1-20020a544501000000b003adfd0487ebmr1373393oil.10.1697740233485; 
 Thu, 19 Oct 2023 11:30:33 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 bi15-20020a056808188f00b003ac9e775706sm21977oib.1.2023.10.19.11.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:30:32 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:6772:9891:1d85:ff71])
 by serve.minyard.net (Postfix) with ESMTPSA id 179CB1800BD;
 Thu, 19 Oct 2023 18:30:32 +0000 (UTC)
Date: Thu, 19 Oct 2023 13:30:30 -0500
From: Corey Minyard <minyard@acm.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com,
 thuth@redhat.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
Subject: Re: [PATCH] ipmi-bt-test: force ipv4
Message-ID: <ZTF1xtM8upLgM49G@mail.minyard.net>
References: <20231018191123.1176602-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018191123.1176602-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 18, 2023 at 10:11:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We open ipv4 listening socket. But "localhost" in qemu parameters may
> load to Qemu trying to connect with ipv6 and fail with "Connection
> refused". Force ipv4 by using ipv4 ip address.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qtest/ipmi-bt-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
> index ed431e34e6..383239bcd4 100644
> --- a/tests/qtest/ipmi-bt-test.c
> +++ b/tests/qtest/ipmi-bt-test.c
> @@ -411,7 +411,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>  
>      global_qtest = qtest_initf(
> -        " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
> +        " -chardev socket,id=ipmi0,host=127.0.0.1,port=%d,reconnect=10"

Yeah, this make sense.

Acked-by: Corey Minyard <cminyard@mvista.com>

>          " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
>          " -device isa-ipmi-bt,bmc=bmc0", emu_port);
>      qtest_irq_intercept_in(global_qtest, "ioapic");
> -- 
> 2.34.1
> 

