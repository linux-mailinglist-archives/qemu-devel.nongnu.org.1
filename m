Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D4A7AF50A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEdc-0008Du-RD; Tue, 26 Sep 2023 16:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEdW-0008AP-Ce
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:26:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEdU-0005lS-Sa
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:26:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so11010624a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695759983; x=1696364783; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XVK+pCP/Y2f69DiIvXasyz7c++tXlqJ7J7gV9eUHJrA=;
 b=guSYXa6MpLSFx3j/x76atGD+CKQbOHnZDbZsRIoEv1ZxsnQI92lyfKc6sTcQZ/qA6O
 DKr4UpJArt8uUZky1BaeaGzz98rGnUcaHnTCcawhBHG3LTOl184syJ8g26qSfJ0U44hI
 ts/5x/iUbDXfQDJYlkbB8vvRNatMOoNPwHA0sot7E+3zm+Av8Y0pEbj40KHm0fjjwmED
 PZSnQiGxAes9IXs2NhAXF4ulEMhTIRE705TyR2p0unMnai4pc+mHJpY/mRqYleqRQ5JY
 +dZV6MJtIDjVRNGzyd7Nr1A0sAlB0R4+3uaMre/cq8EZCZq8xNVIWlQNKfLQGgP4FaZ2
 Gmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695759983; x=1696364783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVK+pCP/Y2f69DiIvXasyz7c++tXlqJ7J7gV9eUHJrA=;
 b=eW8sMpUIg6aABr2wppaSkYLOMRciIZ3PxanXg3sSAP7l3XjUyn7pzR01LKWoKQkZqP
 f7o4GBDSsEXyzViQc1IcouURVJ5mm+VVtl0WQ2Cx0KLfxgnSO/U9iCtcO/JMi7IF3Jjm
 grC2tK2E9LX2y9rW4w9oiAWnbwVEQnnyK+D+rE/3c5W9mg+e/Mgk6GI0Z3w4R/sdVjiK
 m/eURgFwqytlCggbH069pMFvuFAyxm9oiNs221vYX8tOED0creXB2EwAKjIuwGQoSMto
 4R2m+pgDIwc1YE4aE72ukP3Emtsg9Y/uUzGphMJC2Y+hInW43epBikcmpg5FiB9r+dzJ
 sH2Q==
X-Gm-Message-State: AOJu0YyZg41imAIdH3CwdIxMuuAVVJi0/FBuKKv+xFtJq+9kvkytEDuT
 U3kH1iMWQJry3TFXePddRvB3rlJoKQCN2xek89Ljbw==
X-Google-Smtp-Source: AGHT+IGE8csGr8Oxz2Q8txHVU5m/PugM/et3axI5QpmbiUWI1FLQYJRN4LhlwOJE5uVdpa/WiSyOinwGcIEyMgS9j3w=
X-Received: by 2002:aa7:c98b:0:b0:530:74ed:fc85 with SMTP id
 c11-20020aa7c98b000000b0053074edfc85mr128936edt.3.1695759982843; Tue, 26 Sep
 2023 13:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-5-vsementsov@yandex-team.ru>
In-Reply-To: <20230926201532.221152-5-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 21:26:04 +0100
Message-ID: <CAFEAcA9LVaJSuj0XTNRH3RsDgZR+Gm82mOBzOZ8XtBgy4_BHCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] mc146818rtc: rtc_set_time(): initialize tm to
 zeroes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
 davydov-max@yandex-team.ru, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 26 Sept 2023 at 21:15, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> set_time() function doesn't set all the fields, so it's better to
> initialize tm structure. And Coverity will be happier about it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/rtc/mc146818rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

