Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C1A3D2CC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 09:07:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1aC-0000aQ-SS; Thu, 20 Feb 2025 03:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl1aA-0000Zs-3x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl1a8-0005tM-Es
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740038811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RznWqLgvFE5PKLUSqH1M8hFthgPsAN2ir+2+kAHHk7E=;
 b=ExHi0AcKAUpkQoF7T8s4q1v1qHOTb3JxJ1syY+RPcs9W3/NY6d2c0Hqk5oJkxrT2QvrSLr
 QOkOJbNlosRbGeN8/6Ez0fZw+YudYGlX5PvR58NoDXcTeIcgZG4Dsl39/GQJE9VjQYAvrs
 JEM3uCJnTLf1Le+QXecVQpRCPraok9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-J_mAGSsqOdWhYv35PHAT_w-1; Thu, 20 Feb 2025 03:05:56 -0500
X-MC-Unique: J_mAGSsqOdWhYv35PHAT_w-1
X-Mimecast-MFC-AGG-ID: J_mAGSsqOdWhYv35PHAT_w_1740038756
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4bf0d5faso351138f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038756; x=1740643556;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RznWqLgvFE5PKLUSqH1M8hFthgPsAN2ir+2+kAHHk7E=;
 b=DpWQU9xx8D6OtKrmCM+bgpFLbRvQmP3vgHexRKEVNo2DWT7dUPzdEpxqybMN37y0Q0
 eSuuAJNwiurU2QYAu37slK8X7mLDgmW/TZ95iNLphPiSao7tKInbNzXTVTWHbwNJZIJO
 P1kt1oZNzbxeRcU6axN0/flCplekEc9czLkqBPw5ds0CfwUt83ZxFjuw7lJikJsmkHgs
 uZYZVC2E8jVyRZCl6Lrn2CmwTr02F44LukGrAfIyLSW+TJ8uwpxUJ0Qxdqthbu/AsW9v
 QbxOBg3GYJanYG85r+XT9j5uEIUKE+1Ar5lcScObHKxuaUDAuKkEQhzjMsuqJ4lZA4mb
 icQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0T3fgKPLxU8DI6DCpUAtTjNEQfu6AW5eiIQzfmVnkckdZY5Jri838W0jbIJTFSxuEN5gN+6zjW+2L@nongnu.org
X-Gm-Message-State: AOJu0YxttnHHUltXqk3nAcLqSFfmWdjdWWKnikKiWAnubi1oBCMBujcz
 y7+r60crhZI5WDKNiPAAbZkhJD/gO5KohtXRt8Mx6boYdgRA2qmLam5Y3G/MUc2FtZcUQ9HjI29
 RS9rUCUHCw0acSy7bN6hw3AdV3mBFpJYx8maMXlGn8+RwAK5cFi/N
X-Gm-Gg: ASbGnct+Nc8tih1s+w6uB73OnKEzDKyEL3pkGvHl5E2/pUjSgxUwIQKvvpS4cEBub6l
 2wdPqtdfa3BU4Eo+kOs0mw+sCB9K5PEFLG9Y1fvOMS/F/tYIgt2NSsONow0qpQKY62b49KWpaqv
 e+qCNZvXxB79X3fBwIf/lINDzrkCX/JhSyilQWJ7YJdohGiH2KuFv8uiLkgHyCVWz0u3wOpBX7f
 x4Duzc8aVSJ58s7JvVH6T/OEIfaGZNc4gpkIowYE5eog5ssJK0tIUnYTY+ykI04FZeBo/gfP6vX
 SKZYUswMx0XuogWKPDMhy+NdK2mlOotW3CBQ
X-Received: by 2002:a5d:584b:0:b0:38f:4251:5971 with SMTP id
 ffacd0b85a97d-38f58782badmr6000257f8f.6.1740038755641; 
 Thu, 20 Feb 2025 00:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEJDsiDrCZtvGCtb4D/FK0lsJK/sv8LtkGwcbSijHEcWXuLUoe8RKXalAc+WzjTWAzvM7p9Q==
X-Received: by 2002:a5d:584b:0:b0:38f:4251:5971 with SMTP id
 ffacd0b85a97d-38f58782badmr6000219f8f.6.1740038755252; 
 Thu, 20 Feb 2025 00:05:55 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65bcsm20011148f8f.65.2025.02.20.00.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:05:54 -0800 (PST)
Message-ID: <16754db1-d0cd-4c55-a6e2-4cf8ebb80639@redhat.com>
Date: Thu, 20 Feb 2025 09:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250220080215.49165-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/02/2025 09.02, Philippe Mathieu-Daudé wrote:
> Introduce a helper to get the default shared library
> suffix used on the host.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py | 2 +-
>   tests/functional/qemu_test/cmd.py      | 1 -
>   tests/functional/qemu_test/config.py   | 6 ++++++
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 5c972843a6d..45f7befa374 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -7,7 +7,7 @@
>   
>   
>   from .asset import Asset
> -from .config import BUILD_DIR
> +from .config import BUILD_DIR, dso_suffix
>   from .cmd import is_readable_executable_file, \
>       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
>       exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77d..254e23ef748 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -15,7 +15,6 @@
>   import os
>   import os.path
>   
> -
>   def which(tool):
>       """ looks up the full path for @tool, returns None if not found
>           or if @tool does not have executable permissions.

Please drop the change to cmd.py now.
With that fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


