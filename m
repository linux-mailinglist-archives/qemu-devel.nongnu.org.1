Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B637BB463
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohIb-0001yo-4u; Fri, 06 Oct 2023 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohIR-0001yX-BM
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:38:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohIO-00009g-Qn
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:38:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so233089f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696585135; x=1697189935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uTmsobzK+1o2w4HOgJzSYnT0B5QvJt0VQBzYZ4b59Iw=;
 b=bAi65nahIvFQ8r0TRaODnLKovkTLA/S3wJ160pj31LWIGvi0qO8EYcRZPzGk45Y6tl
 m0778aGbeFqT24MzFk3gCRhprvSUUkLeKNocvx7+c8JpykGV6yOtlRgncuVg4NewBnm6
 I1td2Xy7O7nntuL6+EKFhEyRAZ6Zs1UI38BvKMyoHIS9eKVDmEuOHiw/QEBah6kxgBob
 HFdA7JdGbi+Qs4Lfuz3NSAxLpGsacYxGbNQRMiTimPWGQypXID7czzGQ7EObJhjD5HpS
 kbKvPO2fu1N5rBYGwzVjUdymldQtENxo+1Ta8+BVXukpeF4xwmZwYwWtuhd1ZPMzQwfH
 a1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696585135; x=1697189935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTmsobzK+1o2w4HOgJzSYnT0B5QvJt0VQBzYZ4b59Iw=;
 b=r2p03oGZ0VaotnuQV6CiH9n9NJkl/CMqCYdwZdsz4oK0ahGJHv5EeytI+G2/znfMOG
 MeR3gVPQm4Fh8QsLCGZeG0fCrmEz5a08Hq/ZAZvn+Gz7yEBCN0kVfQqvVPZWyZgKTv6n
 Q0MSkn4sYdfftQhwuiqHsR4wygH+NSnzH0gwHDQuN4lXnRSNMnrUUMOYJF4T9Ztz2Dd0
 5abhYgRZ/TNe+eyAkPBj/BEkbWD8x5t7eb5zfE/edKCyFziqMdc36fbxoEt/mV/ceITO
 s/k/APX90Rbhns0wSbQYLYNbr8FtMB3WRRLZ/Kiu00Ulo80m6XnxmVhIJJnqeylpF1au
 je2w==
X-Gm-Message-State: AOJu0YyDK1idRnQjiPX/kKQp3op7QavSuzkfrGfqGrYfhvybG5h0E7x/
 IMn1fe7riU3S0N+gId6c0j1wzQ==
X-Google-Smtp-Source: AGHT+IEH1FQrmsn20A7kjLpqlNqPk/Y4tt9kIZWn2yE1O4+rV3RLSbSRSmkUVs2WM4dC5W5KuVMKSg==
X-Received: by 2002:adf:ed52:0:b0:31f:fa1a:83fb with SMTP id
 u18-20020adfed52000000b0031ffa1a83fbmr6819485wro.7.1696585134971; 
 Fri, 06 Oct 2023 02:38:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfed8e000000b00317b0155502sm1227446wro.8.2023.10.06.02.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:38:54 -0700 (PDT)
Message-ID: <556994f8-c7cf-92c3-f49d-4c37b955c7a4@linaro.org>
Date: Fri, 6 Oct 2023 11:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 3/3] docs/about/deprecated: Deprecate the
 qemu-system-i386 binary
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230425133851.489283-1-thuth@redhat.com>
 <20230425133851.489283-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230425133851.489283-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 25/4/23 15:38, Thomas Huth wrote:
> Aside from not supporting KVM on 32-bit hosts, the qemu-system-x86_64
> binary is a proper superset of the qemu-system-i386 binary. And with
> the 32-bit x86 host support being deprecated now, it is possible to
> deprecate the qemu-system-i386 binary now, too.
> 
> With regards to 32-bit KVM support in the x86 Linux kernel,
> the developers confirmed that they do not need a recent
> qemu-system-i386 binary here:
> 
>   https://lore.kernel.org/kvm/Y%2ffkTs5ajFy0hP1U@google.com/
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   docs/about/deprecated.rst | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1ca9dc33d6..c205816c7d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -34,6 +34,22 @@ deprecating the build option and no longer defend it in CI. The
>   ``--enable-gcov`` build option remains for analysis test case
>   coverage.
>   
> +``qemu-system-i386`` binary (since 8.1)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The ``qemu-system-i386`` binary was mainly useful for running with KVM
> +on 32-bit x86 hosts, but most Linux distributions already removed their
> +support for 32-bit x86 kernels, so hardly anybody still needs this. The
> +``qemu-system-x86_64`` binary is a proper superset and can be used to
> +run 32-bit guests by selecting a 32-bit CPU model, including KVM support
> +on x86_64 hosts. Thus users are recommended to reconfigure their systems
> +to use the ``qemu-system-x86_64`` binary instead. If a 32-bit CPU guest
> +environment should be enforced, you can switch off the "long mode" CPU
> +flag with ``-cpu max,lm=off``, or rename/symlink ``qemu-system-x86_64``
> +to ``qemu-system-i386`` -- QEMU will then run with the 64-bit extensions
> +disabled.
> +
> +
>   System emulator command line arguments
>   --------------------------------------
>   


