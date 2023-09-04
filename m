Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B3791A21
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAyv-0000QE-86; Mon, 04 Sep 2023 10:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdAys-0000Pa-BF
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:55:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdAyp-0006gX-K6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:55:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso1178644f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693839306; x=1694444106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohMhkSEG3q7rKDnrpXqNwzclMVCWMxQISciHtB7L1yw=;
 b=oii2WItCiIstAJKCRxT+LwGBgmlbQyk48Igyqj6rCb0lJwx97va9ejy8nKhnnYiRCF
 NiXy/PjmaqNsTBfLoGjM5ahxFJEiAuwtAeVRAcS3GWCAWaHcvhbBR/bsXmlJbdM8ESFo
 o/lPbkow46mseV2W0BrKPTKaWSHQAPssDq9PDKQGuBy/64dD6YceVHHa63hwKt6cUWiY
 LJVEVMPUaV17Wq4rk3+yrhwxu8mv47eC0s/I1u28tlvLVL69n1FGnTkaZnB+08VzXcKI
 bCRFSj5f0eX4Ql/hj4hC+L43dc1oGaOZpYLSDtcmgwqqQUrDOFblxAOGABqpTEqSf3h9
 3ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693839306; x=1694444106;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohMhkSEG3q7rKDnrpXqNwzclMVCWMxQISciHtB7L1yw=;
 b=M70vKI3JTmEkDiAzPy81nkJ3lGCy4ex6oBpp9nNqDnZKMsC0WEaFEqhjK9OgWHD056
 lVKMeDrgXMiVsDvzIW2XPZXT5Vb/rPI9/HEroebdM7aUlnA5oNPUFBs2ekMWkLSVlFq/
 vJWBXfru7jJ+ckbRtrxlCHxmt0U7Ym3KAny01iiVAlMJ1wzKEavPjzS3FMTnHBDyn3RC
 OPPKzSlm8ZgFNPoMrG7ZYbqb3kHic5joZfamUV1UG8NVP0zIXFdAwMmfmjWyYrQ7dhC1
 KovUv4KVxaXCi5zsqjuhQblK7Wgw/CdyUVZvxLQD3ML0OSCyC7KHrSozPFZt3EPOQNgf
 EvcQ==
X-Gm-Message-State: AOJu0Yx8g+exBrB/CS508I+AtnU6Fs0ntRItm3PpTR6ahVw0aeIufw+Y
 REWwdoZE9JtEMfZcCfttnb2tKw==
X-Google-Smtp-Source: AGHT+IELuyrzdSIzUVRYSoLztFQAtQY9k0TxI3uo/VqF0OC1WuNZOns53qlo0/hs4MVMAfLZn2FAjA==
X-Received: by 2002:a5d:610c:0:b0:319:72f8:7244 with SMTP id
 v12-20020a5d610c000000b0031972f87244mr7323593wrt.45.1693839306014; 
 Mon, 04 Sep 2023 07:55:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a5d4242000000b003197c2316ecsm14673389wrr.112.2023.09.04.07.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:55:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4DACC1FFBB;
 Mon,  4 Sep 2023 15:55:05 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-4-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 03/20] linux-user: Tidy loader_exec
Date: Mon, 04 Sep 2023 15:54:57 +0100
In-reply-to: <20230829220228.928506-4-richard.henderson@linaro.org>
Message-ID: <87o7iihtti.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Reorg the if cases to reduce indentation.
> Test for 4 bytes in the file before checking the signatures.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

