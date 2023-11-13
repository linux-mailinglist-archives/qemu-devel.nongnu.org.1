Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547627EA4F6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 21:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2diV-0006If-CW; Mon, 13 Nov 2023 15:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r2diR-0006IX-49
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:39:27 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r2diN-0008J2-Sd
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:39:25 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5875e24c749so2607297eaf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 12:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699907962; x=1700512762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zLjJpSGlxlbmZ2kuN0eQ1GUmbWuX3Kcc9vxpb6XAUiY=;
 b=egzTDtaSKkbvvvIz9li8U8T2e9DZe4FqJYvZGctS0K6hS68hol1mrCmykN0VZ+LylC
 /Gwzih+zMlKENzaiZVtINIkQKQO9yZG0/5nPKptml9k6vuG5dMWRIokHkdTkfsysVtoS
 t854P8BQdlISED1kUQTKyli7a6QlnvHUPhYAgJOSdHUYPNYnKZnSV4kErw3IOhyd8EkZ
 88H6OHbn4LA2/JYnsQ8l7+7Cim/+4+HFnVnnjC/6hI7dnGCOjlk5im25+Kg3riURFv6e
 fZqjP1wh+v9zEHpgORIvXRQpy9DNctWxlSXdtZAKXefZDWmi0O3rJ/B74obE2A0WHJxP
 /uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699907962; x=1700512762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zLjJpSGlxlbmZ2kuN0eQ1GUmbWuX3Kcc9vxpb6XAUiY=;
 b=ALT9JSfvoaUc3aHUsKeyaKo8V09b/ujtj8G7VR4FL1XJU1rtBFRFXsAxaPiqQRqg3k
 NHPUI9C9l0dBxmOShLr/ui6dKvqDDZ21UgZxpyxs2OTY+uscAT5VqCMpPvPJ5cXsWFp0
 /DcHXoh7rR+E06G7WLfNl+Lmxr6FHLpOnvhMdr4ZjZuyCgQP1qg3Tbf2EuIF35rSWxPc
 crwdFs25bai643CYTGtYcE0n0/wWmA0CXMu0XRruMt1rrYsrXyhdij/ZAE6X8POB0Noh
 JDUiX3c7CGns4jHQQJg9qhNX7XVBw+FcLAW05wKosYyfZf9UZIBgSkzBYpmyt2ZE1vuG
 cGpA==
X-Gm-Message-State: AOJu0Yxg+xz2mj0N/GNlGmi+gtE3b8oI9BXf+oU1LK+MO8nyOvJJvJ4N
 pelybPJLrEDexRKq0Ov3pONDSgcsWeO47y2CDk0=
X-Google-Smtp-Source: AGHT+IHcIBUeEaI6ryCS3mkrGn0iU9hx2VRv+YwCWD9d/Bzz6ngNeF04UBMB2jrBAO+B/xn9zCE4Ld1YSp3wwvU9bJI=
X-Received: by 2002:a4a:3859:0:b0:57b:3b48:6f11 with SMTP id
 o25-20020a4a3859000000b0057b3b486f11mr9181081oof.4.1699907962001; Mon, 13 Nov
 2023 12:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20231111004920.148348-1-stefanha@redhat.com>
In-Reply-To: <20231111004920.148348-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 13 Nov 2023 15:39:09 -0500
Message-ID: <CAJSP0QVFS9D6vBrtrfG1wQMz2+OBvBETYQy_c593zs1GPC3W=g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update virtio-fs mailing list address
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Applied.

Stefan

