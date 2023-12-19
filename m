Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D2818650
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 12:27:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYFV-0001C2-Oh; Tue, 19 Dec 2023 06:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFYFS-0001Ay-Gx
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:26:54 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFYFQ-0005oA-IJ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:26:54 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e4b6b13d4so403775e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702985210; x=1703590010; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbrlIe18ylYOI69V4v0PDA1Q6DVOoxMHqDlNN+FjgzA=;
 b=ypkSt18X8eFR7+YU0++ysLg6CtNZwePjpWku+35jARMPEPHzSAE5XZIq0xkMou1u68
 ecyOvGir6KvBlZqCB6uGjHAgBwM53ocpsU/qMbx8D0rcDwDnkxHN4ZRljaAD1ENZZgNK
 EmqzY+V0Byy/6iTU/X2Han1kFYd0VleM9vSim+fFPB1WRuSVS5qh4IUMp3Tc7pfA3/JY
 5KiQI0oqymhZFYJUn5p7x62F2wY9vngVHnzJmSs2M05mcRT4tPrpgXe+mBDL2HCOYpXx
 v5NPy8zqD8W7AW5r4f2jd/MVZwJ8F7VxN4QSsEdM0gQNWMqf9vhYE9PTV9j/ikgNai0p
 ehgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702985210; x=1703590010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbrlIe18ylYOI69V4v0PDA1Q6DVOoxMHqDlNN+FjgzA=;
 b=FjqZF9bU0eAJxAcF/9HPx1qxlldSQe7pyxRE+E7DhT7Kgc1DDGWqIBjBX6E89Rf8rj
 CpafQ+AxKEmQ6BkrgcBC5ZCAAel31j9Wq7UgR9nK94D9wm9RmIAu8PeEFtTCYBmZ55h5
 IjAzDuNf/gDWg4XTva7G2Otzoop9rZmn46f+NwWjwDOQZxsmkKVXMKVRUJbGyjRImT+F
 rDnUO0e4JNxlTiQtCqRfHynAc/QBdhJLmH5buy1uXeqfsKM7unCRWSMNVUJ9vV20ZNBH
 2XgQptl1kLLQbCd4emul1Yrw67nF+E+Zzf2a5xKZVD8RGBxG0vt5TN2cvoXKUtQbqY/z
 5KNg==
X-Gm-Message-State: AOJu0YzwZSbvPV68a1ipS9rkuk5DGljntYbhXGhajGR9y5bM42qZP+iG
 jBjDUjhqBZlOVmKfIxz13PeNFU5DdUzsVOdAKAoKFPJQCpS6Zkx7
X-Google-Smtp-Source: AGHT+IGNNBz+gC8mCnAiVzSsUS5hjquuC+S8Iw3Yt/zMqraKmomDmFugoDYQyFCXVTcLqbEdMu7afBjZA1r7KDO7J9U=
X-Received: by 2002:ac2:5f70:0:b0:50e:2333:3ae0 with SMTP id
 c16-20020ac25f70000000b0050e23333ae0mr2289385lfc.4.1702985210610; Tue, 19 Dec
 2023 03:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <CAFS=EckTC5P8X4-cnyF3oB5K1sDCbAeBnwLwpy-aVrAJomt3sw@mail.gmail.com>
In-Reply-To: <CAFS=EckTC5P8X4-cnyF3oB5K1sDCbAeBnwLwpy-aVrAJomt3sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 11:26:39 +0000
Message-ID: <CAFEAcA9PN43Q5AookacMA8gqtj+ogacetjZLZ7uDcp0Sszq6Zg@mail.gmail.com>
Subject: Re: [PATCH 0/2] support unaligned access for some xHCI registers
To: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Tue, 19 Dec 2023 at 04:49, Tomoyuki Hirose
<tomoyuki.hirose@igel.co.jp> wrote:
>
> I would be grateful if you would any comments on my patch.

It's on my todo list, but at this point I'm afraid I'm
not going to be able to get to it before I break for
the holidays, so it will be January before I can look at
it. (It's a bit complicated because I'll need to look
at this patch, at the other suggested patch from the
past that also tried to address this, at various
mailing list discussions we've had about the problem,
and at how the code in general is doing things, so it's
not a trivial change to review.)

thanks
-- PMM

