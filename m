Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF037E3EDA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:43:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LPF-0006jG-Ag; Tue, 07 Nov 2023 07:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0LP1-0006i5-DH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:41:55 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0LOu-0000RL-GO
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:41:55 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d10972e63eso829746966b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360906; x=1699965706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAoZibYEe4Ru+I+aeFdl+94OXUU0LwHizg/8NDWLrTE=;
 b=GNYrrdmW8x4T32terHZeGKiLdT88HI54ME0oMBNaVf8WRXqX6u1AlLQ8UfUiKHIAe9
 hN6NKXv7QCJTM4/phT3Zt2kV0q5wxwojB0nvGq4EGucD1kEJdc1CPAqGyARJEFJpXccZ
 wX2lNj53sdFbhtFqg6BSWWJXEO5w/vI3Yu8UwH44GzvCUo0gXHkvzjZueXqlLWMx5h2y
 /pb0n6S5pUD+Lhv9zVCiL9eXs71Eolga4gQHqrgV/xf/fIiOUOINif5/BIi5B5+Bm6dx
 nTJN5Pm7RA+Dz+QAkH6Dejs+QSiBTSehnCkGjxtX79r8X57jVH2SphTBtkJcQgGTVdeP
 EVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360906; x=1699965706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAoZibYEe4Ru+I+aeFdl+94OXUU0LwHizg/8NDWLrTE=;
 b=OGznd3tEBlXhJ0I6B2Z0W/eORSnR5h5N78enzNESGdkoN81fLvn00W9uu3V6HT1Xlu
 RveweU0jXUHPG7ET9hFnEuMgsgp1ZWjAE8CmSCJBK5AaubhJLn0NzF87iXq6CIdIs79s
 DeFAr/jH1h7A3BmG/Zu3nS/nhGzBMaSSwAgrIalrDEOCqiMU6LG0xdKZxqEjg6apMVon
 ma7hT6cnO3AQI611mPwOTAVpZ4Fdc+dBd5sxJPXep91RD5cSFI+E6y2/dcg80qPzBcVX
 0R6RtN8O00QGsuHPgxGzmMJv7g51hFnBl4xZMfNI/uBIZqrUfXcWy+GvPeWLuH4obrLP
 f05A==
X-Gm-Message-State: AOJu0YxA2n+GPrNTNQNkVu9hn9Stf9PwmxjbLIN6qi1Rf5rE7/CY13Qc
 EOObXCvdGgBO8HZgBeWrPCentw==
X-Google-Smtp-Source: AGHT+IFJZb7nQSTx55m/1srg1ujgFK/fTE8UpyP7djFlxvda2wBfhwTRcotViXwPYZUXpL09apNzgQ==
X-Received: by 2002:a17:907:a44:b0:9e0:8782:fb98 with SMTP id
 be4-20020a1709070a4400b009e08782fb98mr4811812ejc.32.1699360906004; 
 Tue, 07 Nov 2023 04:41:46 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 n30-20020a05600c501e00b00405442edc69sm15733671wmr.14.2023.11.07.04.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 04:41:45 -0800 (PST)
Message-ID: <556909c8-4beb-4e8d-972f-55c075d7fdaa@linaro.org>
Date: Tue, 7 Nov 2023 13:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] gdbstub: Add num_regs member to GDBFeature
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Richard Henderson
 <richard.henderson@linaro.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-9-alex.bennee@linaro.org>
 <3bf96059-44a8-4af3-9b0b-c9f070cd498b@linaro.org>
 <878r797te4.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878r797te4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/11/23 11:24, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Alex,
>>
>> On 6/11/23 19:50, Alex Bennée wrote:
>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Currently the number of registers exposed to GDB is written as magic
>>> numbers in code. Derive the number of registers GDB actually see from
>>> XML files to replace the magic numbers in code later.
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-Id: <20231025093128.33116-2-akihiko.odaki@daynix.com>
>>
>> Something in your workflow is odd, you should keep this Message-Id,
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-Id: <20231103195956.1998255-9-alex.bennee@linaro.org>
>>
>> and not propagate this one, IMO.
> 
> Why not - it tracks all the review stuff. I explicitly keep on
> Message-Id per domain so we see the original posting and the last time
> it was posted (which you can then follow the chain of reviews from
> there).
> 
> If we want to have an explicit policy on which Message-Id's to keep then
> we should document it.

Fair enough :)


