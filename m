Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E383097F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:16:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7eV-0003kB-3G; Wed, 17 Jan 2024 10:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7eQ-0003aZ-CW
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:16:23 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7eO-0006KG-Oj
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:16:22 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cdeb954640so11216101fa.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504579; x=1706109379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sr6SHmCGjvPjehd25HC9gqfOVX2FX/BqLRapK5covM4=;
 b=mEjmHNxPMnU+lE1u65zMSZO30FxXV41GKN42b5zguasJofPo6xKMo+Khb56fprvcv4
 HiNum/pEb0I9jW750sG7f7befhN7kUex5IRNDO3YUGjsuuIuQgqeXq3EzJT+cSZmAmXH
 XqtiHznLI9JYcE3YCi0Rh1nkTGI789qVDs+o+1uFzJIPkwvFZkusr/TIIUlBWUfGAenv
 KScp0cDRLK07+zk2D4oon6E7dCJxRrB13RM9UsIsMCSiM0S7v/xS7EquJ/bhJsSlIFfq
 0P1e0qmI97WGWQPs6z9DlY3j0pBd3hKdJPARSpWRMsTWCRXx4YiQnrG+ZoLHr576UhbY
 iL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504579; x=1706109379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sr6SHmCGjvPjehd25HC9gqfOVX2FX/BqLRapK5covM4=;
 b=QWl5vKEqa5WJLiehQex9uEiaZ2D40165nLuD5weS3SUCpGSnk5E3nkSVbGfZbC6vjO
 faeZIGcNSkiL7LlSG1tbXj5WgDG7wMtEnJDfLe2EKujfEgn4sKor0RmMB5DQacWUaWJ1
 Y4FGJiypIMwQzd0ZmEXywTK6koFhOA1bwqeHEA99Us2xdD6t/GoNKRVgNd93ha7gIajt
 Omy7qaVYCX1NoWjmik2vvxHIhtifI6dmZ1yU0QCv4HcoGA3cBkz2WO2W8WAjp1NfpDOQ
 PJ0uIAy5XiEm4F26E6FvW7kYtF0yeZMI412p20N2Nu/gwPxxABShr3/F8IQI1ms44t5D
 eOog==
X-Gm-Message-State: AOJu0YwpI6mVkyGY6iql/IfGVjLneDe4sUd7v36uzZt0eJ+JLblSopwz
 55rKy/5t54veouDAH4vjqsnOHN8Vh/iGIg==
X-Google-Smtp-Source: AGHT+IFjw6WXHgftBO8lTwKrQ3WXIF7ibuVsH30ImvR56J/7+mDJvJrQl0uqPl79Mi65TXeIzzKphw==
X-Received: by 2002:a05:651c:2db:b0:2cd:a311:6ae9 with SMTP id
 f27-20020a05651c02db00b002cda3116ae9mr3407447ljo.5.1705504578800; 
 Wed, 17 Jan 2024 07:16:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 ef5-20020a05640228c500b00557d839727esm8230579edb.7.2024.01.17.07.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 07:16:18 -0800 (PST)
Message-ID: <0f43493e-84a0-4824-8c02-b5411f0f38fc@linaro.org>
Date: Wed, 17 Jan 2024 16:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240117112407.22462-1-philmd@linaro.org>
 <87h6jchu7v.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87h6jchu7v.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 17/1/24 16:09, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Per commits a9dbde71da ("mkvenv: add better error message for
>> broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
>> py310-expat to NetBSD"), we need py-expat to use ensurepip.
> 
> Queued to testing/next, thanks.

Please take v2 instead:
https://lore.kernel.org/qemu-devel/20240117140746.23511-1-philmd@linaro.org/


