Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE177778F
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4DJ-00037r-Nt; Thu, 10 Aug 2023 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4DI-00037i-79
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:52:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4DF-0006kF-OW
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:52:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313e742a787so450401f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691668340; x=1692273140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZJxvP+I1euyto2DOEwcf5TFUbkyZh7giIAFgShM6jg=;
 b=WweEENoQb0ldm2BjqQqCQpYAeD4XPtAuZzgaWSxaHDKbdPXbBSCGAch8fUvsP/hmuC
 nHfvuSmTNjSYvalxHXX/6ssCQRJNiI7KfYHskybAFgJ530DO1CUEf9d44if4LgSe+KeA
 dOsjstEItyyG+AsRydowGZkYp9FcgjLXI9chT9uv63TlVIoBZ1FEx4a2MH61O5Dnlr70
 bZ7IdcgKfsGAwZ+3pmg8GAce6fo2nMEz44Csnm+Od1jTWTh1oX8rHbKL0g4U7nzHjTfo
 H67GrTwnx26OSeYMpWZl1f1QSi366O62YA1H4E0jbVK2nu8+V1DQ562wtkY82K10IsXL
 3mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691668340; x=1692273140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZJxvP+I1euyto2DOEwcf5TFUbkyZh7giIAFgShM6jg=;
 b=lCDkoD65HytG5IVE+UTAuEX4Ez4YQ4tHQYyPIWN82V8wLWYmEZGvOBZc8RkuX88Q52
 GF8S5wr2R5MBiCKpqWU3UwV/cwRJtI3N2bw+hzi1JXM7CYijWCXG6tMnq/KDf8u2U1wK
 9CACiUNwypJWUAd728OtuOkErW2sat1vaGhrULjXSzZHlMLlvfnfmbEnu4motk98/iN5
 5h34ARoPBzDEzl4MaEMsvXo6QqR+GOMwpiRzX4gMU64jh+dz5H5mYgDco7eJGXL9zkLL
 hs3UWc6thtMaakQZ3qoYikalfpTmrK7NFd/zH7+kI5ZOivPYH3Snz+zcsYYgmrCvXTU3
 rXEQ==
X-Gm-Message-State: AOJu0YylPOX/7nA98EZpQYab8vta9YzKPVETQroPon6k0iyVclmOcYTK
 lWazKuv+15VohW6mX3q8HwIHmg==
X-Google-Smtp-Source: AGHT+IGvZyCw00U0HUxiDuNeJv5gWL08evKv+OheFPHTjvUFqFWba3/GbM0Lbs211Z9AydhKAPfUzw==
X-Received: by 2002:a5d:42c4:0:b0:317:417e:a467 with SMTP id
 t4-20020a5d42c4000000b00317417ea467mr1536603wrr.6.1691668339991; 
 Thu, 10 Aug 2023 04:52:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d698d000000b003180027d67asm1953010wru.19.2023.08.10.04.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:52:19 -0700 (PDT)
Message-ID: <c8d32a26-b749-01b3-0b36-98e374947427@linaro.org>
Date: Thu, 10 Aug 2023 13:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/9] Use known good releases when installing in pyvenv
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Jan Richter <jarichte@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

On 9/8/23 11:29, Paolo Bonzini wrote:
> This series introduce a new installation command for mkvenv.py that
> retrieves the packages to be installed from a TOML file. This allows
> being more flexible in using the system version of a package, while at
> the same time using a known-good version when installing the package.
> This is important for packages that sometimes have backwards-incompatible
> changes or that depend on specific versions of their dependencies.
>      
> For example, in the case of sphinx we can always use the last version
> that supports older versions of Python and especially docutils (Ubuntu
> 20.04 for example would not support sphinx 6.0), and in the case of
> Avocado we can avoid installing a package that conflicts with any
> plugins already existing in the system package path.  This in turn
> enables using the same virtual environment for both the build and
> qemu-iotests.  John has patches for this.
> 
> For the configuration file, TOML was chosen because it was more human
> readable and easier to edit than JSON.  A parser is available in the
> Python 3.11 standard library; for older versions, the API-compatible
> replacement tomli is very small (12k).  I am introducing it as a vendored
> .whl file because it is not installed by default in most distros (unlike
> pip and setuptools which were introduced in 8.0) and because Debian
> 11 only has it in bullseye-backports.  However, if preferred the patch
> "python: use vendored tomli" can be dropped.  In that case, tomli will
> have to be installed from either PyPI or bullseye-backports.
> 
> While tomli is bundled with pip, this is only true of recent versions
> of pip.  Of all the supported OSes pretty much only FreeBSD has a recent
> enough version of pip while staying on Python <3.11.  So we cannot use
> the same trick that is in place for distlib.
> 
> In order to pick the tomli mapping, lcitool is updated to a recent
> version.  As a side effect this updates from LEAP 15.4 to 15.5.

Does this fix the second point of commit eaf245becd ("Revert
"tests/requirements.txt: bump up avocado-framework version to 101.0"")

  > Second, the recent changes to Python handling mean that there is
  > a single virtual environment for all the build, instead of a separate
  > one for testing.

?

If so, what's left to be able to run QEMU (Avocado) test suite on macOS
is the first point from the same commit:

  > Avocado is not logging of command lines or terminal output, and
  > not collecting Python logs outside the avocado namespace.

This seems to be fixed in Avocado 102.0:

https://avocado-framework.readthedocs.io/en/102.0/releases/102_0.html

  > The root logger handler was restored. This enables all loggers
  > out of avocado.* namespace by default.

Assuming this is enough for macOS, what would be the next change,
moving to 102.0 or integrate 102.0 in the current set? I.e.:

   avocado-framework = { accepted = "(>=88.1, <93.0, 102.0)", ... }

? But I expect the "<93.0" filter to clash...

Thanks,

Phil.


