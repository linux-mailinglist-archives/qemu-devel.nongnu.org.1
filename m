Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BA781FECD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:56:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9b5-0000pr-0X; Fri, 29 Dec 2023 04:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9b2-0000p2-CL
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:56:04 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9b0-0003Ys-KX
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:56:04 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e77a2805fso3841226e87.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703843761; x=1704448561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aeudtg0llYyRFuVwlWziLIOJ38GWOf7/v955vyG4Vls=;
 b=LVMpfygJbkVBoV7tBtg9hO7yGY3ZkgfTanyerk1EXABqpHDAimifeRGXseot3XKOi/
 wfeqdZ9mh2LC7lwwrfBu4UMYpa6va6VJK5WCe+d6/oJ0h728QzpGf+/NbO638OpuYnmZ
 pZRpwRKpcRvLd4kV7+nb583Ej/BpmefapWWkIA60i+mLZ6h1XadkdOgG8WSUSiXktijd
 6BJSVCaBB/6xleX35FdHMDW+drXkXaCLiMNhuM0luGviJnwtyrazCQThTOKuEiWbu4Br
 C7sP6ktjN9SmQPqFwBlH1rkU1hCdQ3eavH2ZNzHSpDUaYp4TOBMbJJ7Wt1+DoYvIJQIg
 sKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703843761; x=1704448561;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aeudtg0llYyRFuVwlWziLIOJ38GWOf7/v955vyG4Vls=;
 b=UU20N/mGlrR2QvQGN/WwmwDzAZbFrh4rZWiTRgyt3Attl2tQ5ybg1Yq6feeTyYGyah
 s50x8Fv54Ar9v3OOnOZvrjWWQFCP/+fJlE/5q1fMp+Sc5hVHuiWgOVUULOBOSffl0DXz
 flJIov1liSAb+6jnVhNfk+0nCUEvVix5u/cQSDWrAmady4pmRhP7HsNoESOOajvt5Dah
 bHvuI49vzn9ZLjsuqOgow4RU4e1gNwJurHtorUYJ/SN0Trshn1sZOFdWU4xtVBxfyw1f
 e8dh1QtxGXV+yYpUQ408VpilBdVW9XXM+3v770Nf3XzR3dBTE0SIiZo+kk2Vb880hlf4
 dhOg==
X-Gm-Message-State: AOJu0YzGW34g+SKNrvzCkdXv+2eQZfJvIrPHb2yWRXaKTquYcnppeEsV
 uGhdjnhce6f2EEex0GXu8nHeQHP3CklY9JuZu3xbdPxkP9g=
X-Google-Smtp-Source: AGHT+IH2GaP+SaJP9Ni4JzoA5uu8kodgUCFHzgNnm47vJw5oAy1lLrRUuqGJx6bJtZjDg6+WnpOzsg==
X-Received: by 2002:ac2:43ab:0:b0:50e:6a1d:db9 with SMTP id
 t11-20020ac243ab000000b0050e6a1d0db9mr3018644lfl.112.1703843760044; 
 Fri, 29 Dec 2023 01:56:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 fi11-20020a056402550b00b005550192159bsm4908811edb.62.2023.12.29.01.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:55:59 -0800 (PST)
Message-ID: <4f54f10f-5150-4773-a9d1-0eb058337721@linaro.org>
Date: Fri, 29 Dec 2023 10:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] meson: move subdirs to "Collect sources" section
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-21-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 66 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


