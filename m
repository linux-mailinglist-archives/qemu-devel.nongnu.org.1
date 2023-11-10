Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C180D7E7B97
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PHG-0005M0-C8; Fri, 10 Nov 2023 06:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PHA-0005LM-D0
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:02:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PH6-0008Eb-24
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:02:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083f613272so14699665e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699614125; x=1700218925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cQlg1PFbziQhy1MSqYIFuEQXWN8xizhWbYBQqbezDhw=;
 b=eaxM+EXOC9qxwt7GtuDQ/AJAm2BMdl0H204nmhU+f/ag9d8/Qkth3m0BDux+BJpUbg
 Ub9449ZTFK0O8ZsRkTMimQNO+nWRD+d8BE4AOxEd8rBrttYf026Ii2uHxEEA9bM54dOt
 QQxVtuFo57wjStlsaqXmxRC63c6Gxoyum1X46FzZ701xUAwKsDq6fHjwgWTS6WstWy8S
 9g44lICP4ES0AoF1R3dwD+77gysCUfQT8hHPPuhXZHyQVsKs+JxzGsHKCXvODhMGdL1k
 ObQ9EWHUt5Cvt5/5Dk3l6QQ3fPB+5zpdovSJTQdo0/Liyf1HovGwoCUjuFsVCbuAvBU7
 NO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699614125; x=1700218925;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQlg1PFbziQhy1MSqYIFuEQXWN8xizhWbYBQqbezDhw=;
 b=KAL6MuALvpiXX9dA3rwQd7UrxRjFFaalhtpjYJKWqRKFtX0kPqn7KfvCjMsfDASNsW
 JSk6ST3R81FqktBc2I6AFYg5vIvzWImAma6VtGhX7dDDvJ0XsTPSfiQHrGbnXQPQ8b1B
 s1zspkDnBbzNvWYccIHMJQeRm9QY3gZQ9QqgaO6Itrp2JcmfHR6/D+T7JeUyRVe/27in
 gp0JEJGGiqmq42EcmESu5F2QlmcLfvDYiBf/NejBbwifI+k7L1vN9pN9+/W0KUh0wE0M
 Ixhf/UtKUlNaslMH96zqoaEntgziF8R2yVYTI+dj6oFGAZNK3kCZM6hwV27TMy8dvNM5
 ESnQ==
X-Gm-Message-State: AOJu0YxKQQYBzBTYJkEIs6xGNdEI0gVhGJ9aBOt/TZGzQGRnkNFA7k0l
 GP3XxCbJi0nYEjoHMhleecpfnQ==
X-Google-Smtp-Source: AGHT+IEoVM6Yzg8L7rUqKEYK/hzyoO+SZx6hpQjvEASK3RR4MK51TF7HoQLrXdPKmYsVKWZyH0QwGw==
X-Received: by 2002:a05:600c:35d6:b0:402:8c7e:3fc4 with SMTP id
 r22-20020a05600c35d600b004028c7e3fc4mr6470094wmq.30.1699614125041; 
 Fri, 10 Nov 2023 03:02:05 -0800 (PST)
Received: from meli.delivery (adsl-157.109.242.225.tellas.gr.
 [109.242.225.157]) by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b0040a4835d2b2sm568664wmb.37.2023.11.10.03.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 03:02:04 -0800 (PST)
Date: Fri, 10 Nov 2023 12:44:56 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Marc-Andr=?UTF-8?B?w6kg?=Lureau" <marcandre.lureau@redhat.com>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
User-Agent: meli 0.8.2
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
In-Reply-To: <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
Message-ID: <3wmne.fhuf28sb5yfg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>This kind of thing is why Coverity's unused-result warning has a
>lot of false positives. We shouldn't introduce extra code like
>this to work around the fact that the tooling doesn't understand
>our error-handling convention (i.e. error_fatal, and the way
>that some functions report errors both via the return value and
>also via the Error** argument).

I respect that :). But I personally believe that clinging to C's 
inadequacies, instead of preventing bugs statically just because it adds 
some lines of code, is misguided. Proper code should strive to make bugs 
impossible in the first place. At least that is my perspective and I 
would like there to be constructive discussions about different 
approaches in the mailing list. Perhaps something good might come out of 
it!

