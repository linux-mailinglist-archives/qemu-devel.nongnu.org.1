Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE997F7435
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Var-00048N-Bb; Fri, 24 Nov 2023 07:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Van-00046E-Af; Fri, 24 Nov 2023 07:47:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Vai-0005bl-T6; Fri, 24 Nov 2023 07:47:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cf50cc2f85so14835785ad.1; 
 Fri, 24 Nov 2023 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700830047; x=1701434847; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzcPYixxKK9Iy1JE7Sh/jXK2a+O7mPkOBydd/jxBtfs=;
 b=RyNNq9JcDe8KB4jhvP0gybQ1To87OJg1tUCrNguueCheuD6Q3yQKi1KBZHssTGP441
 GNYoGbg0eKaazCouUouGxuaGXxtUk7F3ZyC22RHBFWbyYGOOwO8PBWoYtJ+zQaNapThf
 1QxCI6S/uBDPgcMxYuJbcVatvEFTk96sEBMIQD3xJCHQI2lR8e/UisYZbQTq37Apggwb
 jk8n6RWpF11FtXeIO9LpwVitNVT7iyweAXJXQeNN6Pv9xMNshTRqZMuZaCUcNbuewM8h
 U0uVvQyfbZcksMTsIQ9L6Vb7DIsDhlvslhzxhG3DRbFb4fnMIvKWlbYOOq4doYLrY28f
 NwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700830047; x=1701434847;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HzcPYixxKK9Iy1JE7Sh/jXK2a+O7mPkOBydd/jxBtfs=;
 b=MTYnsBQn4zQ6l+NBlHk73ZOlwyq+MGAeZoi/viPUJ1Cx3ZjvJmb4uFsZM1UpxLhaKu
 XV+Xdh4+tAxIGzs24i8ailOv7hYLWNus0X8olPdsiQglvw9pGR8IMIgXV/fNY1CsqmBG
 u3c3+cde4ffEWcBRj7fcCTLJKKOrV9IvkDrzeJ3GSqVAKLsthyA7iBovIFwdr1Rnqsjc
 unCiSPqyYrLQen7q/eVdkidl4nsRms4QsJ5wm3FW8dKQDlebCxiF4K8fCSUHfjOeGPgS
 lpEDbStwRzDpy2+sTjDVujnD/63FNCiZpbyhHhLjwJwt8SvE6yoYi2p9ynfAr7vsQ0yP
 wsCA==
X-Gm-Message-State: AOJu0YyC+8zHYbl6ceT+I2bJesikCbTHzNl698HBhU7NAaMa0vysAUs1
 Z4a8MxG9WfNS6PiHtidkOHE=
X-Google-Smtp-Source: AGHT+IFVCe1Q34g/kVlRI/LbaFAOi0jXIWKxRz98O17gypO1DmgaIt+E7jN4TRffhmrtuBTXKtcScA==
X-Received: by 2002:a17:903:451:b0:1cf:59b7:b035 with SMTP id
 iw17-20020a170903045100b001cf59b7b035mr2203237plb.21.1700830046780; 
 Fri, 24 Nov 2023 04:47:26 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 jc11-20020a17090325cb00b001ce664c05b0sm3104752plb.33.2023.11.24.04.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:47:26 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 22:47:20 +1000
Message-Id: <CX71XHZKBIK6.1MNARW3MTDJFT@wheely>
Subject: Re: [PATCH v5 3/3] hw/ppc: Nest1 chiplet wiring
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Chalapathi V"
 <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <calebs@us.ibm.com>,
 <chalapathi.v@ibm.com>, <saif.abrar@linux.vnet.ibm.com>
X-Mailer: aerc 0.15.2
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-4-chalapathi.v@linux.ibm.com>
 <CX708Z3P2ZAA.3VDMJRTBIK14W@wheely>
 <bac39d18-e922-4979-9c52-216cad088483@kaod.org>
In-Reply-To: <bac39d18-e922-4979-9c52-216cad088483@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Fri Nov 24, 2023 at 10:26 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/24/23 12:28, Nicholas Piggin wrote:
> > On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
> >> This part of the patchset connects the nest1 chiplet model to p10 chip=
.
> >=20
> > Seems fine to me. Should it just be squashed into patch 2?
>
> It is better to keep the model a part from the wiring because the
> same model could be plugged in different board/machine. It clarifies
> the interfaces, which should be limited to irq connects and memory
> mappings and it makes modeling shortcuts more visible: backpointers,
> looping on the machine mappings to find a core, etc.

Okay that makes sense.

> I didn't comment on the PnvChiptod proposal but it could/should
> be done the same.

I'll look at splitting it too then.

Thanks,
Nick

