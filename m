Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84309830BB0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:09:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9Om-000237-2d; Wed, 17 Jan 2024 12:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9Ok-00022h-9j
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:08:18 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9Oi-0007QQ-PI
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:08:18 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-559eefa9dddso490497a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705511295; x=1706116095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AV1Xs8Uzv15NB39V5qvNYhyXqB67iNd1v0FY9XutDNA=;
 b=fm3tjlwFgOmwFAxAkNSQrht/XFgeo26Q/Wn6Gt0Zr1M6ujgKCdERL+0+ZtsDi2nMQ6
 MvDlLsgJ5KR5IOOjdfhgm+XC5h3tRFBYXo1v3D+MWBjkSl8HeiBpsHHaX3ZIpgld7vNw
 p/wdGSOrnD7YoVAcC1kJfuu4mFb6JCuMXm399/f1F3iRL278fA43LXMiv1zMtsp7RuXV
 VlCJbo8ntf7etp6liLln9oJqFktHkjlypX8qB5WsjqZMfGKXWJnm2nM70dFsOmuAvQHl
 yB6hSMmeYdBWnke3y5b0RRI3iGW9VsieD1uNmT7GzVo3yNtxn6DgFZOxiP5MVcJsYNev
 aTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511295; x=1706116095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AV1Xs8Uzv15NB39V5qvNYhyXqB67iNd1v0FY9XutDNA=;
 b=dgTqosLhlUbCNo7RbsJRIOA3LSvOkKBfZ4b993JwUglmsbWTARZwzq8JX9BwKnRpoT
 K80pLmDJZ7zWJ0eUHB4T4jpFkhwmdaOKvBkvxuPllDRuF9zsGr1q9pVvvFA32+FtpO5d
 LROWg8YwJN3V3MkU42yI/4Rw8Yr9k0eGRiCoxVL4afmyNg5gW2LhumZC37p1m0vIbIKH
 gyutYo4dUkpuEbwXHzmrN8wDoh+8FZWFpnm9EyEgNR9VZA4R1UizVOLpqpr2A0VYJmwa
 hVQ2xrDePHa/ydwYVmXv9d7URatZ86kbjLttn9OgGQm/lg6Pt6s0uSIMSQJfrIruGT47
 fujg==
X-Gm-Message-State: AOJu0YxNsKvAG3wmJnAj8W7Oiu0PzReL7OSWae9D5ifxcM/5yxZacm9F
 oFNH7FF3+7VzYGuGnCIGW9g6N5qpOpjeNQ==
X-Google-Smtp-Source: AGHT+IGx8qLDoMzH9eH49IesIczPIVddPeF6C9IQPqjvxMOsMrtqLr+ar5MM+QnH44QDtZ0kIuPuCA==
X-Received: by 2002:a50:9f44:0:b0:559:ba18:1662 with SMTP id
 b62-20020a509f44000000b00559ba181662mr1317549edf.8.1705511294926; 
 Wed, 17 Jan 2024 09:08:14 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 ez6-20020a056402450600b0055803202e83sm8340090edb.67.2024.01.17.09.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:08:14 -0800 (PST)
Message-ID: <fcc24183-25d7-44da-8a99-1a9ef69a6993@linaro.org>
Date: Wed, 17 Jan 2024 18:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240117164227.32143-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117164227.32143-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 17/1/24 17:42, Fabiano Rosas wrote:
> Avocado needs sqlite3:
> 
>    Failed to load plugin from module "avocado.plugins.journal":
>    ImportError("Module 'sqlite3' is not installed.
>    Use: sudo zypper install python311 to install it")
> 
>  From 'zypper info python311':
>    "This package supplies rich command line features provided by
>    readline, and sqlite3 support for the interpreter core, thus forming
>    a so called "extended" runtime."
> 
> Include the appropriate package in the lcitool mappings which will
> guarantee the dockerfile gets properly updated when lcitool is
> run. Also include the updated dockerfile.
> 

Suggested-by: Andrea Bolognani <abologna@redhat.com>

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/docker/dockerfiles/opensuse-leap.docker | 1 +
>   tests/lcitool/mappings.yml                    | 4 ++++
>   tests/lcitool/projects/qemu.yml               | 1 +
>   3 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


