Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FED7E48DE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:57:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RFs-0003mt-RZ; Tue, 07 Nov 2023 13:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RFq-0003gH-VX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:56:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RFo-0003dR-Ks
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:56:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso4055995f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383406; x=1699988206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wDO1GuVHICUJrAK6p3gCVD8aMxy8SksPs9MNedjBXsc=;
 b=NO66iOTlZ5HHDYEc8C5tDR+mBzLrmp59/8Cq9MFDU/XOglu+hP3B785Dq/We9dwfoi
 8OOuw9paWAfoUukfpddw5toTlCNxEyiPShrqcwJ/4hfXzIVbcYgacrLqA2WzUNC9+poc
 YT6APRZ9RIM9Tz7Y9ZfnNRdb9jP/uYuMRUhc1gTDzczCzeK1ukXkJqJnVejzMEliJ5qK
 TtBUOthXHNlvCF7qlhOfZEjxMJht7fa9JKRqBEHUeAebmxfCkvN9PjIkpzRlNaZpN/3T
 1l4/qu5+JOub9G+zkyoZR0ZB1iQHSjCdw8g1iH9Sfc9v7VXPU0SIUTUvv1oRdIl0jf5w
 9WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383406; x=1699988206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDO1GuVHICUJrAK6p3gCVD8aMxy8SksPs9MNedjBXsc=;
 b=om7Gnp4VfOdYqzeRMkbvOu2WPFGWx3Rujcc9kOeHf00+ttVLiiBZmfn+svcjmPCZdU
 HOc9yRe6nbybrDNk2XvLdeZT8YJnpZxM/2BtF9TmI/CqOWIyOeN75M2W2iHeSrYBmpXC
 N6I49OTr/ZBdq60RPGlU97OE+PlFsROnbYgiGlo6wOLJ0ws7vPo7x6HNK7BujD7vFN6E
 dls4AFNYFbmSYlAISZUOr6pSKs8Km+A31qtohHJ2GFgFxpuPKdeeAdfb9oYYjFq9AtkE
 qga4ceTK9BxX+ob46aKrX+GGQMjcaND3qNEXvJx1DIWpb2XhQX0/kg0FjQc+cIu3rQMx
 JWRA==
X-Gm-Message-State: AOJu0YxJzvsSGcfpNCb72Ry3Wd8AiJpQJ+XsHgD23erdyx36B72WE+PT
 frWXS5FTzcvIbSE0Xmq2KMZY3w==
X-Google-Smtp-Source: AGHT+IGKYm3UvUHB0wvbExnporXPEp6ETRV0lF0VjlLR6r7SGbJ/IvAU2YrwKTbZ76NW76th3cweUQ==
X-Received: by 2002:a5d:414a:0:b0:320:8d6:74f5 with SMTP id
 c10-20020a5d414a000000b0032008d674f5mr22270547wrq.28.1699383406646; 
 Tue, 07 Nov 2023 10:56:46 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm3079754wrt.18.2023.11.07.10.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:56:46 -0800 (PST)
Message-ID: <d72ed668-0744-4221-83cb-04ea7f338c50@linaro.org>
Date: Tue, 7 Nov 2023 19:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: replace fedora-i386 with debian-i686
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231107164109.1449014-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107164109.1449014-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/11/23 17:41, Daniel P. Berrangé wrote:
> Fedora is gradually killing off i386 packages in its repos, via a
> death-by-1000-cuts process. Thus Debian looks like a better long
> term bit for i686 build testing. It has the added advantage that
> we can generate it via lcitool too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/container-cross.yml              |  11 +-
>   .gitlab-ci.d/crossbuilds.yml                  |  12 +-
>   configure                                     |   2 +-
>   .../dockerfiles/debian-i686-cross.docker      | 182 ++++++++++++++++++
>   .../dockerfiles/fedora-i386-cross.docker      |  40 ----
>   tests/lcitool/refresh                         |   7 +
>   6 files changed, 202 insertions(+), 52 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/debian-i686-cross.docker
>   delete mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


