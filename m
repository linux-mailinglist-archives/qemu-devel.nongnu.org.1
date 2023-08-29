Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DE78C77A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazew-0002QP-Kj; Tue, 29 Aug 2023 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazel-0002Ps-Tn
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:25:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazea-0004La-ER
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:25:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso1262652a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319106; x=1693923906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=at4Op2YnOoQ5dT/lBpPIAKCY7vXfDOrBVIs6vqPidk0=;
 b=N7NLex5E8YBEIDAZUXnkC79jOxY1nI5+VrGV7Fyn38AdCcnylqNK2tTdrEHcBEbotR
 tREXpxph+hdUeyQRBnEFjfT9Uqy+DHZV/8GIuBZ0n9nGHrADu1mdVa/p2gov+tyMXfqA
 orLBupvPt8f/QSK9ZNOX/pr6VpZEdveY7ZBFHWAnAFByy9zQsakknnRowTM2hXusCs8d
 yzLZG4cIo1Mfzh33xh+4gtK6GRfyOT4gdz/vddy4cswsyLLuEFKp1R3JB/kIaKqh7baj
 Ipz74D6M0vlHOC4y3sD1C0AmOXvNzrqBjwo0CTyzseyaJBulkny9tzTZ75G0MaTAIYWY
 CfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319106; x=1693923906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=at4Op2YnOoQ5dT/lBpPIAKCY7vXfDOrBVIs6vqPidk0=;
 b=NECJq+KEO3v9B1oa8x66yTRmWzcDVHhi2LnamiHLL+9kJiOHU3vUAQUvTB38T7vCml
 0rb8x8A1wsdCBm3I+4kgnaIRvkSFFzphCSug4dxqR309cMg4TQUlixoZLlerfDV/VbJb
 RZFcEMMSzHsBjLf+A1ilDGpJ7vAYr8I6xxc0vyCUfoed7YuZo7i1lCuUB0Qy0dHhB/gl
 zV+86v86NgZIm+IDtI9agnESRIYj263KGh3YcWWjB7Q95fVLTUARq6snvLoq79msOk7p
 jfKSVvSwj+v4hDKU+lp3u6U4RFwF+95omE9hbdAnqIOu907Gj7IWGKvnS+QDwMs1YwhO
 T1TA==
X-Gm-Message-State: AOJu0YzjL3v7IEUGgO3IcSJoDg+vaumr/ayJNeLFt4+kNm32C8P6NV4k
 Ub5cUZVOCG8gtpcbw5eyA4/hew8FhtNrEtR+Pj0=
X-Google-Smtp-Source: AGHT+IFFPIEFWgQk+Ry59mwzqxwWItsxSBcR5TYFlE1WBpYa7Xv9VJacZ07NLC5543UgsD4xFvJopw==
X-Received: by 2002:a17:906:76ca:b0:9a5:d972:af43 with SMTP id
 q10-20020a17090676ca00b009a5d972af43mr467893ejn.65.1693319106265; 
 Tue, 29 Aug 2023 07:25:06 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 t20-20020a1709063e5400b0099cc15f09a0sm5966925eji.55.2023.08.29.07.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:25:05 -0700 (PDT)
Message-ID: <898e23ff-6ec7-a213-9e70-06085b4b3fb0@linaro.org>
Date: Tue, 29 Aug 2023 16:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 05/10] meson: compile bundled device trees
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829082931.67601-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 10:29, Paolo Bonzini wrote:
> If dtc is available, compile the .dts files in the pc-bios directory
> instead of using the precompiled binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   pc-bios/Makefile    | 19 -------------------
>   pc-bios/meson.build | 25 +++++++++++++++++++++----
>   2 files changed, 21 insertions(+), 23 deletions(-)
>   delete mode 100644 pc-bios/Makefile


> +dtc = find_program('dtc', required: false)
> +foreach f : [
> +  'bamboo.dts',
> +  'canyonlands.dts',
> +  'petalogix-s3adsp1800.dts',
> +  'petalogix-ml605.dts',
> +]
> +  out = fs.replace_suffix(f, '.dtb')

Does that work when building from read-only source directory?

> +  if dtc.found()
> +    custom_target(f,
> +        build_by_default: have_system,
> +        input: files(f),
> +        output: out,
> +        install: get_option('install_blobs'),
> +        install_dir: qemu_datadir,
> +        command: [ dtc, '-I', 'dts', '-O', 'dtb', '-o', '@OUTPUT@', '@INPUT0@' ])
> +  else
> +    blobs += out
> +  endif
> +endforeach
> +
>   if get_option('install_blobs')
>     install_data(blobs, install_dir: qemu_datadir)
>   endif


