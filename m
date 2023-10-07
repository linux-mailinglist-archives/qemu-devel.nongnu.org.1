Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77E7BC5EF
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 10:05:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp2I4-0000C2-7r; Sat, 07 Oct 2023 04:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1qp2Hx-00007L-0V
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 04:03:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1qp2Hu-00027b-SU
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 04:03:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-694f3444f94so2427542b3a.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 01:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1696665824; x=1697270624; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjwOSRl5Moe97C0ux5uWNNaZO5PoXf/S90zPpk4KeIU=;
 b=WA7lgiTZkqBmwzM7qOJJdOQGyQsBb4RH9O2QpcdHbaPPyy9bhxmLRB64DAUeaEEOai
 V3Impo2uwZeZlQ8vVZun0o4zIMeZiOWSFQZn10uDbQCxmgpsDBEdb2losIuCvbpR/M0P
 hu8/WK8uIB/mICq1a1/N1X3wIiLtiqcwyHbASAI4gdaVN5s/XI/ylM0C4Z8GiVwWDP2o
 8nb4VF/yYaBhS0Fki/XCUbXe5ilTXXNX0WzYKRsyAb2QI+gWcbttHFWqyhD4gtt/tJFK
 KaCxyWRpZTow+E3zDp3r11dO7a/UBsWudZOxU/aEuNO+jCg1iFasvT8RgEGOjrzhXyCN
 PBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696665824; x=1697270624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjwOSRl5Moe97C0ux5uWNNaZO5PoXf/S90zPpk4KeIU=;
 b=rfNdCqYbLehhGr0HN1O18UcwCXOvm/43gs2TXOhCBWFqtutxPXSOsXU22Pzn/cmOXI
 e64lwnyixOAKqVLqGncEpL1zWTjjf4aNBxxnIWgiffru2/jQqVN3Y5wE6ROU56Z79X2w
 H9T9OxB6VsyI93UJkZA53zSBwj2Xy7QROxX8LwsVY55MDURbazGbebArBEgnFFPIr5vh
 pozbi6CUzmrTzdJicQqlMFfFoz+69Tkgtq67Oidpy/JCjwq4Z/77pZoGIqcW09Y68a2l
 7/Rx3piIan42IOMVjTkMJClyT5tKPe/kweCRlExTyIe2Ht6ScQ/TiG+CYL9MAkj1MEvW
 DWcA==
X-Gm-Message-State: AOJu0YybhrJhc7Xv3BJmSSS8TzFSbHM7m3Lp5IihCqE79l1zsG0KhTKm
 +O2bv6j1dKcbVU6NPQ8ZhrdMHw7zgU86Gp2X7ddS
X-Google-Smtp-Source: AGHT+IFL/k6tUIxcQhSfIFVcdaGaXP0LEAAmdhZlqNDatTninRBuBOg4JgeZlmLhdGaYoN69pJsp9nSIDHOY3eVj1Jo=
X-Received: by 2002:a05:6a20:12c9:b0:15c:b7ba:6a4d with SMTP id
 v9-20020a056a2012c900b0015cb7ba6a4dmr12125143pzg.50.1696665823777; Sat, 07
 Oct 2023 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231006120819.480792-1-thuth@redhat.com>
In-Reply-To: <20231006120819.480792-1-thuth@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Sat, 7 Oct 2023 16:03:32 +0800
Message-ID: <CACycT3vRayGGP2TfN5=Gm+KOkvpfp6iypcQScnj6t1Hs7bJppg@mail.gmail.com>
Subject: Re: [PATCH] libvduse: Fix compiler warning with -Wshadow=local
To: Thomas Huth <thuth@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=xieyongji@bytedance.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 6, 2023 at 8:08=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> No need to declare a new variable with the same name here,
> we can simple re-use the one from the top of the function.
> With this change, the file now compiles fine with -Wshadow=3Dlocal.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

