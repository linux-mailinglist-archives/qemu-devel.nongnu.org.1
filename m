Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77ED77375D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD67-0007SL-KM; Mon, 07 Aug 2023 23:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD65-0007Rp-Eu; Mon, 07 Aug 2023 23:09:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD64-0007oc-1P; Mon, 07 Aug 2023 23:09:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso3763193b3a.2; 
 Mon, 07 Aug 2023 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464162; x=1692068962;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdHjciNpGWdMbC3CCZ1sM6WJY5B+CxZfOCmfCfZO4vY=;
 b=YVJCcn63P1V8fKfF8dKRnHC91AGwur9IXVkE8ke1aQCHuHL1evBQFaQ6TvWYPEcCwy
 qDPJMMPvIrz9dUZ8Dno27I0ZGXYbPBVuUQrMJTz+oXShqyiICGixe0viG2FP9Rwvf/+d
 nsH+//MR2iyNpNgq812t5BX3Fo+EhRriE7xIXGo1bQ3qi5EEKmmMFD9ianWUttl8ZrL1
 QrLIu0lpXpJ19Th2ks9p34znulwIrRV3Kzl3coxFd2PvJVMmp5R5X7oV4RwhFVtC9Prx
 I/ThPkeLD+2pXLaxqoab3XcN1rcXAzkHMm46h2mjRrGNUaZ51VkjV1w061WyIBkNrKpm
 YfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464162; x=1692068962;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vdHjciNpGWdMbC3CCZ1sM6WJY5B+CxZfOCmfCfZO4vY=;
 b=K/uKoaNEShPS/Hoa8LM4FY6z/gQOkovYsr8WaxXqAy8eSG1Jy/FgXK98Prx6ma8K1G
 mWzUnapm6ASP7G3cEtC2cZCO5RKiWwFseEL62Wccafq0yJcG8cZuev3yuxyJp3Vs6ZtT
 WNvNW+BUCswrUyDr5BsTWOy1VzgR8NDHB0TmdEub2C1wJmllO1mieHTqnyffdOSdlvPz
 oMKpbJxxxIk4OM/oYN5DdxO9FnrDcqo92v3xj81dWv8CCROxaSNYqgdLHWhQTdKjpzE5
 KQBSD+ZGfbaV2/E96DrXmgAVdZ0y7lLQ7YXncyofdiSsyuhxqEeCSaZUYtIr/I4ytdwc
 sCKg==
X-Gm-Message-State: AOJu0YxW3HkHSxfWQtmXAQr0sM8ZpddgaDfQrJmY4tLcDuxQUQ0PXDtz
 aKqmd258J091pKqWvftL3Uk=
X-Google-Smtp-Source: AGHT+IGFZVfHh+iBflDL23yvKpjwiomaF6o5XPLa71UCIELrMLc16Mi9kCr89g1nvdstTSIlHpl3GA==
X-Received: by 2002:a05:6a00:130d:b0:675:8f71:28f1 with SMTP id
 j13-20020a056a00130d00b006758f7128f1mr12227976pfu.30.1691464162390; 
 Mon, 07 Aug 2023 20:09:22 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 s8-20020aa78d48000000b006873aa079aasm7126705pfe.171.2023.08.07.20.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 20:09:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Aug 2023 13:09:15 +1000
Message-Id: <CUMU01SZ63FP.3B3F5NBPCVQT0@wheely>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "Harsh Prateek
 Bora" <harshpb@linux.ibm.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming
 too many events
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Pavel Dovgalyuk"
 <pavel.dovgalyuk@ispras.ru>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-5-npiggin@gmail.com>
 <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
 <CULFQXOOUWDB.3GMPJXRWAWSDW@wheely>
In-Reply-To: <CULFQXOOUWDB.3GMPJXRWAWSDW@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Aug 6, 2023 at 9:46 PM AEST, Nicholas Piggin wrote:
> On Fri Aug 4, 2023 at 6:50 PM AEST, Pavel Dovgalyuk wrote:
> > BTW, there is a function qemu_register_reset_nosnapshotload that can be=
=20
> > used in similar cases.
> > Can you just use it without changing the code of the reset handler?
>
> I didn't know that, thanks for pointing it out. I'll take a closer look
> at it before reposting.

Seems a bit tricky because the device tree has to be rebuilt at reset
time (including snapshot load), but it uses the random number. So
having a second nosnapshotload reset function might not be called in
the correct order, I think?  For now I will keep it as is.

Thanks,
Nick

