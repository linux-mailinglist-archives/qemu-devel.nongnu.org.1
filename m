Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F27A49FB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDZR-0004gY-EI; Mon, 18 Sep 2023 08:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDZP-0004gH-20
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:41:43 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDZN-0000o8-7U
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:41:42 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50309daf971so2347376e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695040899; x=1695645699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3DBEATUhrUmNTQdwzEHc4hoswf6rcuMK8fN1Oh2dtI=;
 b=XSqQMmpVrtUiNtuscMGULrphNq/4gV+xe0V09TIx1hm4nvfcH7Pp2JBogsTPUrXwX5
 wGKY1Bl8MPBf12TBVTqCwWbQYTjKEbWRhTsd5KPpOlSbeWqzuhsYxpgAiCbITC88zt+X
 XVyRFeJajNHFWZ70/7W5uGW9v7X0s7ReSLZ/vVQCltdOUuxBHntGk/ZAbrVzCeDF+bwg
 2IEkVMd28e4/7VbJhIt4wsuPvzqQsZFEsFATIhcq6kyUlCmqN+xyInkYdtCw6D3+vubV
 +CflZCsefbiFevNWj6MaFg0Lr29xWSj4CZkI+lHgEGPL04qXXhX0ku8beMK7w8OL0qzp
 JT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695040899; x=1695645699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3DBEATUhrUmNTQdwzEHc4hoswf6rcuMK8fN1Oh2dtI=;
 b=N/0S4kXeoxA/S5x9gZLEQOo+HdMAF6yc5tDz3SNHhULE+4Abnjprkx8nms1BPlzcvB
 L3AugFJXNm1wZsnOUyX6hnMXgwMri7Qc3Mv1r8aSFi+dLlu1YJsqLaK2N8v1+0hg0PwK
 dn5LDfWxiOZMRxb+JAM7IyYtNK4F0WFf/i3HM+D/DoY6Jv7aJqJMRpk3YSDXkz77J4hs
 AONnXMEiF5G7PRTUj4tNesRxMgMGUjKVl2ba8Y8gLvsohYIQE5hMwpEmWYS5DgwjfCPB
 2mYqvEigo68WCCaVvNGTy1wLrG+7cjFpB3uj3DUbBbFvu2DNftg/Uh/RDWjFIux3BuTe
 URRw==
X-Gm-Message-State: AOJu0Ywq5oHJ5/yRqeONr0T79uiysFdJHpqMBrTaTSR09H/WLNqerH3e
 jWRmTFfTvHtX7LcD7xEAbDvf6W/ErN2aZvHREHU97KKIN31HJSK/gl4=
X-Google-Smtp-Source: AGHT+IHU9lDfaZjrMl9PFf+5NVpJiMCRsAa0/xF2dj72P+sUzvOq52DFKkgbeAVu/Q5tsNzJD6dI8tCPKGrkxiTIlpw=
X-Received: by 2002:a05:6512:2039:b0:502:df85:c049 with SMTP id
 s25-20020a056512203900b00502df85c049mr6247403lfs.2.1695040899192; Mon, 18 Sep
 2023 05:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <2023061615433049315231@phytium.com.cn>
 <ZIylkIt38MXaTytx@memverge.com>
 <20230619105809.000007b9@Huawei.com>
In-Reply-To: <20230619105809.000007b9@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 13:41:20 +0100
Message-ID: <CAFEAcA8beGka0AzEkX4SE1B+UwFpck2_0gWM9bV5WgFbWQYB1A@mail.gmail.com>
Subject: Re: A confusion about CXL in arm virt machine
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Mon, 19 Jun 2023 at 10:58, Jonathan Cameron via <qemu-arm@nongnu.org> wrote:
>
> On Fri, 16 Jun 2023 14:10:24 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> >
> > Last I tested cxl-2023-05-25 branch of Johnathan's fork is working on x86:
> >
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25
> >
> > I have not worked with the ARM machine, but Johnathan may be able to
> > comment on the state of ARM support for this code.
>
> ARM support is not yet upstream.  There are some precursor problems we still
> have to solve because arm-virt should also support device tree bindings.
> See talk I gave at Linaro connect that includes some of them:
> https://resources.linaro.org/en/resource/hM986DSHfoTrZ98UjpvLg1
>
> For now, I'm carrying the arm-virt + ACPI support on the tree above.
> There are a lot of things we still need to provide support for in QEMU CXL
> world so for now figuring out the path forward for upstreaming ARM support
> isn't at the top of my list.  I'll get back to it at somepoint - probably
> next month.

Is the Arm CXL support still out-of-tree? I ask because at the
moment docs/system/devices/cxl.rst has some aarch64 virt command
lines which don't work, and we've had a bug report about it:
https://gitlab.com/qemu-project/qemu/-/issues/1892

Could you submit a patch to correct the documentation, please
(either fixing the command line, or just deleting any claims
to aarch64 support if it's not upstream) ?

thanks
-- PMM

