Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 248EE7E7BD9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PgR-0003JY-GL; Fri, 10 Nov 2023 06:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PgL-0003Io-2E
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:28:14 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PgH-00066r-5r
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:28:12 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c509f2c46cso26265931fa.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699615684; x=1700220484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x2cJf8U8zq+7Qc886E7RORcVF/kML0kHxdy9k4APJtU=;
 b=lVBjluGrZXpb6ZIladq35o4iVt0n7YXmJnNcOpJp+2rvMpABEri9gY6qawKFTEI6Ya
 ylwKm8nGjZJnjww90KwOn85W9doAFghVfr/BAhuzyBaXUqsyBlgaG+zOLe/1dIFPhn5v
 9SxFUWgye0mN6GMBheqpZOs2kM2lzCOIrpZrPqsbOqvIr2ixtqhdnA4tyn//DEtsxVVv
 tfppk6RycTJ1AeNukvgciFOho8BPKTZl7kO8tAcX27cj0RMg0OoEL5ljty7dhjuY7QZX
 wao85Ck6EaWmwceI9kA4NPp2GjZw++hon+MRlWfypvtkqRkCiFPRtLghcNRozYR1Awua
 w4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699615684; x=1700220484;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2cJf8U8zq+7Qc886E7RORcVF/kML0kHxdy9k4APJtU=;
 b=F0le31Mn7emZfIwiILZ9Lm6ocbjHSEd0orSEJMQ5RvGVZa6VGiwzUvnjVhOIzSYZnI
 bHo1ykr9Ma4C+fZbx6ugofAbIdQ+2g2abk7kmgeJQ7KqjvEfRlMyUppTUgtY7MMhLYvX
 m2mN36DErvf2ts1wKp1wvoCVyVs6t5hHmiZfpcwVfp4o/HrleVmju3anRyBEPiORcvot
 wpox6DEEBrmXRxE8EDjISA6MdUqm+toQSfojc+lz1ABQxWqMyfapJTivzS7GoOTtUlG3
 nIo96G3bw/sNvAUaNjpdTruKFSa29HsmLVAjLxcWfgO+zRQwfHuNydhsemFgXEHCZwbT
 oM5Q==
X-Gm-Message-State: AOJu0Yxyi8sLxQjUleywMtaMFLdt61kVWl4V944wRkIUcye0KRA7Ufyg
 Z00RUY/WFQP24MIQobJglzEXZg==
X-Google-Smtp-Source: AGHT+IEiFxW3X7KRfu9WIpr3bMT8fcKpdAkVBcwny1Vh6H3hpRmcwL8h8kl8KY6lpzxxTr01XRTVxw==
X-Received: by 2002:a05:651c:a0f:b0:2c8:3571:b08c with SMTP id
 k15-20020a05651c0a0f00b002c83571b08cmr384477ljq.53.1699615684521; 
 Fri, 10 Nov 2023 03:28:04 -0800 (PST)
Received: from meli.delivery (adsl-109.37.6.163.tellas.gr. [37.6.163.109])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c138800b004075d5664basm4975761wmf.8.2023.11.10.03.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 03:28:04 -0800 (PST)
Date: Fri, 10 Nov 2023 13:25:56 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
User-Agent: meli 0.8.2
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org> <ZU4R+08zuo8xvlg8@redhat.com>
In-Reply-To: <ZU4R+08zuo8xvlg8@redhat.com>
Message-ID: <3wnuq.xckj65oye27@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 10 Nov 2023 13:20, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>Your approach to the problem:
>
>  if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
>    exit(1);
>  }
>
>is adding dead-code because the exit(1) will never be reachable. So while
>it lets you squelch the unused result warning, it is verbose and misleading
>to anyone who sees it.
>
>Perhaps a more viable option is to pull in gnulib's ignore_value macro
>
>  #define ignore_value(x) \
>    (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))
>
>and then we would have just this:
>
> ignore_value(AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal));

Good suggestion, thanks!

And to be fair, I did put a comment directly above that line to explain 
the unreachable code path. :)

+    /*
+     * We pass error_fatal so on error QEMU will exit(). But we check 
the
+     * return value to make the warn_unused_result compiler warning go 
away.
+     */


