Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B436F7E9422
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 02:34:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Lpb-0005HV-1y; Sun, 12 Nov 2023 20:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LpW-0005HA-0Z
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:33:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LpU-0006Ve-Dj
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:33:33 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso3607077b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 17:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699839209; x=1700444009; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l3fJ1yQSq+FPsm6QL4pljo/qEW/H3/8X9dmFKtx5GY8=;
 b=HoD3wIv3FhcRP00AyXy/oi3r8G1zs9QVHX3Sqvyb37azw5NdqZp1jYPaJVanoAFCvm
 n4PV40wa0IENVmP6Z91n0wpPackKj0uVuJAQ6OTg8j+rIFxTjsZ566ZTJVlZ6/5CJPDP
 jpzKBbAW38+VcohuxxkyvcK86hMonH/8vXjqYmMfNJsIpdIGuXB0ScXv0TWV7BOTaBUC
 djPOWc0jz6ZVLzdENlRjTNEfhHA2go++uzFmyYXdHCPslkcE5iOiGoOy1ZUAFGJqLDse
 vBNx4iUbNWPhkPXSkHVJ0xb81I7WiI3l5wAuTH6MyYW6+s6ykmmQ5E4Aiom1+wpBEWsr
 FobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699839209; x=1700444009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3fJ1yQSq+FPsm6QL4pljo/qEW/H3/8X9dmFKtx5GY8=;
 b=NUdyIKgkJyyyZQCrrYxrUKTClHRp9jnsArcAglZkfPxvmgviTzKoQhToMmpkJsINNW
 4vt2nwMfMRJN6gZqk+jvgX5cuEhu9Py/hteJRZD0016CMBwp8rRkfNwWPsvG9h/c+VoZ
 gAz/Gk2BiP9nVQFidkOfQVsOb2Hsn3UfeP9k69KIl68XGCmQbiNSg/aeIgAI1qaDGzfR
 RRC0KBCsC7ccP3wtRDazjAIiUBAr8oGH2wgnqs1fzTawxoWGPLEAc1wylmBondKFvMDW
 qYIwr1yvRM4sFqNrVuT8CAPIY/c646b5ts30mJcD6bBmDyvRIjNA+jW/16jQmUTX3A/X
 AASA==
X-Gm-Message-State: AOJu0Yzv40WkeTs7LrhAMOvYktCvAeN2MDN+bNZ63CmHzOBW87REbJou
 +Wip7Nm5JdHyhJAJPBfAgEBXxAigVoWJksbQT4TKZQqVhIP30Q==
X-Google-Smtp-Source: AGHT+IEAhnuynNJ3X46+3bX0CXStzZ56wL/5uQZApDqDua9fcQ4S6hj/zn0wdLJ4uyYKjjZDcDcuXA==
X-Received: by 2002:a17:90b:502:b0:280:29df:747e with SMTP id
 r2-20020a17090b050200b0028029df747emr13545049pjz.1.1699839208809; 
 Sun, 12 Nov 2023 17:33:28 -0800 (PST)
Received: from leoy-huanghe ([128.1.74.235]) by smtp.gmail.com with ESMTPSA id
 l23-20020a17090a599700b00274922d4b38sm2860556pji.27.2023.11.12.17.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:33:28 -0800 (PST)
Date: Mon, 13 Nov 2023 09:33:14 +0800
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v1 2/4] docs/system: Add vhost-user-input documentation
Message-ID: <20231113013314.GA49717@leoy-huanghe>
References: <20231113011642.48176-1-leo.yan@linaro.org>
 <20231113011642.48176-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113011642.48176-3-leo.yan@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=leo.yan@linaro.org; helo=mail-pf1-x432.google.com
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

On Mon, Nov 13, 2023 at 09:16:40AM +0800, Leo Yan wrote:
> This adds basic documentation for vhost-user-input.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  docs/system/devices/vhost-user-input.rst | 44 ++++++++++++++++++++++++
>  docs/system/devices/vhost-user.rst       |  2 +-
>  2 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 docs/system/devices/vhost-user-input.rst
> 
> diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
> new file mode 100644
> index 0000000000..601282e658
> --- /dev/null
> +++ b/docs/system/devices/vhost-user-input.rst
> @@ -0,0 +1,44 @@
> +.. _vhost_user_rng:

Ouch, a typo: s/_vhost_user_rng/_vhost_user_input

Anyway, I will wait a bit for review before send new patch set.

Thanks,
Leo

