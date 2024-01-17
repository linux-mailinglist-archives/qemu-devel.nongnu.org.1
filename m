Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2B83005B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:10:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ03B-00060M-FE; Wed, 17 Jan 2024 02:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ033-0005zM-5u
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:09:17 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ031-0002rN-GJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:09:16 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so731909566b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705475354; x=1706080154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EdFBGjN1htYHGgZ1AXcJTTlNTrZ4H/QfXsSHpfWJqYk=;
 b=L5SN/tTAiqb67v9zt7JsxFcaz4cLUDx2kft6RMqOPOQ+GyucIByGkDM2bkm3KThkiA
 HMSHLx/lk/LbpuSDD4lW0iTNXopCKk+lgh0CnjhTEYhJf2OYWXzdIgWYYsx6fEJEVOW0
 Xn2czkNK8EUliFOItLQv5G8DZS6FSwHtG/C+3E/sYbAGB2NUx6xhpKOsZDcBvB48WHdt
 /R7wE8pf033TgU9zH641C06j/PLNH8uFsYH+IGElsJY+8Wg4yHx0F//ImZCLSrp6tFaf
 PeuPomVUxSelvFdxfc7qwdMPooKLpooX6lXit7Bjck20+g4MqCacB2Tq1iGDCgmrn5wa
 pm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705475354; x=1706080154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EdFBGjN1htYHGgZ1AXcJTTlNTrZ4H/QfXsSHpfWJqYk=;
 b=Jt8rg4OwUXs9Pei24IWbIu7skK4NeNkphD02Ucy/vuo33HGFEHTxQq08OXAT2EBEzF
 GgTAH9rDH0+hjaiZK6qGngfFnBzFcS9yzl4zRhSABhlv50uOEuYYSMoP8Fa0tIszYKeB
 hOcu7/7tmnfEHmHQnK8PxUnjBWOalkB8PgBGKSp4xa5wvtQE2j9JMBiY5gw1e5+HhxFG
 CnktNu5oW8vgKyPkeNNv9tAfE5DGaM9/UEMB79OpZZfZsgwuO1PtV4+xJbUN7jUsTN0G
 ofs3G3Tpw5wLpepX5vS9/y0YXQNe5ErA1CuRqVnofd2nDMOqI++lAcJNR7cF9Xjk1ike
 mtHg==
X-Gm-Message-State: AOJu0Yxl9XSQgTgm4Ve9tDQzT/lBsbOxaCI+ioTope3PCkFqUVXV1nuB
 tqoH47K0dQo+Bz7wp9m61G6AdzHCiBYdOg==
X-Google-Smtp-Source: AGHT+IFhIMmzgen2Z8630cE/D1R3iwWXvs7HsWzZfqE/A2JQlw7hecnhXVxcPQQ5SwADJHMd+Iovfw==
X-Received: by 2002:a17:907:c205:b0:a2d:9511:1bef with SMTP id
 ti5-20020a170907c20500b00a2d95111befmr2772607ejc.110.1705475353869; 
 Tue, 16 Jan 2024 23:09:13 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 tx27-20020a1709078e9b00b00a2d1b0c7b80sm5355564ejc.57.2024.01.16.23.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 23:09:13 -0800 (PST)
Message-ID: <0f9bb6b0-6292-4926-ad9d-8bc21087c873@linaro.org>
Date: Wed, 17 Jan 2024 08:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>
References: <20240116230924.23053-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116230924.23053-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Hi Fabiano,

On 17/1/24 00:09, Fabiano Rosas wrote:
> Avocado needs sqlite3:
> 
>    Failed to load plugin from module "avocado.plugins.journal":
>    ImportError("Module 'sqlite3' is not installed.
>    Use: sudo zypper install python311 to install it")
> 
> Include the appropriate package in the dockerfile.
> 
>  From 'zypper info python311':
>    "This package supplies rich command line features provided by
>    readline, and sqlite3 support for the interpreter core, thus forming
>    a so called "extended" runtime."
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/docker/dockerfiles/opensuse-leap.docker | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
> index dc0e36ce48..cf753383a4 100644
> --- a/tests/docker/dockerfiles/opensuse-leap.docker
> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> @@ -90,6 +90,7 @@ RUN zypper update -y && \
>              pcre-devel-static \
>              pipewire-devel \
>              pkgconfig \
> +           python311 \
>              python311-base \
>              python311-pip \
>              python311-setuptools \

See in this file header:

   # THIS FILE WAS AUTO-GENERATED
   #
   #  $ lcitool dockerfile --layers all opensuse-leap-15 qemu
   #
   # https://gitlab.com/libvirt/libvirt-ci

libvirt-ci maintains dependencies required to build QEMU,
in this case since it is a 'testing QEMU' dependency, you
might add it in the generate_dockerfile("opensuse-leap")
call in tests/lcitool/refresh (otherwise raise an issue
in libvirt-ci about it).

Regards,

Phil.

