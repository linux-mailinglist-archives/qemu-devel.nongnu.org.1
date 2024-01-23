Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3221837FE0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 02:55:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS5yr-0000xx-Dq; Mon, 22 Jan 2024 20:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS5yo-0000xQ-DI; Mon, 22 Jan 2024 20:53:34 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rS5ym-0003JF-Pv; Mon, 22 Jan 2024 20:53:34 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6dbcdbe13e1so1685556b3a.3; 
 Mon, 22 Jan 2024 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705974810; x=1706579610; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNbwDsG4lb3Kt/1dUOE9HEgOQGSweLY9oNP3b4LSRyQ=;
 b=E7qNoWlSh+GWSAR9NyRMv8UU3sPQZlFUJWJ/QHNjfkWQs/INca4BaAiQz3/edV6Z/+
 74fzR27scExdzPJzUN4buqCeFHqNkfLPc4i+xJ1isLOohUGUC8+apNpaqpSghnLOUKsq
 dWX0FtbeVA+1n1oxnCglNmiuvAWXsxgDycpYuEzLusEFaovisQjgEicbgl3FdIPv5iBX
 E7dvKDuXYXsJylXlAP6jwzCrpurM/vpKSgxTruIDnDRiPPdPFPJySUji1z+jiAVVM7iY
 BMHR5TwzsEbMgomZ/cKBKZWemvKwXvbgdQ13f3Ch46xt95N6lLAw96Sauh2ZxpedBNIl
 yKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705974810; x=1706579610;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xNbwDsG4lb3Kt/1dUOE9HEgOQGSweLY9oNP3b4LSRyQ=;
 b=g79opRRCRoEwX+PPAOZtjkfnUc9Xv/z9YW26/PNmqcsM3aVBD4wCsH5XqCr0JfrEuc
 +nSZnPKhUTKQqsC3ymQyA+eSqOLCm3ediv8e06s3YHkR4wNVW07IXt6r8GFJvy+HxpGv
 c0zQ5dzJe0wNNDZjvMKAlHvQnCOJCl3vKvObVr5z+VSbTJ5cGlS7UMjNzt1MKILJ4Yic
 6Q39U2iB5HIJQl+9Wg93hRjiDENZ5wT42gqjAqOG5SgsQwZiOjt7BTC7N801eehvmcx5
 3FI8iho2hmbrLePEw80XqWb/vG03qpWzLx/u56BOaceGud/1beEFuotJbZSA693wlnO3
 vnfA==
X-Gm-Message-State: AOJu0YwIAU9wVUzwaILHiHDrL5A8NdXdGL71etmUhGY3l61wgbzSg8zz
 vD2WY42ePD62YGrxd9YzvVF7eU2GQwO/61aJkQGQh7TzeTCYDl8+
X-Google-Smtp-Source: AGHT+IF0LVPZ30xq4rrIIAzb3ibY610GSR0v2dbjOroHtPqynvASfoImYhNnQPC4axmGua7m3F9YmQ==
X-Received: by 2002:a05:6a20:9149:b0:19c:520c:c5d6 with SMTP id
 x9-20020a056a20914900b0019c520cc5d6mr1278078pzc.13.1705974810161; 
 Mon, 22 Jan 2024 17:53:30 -0800 (PST)
Received: from localhost (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1709026b0500b001d70af7dd0dsm7344669plk.263.2024.01.22.17.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 17:53:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 11:53:23 +1000
Message-Id: <CYLPLHDACTB6.3U6TMG2OMBXU0@wheely>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 00/26] target/ppc: TCG improvements and fixes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240118150644.177371-1-npiggin@gmail.com>
 <4d55b173-3fc1-44ef-882e-a5da945c67ad@kaod.org>
In-Reply-To: <4d55b173-3fc1-44ef-882e-a5da945c67ad@kaod.org>
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

On Fri Jan 19, 2024 at 6:58 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
> On 1/18/24 16:06, Nicholas Piggin wrote:
> > This is mostly TCG core emulation improvements and fixes. I
> > got the chiptod model in there because it's intertwined with
> > TFMR SPR.
> >=20
> > Other non-TCG patches are spapr MSR entry point change which
> > goes together with the other machine check / MSR[ME] fixes.
> > And Saif's gdb patches, as well as some SPR renaming.
> >=20
> > Will probably a bit more similar patches too, e.g., Dan's SPR
> > patches, but I'll just get this out for review before
> > upstreaming it.
>
> Before we start a new round of reviews, could we please uptream the ones
> reviewed in the previous cycle [1] ? Some are part of this series and we
> shoudn't have to go through them again.

Yeah good idea, will do.

Thanks,
Nick

