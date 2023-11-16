Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F97EE1B3
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:41:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ccO-0004Xf-03; Thu, 16 Nov 2023 08:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3ccK-0004Wv-Ki
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:41:12 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3ccJ-0002zl-0l
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:41:12 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so1073842e87.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700142069; x=1700746869; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lmYEG3tOrqPsmAFwlmUArvOzpuuxH/s7adjrD2ARj5A=;
 b=FNsLQAAM0PbL7ZPokVtFxvTyTpwtDSl5b71OUmhxj7ri5JxUgqaMOkmUIMNe9ZJpFv
 +mO93XaiZJWuYhEU9dl56ShxkM9SgqX8SDW/KcOFSNelnBQgDRyMs+ibYvQZY3T8gZ4Q
 LcDKfbEiAq4O1xt78KGgp21TwoAl5TTRDi/pdPxntoetQJ06v5RqLsLdL/2Jv+QdwX1f
 XPe+95Za3kwvZLfjS23H1DO1IdZv2Wai6P0ke+Fr4lF6uRkRYb60DwQN2z/fNYxb5EAE
 kgq7kV8muCNrTqCvvaMPe00t5ATj901nGbSIdHvtoXsyD1Coj5ZKreClgVKefk7CjTHh
 SwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700142069; x=1700746869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lmYEG3tOrqPsmAFwlmUArvOzpuuxH/s7adjrD2ARj5A=;
 b=aJFJnPIT8hVriDXUIiAYDn8CJCHr2jroX+Gv7PCS2sdcZzniO9qQH1xxPh4XI3aTCY
 unvVEID1q/N3roxk4vm0R5coRFJfVpg0wNIQcq19vgHRwZt7f1YiHRi2H7Kp40kDVtmi
 mr+0rxOOXJflUQxvE0UjwUB0TYVuS/M9vXx7KpYbSa3zUWboYt4bz1XiMWvUsqlPGWad
 qAIBaxROC5n7S68ge/hb+rFRAATfiTwwXeKwTG8uB/i08ySYNDV1lsATbzaFbLtF8Dh6
 Oq9mMnSBHh3rDD4/KN4U6mERFmhIwn/sJ7E0A3nPpcBkIEWLRL+s1HiUPPkGEPiETXct
 2xMA==
X-Gm-Message-State: AOJu0YyvMTXd7M9TTKJwO3d1YYtZRD7XpPQPBxi2DuWbkPZdssUUUf+F
 eduErZG+dtNrsLN/X6rWDAyALStG8yaEHcLkpn3QtA==
X-Google-Smtp-Source: AGHT+IFT4TGrDu5+eoUU33JUCQYlZtws/v2HJK+TeI38l91/vp5lj1Vi6Q+YESYdBppMNzkJB5otgOkwIJ8VuTfHLlI=
X-Received: by 2002:ac2:51ac:0:b0:508:1227:5a10 with SMTP id
 f12-20020ac251ac000000b0050812275a10mr9530565lfk.23.1700142068935; Thu, 16
 Nov 2023 05:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20231116131454.541434-1-thuth@redhat.com>
 <20231116131454.541434-2-thuth@redhat.com>
In-Reply-To: <20231116131454.541434-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 13:40:57 +0000
Message-ID: <CAFEAcA_0yGAm_=mOSRe+1ci6L7jO2v8agKQwLSP0i2n2K72oxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Thu, 16 Nov 2023 at 13:15, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Markus Armbruster <armbru@redhat.com>
>
> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> [thuth: Use longhand syntax to avoid problems with the "." in the name]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

