Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052E7F72EC
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:40:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UY2-0004DU-Sd; Fri, 24 Nov 2023 06:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6UY0-0004Cf-U9; Fri, 24 Nov 2023 06:40:36 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6UXz-0000mP-Dx; Fri, 24 Nov 2023 06:40:36 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cfa9203c14so1718705ad.3; 
 Fri, 24 Nov 2023 03:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700826033; x=1701430833; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbMv7xwkKEevL1i4QtJkvYCmUHmbj+KxYzKxaFbCuqI=;
 b=ljrviXojJGh2PvYzLv5RiToq2XOvfnNQK2S1FyAmQMqAguwYa5rCDHzEBMqC3A5L/o
 rOreB/6A4PJg1DHJO+DjBgaiVivDlfd0svK63QZDFt7x/ftyPDHWnUwxNUbV72H0rfzM
 BbVJeAt6qff43ixNDkPtsqr5Hd54E9QE0t5NBcNJNkwyAXEuWDnJ63x1WzqXc8LUk1Qn
 mcxSqFCBO/43qtXvL79dt7mR0oRxSea1n4T3DWjDnbrW4JR3VlKyMFNTNSoprOolxYW+
 W6rL86r0UvR1pyilCy6hW8FJcVurk82WVzwHM9LBshEaFm9YGJHjVDOIbB8vdEKfL7CH
 yUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700826033; x=1701430833;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lbMv7xwkKEevL1i4QtJkvYCmUHmbj+KxYzKxaFbCuqI=;
 b=uJZE5jMlZ1jzqfGljo26Haw0Ry00zWvheemuoF/zimYD3MEo3ijfBMhjJMXbNbHc1u
 bQcMW7leksimcBsRU+xaYnxcJkBbPOG/WENcNFCsCutfbFnQkjGiQrGgUqopVhpr0vZb
 xLeBxVxfxEedug9Fi8VKepJ2mWyj/8XenF9zlRMDE3ptkqBPSfTcKJ6vLBZ5mt5Iw+ou
 t3LW3n6OMKgcEJZt5xdwWeF+ebY0sgyNuRId3EIVaA5lFtNGc0RA8E1Jh1xNCERQAFCT
 HFxDqy4gTVozP27187xW69Z0lvntYVQl5fnY/gpay7Pswe9tXUlu/u9bIKuXl9Fqm1cR
 gMRQ==
X-Gm-Message-State: AOJu0YxCEZqwWKZjBqBSLdrTgozDsHBb5KAF1Jdq0ZZ749IC3/ym3PVY
 MBq51aN/UODD5qkbkJ5qrLR6yoUOKKs=
X-Google-Smtp-Source: AGHT+IEVncW+ReqT39JPr/Qonv93UI6U/YmLAS0I5Bz3g7nzek8iQl5bU14zNDYsxNreQUXeSQpDGA==
X-Received: by 2002:a17:902:b281:b0:1cf:67e0:8904 with SMTP id
 u1-20020a170902b28100b001cf67e08904mr1845996plr.43.1700826033641; 
 Fri, 24 Nov 2023 03:40:33 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a170902b7c800b001cc3b988fd6sm2974778plz.265.2023.11.24.03.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:40:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 21:40:28 +1000
Message-Id: <CX70IAVO6M53.L9XAUVRG81AJ@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 4/7] pnv/chiptod: Add POWER9/10 chiptod model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-5-npiggin@gmail.com>
 <990dc2b7-8c39-4b3f-8340-1ef75f005850@kaod.org>
In-Reply-To: <990dc2b7-8c39-4b3f-8340-1ef75f005850@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Fri Nov 24, 2023 at 5:16 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/24/23 07:39, Nicholas Piggin wrote:

[snip]

> > +static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
> > +                                    uint64_t val, unsigned size,
> > +                                    bool is_power9)
>
> oops, I was too quick. You can remove 'bool is_power9' and xscom_ops.

Ah, thanks I missed that. I removed that and the xscom ops class
attribute so that's nice.

I'll wait for a bit before reposting. If you don't mind I'll just
keep your R-B with this fixed (it's just a mechanical change).

Thanks,
Nick

