Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3B82C37C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:20:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKGg-0003Zk-H5; Fri, 12 Jan 2024 11:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKGN-0003Vi-Ds
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:20:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKGL-0005pB-NJ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:20:06 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-557e76e1bd6so6041306a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705076404; x=1705681204; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ymDESbPOV2jRqIWtDkkn/wHqhdJOkPjfvLhT2Hj808k=;
 b=duamjr+7CiWpfMdpm3VBk+GUvwr4aooNsvlB7bFEXCr9A+RMlcj4dt36C4vEo0CF1N
 4dV/bfOZLVJBQ//Is9ILwZ18JnySKPnxm1fgwrNeuzUjcl1d5dOgWUIACMBIk7Kf0FTX
 C7MBQvPKs569/HeB0/SnCaqX0j3vx3S6CjQhLbTUI7CSRQAurXuhI8ztaVkxGLwJdZzl
 8COT9ew8VXVWafAAorHnRhfbShALHz1AQbMbVv4aRDjTmdeUZNGv2u7XOGaEgCDKZxQB
 hqbaTnDPtIpkbOT3H3uK32DBCXkw2TqJbSWujin1ITOKuW3YOzPBFdgMRo+DqNH9IVzV
 p6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705076404; x=1705681204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymDESbPOV2jRqIWtDkkn/wHqhdJOkPjfvLhT2Hj808k=;
 b=iZ4RWone5+nUOTibbTfnYqNRRMvCQFyxhmLeLb6Ryl3dUXw+mzSmP0Yip8M3ydsV23
 RPdcAEcr2ff3Bak86GCISYdEavOuM6/NcEJiSz8iaObiJjOZ+2hiOFQ+Ml459G82IgFO
 yNlHpjdFvDFBPifes8Td9M5yJTUbooVDY6+SYLXKASvCgPSDkKT3n5U1n6RWTgJAYo6k
 s+Srn08ebsW+dLPFxoK6mwgV3j6SSzUO6O8lnZgpii/QxSkObtvoHTU0b+ZqQCPsXxup
 nPWb3+ALpTRHMUa0p/A//Wo8s2X2IMkyVrr6v77KlEEQJtlHTmju5CvgBW5P7y+XdbPd
 3pXQ==
X-Gm-Message-State: AOJu0Yxusio3T2mCWpv2Nbbdl9UVoCEQJrgaCcaL/iZeGfP7k970DD+u
 CStjTkwUGIUBQCg127BXH/3AO8KwLXNgsturxhmtOWBt+LgOOw==
X-Google-Smtp-Source: AGHT+IGDMQZX0xA4hNunZ8CGAbJZ/EWjIxKMW/EOh+Q10H8bi4RCyJFnY4fM4aBwE528GhF2d4rSar3kgTh8QcPBhx8=
X-Received: by 2002:a05:6402:8c9:b0:556:a28e:7cc1 with SMTP id
 d9-20020a05640208c900b00556a28e7cc1mr772240edz.81.1705076404162; Fri, 12 Jan
 2024 08:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <y2kuootd3k2tqe2245zggbuusg2kaaqrxlvxfwy2wrcbdxg3cn@zgj6tl7gd4lp>
 <CAFEAcA8H6kVNiSk6CEVun5KWQH-sqWxBKxZ9Rf7haQhZHEKiow@mail.gmail.com>
 <CAFEAcA-sw2FNgTft0PYL=GW0JQhdRX9Zn0B6muUjC68nmVXHnA@mail.gmail.com>
 <e2hpw77r6t2ge6h233cq75qdadou6koz62sfktcsrlc2gzeqnq@4ejyxysmmulo>
 <CAFEAcA_f0Q7LkSQ2+sxgBcRQNSTenykq1R28QMuGyW22PtxW2Q@mail.gmail.com>
 <CAFEAcA_-fF7fWGm_QUJa86LHJvtBk4jKvTw=OvM+EOxQzuYvWA@mail.gmail.com>
In-Reply-To: <CAFEAcA_-fF7fWGm_QUJa86LHJvtBk4jKvTw=OvM+EOxQzuYvWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 16:19:53 +0000
Message-ID: <CAFEAcA8BnGb1ods7t1M99zc2fgA+TTatueM2+D8Kyrq0=qciFg@mail.gmail.com>
Subject: Re: Re: [PULL 0/6] Firmware/edk2 20231213 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 12 Jan 2024 at 16:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> PS: when are we likely to be able to update to a proper released
> EDK2 ? Running with a git snapshot isn't ideal, so if we can
> move to an EDK2 release version within this QEMU cycle that would
> be nice.

...and for a stable backport, backporting the released version
seems likely to be better than backporting the git-snapshot.

-- PMM

