Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638ED9EE358
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 10:44:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfje-0000o5-J1; Thu, 12 Dec 2024 04:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfjZ-0000ch-Nr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfjY-0002Ik-54
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733996627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lePG/YfCij2LG4F15R4WPZFnl4jJNuxyGEl5E1GeKS0=;
 b=DYGwcnMzVyHl31R+d5PYplnkYuZE98Fka78zCqaiUKawkCUPo2h8ML5DAwoUlDaoSk9Hj2
 F3FT681rrgPkv/gM8ojar3+GZEcSB65o3cSKt8KY8k4hj6amgzU8iHGsjP6t5ySJZhYjjw
 zR+pVt2TKu63qxMh6s0HcRIiIS29rvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-z-WVgXxBOtyjOp4njryDlw-1; Thu, 12 Dec 2024 04:43:45 -0500
X-MC-Unique: z-WVgXxBOtyjOp4njryDlw-1
X-Mimecast-MFC-AGG-ID: z-WVgXxBOtyjOp4njryDlw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so244307f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733996624; x=1734601424;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lePG/YfCij2LG4F15R4WPZFnl4jJNuxyGEl5E1GeKS0=;
 b=vtviOopdbdwgxHLxxeFqPt/EFk/NO5MmXH0W3fzMOu33pllFAPCdGU/+2PthnpAY53
 B4QXNozqS8O+8CAgM2ggiKGZyz2J/q8X+5rJilWv34w7ndV5GISSztRsXHYgQDJR+4C1
 5frU/bwWpUb7vMblrhXB7Dya6/1bNRC+A0SVxJgaiiKZf8TSiumwOqtk0CMwQkkVC8lg
 1Fw86AlnvO59OTiSmlPQGhOZnJzcunLwESAR5zgo5NendkL9BXM+n5WgFR7GcKhY9JKP
 Fae1e7azviN5GDAtthke0VO7Kxf5CHRKaVQhw2Gwjt1vzvXDl1y7vuIlyCyQOAol98Co
 W7fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBI6KL/7qYR0wIcQiZjIkcO/+e9ecAHfie5RZOXUeEpT8ocy+TUEdYnGWVEIXPr9JNx9MYne0mV3p@nongnu.org
X-Gm-Message-State: AOJu0Yx9WhZY4Eo/ZSQQypdwJczQSJgvptNUy4gnIzXYIOjv7StMdekV
 xl0gMO6os5I29M+G2Td1rFnzWt1xO/etSZc28mE+kmoCJ+SjBKI8n+lNh5dilYU11cg22PxEwBR
 gNG65A/KJfRx1YboiIW5BGeHxl24mGVRG0UTleEemAOpz7+o5tw8c
X-Gm-Gg: ASbGncvzHGZEw9upuIZbNKMsniuE2glkuGvpzOPJ12xhiKMXX0XKcHEWu5OGLpwAKzz
 5w88I43BLgoq2q6e0YjEIb9zPzch3BI6pGr+2h/3hBEWLfkssYSeelkQE5ZOlmeD4mEnyB1CtAT
 +UIe4pSXoC7Gt0O2LFiuD91DZWL9ftosZnLCMNUuWWSnj2FEKN63MxJn/q7sh24Avc9feh62bVM
 VL7HowKMB3H3K+j79DJPX4mNUTe8ucTyXoGWGBmEWdLBxBHX0VajvbEi3I94qk2BIXgsDfLUsoa
 IAvUGg==
X-Received: by 2002:a05:6000:490a:b0:385:f996:1bb9 with SMTP id
 ffacd0b85a97d-3878768e743mr1965426f8f.23.1733996624488; 
 Thu, 12 Dec 2024 01:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhLvVIARtKIgCu3m/9Vypqri6Pzcqp2gmcOhQjayBNuSWlRbLURHR0EFOfEakRfVPWJnZYfw==
X-Received: by 2002:a05:6000:490a:b0:385:f996:1bb9 with SMTP id
 ffacd0b85a97d-3878768e743mr1965407f8f.23.1733996624159; 
 Thu, 12 Dec 2024 01:43:44 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c3a7sm3462951f8f.94.2024.12.12.01.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:43:43 -0800 (PST)
Message-ID: <a1deb3cf-89cf-4018-99e4-02b92d20c913@redhat.com>
Date: Thu, 12 Dec 2024 10:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/31] tests/functional: move uncompress handling into
 new uncompress.py file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-18-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> More uncompress related code will be added shortly, so having a
> separate file makes more sense.
> 
> The utils.py imports the functions from archive.py, so that
> existing callers don't need to be modified. This avoids
> redundant code churn until later in the series when all
> calls will be adapted for other reasons.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/uncompress.py | 36 ++++++++++++++++++++++++
>   tests/functional/qemu_test/utils.py      | 27 ++----------------
>   2 files changed, 38 insertions(+), 25 deletions(-)
>   create mode 100644 tests/functional/qemu_test/uncompress.py
> 
> diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
> new file mode 100644
> index 0000000000..955170df65
> --- /dev/null
> +++ b/tests/functional/qemu_test/uncompress.py
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Utilities for python-based QEMU tests
> +#
> +# Copyright 2024 Red Hat, Inc.
> +#
> +# Authors:
> +#  Thomas Huth <thuth@redhat.com>
> +
> +import gzip
> +import lzma
> +import os
> +import shutil
> +
> +
> +def gzip_uncompress(gz_path, output_path):
> +    if os.path.exists(output_path):
> +        return
> +    with gzip.open(gz_path, 'rb') as gz_in:
> +        try:
> +            with open(output_path, 'wb') as raw_out:
> +                shutil.copyfileobj(gz_in, raw_out)
> +        except:
> +            os.remove(output_path)
> +            raise
> +
> +def lzma_uncompress(xz_path, output_path):
> +    if os.path.exists(output_path):
> +        return
> +    with lzma.open(xz_path, 'rb') as lzma_in:
> +        try:
> +            with open(output_path, 'wb') as raw_out:
> +                shutil.copyfileobj(lzma_in, raw_out)
> +        except:
> +            os.remove(output_path)
> +            raise
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 5ce1c4388e..6b87af4414 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -8,13 +8,12 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -import gzip
> -import lzma
>   import os
> -import shutil
>   
>   from .archive import tar_extract as archive_extract
>   from .archive import cpio_extract
> +from .uncompress import gzip_uncompress
> +from .uncompress import lzma_uncompress
>   
>   """
>   Round up to next power of 2
> @@ -36,25 +35,3 @@ def image_pow2ceil_expand(path):
>           if size != size_aligned:
>               with open(path, 'ab+') as fd:
>                   fd.truncate(size_aligned)
> -
> -def gzip_uncompress(gz_path, output_path):
> -    if os.path.exists(output_path):
> -        return
> -    with gzip.open(gz_path, 'rb') as gz_in:
> -        try:
> -            with open(output_path, 'wb') as raw_out:
> -                shutil.copyfileobj(gz_in, raw_out)
> -        except:
> -            os.remove(output_path)
> -            raise
> -
> -def lzma_uncompress(xz_path, output_path):
> -    if os.path.exists(output_path):
> -        return
> -    with lzma.open(xz_path, 'rb') as lzma_in:
> -        try:
> -            with open(output_path, 'wb') as raw_out:
> -                shutil.copyfileobj(lzma_in, raw_out)
> -        except:
> -            os.remove(output_path)
> -            raise

Reviewed-by: Thomas Huth <thuth@redhat.com>


