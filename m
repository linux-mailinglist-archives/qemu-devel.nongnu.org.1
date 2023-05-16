Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 700AA70498E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrBc-0000L4-Gd; Tue, 16 May 2023 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrBV-0000KT-Fb; Tue, 16 May 2023 05:41:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrBT-0006uc-VM; Tue, 16 May 2023 05:41:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so4232439b3a.0; 
 Tue, 16 May 2023 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684230090; x=1686822090;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpWYZIIFK1mw+JyjCIPquJfP6DiJ/Yfvhv/uA5ae2b4=;
 b=dfX9XgHA1CUB63t9l+ZQINuImxXmmMn39mZ15TPpsnjemuTjUFJOFDDXcmexk8mkth
 +1tCgV37JGfjQj1ToD2uSr+BCUWCbwHPwXLb5tPGfpAvkrXzBzHdZgO001+pVLdoJqQS
 a21f1A8JIRyGv2GqaIK6ZQdbdWkaw77fWOb/vT9NsmuMN83Ghthc1Pd4I7249SsX8ed7
 xfQPO6YIFJmT0/WmIzcrxHDhQbawFgu+zFOzbFHrmgevqLi7Fk7kKJbf6wMUxp+xCXfs
 xkFVpfZFJek7FCoRWq0bUM2Dojwbvi0YJkbdzbEe0My9729vfsNxaY0HIf2XdDWxu6X6
 48bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684230090; x=1686822090;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gpWYZIIFK1mw+JyjCIPquJfP6DiJ/Yfvhv/uA5ae2b4=;
 b=YUVSks86nLeAFgpnuD+f+5QqmQpn/THw5zJ8ZsB4fqsSPJRgofG8wfbyAbbFCZXugv
 oi+ux9y49LgxTtdaei/ENQzCtjtRUCBPnFsAtxUkUT9JjMztCsJnIn2T+sqPmRSnRcAW
 WWc6vkBZbdSHJl27MkxTanEwn+G8mlktYXP6tVMXsAx2Pq1GhWSJ6ui3rSExuoN9I07y
 pOaMR1Ubk625EAhBusRGN/xlSTK8VB0QAp3BPPGdynUM/TCCfZnDAjS5VgBdZ6tkxczf
 alYN++uuR0jUSY2Ad//WZNlqLBXPyJ/zpOi8Bj6Te2P1Y5xj5AqKvG57VxC9JJPRjYyw
 IVfw==
X-Gm-Message-State: AC+VfDyhaoqrDmIX30yZXObQTgWvFSVRlX/gyHqHIIx7hc9fdFMuKTgN
 b6aydzotO/Lq/1DggEq6m9Z4bO/uYr0=
X-Google-Smtp-Source: ACHHUZ4zdvBX+3w86DC+BSKkFifvUPykT013uBLprODbsxMAlEabunAE9j37dvLdfFlxLydzm+djLQ==
X-Received: by 2002:a17:903:1209:b0:1a9:7912:850e with SMTP id
 l9-20020a170903120900b001a97912850emr45407006plh.10.1684230090117; 
 Tue, 16 May 2023 02:41:30 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a1709026ac600b001aadfdfcd06sm10356136plt.299.2023.05.16.02.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:41:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 19:41:24 +1000
Message-Id: <CSNLQJHLOHZV.31DMA8N2797ZQ@wheely>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harsh@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Frederic Barrat" <fbarrat@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515160201.394587-1-npiggin@gmail.com>
 <24568628-f3d8-6d14-6bd3-80fda8f45734@linux.ibm.com>
In-Reply-To: <24568628-f3d8-6d14-6bd3-80fda8f45734@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Tue May 16, 2023 at 5:58 PM AEST, Frederic Barrat wrote:
>
>
> On 15/05/2023 18:02, Nicholas Piggin wrote:
> > POWER9 DD2.1 and earlier had significant limitations when running KVM,
> > including lack of "mixed mode" MMU support (ability to run HPT and RPT
> > mode on threads of the same core), and a translation prefetch issue
> > which is worked around by disabling "AIL" mode for the guest.
> >=20
> > These processors are not widely available, and it's difficult to deal
> > with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> > and make it the default POWER9 CPU.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
>
> I almost forgot: the patch doesn't apply cleanly on latest upstream.

Oh, some fuzz due to needing the PVR patch I think.

Thanks,
Nick

