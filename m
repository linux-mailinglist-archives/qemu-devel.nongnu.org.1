Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E247B7E7BDB
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:34:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PlO-0004hH-Va; Fri, 10 Nov 2023 06:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PlI-0004gJ-TN
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:33:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r1PlG-0007P4-Nd
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:33:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40859c464daso14480375e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699615994; x=1700220794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N9RRjo0H7ohPMN50cLmaMghwMlykvqa2DWQuM/AlxhE=;
 b=lpLzH6ghRlUR38FVa1ED8/9BWWg5tGfeYEhcIOMgEVpeK9jSuUvHY9BJ7UY1IER/qS
 UBlK1rby9dhrCHpOyizWmOhMUz9xZ+t+716wHcdB2nLWRCLLpIl+entOZPLo8AZIS7H9
 oDQJQXO0A25b7Wer9408fsAmM/8G8D2RnecTL+MtDki2G1wvzj2jSUrm7lV7CJ88beKW
 1YBsEdZTMtUneiZdIiZj0ljgfarSThLrsn496XUfkyC75cwSir/kurquQAIXaAyi0I/N
 rGZa79eSShbPSvuqcWV0syEQyP2PydjC8+6CD3TFX9hcnv5dzr1iTIoSJfikF60wQ6Rm
 l4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699615994; x=1700220794;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9RRjo0H7ohPMN50cLmaMghwMlykvqa2DWQuM/AlxhE=;
 b=nG47N8UntsmnYSACSooUORAhpubKwu8+2sCgZ5/qFFeW4HE6RqBoNxGK9f4oGTq/Zo
 A9q8NdV2PCpJmAAEWTMG2ZRPWWDxvmo6vn7V7LnxkAGVoHbXBuAlUjkFRjntkoLQrxMP
 Q+U6+4kwCmsB2h+PqamB8k+ihGExUeeTjMJw3COJwAthDx252vuwtdj0Yb/Ck5WbNezt
 PrR6XF1/KCvPjDS34KZisS6d0fNNt9dc/II5oqQ1cq6VHYkZ8zyWnCzjbSOqesQD4LMb
 6I3SmywaXJZrqnDB5TGYoKl9O3dkDv62HNAQXUwOuV+yP1MbrgkeVk0WVUwJM5vJvDwq
 lkTA==
X-Gm-Message-State: AOJu0YxhSRahUQLB6fIIbrRjbetvRlek1rCI55YYFX0KZsC16MH0Bx+c
 TtUbgkLjxYhaLNIJyWPn7Rtjyg==
X-Google-Smtp-Source: AGHT+IETydfU1s7L52ySs5hwWyHooGQ9ot1TOFqefxINI9gvE6d0ep/qBrJJikE326YkA8+z9+PijA==
X-Received: by 2002:a05:600c:190a:b0:40a:4609:9cbd with SMTP id
 j10-20020a05600c190a00b0040a46099cbdmr1129318wmq.13.1699615994588; 
 Fri, 10 Nov 2023 03:33:14 -0800 (PST)
Received: from meli.delivery (adsl-205.37.6.2.tellas.gr. [37.6.2.205])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c445300b0040813e14b49sm4988328wmn.30.2023.11.10.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 03:33:14 -0800 (PST)
Date: Fri, 10 Nov 2023 13:28:14 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
User-Agent: meli 0.8.2
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org>
 <CAFEAcA-mSBgLuGLp4Tzaq0L78PtsxF19CVfmkJwaM8pHfwv7wg@mail.gmail.com>
 <ZU4SmH8LMGVJmGZp@redhat.com>
In-Reply-To: <ZU4SmH8LMGVJmGZp@redhat.com>
Message-ID: <3wo3c.z2jjrdl2xn4i@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

On Fri, 10 Nov 2023 13:23, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Fri, Nov 10, 2023 at 11:18:39AM +0000, Peter Maydell wrote:
>> On Fri, 10 Nov 2023 at 11:02, Manos Pitsidianakis
>> <manos.pitsidianakis@linaro.org> wrote:
>> >
>> > On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > >This kind of thing is why Coverity's unused-result warning has a
>> > >lot of false positives. We shouldn't introduce extra code like
>> > >this to work around the fact that the tooling doesn't understand
>> > >our error-handling convention (i.e. error_fatal, and the way
>> > >that some functions report errors both via the return value and
>> > >also via the Error** argument).
>> >
>> > I respect that :). But I personally believe that clinging to C's
>> > inadequacies, instead of preventing bugs statically just because it adds
>> > some lines of code, is misguided. Proper code should strive to make bugs
>> > impossible in the first place.
>> 
>> I generally agree. The problem here really is that we've ended
>> up with this odd API convention that reports errors in two
>> ways. In an ideal world we'd tidy up our APIs to report errors
>> exactly in one way (presumably via the Error).
>
>The compelling thing about our slightly odd &error_fatal/error_abort
>approach is that we can directly get stack traces showing exactly
>where the error happened.
>
>If we just propagate the error up the stack to finally exit/abort,
>the origin context is essentially lost, and when it does abort, we
>don't get a snapshot of all threads at the time the error hit, as
>we've moved on in time.

FYI: It is possible to get a stack trace using gnu libunwind which is 
portable, dependency-free and runs on many targets: 
https://github.com/libunwind/libunwind#libunwind

Or llvm's libunwind which is also of great quality: 
https://bcain-llvm.readthedocs.io/projects/libunwind/en/latest/

They are also compatible with co-routines and JIT code (At least, the 
GNU one is, not sure about llvm).

