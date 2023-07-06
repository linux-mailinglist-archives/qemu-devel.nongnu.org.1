Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D774966F
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJTj-000409-EP; Thu, 06 Jul 2023 03:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHJTe-0003za-BW; Thu, 06 Jul 2023 03:32:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qHJTc-0001vx-Ri; Thu, 06 Jul 2023 03:32:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666eec46206so410745b3a.3; 
 Thu, 06 Jul 2023 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688628750; x=1691220750;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3isZmhugWeNla+4b18LPVpbxdShr2VeOaLIOfdBy2U=;
 b=bot/S7qdAXyALBZ2IEd3eq0HAWB6oz2KQ0bl8Ob4LSwr+N1ZuqAQSNT6/UdHwVgODX
 mIadfaboVfVqrtRw674305MGaBWFZh025KtbO7iUallqw9dlmD5VHDnbp7bibv5S+eUZ
 Ekjwo8xxGKT4XbRA+5jChAtKSOMn6NGb0PKo+8BEc/+yv5wH6/FPBqrYoLiw+mNj/875
 ga5i/4PyAYRXgPday9q28oS1IBlf5fyc677RXuJJnhVdE7kI/7Zs7Wz/uIQntk9DGqgx
 7frUPhSJN0luElMmsNnquLAdhaitkbs8PRp5PH9Nt6K7BMJs68l0ydNj40puLQQ1l50J
 qJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688628750; x=1691220750;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M3isZmhugWeNla+4b18LPVpbxdShr2VeOaLIOfdBy2U=;
 b=lY4gQgIAYzmGHTc6ci7R6oTlXQbeHB23zma0UPCpJeDLjyagrYkTnxb9yLqk3LrTli
 C8GT9aQxgTHZPB/rR+hCsEFdjIO+vTKVhUsEyfbV6K+G4F1OeXtS6QWHhQzc2x4ePh3f
 f0DWt+Rtv6nnn1hXzj4UjjLd+cCWMoXTZW/pYKtspGSSibzAmd9p9CCHTm+aTRSS74ty
 v9nrvAtPU2TGRg0C8DOvwSfqmgN1e46wXokJAG9qgRYofuZijiiqNLk6roXLsLDQyUNX
 Nk40PBzv+om5Vdg23POD4wKTYfkq78BGUqJtauGKiP1Wrq8gu3bXFbFoIfdJRurJOhEl
 wXmQ==
X-Gm-Message-State: ABy/qLa0rENlJqK4UrHvby3uyujClSBWVd6skaaFQgbMKoU7QetDVNSP
 rk6M4idPpWlrUeqNw2mFUF4=
X-Google-Smtp-Source: APBJJlGrZ/CSL5iYaoSNq6rKon/aH19M+0Bz2JSVBOhI3ZIYDV0UiLJLlm+UQa1W/ObYuCHjPmRkEg==
X-Received: by 2002:a05:6a00:1a12:b0:676:ad06:29d7 with SMTP id
 g18-20020a056a001a1200b00676ad0629d7mr1497387pfv.15.1688628749926; 
 Thu, 06 Jul 2023 00:32:29 -0700 (PDT)
Received: from localhost ([61.68.2.145]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b00682562bf479sm659937pfn.53.2023.07.06.00.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 00:32:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jul 2023 17:32:22 +1000
Message-Id: <CTUWXISZHAI1.3A3FS0U9SD90B@wheely>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3] target/ppc: Machine check on invalid real address
 access on POWER9/10
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230703120301.45313-1-npiggin@gmail.com>
In-Reply-To: <20230703120301.45313-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Jul 3, 2023 at 10:03 PM AEST, Nicholas Piggin wrote:
> ppc currently silently accepts invalid real address access. Catch
> these and turn them into machine checks on POWER9/10 machines.

Would there be any objections to merging this and the checkstop patch?
We could disable this one before release if it turns out to cause
breakage.

I don't think it needs to rebase, and passes clang build and make check
here. Just messed up the separator on the changelog of the checkstop
patch.

Thanks,
Nick


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Only implement this for POWER9/10. Seems like previous IBM processors
>   may not catch this, trying to get info.
>
> Since v2:
> - Split out from larger series since it is independent.

