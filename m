Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA87A54F2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 23:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiLgi-0008Rf-MV; Mon, 18 Sep 2023 17:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qiLgf-0008R9-5C
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 17:21:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qiLgd-0000d5-6Y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 17:21:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso6162951a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695072100; x=1695676900;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qp7ijy4o9sGSDsF0679ir2MQzijqTNvVHvPAvf3uHhw=;
 b=plRIcaG7AuUOX3k6UCRUfWPgdRkhtWAehPL+fjxsHFH2skh8IZaX5QyNdRlhRkE4Oc
 j2iOWnI6Lzv+n52XjtOkTYIpkXls4AHKRXSVkqKVk5O4iADN9qA/d3IScs56tODW/5iI
 yoqfbh18LjOOrOKeVRH9WXKjN1jmMjtVEB5kU0ZrV51RBijgUIIPcOuOCwuSYza1K7b3
 n7p8tQbJp3ChgDi7xI2tQMcmODNEUpq1NJrhhp4EWg6XkhqSt0YZyTqfFuAGE33fXLst
 rgWHUOxa+ZySMVDLV75/t2CUPydu9WaqTgMIKmlwiHxtijGh8olawm3zQj25WeAo2o5H
 Aw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695072100; x=1695676900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qp7ijy4o9sGSDsF0679ir2MQzijqTNvVHvPAvf3uHhw=;
 b=ZDCX0Ehy960QZNWYSQBmnp18e6q7Sz7+KdaBHwyYV/9xuGzudz+9a0UA6qmFIi/XhE
 iVWigbS6slcse1R37Thc7qmd9c5hTk37OpTA2gBV2H8c/njLKfpQX2xSTOh3T1gjPE0E
 Z5Svlr90e9btFwrBcsNamzq/e5dcdhKmCn0DUvC0abyrd0vXkBtpfxk9PvpBhLMD1qip
 3cmsVE/Ilzy5cIqh0PKT2N60uVYU7Id/sBAUrKHF+YYYAAkY8adkpIbSvD8DyXP5QZxc
 y1tSxdRwgj3ZcDRg19vUPLQNqDwLWv4uw5VfShpxLF1S1R/MgbdMxUni1HtqI8D6NIRQ
 XcAw==
X-Gm-Message-State: AOJu0YyGMAUHd5R3lfqkvRnQzMDu5+dtu5aPwlatiUl26L7SIpOMkmIK
 Lj+Whcv+btWqyE06tl42LwgjN+kFATbxpauNRm0lig==
X-Google-Smtp-Source: AGHT+IGqHiBDAAogFWQruR5zI776cTJZ2c8cKasv9g9QDWk6xazHXnmWIxL7Zr4H+LjfQKwK/ubnPsaCrWJY5gzvs4s=
X-Received: by 2002:aa7:d699:0:b0:523:bfec:4915 with SMTP id
 d25-20020aa7d699000000b00523bfec4915mr8782681edr.0.1695072100546; Mon, 18 Sep
 2023 14:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 Sep 2023 22:21:29 +0100
Message-ID: <CANCZdfo9ki-B1CgqNN5pLyQggNxV+MYWH4CCsACEvS7TpmcRqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linuxarm@huawei.com, Peter Maydell <peter.maydell@linaro.org>, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Content-Type: multipart/alternative; boundary="0000000000006c22bb0605a8ba60"
Received-SPF: none client-ip=2a00:1450:4864:20::52f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000006c22bb0605a8ba60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 4:04=E2=80=AFPM Jonathan Cameron via <qemu-devel@no=
ngnu.org>
wrote:

> This has been missing from the start. Assume it should match
> with cxl/cxl-component-utils.c as both were part of early
> postings from Ben.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c5855d4e7d..ad3f0f6a9d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,3 +1,12 @@
> +/*
> + * CXL Type 3 (memory expander) device
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See
> the
> + * COPYING file in the top-level directory.
> + */
>

SPDX-License-Identifier: GPL-v2-only

while you're at it (plus a +1 on the other concerns in the thread, though
I'll let
that play out elsewhere).

Warner


> +
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> --
> 2.39.2
>
>
>

--0000000000006c22bb0605a8ba60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 18, 2023 at 4:04=E2=80=AF=
PM Jonathan Cameron via &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-d=
evel@nongnu.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">This has been missing from the start. Assume it should match=
<br>
with cxl/cxl-component-utils.c as both were part of early<br>
postings from Ben.<br>
<br>
Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Signed-off-by: Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huaw=
ei.com" target=3D"_blank">Jonathan.Cameron@huawei.com</a>&gt;<br>
---<br>
=C2=A0hw/mem/cxl_type3.c | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c<br>
index c5855d4e7d..ad3f0f6a9d 100644<br>
--- a/hw/mem/cxl_type3.c<br>
+++ b/hw/mem/cxl_type3.c<br>
@@ -1,3 +1,12 @@<br>
+/*<br>
+ * CXL Type 3 (memory expander) device<br>
+ *<br>
+ * Copyright(C) 2020 Intel Corporation.<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2. See th=
e<br>
+ * COPYING file in the top-level directory.<br>
+ */<br></blockquote><div><br></div><div>SPDX-License-Identifier: GPL-v2-on=
ly</div><div><br></div><div>while you&#39;re at it (plus a=C2=A0+1 on the o=
ther=C2=A0concerns in the thread, though I&#39;ll let</div><div>that play o=
ut elsewhere).</div><div><br></div><div>Warner</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div></div>

--0000000000006c22bb0605a8ba60--

