Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C37E296B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:07:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r027A-00044M-MV; Mon, 06 Nov 2023 11:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r0278-00043v-Bd; Mon, 06 Nov 2023 11:06:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r0276-0002a0-HB; Mon, 06 Nov 2023 11:06:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083f613272so40717365e9.1; 
 Mon, 06 Nov 2023 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699286766; x=1699891566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MeZXKteg9ly/LgC189oPLkONMw9yBgVhmCgiKF0kD7Q=;
 b=kp4uI0mJGfb7i7egpKxnWtlmRCQhDR76XCNgHGpSwSjCn97Oei9LFqusnHdZuY8ynW
 nI6GmZSdi+nkH8tPB9hBuWxgfyu+8r2TjmwpbL4kJTUewgdaNzPKYw7jaD8GXlZWV/RY
 EhLptigf7l1JoLFqenaBRxSU1I2/IQf8LsCfViDMlnGc53pOY4b9c7MTiFtaub1rhwKZ
 ewH0khCDIQ25R+KlEHzq3vFcEQ69BArgbnbaMOdi3I9REC5BiUOb2IWLLB3AFNqWhuRa
 psd2MAFcZGdkuIH5+tXqv77JnksvyDPNCAePNbHKD/EGMzsKYYyfqr+RzwaLcqtP9o3i
 X7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699286766; x=1699891566;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeZXKteg9ly/LgC189oPLkONMw9yBgVhmCgiKF0kD7Q=;
 b=NSiR783HMdU4+4t6TFQXGy2o+6i7mLAJDoh8GSIHVRBjIKZqRO4SYApa7LgcrAn37k
 ufcFPReb+rhqHsPt0o6FTiSy/B8O05pXe0vk67J0IewKsvSAvpnq1C3ARxY+4X1lFWkA
 +GoI9Ax5MtfDCrji+wYVFFwUm2iWtG4joaHSyRWhDBTzUoSvcQxMhgmeF4yfnZZ63USl
 uKbF1MzUidwsIfmFTAHxBWrfww6AIUYMD8aUR3MZNNrRQYPh2//jIxPAzfLjeDlNXSp+
 6C8tnA9OdToU5mSbJ8wX8iY1yOuT+AYrSs7MbhhwMCNXo+IjwUH9xdIwmlEUbsoZNd7p
 NBSQ==
X-Gm-Message-State: AOJu0YxgdzWvaCya8dX1nrO84X2WRoajCnhd83ObHQAjq1Pi3wyXjP7u
 jXG9oJKtCAkh4JUTv6zgR34=
X-Google-Smtp-Source: AGHT+IHSWnf3wN6plpUIgGebG8qT3uQ6MHwdZ3cvFdZB/eJDKIi8+G3R12MVZ1RUvoie9Yarv/csaQ==
X-Received: by 2002:a05:600c:1d19:b0:409:5a92:470e with SMTP id
 l25-20020a05600c1d1900b004095a92470emr102303wms.28.1699286766483; 
 Mon, 06 Nov 2023 08:06:06 -0800 (PST)
Received: from [10.95.110.31] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004094d4292aesm12576758wmo.18.2023.11.06.08.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:06:05 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8531c820-549a-4979-9575-e659ab1b6659@xen.org>
Date: Mon, 6 Nov 2023 16:06:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/17] doc/sphinx/hxtool.py: add optional label
 argument to SRST directive
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231106143507.1060610-1-dwmw2@infradead.org>
 <20231106143507.1060610-17-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231106143507.1060610-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 06/11/2023 14:35, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> We can't just embed labels directly into files like qemu-options.hx which
> are included from multiple top-level RST files, because Sphinx sees the
> labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707
> 
> So add an 'emitrefs' option to the Sphinx hxtool-doc directive, which is
> set only in invocation.rst and not from the HTML rendition of the man
> page. Along with an argument to the SRST directive which causes a label
> of the form '.. _LABEL-reference-label:' to be emitted when the emitrefs
> option is set.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   docs/sphinx/hxtool.py      | 18 +++++++++++++++++-
>   docs/system/invocation.rst |  1 +
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


