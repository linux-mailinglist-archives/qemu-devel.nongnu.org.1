Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4D7E7110
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19NM-0006oT-JV; Thu, 09 Nov 2023 13:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r19NK-0006np-2g
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:03:30 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r19NI-0001ll-98
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 13:03:29 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso1841448a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699553006; x=1700157806; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tfLGbPlSClvjoMRc/unecfSgcRxpfG1pO99Iq5e8SJw=;
 b=GxYb4tLjEqFlRnpPDxAdKXrBo55swnecX7eJ8iN4Mrt6BpCieStQmfSTj1KtLgKE5d
 bzmA1xxef5REePvE1BVoxK3RHBCRC5Cvl+5Ya8GXFqNvIWXhfdChfbOtxEsAs55AEb7U
 amyeqoYh/fM4VonxbvGhg62Cmc+9IQCCjhqDqKBiZ0//0/5SUrC/EIRM0zJ80OiBoUcK
 MUjdiab2xVos0Or0BSrg1p/iYlXRpPtO/RbxX9jS+z3Gs7j+DOvl8flf9R+/YmZQ9Xrz
 IGYlfWgNF5Fb959jT5MaEGW+RmnTZDApsvk4+i4pLklUV36sqbkon1pc6T/OVeDQ9eLi
 5Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699553006; x=1700157806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfLGbPlSClvjoMRc/unecfSgcRxpfG1pO99Iq5e8SJw=;
 b=WOiQ/KQyK0zfc+k3U7H0kG5B5Wnh3rzzUzG5kuud6YtIMn9lwNXqQGYfo5qGfhDLru
 d7uYMhJJPP7GTZ2SDPcA5rlpRCuGKOi2fyKvEbSgVkNrt2hbGf622WKANqRA20sGh96n
 tigZAwAC5YbQeYlHUWhl9P8NPhDHdz7JNC3bt8VIpODmE0fBTZONHAXSoeGHLfBElsY5
 d+SvFLOLGVWSEi9z4VOwwMT3kFJp7gEa0xwXCbYStTsXLkfcrQ0UGtiJKEzCRsIkKWZ0
 XKwCbEgsrBCs+s6eSArgUzIzX4dYJtM5pJEdhJ11O8Htmo0zdUjb7VQFTacnxIQsXt44
 743Q==
X-Gm-Message-State: AOJu0YydHeyOVITFn2v8A2Z40QHadDUfD8l/kWQ0cAcs+z3Zrm4mWk4m
 epv+lhm2d3wQeT42FAw1Mwgodp0uCvP4SGbtoSfmdw==
X-Google-Smtp-Source: AGHT+IHv2SuSrtyDvGQbMDB/HACDr8RNRUSuqIpKbYYh0LnqTVCPVUR0aMoPfNQ+d9dwKPcqS9Kjqpyv14DyS6UhYyc=
X-Received: by 2002:a50:d554:0:b0:543:5886:71c3 with SMTP id
 f20-20020a50d554000000b00543588671c3mr4754036edj.25.1699553006252; Thu, 09
 Nov 2023 10:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA-XqkBqKt33pxXHv0Y81kShV1rZatgAYMJNxibBD1a_6A@mail.gmail.com>
 <20231109125334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231109125334-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 18:03:15 +0000
Message-ID: <CAFEAcA9-tvxsoGoRksUSQpV-U=Pwc64CD0R17n-QkEwLA8OegA@mail.gmail.com>
Subject: Re: [PATCH] virtio-snd: check AUD_register_card return value
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 9 Nov 2023 at 17:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 09, 2023 at 04:25:04PM +0000, Peter Maydell wrote:
> > On Thu, 9 Nov 2023 at 16:21, Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > >
> > > AUD_register_card might fail. Even though errp was passed as an
> > > argument, the call's return value was not checked for failure.
> >
> > For whoever picks up this patch: we can add
> > "Fixes Coverity CID 1523899" to the commit message.
>
>
> Better:
>
> Fixes: Coverity CID 1523899

I thought "Fixes:" as a header-line like that was for
the commit hash/subject of the commit the patch is fixing?

thanks
-- PMM

