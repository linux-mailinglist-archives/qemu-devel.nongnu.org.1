Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E193712335
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:17:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TZW-0000xo-5n; Fri, 26 May 2023 05:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TZT-0000xZ-Uf
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:17:15 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TZQ-0002Tn-MM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:17:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d20548adso270303f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685092631; x=1687684631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGs6qvIGpfVWqkfTPgW8SQqkWQkSyM2ziHT5LzAEKfI=;
 b=xMo1nyJ9H00LiaZiuB4LKUQnhCZKx65fxDkbCykfxZXKNVqfHyFtkeysLd0+c5EB5G
 4yPSWC7GBxKAtt/ou54VZ7nLGSpU4bpUDz6vvJTe7OdwJRRpTTB02G31cW/p0pEfP3Ij
 67s5GiWsou6O6xMkNApAf+SFIjy0B1Atoddsws8gjM87wInNnNB0sOKF7gJVQVfyNaZc
 6LwAdE6GWmjRW+k3s534XKJAvyHeqPDpucSeCXKm+Qfw6LHU3pOpGpVOe+YxWcJtG1i6
 aKPgxKKV8L64FW8H9gNb47ORc63J5dOCMzVxo6kyr9frNMeSWPplQi/R+lq8ospZKHwM
 NQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685092631; x=1687684631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mGs6qvIGpfVWqkfTPgW8SQqkWQkSyM2ziHT5LzAEKfI=;
 b=Wu3fjhS2P9jp+zHN+Qud9AZGSx+E9qv1+CbJeFSUMNYHH0ezoK+lOIoUb9SeyYKixy
 CIYJ8KlIzvwzVeD/R+YNLBdiFLcu6f+TPOMuj08O0POKCeRyRqEIq5oUEVmB7UOi0spU
 jglCrWmEbrsEu2uIJbe92MkXatz13pZRFJsPq4wwqHMS1XGK0iTyzudealzckJDLhTHG
 5Oce1f8uMBngvf5Gj3e7h/m3/n3yhZQ858PCyqqRa9/QZbZQLqjvGAodksEmi+KALJoQ
 iEdbPKEOxuTvZNLQFV9imXGT5YItinQCGZTSc2A2OeHlzK8ApNCmKv4iqQJP/2XUY7I/
 7GGA==
X-Gm-Message-State: AC+VfDzCi33ahcv1toqUtsACrdZ6jh54knA9mYqyhWQX/rMZla22gZVJ
 OQ1i0sdovGTIkju+gd71W30igrI7bCsFmGbkZuY=
X-Google-Smtp-Source: ACHHUZ7211EZ+G1bJqRq8JuT5h4IlznyISb1q5wZfLxzXffvrVBajVj85FD84qJwe9FTd9uv84/DRA==
X-Received: by 2002:a05:6000:104c:b0:309:3698:8006 with SMTP id
 c12-20020a056000104c00b0030936988006mr840169wrx.34.1685092631157; 
 Fri, 26 May 2023 02:17:11 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 e10-20020a5d530a000000b002f6176cc6desm4476654wrv.110.2023.05.26.02.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:17:10 -0700 (PDT)
Message-ID: <58812207-f614-b0b6-0ac9-13949d2719c0@linaro.org>
Date: Fri, 26 May 2023 11:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/27] tests/docker: add python3-venv dependency
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, berrange@redhat.com
References: <20230516105908.527838-1-pbonzini@redhat.com>
 <20230516105908.527838-12-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230516105908.527838-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 16/5/23 12:58, Paolo Bonzini wrote:
> From: John Snow <jsnow@redhat.com>
> 
> Several debian-based tests need the python3-venv dependency as a
> consequence of Debian debundling the "ensurepip" module normally
> included with Python.
> 
> As mkvenv.py stands as of this commit, Debian requires EITHER:
> 
> (A) setuptools and pip, or
> (B) ensurepip
> 
> mkvenv is a few seconds faster if you have setuptools and pip, so
> developers should prefer the first requirement. For the purposes of CI,
> the time-save is a wash; it's only a matter of who is responsible for
> installing pip and when; the timing is about the same.
> 
> Arbitrarily, I chose adding ensurepip to the test configuration because
> it is normally part of the Python stdlib, and always having it allows us
> a more consistent cross-platform environment.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230511035435.734312-12-jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 3 ++-
>   tests/docker/dockerfiles/debian-hexagon-cross.docker  | 3 ++-
>   tests/docker/dockerfiles/debian-riscv64-cross.docker  | 3 ++-
>   tests/docker/dockerfiles/debian-tricore-cross.docker  | 3 ++-
>   4 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


