Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F4B81E857
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 17:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIAC1-0001io-G5; Tue, 26 Dec 2023 11:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIABz-0001id-Nb
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:22:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIABy-0000xK-0j
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:22:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso4510025e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703607724; x=1704212524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLxU7EyhBDGPc/H234EyJJg3Ur4y5X4RYh2R+ucDxfU=;
 b=XmVkKZUczGVJCF0+QrUWTk1JLHZe1/0bZFftUPRBiMPfhrv+M2kshNEvlELu/EuNsg
 BhPmVfITUZ805mdFrjR62LqEOsljncQEnKCl5MvLR82tYv6JrYSoCoTg9fJw1mrCwiyy
 1gt+Qiu8eciS5GRUfSfUVgRI4YvfIsBRnxDvaQOeD0bR1n6PH8cda09//gdq9qupjHlE
 F3MiMQlRVeNLjbZFj/4+DWVCv02KdLT2RSPGWDEAqT0AzcVFBivPKaeIJX3CRGLfkOKF
 PlDa9VaZA2aJ0OkPZqsvzw63FZwUCK/zUr+6x9dxq1WoB7xPFd6ourcRaWldmkumY1b1
 tFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703607724; x=1704212524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLxU7EyhBDGPc/H234EyJJg3Ur4y5X4RYh2R+ucDxfU=;
 b=R6+TW+FGvYnLSwlAneWTpmOn+QVboh+4s0NGlpgnbehINrEPS2lh9UEZKUPVtCIuce
 /vMl6ev8h3V3sVN+VqGqYzpjzBjlow61Xu+afNDS/A9ZtUEbiPfknOMswaCDMNBQ7Vsr
 fPBsdnzVdg+YqLp8iymVf397qN3gHHnuSPUn6BbDpqGh0Dnmrd0b3RrCkcLJK7OaNcvI
 ImtHdwPBbeVQcsp8cyaHpbcTK4dtw4MyQP4Nix12zcpnQOhulR83btH9Mq8Sp/aQqb0N
 TLVXRlty2U+pbu0CWcG9J/65LYo6XtE3MwGWh9ZGDkdvnWCd4qSpg+m+gMlLvoSSaJ2e
 VLfA==
X-Gm-Message-State: AOJu0YzyvU1SX/m29eLCKbEBKs9WZq/mEenPAdKKnX7ZtZ5L55Qu/Pnh
 6ZgUuMZ2q27HqS/2vMoTqUK2g0EOLcKwww==
X-Google-Smtp-Source: AGHT+IGDvrDWxWqyCj1SOTLa+WLAlE0t213uRV7TfUIMQJFdTov3YC8BqVsQogNbZYodsRekIUIIGA==
X-Received: by 2002:a05:600c:4e09:b0:40d:58d7:638d with SMTP id
 b9-20020a05600c4e0900b0040d58d7638dmr1131990wmq.84.1703607724202; 
 Tue, 26 Dec 2023 08:22:04 -0800 (PST)
Received: from [192.168.88.175] (97.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.97]) by smtp.gmail.com with ESMTPSA id
 p35-20020a05600c1da300b0040b360cc65csm21656617wms.0.2023.12.26.08.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 08:22:03 -0800 (PST)
Message-ID: <1e94160d-09ac-474a-938f-364fb7f0a778@linaro.org>
Date: Tue, 26 Dec 2023 17:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson.build: report graphics backends
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231222114846.2850741-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231222114846.2850741-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Alex,

On 22/12/23 12:48, Alex Bennée wrote:
> To enable accelerated VirtIO GPUs for the guest we need the rendering
> support on the host but currently it's not reported in the
> configuration summary. Add a graphics backend section and report the
> status of the VirGL and Rutabaga support libraries.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   meson.build | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 6c77d9687de..93868568870 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4307,6 +4307,12 @@ summary_info += {'curses support':    curses}
>   summary_info += {'brlapi support':    brlapi}
>   summary(summary_info, bool_yn: true, section: 'User interface')
>   
> +# Graphics backends
> +summary_info = {}
> +summary_info += {'VirGL support':     virgl}
> +summary_info += {'Rutabaga support':  rutabaga}

These are already under the generic 'Dependencies' section
below.

> +summary(summary_info, bool_yn: true, section: 'Graphics backends')
> +
>   # Audio backends
>   summary_info = {}
>   if targetos not in ['darwin', 'haiku', 'windows']

Instead you want to move to your new section:

-- >8 --
diff --git a/meson.build b/meson.build
index 1bf526d653..ad7d870321 100644
--- a/meson.build
+++ b/meson.build
@@ -4308,4 +4308,11 @@ summary_info += {'brlapi support':    brlapi}
  summary(summary_info, bool_yn: true, section: 'User interface')

+# Graphics backends
+summary_info = {}
+summary_info += {'OpenGL support (epoxy)': opengl}
+summary_info += {'VirGL support': virgl}
+summary_info += {'Rutabaga support': rutabaga}
+summary(summary_info, bool_yn: true, section: 'Graphics backends')
+
  # Audio backends
  summary_info = {}
@@ -4343,6 +4350,4 @@ summary_info += {'libtasn1':          tasn1}
  summary_info += {'PAM':               pam}
  summary_info += {'iconv support':     iconv}
-summary_info += {'virgl support':     virgl}
-summary_info += {'rutabaga support':  rutabaga}
  summary_info += {'blkio support':     blkio}
  summary_info += {'curl support':      curl}
@@ -4361,5 +4366,4 @@ summary_info += {'U2F support':       u2f}
  summary_info += {'libusb':            libusb}
  summary_info += {'usb net redir':     usbredir}
-summary_info += {'OpenGL support (epoxy)': opengl}
  summary_info += {'GBM':               gbm}
  summary_info += {'libiscsi support':  libiscsi}
---

Without duplication:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



