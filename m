Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E067B29DE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1ZG-0000NX-QV; Thu, 28 Sep 2023 20:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1ZE-0000NF-Sk
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:41:16 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nbowler@draconx.ca>)
 id 1qm1ZD-0006Je-Et
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:41:16 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7a803afa8c5so5138695241.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1695948074; x=1696552874;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QfLlRviRWWWW8hdXiWwDl097ymzJbzlyf8hvafoJzcM=;
 b=Aqnl4PgCgnO/lQAMHwSvjhOxAyeXNTPQG6p+LlFEZ4IwyyGZ7dvT0kPxCteW8jxXR7
 4r/lbx2MC2oSRDRudXCeAVEOyqQwAFlSRJDdzhXwF50LykVIes9oDcN4eavTe5uhPBx0
 IuRTHvxngEAy6yZ3/kAbrkPWQpIi6ul7QHJnCyfrsVY9wY8KZVbMKCsdW1rBZKpCYJea
 Fif/G9r2RMXlKPq6v7xSmsDzQowpxd1NfhBJve8SUFug5flUiBYgXeQDBvuZue203LNR
 3oe/i5Myj9ZGCBeSAGiyVn1cmdhItPD+79vumxLEaLb5DzgISdDtpqn/EsewX771mCqh
 xbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695948074; x=1696552874;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfLlRviRWWWW8hdXiWwDl097ymzJbzlyf8hvafoJzcM=;
 b=k7Hi5xREcYo8dBlEJbaq6GB3q7QoXp+Oj3DG/Td1MPyg/apmGf0qO0ORK2d/V65BVP
 YH/ry+f15r5zUfW1OvC/zxEgJ/anMbfZEXVHEX6OnYUaldMV4OjrYes18Sjp0Wfc2atg
 ObP3OKG6htQvf3ATtSJwZW6/1SUtpnBVETV+O2Pi75eG1uWDC+D0Mp7KmShmbtTQHYob
 f2A4BcB58U/azwgJA+yFRl8PQmzRdXIJU9VSikvsscuyilpEmiro86eGnfHHTb8ziL8s
 8NNmWVoUDvCdvdyb7kVLSB+UIthKCEvEmP9I24El2FKKn6x7X8dYxlxf7SL0BTllHtww
 N9Dg==
X-Gm-Message-State: AOJu0YyZSTxbUPbnhov8L2z2+jAqbmQNxASGKZUPzBA2W6zjb5P++xip
 cE335KNJMtC6OtAFH5QDIRjuJhXTOQuRGEnnS/l0pucsNUaCF0IP
X-Google-Smtp-Source: AGHT+IEs1ylubmQN8A0X53Q+axopbseiZL2lHt8lsf8pQLAKJmnZkrve93Gu5xyzzYqhcdcBL4DHxsi57jTXztybS/4=
X-Received: by 2002:a67:cd02:0:b0:454:6fb8:9d4e with SMTP id
 u2-20020a67cd02000000b004546fb89d4emr2643470vsl.25.1695948074155; Thu, 28 Sep
 2023 17:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2a92:0:b0:7aa:d493:bd29 with HTTP; Thu, 28 Sep 2023
 17:41:13 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <1cd9adb3-004c-7512-e587-085959296f03@linaro.org>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-3-nbowler@draconx.ca>
 <1cd9adb3-004c-7512-e587-085959296f03@linaro.org>
From: Nick Bowler <nbowler@draconx.ca>
Date: Thu, 28 Sep 2023 20:41:13 -0400
Message-ID: <CADyTPEzpcKU3QXOQ7pSC_hkrD-BrhQ51K4WMCaYYgKuyfW09bw@mail.gmail.com>
Subject: Re: [PATCH 2/8] target/sparc: Fix VIS fmul8x16au instruction.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2607:f8b0:4864:20::930;
 envelope-from=nbowler@draconx.ca; helo=mail-ua1-x930.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023-09-28, Richard Henderson <richard.henderson@linaro.org> wrote:
> Belated follow-up suggestion:
>
> -   if ((tmp & 0xff) > 0x7f) {
> -       tmp += 0x100;
> -   }
> +   tmp += 0x80;
>
> 7 occurrences throughout vis_helper.c.

I agree with making this particular change but I think since it doesn't
fix a bug, it should go in a separate patch.

So I will include a patch to do that in series v2 and keep this one
as-is with your Reviewed-by.

Thanks,
  Nick

