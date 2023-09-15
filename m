Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CB7A1A2E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh4vq-0003oe-HS; Fri, 15 Sep 2023 05:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4vo-0003nl-Kp
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:16:08 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4vj-0002yr-3p
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:16:08 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcb0b973a5so29846351fa.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694769361; x=1695374161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tobk7HZZ2nYrp4ct5icjk2NTeyFuWk3+o1WLYBkX2hg=;
 b=FchmmzsNBiC6OSNGsjBmDwSNoti31NytkU3TYGkzN1Zdx35Gd1eZm5iabwunhsw1BI
 zQzG3bmpnN8HqWVPFj1p4RR0UnITrAluNeUnkVvDSeuN5ZXIxqL4QA1qFUzE+UdOojoF
 lE5vKetxIe5H22Qaxv/5WoeppsbVvzLZLmTEBYO7NTk3T9eKjcJIpREwzSIGqsxYcdWu
 3QOwku9/AQtgfxMeoxl3yXYEcr+pP7D4I6wYMLltdWg8Dx5fy6tprwTul2LVssGK2Td4
 tc38p7xVrTgPdJeoNF0XGt4k3D1JO428xvCLuJoEtin2SU16/am1XsFASVQSeK0HQbv6
 OIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694769361; x=1695374161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tobk7HZZ2nYrp4ct5icjk2NTeyFuWk3+o1WLYBkX2hg=;
 b=XttQut4KiJdf8UfpIeDCXZ3OWkLgnf+92/QgluidKRPEIgQ1IlJeUJWVSbUeab2Nst
 MfWckGRDCe4vGusKbnDJ/FHCc+zuEPCvN6jzusalL0NJ8r6z/YNWeY78KzBwKTEeQ/jE
 Ktd+niRnGwbqE8rwbeNMQlkbroxLwAI8b13qgQQj5fO3ecc+x4Ak7VlOepAw9Oy16EQa
 KK9eIqsE/jMUE3AA0k4/+LML8LMFYuFq88LHUUVR1rtl21iq7UK7nGGEmn3U470K8gWi
 K9ifFdwIVExVIIdqtiR15R66mauTOc36JxdxcJBRgh2pUQEXqwGuZD2XsWpNJSS2Qrcy
 gUZw==
X-Gm-Message-State: AOJu0YzRj9zrhWQunLLLOpRQB5viG29I0/j0t0EYUFw79SxO44n7q7Vj
 4pqT996IZOlBR9mM/30Tz4VE+w==
X-Google-Smtp-Source: AGHT+IEjZXZdEw+lJzWMbLz6wDxyKQXhvBdiHgegnk4M/OtscX/4t77+pJMTJGHMcRhWL55+y7zRow==
X-Received: by 2002:a2e:b001:0:b0:2bc:ee89:6976 with SMTP id
 y1-20020a2eb001000000b002bcee896976mr1054643ljk.24.1694769361253; 
 Fri, 15 Sep 2023 02:16:01 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 qx9-20020a170906fcc900b0099d0a8ccb5fsm2152978ejb.152.2023.09.15.02.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:16:00 -0700 (PDT)
Message-ID: <a7300e20-6979-e286-0d87-e5a14007b154@linaro.org>
Date: Fri, 15 Sep 2023 11:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/9] gitlab: make Cirrus CI jobs gating
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914155422.426639-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/9/23 17:54, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The Cirrus CI jobs have been non-gating for a while to let us build
> confidence in their reliability. Aside from periodic dependancy
> problems when FreeBSD Ports switches to be based on a new FreeBSD
> image version, the jobs have been reliable. It is thus worth making
> them gating to prevent build failures being missed during merges.
> 
> Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20230912184130.3056054-5-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/cirrus.yml | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


