Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B079D9DE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9bi-0003sJ-Ht; Tue, 12 Sep 2023 16:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg9bT-0003rk-MI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg9bR-0000fp-Cv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694548996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qr39NIMHGuHWXhJuFHiwVLAXS8gppAz9QKxHYpXDcD8=;
 b=TUQWsEMDzHq96rzVPthRAQMe78I7NBCxbBiqGSaKR7W3GtL1CZcigmp6dUNF7gkydAe8hf
 Ijkq3oOVHmoC3dWgOufDn2sptG2s7jGO+dVFto5eOuqT2iwATSLQ5g4x7ipkHeQwa0yTP1
 TO7q7uQYd9cfTkau4dUtqgmyzukI5YA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-7ajHwk7xO0ywlxQ1clQqFg-1; Tue, 12 Sep 2023 16:03:13 -0400
X-MC-Unique: 7ajHwk7xO0ywlxQ1clQqFg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401db0c9d3eso46903995e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 13:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694548992; x=1695153792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qr39NIMHGuHWXhJuFHiwVLAXS8gppAz9QKxHYpXDcD8=;
 b=Mm/L9FAmhrb7wmp5Gy/zHKick15sDhkP5NcHEgyr9UTuNnovl0mMiPSSkk3k4iMLCz
 x+PwtC6p4snV1XFG24nIhS/NrevBs6akIo5W45lFW3Ulho8gmOM3FpQv2znuy9DmEXvY
 K2P27zhigYj3IZZBjYtbFH5jeijayksysPVwabiO3Pwwetvn3O6jbajBvHk8rH7cQXs5
 rXhmLF+cdsH1cmjFttCwYsFH/kTQ3OABkRoc9i38YoPEB7fPDPZdu/0UI75pU+e8AtSB
 917QrnjOLAhMUw/NGpJaTkMDtrWi2zDxGDjmy7BbbcS5XE0+fct6JKMA+Rhq07C4vwWh
 fNrw==
X-Gm-Message-State: AOJu0YwFGs/bJZoLnfaY1AQ2ZSe93ZNOlscCMy540KPhZgA2vBIvYP2h
 3XIz9SORziwmiCyBRLkeXu/Zs4Tegusm7x0UEA2x3/+vEXkK+z8sZ0Iw7krdV86o//mt+uOv0Vv
 iTRKjWBWOqSwYc88=
X-Received: by 2002:a7b:c3d0:0:b0:401:73b2:f043 with SMTP id
 t16-20020a7bc3d0000000b0040173b2f043mr449007wmj.1.1694548992633; 
 Tue, 12 Sep 2023 13:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQpkjCRHrGlGmc627+gx/aEoy2co7XZdIWUf5j87U5spGbttGAXc0QYhQyYx74qj7pQGAl+g==
X-Received: by 2002:a7b:c3d0:0:b0:401:73b2:f043 with SMTP id
 t16-20020a7bc3d0000000b0040173b2f043mr448987wmj.1.1694548992319; 
 Tue, 12 Sep 2023 13:03:12 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fef19bb55csm13814609wma.34.2023.09.12.13.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 13:03:11 -0700 (PDT)
Message-ID: <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com>
Date: Tue, 12 Sep 2023 22:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230912184130.3056054-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/09/2023 20.41, Daniel P. Berrangé wrote:
> This addresses
> 
>    https://gitlab.com/qemu-project/qemu/-/issues/1882
> 
> Which turned out to be a genuine flaw which we missed during merge
> as the patch hitting master co-incided with the FreeBSD CI job
> having an temporary outage due to changed release image version.
> 
> Daniel P. Berrangé (4):
>    microbit: add missing qtest_quit() call
>    qtest: kill orphaned qtest QEMU processes on FreeBSD
>    gitlab: make Cirrus CI timeout explicit
>    gitlab: make Cirrus CI jobs gating
> 
>   .gitlab-ci.d/cirrus.yml       | 4 +++-
>   .gitlab-ci.d/cirrus/build.yml | 2 ++
>   tests/qtest/libqtest.c        | 7 +++++++
>   tests/qtest/microbit-test.c   | 2 ++
>   4 files changed, 14 insertions(+), 1 deletion(-)
> 

Series
Reviewed-by: Thomas Huth <thuth@redhat.com>

Alex, will you pick these up or shall I take them for my next PR?
Or Stefan, do you want to apply these directly as a CI fix?

  Thomas


