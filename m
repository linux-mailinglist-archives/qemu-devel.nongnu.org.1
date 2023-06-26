Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5D73E0DA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmRW-0003pQ-Jp; Mon, 26 Jun 2023 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDmRU-0003nG-A1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:39:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDmRS-0002lC-Ny
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:39:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3094910b150so4015877f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687786780; x=1690378780;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYlqp6bSyNUeGVCmZUFjAcgEhzBMjmcZS1Ze0HZBmTU=;
 b=XVsVb4P5xcmqQBEQCLywl6GCvOApuGJveo4oIfpbBS+BLpWgRnzHe9NFhnzXAcjmX5
 oFGXLyqfAocfao8A8jG5zEOhlC7QTxenGOmm9JfZ8zfxozndGEmW2+N13XSVTmUpRer1
 QFTbSkYqaW2i/c7qVlZN6WTpx5vWDkNjLfok9Rl2r3jKFWkG1IPTBv1Ce3SN9aG5iGBI
 7gQVDQygbuTUdRTdpRGtTI/5trUp/6bh8Dje5kr/p+zZIbiUynHNT3D2YUco5uPWs4ip
 fL7B8/k0+wI/hxOb0L/H2913TRoVhKekdzfrF3z2agC37bXWjK6BVK8mLj4EEiO1n97/
 pZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786780; x=1690378780;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KYlqp6bSyNUeGVCmZUFjAcgEhzBMjmcZS1Ze0HZBmTU=;
 b=Rf9W2lqlm9yV0BHUlvkqyKJhxoyC6hqq/FCcKRqY5yi3PRvEOR5HXxyNaYOuT0kmQ/
 BaP1UgNYeiUbMrYJJAPCawE2N+ryBtI8+I6aIUFT0wfxGgLGA9W7ZTZdDJsvm93Ph9dy
 NKK3xfKBZShuv7pERGNKQGXFuIdBWz7s4UcrW5v1KDnf3TnNT9xyA2U37+/kpe5sIEiN
 PNQFFHXIO2iLLKvfLe9LnbSPKag4ySZ7L39FsaZGFqujFIimJkw4UQWX0CF40aHui1NF
 /NWy4W7gexTFTnM86XJhcAHMeboQyKyY4+bXHc28NaeN+gah6AZxC1nYiKrBVZcgpDjP
 +dBQ==
X-Gm-Message-State: AC+VfDxmwFjkTdTsI8NQzjpDz/KWeiLyVuCWD+oM+v2V83E5md9rU2IE
 n55TX4YPuhLsRmQ1Wvo5XfAfNA==
X-Google-Smtp-Source: ACHHUZ4i8iQhPAriSbuPFKrnOUMfYKVU0nPb3Iq2XHR41xJ+wiiBuvjWI2kbhM65l9Eoyi3gZjvTHw==
X-Received: by 2002:adf:e408:0:b0:313:ec90:ac23 with SMTP id
 g8-20020adfe408000000b00313ec90ac23mr4058215wrm.13.1687786780615; 
 Mon, 26 Jun 2023 06:39:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a5d5549000000b00307acec258esm7534496wrw.3.2023.06.26.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:39:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA31E1FFBB;
 Mon, 26 Jun 2023 14:39:39 +0100 (BST)
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-27-alex.bennee@linaro.org>
 <0c245101-77cf-9e9a-3c84-0293a75125b6@redhat.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, Darren Kenny
 <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>, Peter Xu
 <peterx@redhat.com>, qemu-arm@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Bandan Das <bsd@redhat.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Alexander Bulekov <alxndr@bu.edu>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Leonardo Bras <leobras@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Stefan Hajnoczi
 <stefanha@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>, Beraldo
 Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH 26/26] docs/devel: introduce some key concepts for QOM
 development
Date: Mon, 26 Jun 2023 14:39:14 +0100
In-reply-to: <0c245101-77cf-9e9a-3c84-0293a75125b6@redhat.com>
Message-ID: <87cz1i2vhg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/23/23 14:21, Alex Benn=C3=A9e wrote:
>> Using QOM correctly is increasingly important to maintaining a modern
>> code base. However the current documentation skips some important
>> concepts before launching into a simple example. Lets:
>>    - at least mention properties
>>    - mention TYPE_OBJECT and TYPE_DEVICE
>>    - talk about why we have realize/unrealize
>>    - mention the QOM tree
>> Signed-off-by: Alex Benn=C3=A9e<alex.bennee@linaro.org>
>> Message-Id:<20230619171437.357374-6-alex.bennee@linaro.org>
>
> There were review comments on this series that haven't been applied.

Sorry I'd missed those. I've fixed that for the respin which is
currently checking on CI.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

